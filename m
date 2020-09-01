Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DFB206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979176;
	bh=UbfcBS2F40l2Ri3VjuXityfFN0aeN7ciV4mX6RdhXyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dawr1jW9aU9DD6v7je+ETG621qTiVvzB4E+iasZJUcdwW3V/MFjZmvYDF1RkbtFwY
	 qkwU3AwupZbhpzf6r5UDEZGfQT0PAAfLhC0akLqo4+3oIcHv8L9ijTITkYiLpB8Ue1
	 JXS15xsVkb9FTxhg2REymiaWzRmj+doXQiBiwyOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgIAQwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbgIAPZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D7820684;
        Tue,  1 Sep 2020 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973932;
        bh=UbfcBS2F40l2Ri3VjuXityfFN0aeN7ciV4mX6RdhXyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQuO+5rcsRVAPsrJEbGlSnO8cL29V+DS7qvMLf8GkhsYDFKruDB3/h1NmFL2aiK3R
         Xgyzomwxc45PXLJVYmcJjgidItQcta1+ymGiD9Ca1eruPyIkRzZcZzlPrvLq88mDtQ
         PuCh2/++193f9Kqmmg38tnVe6OLidbpkC4uE3/6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 105/125] drm/amdgpu: Fix buffer overflow in INFO ioctl
Date:   Tue,  1 Sep 2020 17:11:00 +0200
Message-Id: <20200901150939.757773885@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit b5b97cab55eb71daba3283c8b1d2cce456d511a1 upstream.

The values for "se_num" and "sh_num" come from the user in the ioctl.
They can be in the 0-255 range but if they're more than
AMDGPU_GFX_MAX_SE (4) or AMDGPU_GFX_MAX_SH_PER_SE (2) then it results in
an out of bounds read.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -524,8 +524,12 @@ static int amdgpu_info_ioctl(struct drm_
 		 * in the bitfields */
 		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
+		else if (se_num >= AMDGPU_GFX_MAX_SE)
+			return -EINVAL;
 		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
 			sh_num = 0xffffffff;
+		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
+			return -EINVAL;
 
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;


