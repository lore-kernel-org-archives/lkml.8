Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE3820704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865304;
	bh=VZz1Opl8GuC9mzCI6Ek2/0yoM9cZFcxhYqGvex0IluU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NWvGtAFo3c+l0S1NqUq1ZE1b3uHCSSOrQXff4kcCDLvOa40H3ECIq1UYURgjClkA7
	 C5v8fKNH3DEAglmD3bA46kI5D+mvX/5EDTd3xMLOGQ2nPmAkHgEJqUA70UFy6ByXoq
	 BeZ+aW0S4ONuDCOR3ZaECihS9+bzpyMPKSFitq+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbgAXL2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404049AbgAXL2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:28:18 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4130D206D4;
        Fri, 24 Jan 2020 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865297;
        bh=VZz1Opl8GuC9mzCI6Ek2/0yoM9cZFcxhYqGvex0IluU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pR9E69VKFanTZqgqWgA+jQu76r/Dp3bkJS1pDYAGcMh30+dHihcRnob2nWsI1w6fK
         IxSopS0YYWSt1aCq6QJNgMH7MmseeRZ/5YnP026tvLGMbGkC7vo0+a63kaMMnMsbmn
         KVTV9Wbeo1eSxF5Z7J1EYcRdnidNB8JvFjeUTHkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 495/639] cifs: fix rmmod regression in cifs.ko caused by force_sig changes
Date:   Fri, 24 Jan 2020 10:31:05 +0100
Message-Id: <20200124093150.776736298@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 247bc9470b1eeefc7b58cdf2c39f2866ba651509 ]

Fixes: 72abe3bcf091 ("signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig")

The global change from force_sig caused module unloading of cifs.ko
to fail (since the cifsd process could not be killed, "rmmod cifs"
now would always fail)

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a59dcda075343..a8790bf04e95d 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -970,6 +970,7 @@ cifs_demultiplex_thread(void *p)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
 
 	set_freezable();
+	allow_signal(SIGKILL);
 	while (server->tcpStatus != CifsExiting) {
 		if (try_to_freeze())
 			continue;
-- 
2.20.1



