Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FFCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE74321556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864942;
	bh=XYakaCXNYLllXDDo4tPnPA2c1J+mQYpUsBXO6Kz+Akw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSAsE8Fr61Vd6LcQgJhq1RUKEzBpCuE8iae3MiktCnhkujiVADIhmbMuz/g3AOArk
	 kH3Tnrm62k8nYp30sZ7x9MPNS92PdagU7nQ+lAnz/fVGSfMuWrP7jwCuaHmFX6x7BL
	 +iSKOqG3C+xnmq5KEbHxSCchXDSCtLQ4Xy2/dpZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbgAXLWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390948AbgAXLWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:22:17 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5869920704;
        Fri, 24 Jan 2020 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864937;
        bh=XYakaCXNYLllXDDo4tPnPA2c1J+mQYpUsBXO6Kz+Akw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwOXAym81rZtT+YJMNtcpBap20Rqs8qYdo66Q9hAdQX/uEEJnBTRe6Gl3R7zhl/1y
         fNsd/dZSjf8ov5SeZlwUZP+4519qESJVV5M6fcEuHCHgAxub0bYHt98iktTb9B7evl
         5+NHnXti7WvjLsNWT+W1JzGLKDB6BrTa0YZprNjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Jeff Layton <jlayton@primarydata.com>,
        Steve French <smfrench@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 399/639] signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig
Date:   Fri, 24 Jan 2020 10:29:29 +0100
Message-Id: <20200124093136.910052750@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

[ Upstream commit 72abe3bcf0911d69b46c1e8bdb5612675e0ac42c ]

The locking in force_sig_info is not prepared to deal with a task that
exits or execs (as sighand may change).  The is not a locking problem
in force_sig as force_sig is only built to handle synchronous
exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is confusing
and pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Jeff Layton <jlayton@primarydata.com>
Cc: Steve French <smfrench@gmail.com>
Fixes: a5c3e1c725af ("Revert "cifs: No need to send SIGKILL to demux_thread during umount"")
Fixes: e7ddee9037e7 ("cifs: disable sharing session and tcon and add new TCP sharing code")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 7e85070d010f4..a59dcda075343 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2454,7 +2454,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 
 	task = xchg(&server->tsk, NULL);
 	if (task)
-		force_sig(SIGKILL, task);
+		send_sig(SIGKILL, task, 1);
 }
 
 static struct TCP_Server_Info *
-- 
2.20.1



