Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DCC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB030208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845329;
	bh=WM+6gQC/u1UCuyRxHEy0/EwiMOIe8+N1pYqTLo0kF64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhoZEpfJ8rTFE9Fwb2KTqu5AXgwFmvCLplkLPgdulT6CDqGjOFk+PgsG4T3p2rqOR
	 d9Yg8FyDkS2blnYlA4B62Y+qXQTv2sCQKxMr19SxFkeuJqXSRPWepmW2OtrawTfsZF
	 Hti5BiOzqbXqiwcMRaiqTNkV7e/Wmirr7c0YPCoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCJNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgCJNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820D524649;
        Tue, 10 Mar 2020 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845325;
        bh=WM+6gQC/u1UCuyRxHEy0/EwiMOIe8+N1pYqTLo0kF64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUDPy8kp70LTtSpi3Yh2ypY6L8It/V6XM8HIlxLOQbeWPpCZxDCl3VD0prorOl0oD
         yb8k87VBh69xnz4tgtRgJik8AjjcV5MAu3h6JdCRAP/d0q1BN7LP+VfihsCmRGyIbR
         tJ+cjam+DxqYbHhECCuZZP/sGuP2nCVo5LcG8T5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phong LE <ple@baylibre.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 5.5 142/189] drm/mediatek: Handle component type MTK_DISP_OVL_2L correctly
Date:   Tue, 10 Mar 2020 13:39:39 +0100
Message-Id: <20200310123654.188930993@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong LE <ple@baylibre.com>

commit 3d2ed431b8f39483477bc3c3a2aefbc9778ffe12 upstream.

The larb device remains NULL if the type is MTK_DISP_OVL_2L.
A kernel panic is raised when a crtc uses mtk_smi_larb_get or
mtk_smi_larb_put.

Fixes: b17bdd0d7a73 ("drm/mediatek: add component OVL_2L0")

Signed-off-by: Phong LE <ple@baylibre.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -358,6 +358,7 @@ int mtk_ddp_comp_init(struct device *dev
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
+	    type != MTK_DISP_OVL_2L &&
 	    type != MTK_DISP_RDMA &&
 	    type != MTK_DISP_WDMA)
 		return 0;


