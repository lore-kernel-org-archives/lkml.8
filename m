Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A129C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663F4206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975744;
	bh=kRqf6eaOCcK65OnImDGdlXk8P0aZqsLV1CBPAX5RI4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k76zW5uEFEBK3YqtGwG2rvsExXPh7rnjr6QeajPqwNp6duLrAPjjYhgugsYGiUaPJ
	 3gFb9GN/bLwmDmvhKgS9Icr/WOjGrKSxVaf2U+fM6sZwuWwGp5nKrGqBf+Sr7Emckb
	 ZADKZo+hb9AiKPGAjYv4TI+hWV2zW6vFsiuXVuUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgIAPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731872AbgIAPpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:45:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80634206FA;
        Tue,  1 Sep 2020 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975131;
        bh=kRqf6eaOCcK65OnImDGdlXk8P0aZqsLV1CBPAX5RI4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eX2se8c7ftj08TEUH3ti3+03PGF7Wo6JafkQtrpoEnzbZNN+EcNLsmJcUMe2DWC+e
         /EADV0xDa3EO+wzhWX9Vpy5dY1+/57PmzxHt6e/qN3tbu8KE0xOzl15VWBqeYMxFTi
         5elv5AhpVTjExeN07PobrES04CJsrfUEh4W+5xw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.8 214/255] drm/amdgpu: Fix buffer overflow in INFO ioctl
Date:   Tue,  1 Sep 2020 17:11:10 +0200
Message-Id: <20200901151010.957910511@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
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
@@ -663,8 +663,12 @@ static int amdgpu_info_ioctl(struct drm_
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


