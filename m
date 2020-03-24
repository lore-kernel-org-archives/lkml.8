Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6824DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42087208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055641;
	bh=7nN6GI7/68woCdwk5Vi3mTAd6ov6wAQsoBiRvtFyc1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TTR9D8l63m7M0Y/8MOVZZ9nJNXouPbTWQ8bLPGWQfL6jn8p2WSBml48DjYE3zdop3
	 wO5bZd+92SXeI3+ZX8I9IEwe0VwHnXybbXmp2DG0A+GUbqSINo+uy0GlX8gfI4WInZ
	 je1LrhuwKdWurTKGb1gHz4gnllz7qrAJZKL5ELOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCXNN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2092D20775;
        Tue, 24 Mar 2020 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055637;
        bh=7nN6GI7/68woCdwk5Vi3mTAd6ov6wAQsoBiRvtFyc1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD7yfbsw4+fGOczmvKx3BNUwi1fV9WEygBzZ6xR7w2vN2Jp3PUrvOjcYAkrHKW132
         vhy8qJ+B0U5Idej4iE48ZZAVZaG/woZAa55Lb+36ujVoxajsf8AGGvjZCk9ADb74WT
         wnujAVok/KaQouXfe5XKRG+jh2uVprNpb87Xwk+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom St Denis <tom.stdenis@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 45/65] drm/amd/amdgpu: Fix GPR read from debugfs (v2)
Date:   Tue, 24 Mar 2020 14:11:06 +0100
Message-Id: <20200324130802.708594637@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom St Denis <tom.stdenis@amd.com>

commit 5bbc6604a62814511c32f2e39bc9ffb2c1b92cbe upstream.

The offset into the array was specified in bytes but should
be in terms of 32-bit words.  Also prevent large reads that
would also cause a buffer overread.

v2:  Read from correct offset from internal storage buffer.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -694,11 +694,11 @@ static ssize_t amdgpu_debugfs_gpr_read(s
 	ssize_t result = 0;
 	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
 
-	if (size & 3 || *pos & 3)
+	if (size > 4096 || size & 3 || *pos & 3)
 		return -EINVAL;
 
 	/* decode offset */
-	offset = *pos & GENMASK_ULL(11, 0);
+	offset = (*pos & GENMASK_ULL(11, 0)) >> 2;
 	se = (*pos & GENMASK_ULL(19, 12)) >> 12;
 	sh = (*pos & GENMASK_ULL(27, 20)) >> 20;
 	cu = (*pos & GENMASK_ULL(35, 28)) >> 28;
@@ -729,7 +729,7 @@ static ssize_t amdgpu_debugfs_gpr_read(s
 	while (size) {
 		uint32_t value;
 
-		value = data[offset++];
+		value = data[result >> 2];
 		r = put_user(value, (uint32_t *)buf);
 		if (r) {
 			result = r;


