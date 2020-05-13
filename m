Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024DBC2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B0F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363979;
	bh=Vae0fk5GS9SZU20EL2GBC91oaHbAV1FQMj0hlsKvD1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJgxDKuYPJwN0Q1v3ku7ksW/0C2K5S2b8hqcIIFxt3lKxDRBJRR7JazjWsrkH/Su2
	 0PfspBKSD87f4VSvecrO6f5bkC3e64okgLMFfhsYTKRPDDfn3CpAP9CTqANxLu09wL
	 M6Utbg7u4qsMcssVlij0fSz1QkLuS4iRI/bI7riI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbgEMJ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbgEMJxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B62420753;
        Wed, 13 May 2020 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363579;
        bh=Vae0fk5GS9SZU20EL2GBC91oaHbAV1FQMj0hlsKvD1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAGstLg4/a/SPpyce5d2I95rf9jVzFFWSHXP6gtwFIIbOmbDROu9C8AX/dnCUdnZJ
         zL9UhlZMmeBa/u9Q8ZDruxHkETWTjm5bsUgLP4yXwJKc0QEDne/vRBFRmoRPtLyMT4
         kvs5Wqufnz1DAR0TWTsReJF8jo/bgKBeM3D7G21s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 042/118] bnxt_en: Reduce BNXT_MSIX_VEC_MAX value to supported CQs per PF.
Date:   Wed, 13 May 2020 11:44:21 +0200
Message-Id: <20200513094421.011852152@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 9e68cb0359b20f99c7b070f1d3305e5e0a9fae6d ]

Broadcom adapters support only maximum of 512 CQs per PF. If user sets
MSIx vectors more than supported CQs, firmware is setting incorrect value
for msix_vec_per_pf_max parameter. Fix it by reducing the BNXT_MSIX_VEC_MAX
value to 512, even though the maximum # of MSIx vectors supported by adapter
are 1280.

Fixes: f399e8497826 ("bnxt_en: Use msix_vec_per_pf_max and msix_vec_per_pf_min devlink params.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
@@ -43,7 +43,7 @@ static inline void bnxt_link_bp_to_dl(st
 #define BNXT_NVM_CFG_VER_BITS		24
 #define BNXT_NVM_CFG_VER_BYTES		4
 
-#define BNXT_MSIX_VEC_MAX	1280
+#define BNXT_MSIX_VEC_MAX	512
 #define BNXT_MSIX_VEC_MIN_MAX	128
 
 enum bnxt_nvm_dir_type {


