Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B3C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD642173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222537;
	bh=jWX4yRT6wWNhtg/Qm5ktJS7s58vdqoc6Q3ETV5KR6dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dP4rjtdeIfNYGXepg3NjgzoTkVvnbD4LggRn3d4DCR6nH+niahAWcURJuYvjsAQ/R
	 orVtj1XIWUjiOyzJqMgkzXpc8sENl+4hP0zE7gssmuiydlZLhnWD4thJmmT250OzO0
	 sVmFeeR4ium0SSKM5kxiUOWoW6L4qyGN1nnCKkzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgA1OmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgA1ONY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:13:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5142468A;
        Tue, 28 Jan 2020 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220803;
        bh=jWX4yRT6wWNhtg/Qm5ktJS7s58vdqoc6Q3ETV5KR6dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKJzqix7B+nPWm6iTDG3mKY8xCml1kjG02Q+SBMRb69KnE4Kl0O206EUle25QScIJ
         qdawomnn2xyW/JDMNQhwTMQRz1/M5Fv9Io9MN3jLKAzb+Pbkv2xiyEkQTQYPVHCO3H
         W8gqH2DyiZOOD0+ckJFFQK29TTzxcUV+zy56EPpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 117/183] cifs: fix rmmod regression in cifs.ko caused by force_sig changes
Date:   Tue, 28 Jan 2020 15:05:36 +0100
Message-Id: <20200128135841.627295546@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
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
index b608ce741444f..f44281a5eb9ff 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -939,6 +939,7 @@ cifs_demultiplex_thread(void *p)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
 
 	set_freezable();
+	allow_signal(SIGKILL);
 	while (server->tcpStatus != CifsExiting) {
 		if (try_to_freeze())
 			continue;
-- 
2.20.1



