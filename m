Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC12C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3822078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135608;
	bh=F9AAXq3WyiyVkmMDHTVrKFjPsKwV51hexrXei98OIMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVbjGMJ+5Y7jKKN070Xqya5/oK1fehp9HsjSUC1Wd0/IxBfsFBC7fkdiPMYqY5U7Q
	 JZvfj0mCSG/bb5GGW49YxAh1pIq17p29TNg40kEfvFXnVTzBAk86ANuwSCKnMXBiBq
	 hGLOhq16od30NXS9J9zhJNuA/4lJWHjZBSF+Ni4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgGGP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgGGP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:26:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A27D2082E;
        Tue,  7 Jul 2020 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135602;
        bh=F9AAXq3WyiyVkmMDHTVrKFjPsKwV51hexrXei98OIMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abSAiYD2I0gXhq/RBVfQ3YYAQ1iIH1EoMwNitkfOhIV2GfqpWPzn5Z0KvC5lsJ7+b
         eMtPIgyK6EKXr06obMCvndIK1RvhlEBgwsHErJLkz10iHgJB+SRH3VCpkRFBOzaY/4
         VgDX/xrS9+kCk91o9ZqU3LB9lSTasPetwmZSa+Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 106/112] drm/amdgpu/atomfirmware: fix vram_info fetching for renoir
Date:   Tue,  7 Jul 2020 17:17:51 +0200
Message-Id: <20200707145806.013939258@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit d7a6634a4cfba073ff6a526cb4265d6e58ece234 upstream.

Renoir uses integrated_system_info table v12.  The table
has the same layout as v11 with respect to this data.  Just
reuse the existing code for v12 for stable.

Fixes incorrectly reported vram info in the driver output.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -204,6 +204,7 @@ amdgpu_atomfirmware_get_vram_info(struct
 				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 11:
+			case 12:
 				mem_channel_number = igp_info->v11.umachannelnumber;
 				/* channel width is 64 */
 				if (vram_width)


