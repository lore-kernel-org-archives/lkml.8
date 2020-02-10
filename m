Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F34C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EC02080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341725;
	bh=Cp/VK6nfiVSaC+soGMfVisN6+gMQX5SyxkcYr2+iGkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gbZUiTvsxAYOsQNT9Wa5IaocZ7kjpUJjTidY0FqGKKuTuPyiubBXyZ0ShCLlpwb1l
	 Ob9DGxoaYupTPyndKc7e6+5Tkpea2NHoqRCCAgUWikfyF1enQQn2BLlvo3lPzuJpUi
	 3SWQgR6mK46seKA4Rx4pFPVaTj7OK09JUNHve6Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgBJNfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBJMfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:20 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721742467A;
        Mon, 10 Feb 2020 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338120;
        bh=Cp/VK6nfiVSaC+soGMfVisN6+gMQX5SyxkcYr2+iGkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4RUiq6EfBml9blAkWbO/1YSPnlXbqfmVP/FHm+9fO8TDyktrRpyBGytsr1blgS9z
         hzoFQJf6dIZll7DyjjFCH+uIom12pG6R+UY62b5mV7A7Ly5FHDsO/Did/ZKpxqBdM8
         aHol/OcorzEELyA7A7oeXFWJLDnpO5dt7yqUMNmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/195] smb3: fix signing verification of large reads
Date:   Mon, 10 Feb 2020 04:31:54 -0800
Message-Id: <20200210122311.487156021@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 46f17d17687e8140f2e4e517d7dfa65e62fcc5f4 ]

Code cleanup in the 5.1 kernel changed the array
passed into signing verification on large reads leading
to warning messages being logged when copying files to local
systems from remote.

   SMB signature verification returned error = -5

This changeset fixes verification of SMB3 signatures of large
reads.

Suggested-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3130,8 +3130,8 @@ smb2_readv_callback(struct mid_q_entry *
 	struct smb2_sync_hdr *shdr =
 				(struct smb2_sync_hdr *)rdata->iov[0].iov_base;
 	unsigned int credits_received = 0;
-	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 2,
+	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1],
+				 .rq_nvec = 1,
 				 .rq_pages = rdata->pages,
 				 .rq_offset = rdata->page_offset,
 				 .rq_npages = rdata->nr_pages,


