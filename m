Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AACCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255EC24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699485;
	bh=BElaCkOda/ASxPVa60w9Uom3LiwB9M4TLjazoFdpulk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyUy7dFq1+fLWNZWnd3K9f8cH0o9ocuQ/KCojqwR/voJlNiJLPCZsMUxJ219iGXRq
	 Uw68Sq7+vDAvOuCdaLZxcZOZxxgdMSgXcSjwEWAQixB+9wWhXCaNqJ7Z0Nm0H16lef
	 XPSfX/0zQsrehNQoK9hV3IXSEBSTu+eUcyVz41+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgAVNYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgAVNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:24:41 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FC9205F4;
        Wed, 22 Jan 2020 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699480;
        bh=BElaCkOda/ASxPVa60w9Uom3LiwB9M4TLjazoFdpulk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHGbF060tE/tKR3NBTujTeOstPOcmJLbaFSBZrJVrJd8a9ve8PKSwX/DXjX5EMbQz
         YnQlI54KGLut1Uj9hoUVcj8HzOimhp8rncrPl6j9jsmDNvMnQPiSAGAcdCsAoLCRlH
         oQJOiJBWBQdsBUMBzi2RXD72P8/S4EKS0TA4NUzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, changzhu <Changfeng.Zhu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 159/222] drm/amdgpu: allow direct upload save restore list for raven2
Date:   Wed, 22 Jan 2020 10:29:05 +0100
Message-Id: <20200122092845.101869349@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: changzhu <Changfeng.Zhu@amd.com>

commit eebc7f4d7ffa09f2a620bd1e2c67ddd579118af9 upstream.

It will cause modprobe atombios stuck problem in raven2 if it doesn't
allow direct upload save restore list from gfx driver.
So it needs to allow direct upload save restore list for raven2
temporarily.

Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2923,7 +2923,9 @@ static void gfx_v9_0_init_pg(struct amdg
 	 * And it's needed by gfxoff feature.
 	 */
 	if (adev->gfx.rlc.is_rlc_v2_1) {
-		if (adev->asic_type == CHIP_VEGA12)
+		if (adev->asic_type == CHIP_VEGA12 ||
+		    (adev->asic_type == CHIP_RAVEN &&
+		     adev->rev_id >= 8))
 			gfx_v9_1_init_rlc_save_restore_list(adev);
 		gfx_v9_0_enable_save_restore_machine(adev);
 	}


