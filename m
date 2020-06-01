Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF002087D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036778;
	bh=XTK4PTgbowt2TP7bgKTHwyjcQMJPwmm0A2xMP+LiFEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=REDFoT5DHg5bPMvxUukS/aNfogAnujPWrWIX6fqaITSEiRObI93xspqQ55FVF+YHy
	 OS8XLiVnwRb5FKVN1PnaWw8WoiXVV4W5Bb1PuQtahMIjoWkGRqlzsiKh1TovTWCP2J
	 btDuEmT6M1X7ow6XbQuxYyUPTQwSYEOeBNwThhmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgFASjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbgFASOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDBA2065C;
        Mon,  1 Jun 2020 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035264;
        bh=XTK4PTgbowt2TP7bgKTHwyjcQMJPwmm0A2xMP+LiFEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J59cptPBgxvD3wLtKd0kh9GeLAK6h0z9F5//OJnveDq7hZLgKzLeJhmfk97BWHcPf
         V/bl2dWMGW9hF8UeDVojk77MbX/8/koLQ6dLwSNAfCIRSUI06vL2QVsvmGbwv0y1yN
         P5cuh2MRpZie+JqfCfUYvwdkpSL5BMbsAN40QAkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coverity <scan-admin@coverity.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 080/177] cifs: Fix null pointer check in cifs_read
Date:   Mon,  1 Jun 2020 19:53:38 +0200
Message-Id: <20200601174055.576690176@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 9bd21d4b1a767c3abebec203342f3820dcb84662 ]

Coverity scan noted a redundant null check

Coverity-id: 728517
Reported-by: Coverity <scan-admin@coverity.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Shyam Prasad N <nspmangalore@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 5920820bfbd0..b30b03747dd6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4060,7 +4060,7 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 			 * than it negotiated since it will refuse the read
 			 * then.
 			 */
-			if ((tcon->ses) && !(tcon->ses->capabilities &
+			if (!(tcon->ses->capabilities &
 				tcon->ses->server->vals->cap_large_files)) {
 				current_read_size = min_t(uint,
 					current_read_size, CIFSMaxBufSize);
-- 
2.25.1



