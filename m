Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B33C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36A92074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BI37NIjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFCHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFCHWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:22:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90EC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p30so1129591pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Mzj+4P6YyUKaBzY1zA3s1gowMthiSgt2iJhCfK00k6U=;
        b=BI37NIjki97mugGeK1q+0eA7Eji/emfrsOW1ZVQTClNqQnE19bN/1NLfQB6cPnzfIk
         MKYGRayBRabq++g1ta+9aWqvSYrJiSrGtme18cwBnQC7RR0oyh5pt7PqUiAEvSlHZiIQ
         hHQBIQcrDOiNerVjDjUJbOS5YF0kl+D3bVezLHDVNei9ZzRNaIlU+dySK+J50hGDv9O1
         bbcwG2bUdUdU4LDGaCebfuwroDDx2qcFizQWvv51kOy8EVmO0Ok/ylisI2R/MGZWY3Gd
         NfJt/vA6M7DE/AqGOauvk53ennY/56r5jVbvoHUmqALEuKyGl63s628txi8+rvI92pnj
         asvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Mzj+4P6YyUKaBzY1zA3s1gowMthiSgt2iJhCfK00k6U=;
        b=uf+rCA3UD8JlyqCJEx+6KYKINoROUVOoFnjum4oEI08+iSIOwYHng4wPTxjnrOEfho
         IRmwAT4i9V5rBKh8XinFuJIRcj/ymCosfqq1JIAK27A+GdZ4s0nzprmantItn3mxz/oE
         gDMQWDCVt7sbZa11QX4oUmJNeScgDiFNhRHHw/lrKadRQ2cJcqeS7QeTaFhU9XzALdIG
         cBjrbLcpHGjeuExc8BzS1bdKrM3kUHSAERd7IWfUX+e9wSGKAmOv2uvPzTOKfLqDr+EY
         1MfR49Xb8PepHmaTgFDgsB8Kgo3Y5YGVhBBSpznN3pd3MjeLGVPr5Xer5DdSNBrMCiEi
         uRsg==
X-Gm-Message-State: AOAM5337tJ5ZUwzlLnCwDCdXHOr/FtuWuTi+s4Lq/73CUeaFKDDZGfAz
        d5fOr/P3ldsMHLh08TPgVsoJ
X-Google-Smtp-Source: ABdhPJw0Nlb30CTkhejSyv5b3Dz1LVDkw16PIbLMhaRIvo/aZfuJmqJZ8VUvExleC4lztiNntV6U/w==
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr4063507pjb.32.1591168962855;
        Wed, 03 Jun 2020 00:22:42 -0700 (PDT)
Received: from ?IPv6:2409:4072:6e19:d568:fc3d:9e72:444d:f928? ([2409:4072:6e19:d568:fc3d:9e72:444d:f928])
        by smtp.gmail.com with ESMTPSA id ev20sm1500940pjb.8.2020.06.03.00.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:41 -0700 (PDT)
Date:   Wed, 03 Jun 2020 12:52:34 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <1591119192-18538-2-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com> <1591119192-18538-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 01/10] dmaengine: Actions: get rid of bit fields from dma descriptor
To:     Amit Singh Tomar <amittomer25@gmail.com>, andre.przywara@arm.com,
        vkoul@kernel.org, afaerber@suse.de
CC:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <3D3E2940-11E3-4093-8F60-82EB2C11B617@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 June 2020 11:03:03 PM IST, Amit Singh Tomar <amittomer25@gmail=2Ecom>=
 wrote:
>At the moment, Driver uses bit fields to describe registers of the DMA
>descriptor structure that makes it less portable and maintainable, and
>Andre suugested(and even sketched important bits for it) to make use of
>array to describe this DMA descriptors instead=2E It gives the
>flexibility
>while extending support for other platform such as Actions S700=2E
>
>This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
>uses array to describe DMA descriptor=2E
>
>Suggested-by: Andre Przywara <andre=2Eprzywara@arm=2Ecom>
>Signed-off-by: Amit Singh Tomar <amittomer25@gmail=2Ecom>
>---
>Changes since v2:
>	* No change=2E
>Changes since v1:
>        * Defined macro for frame count value=2E
>        * Introduced llc_hw_flen() from patch 2/9=2E
>        * Removed the unnecessary line break=2E
>Changes since rfc:
>        * No change=2E
>---
>drivers/dma/owl-dma=2Ec | 84
>++++++++++++++++++++++++---------------------------
> 1 file changed, 40 insertions(+), 44 deletions(-)
>
>diff --git a/drivers/dma/owl-dma=2Ec b/drivers/dma/owl-dma=2Ec
>index c683051257fd=2E=2Edd85c205454e 100644
>--- a/drivers/dma/owl-dma=2Ec
>+++ b/drivers/dma/owl-dma=2Ec
>@@ -120,30 +120,21 @@
> #define BIT_FIELD(val, width, shift, newshift)	\
> 		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
>=20
>-/**
>- * struct owl_dma_lli_hw - Hardware link list for dma transfer
>- * @next_lli: physical address of the next link list
>- * @saddr: source physical address
>- * @daddr: destination physical address
>- * @flen: frame length
>- * @fcnt: frame count
>- * @src_stride: source stride
>- * @dst_stride: destination stride
>- * @ctrla: dma_mode and linklist ctrl config
>- * @ctrlb: interrupt config
>- * @const_num: data for constant fill
>- */
>-struct owl_dma_lli_hw {
>-	u32	next_lli;
>-	u32	saddr;
>-	u32	daddr;
>-	u32	flen:20;
>-	u32	fcnt:12;
>-	u32	src_stride;
>-	u32	dst_stride;
>-	u32	ctrla;
>-	u32	ctrlb;
>-	u32	const_num;
>+/* Frame count value is fixed as 1 */
>+#define FCNT_VAL				0x1
>+
>+/* Describe DMA descriptor, hardware link list for dma transfer */

Individual comments for these enums?=20

>+enum owl_dmadesc_offsets {
>+	OWL_DMADESC_NEXT_LLI =3D 0,
>+	OWL_DMADESC_SADDR,
>+	OWL_DMADESC_DADDR,
>+	OWL_DMADESC_FLEN,
>+	OWL_DMADESC_SRC_STRIDE,
>+	OWL_DMADESC_DST_STRIDE,
>+	OWL_DMADESC_CTRLA,
>+	OWL_DMADESC_CTRLB,
>+	OWL_DMADESC_CONST_NUM,
>+	OWL_DMADESC_SIZE
> };
>=20
> /**
>@@ -153,7 +144,7 @@ struct owl_dma_lli_hw {
>  * @node: node for txd's lli_list
>  */
> struct owl_dma_lli {
>-	struct  owl_dma_lli_hw	hw;
>+	u32			hw[OWL_DMADESC_SIZE];
> 	dma_addr_t		phys;
> 	struct list_head	node;
> };
>@@ -320,6 +311,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
> 	return ctl;
> }
>=20
>+static u32 llc_hw_flen(struct owl_dma_lli *lli)
>+{
>+	return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
>+}
>+
> static void owl_dma_free_lli(struct owl_dma *od,
> 			     struct owl_dma_lli *lli)
> {
>@@ -351,8 +347,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct
>owl_dma_txd *txd,
> 		list_add_tail(&next->node, &txd->lli_list);
>=20
> 	if (prev) {
>-		prev->hw=2Enext_lli =3D next->phys;
>-		prev->hw=2Ectrla |=3D llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
>+		prev->hw[OWL_DMADESC_NEXT_LLI] =3D next->phys;
>+		prev->hw[OWL_DMADESC_CTRLA] |=3D
>+					llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
> 	}
>=20
> 	return next;
>@@ -365,8 +362,7 @@ static inline int owl_dma_cfg_lli(struct
>owl_dma_vchan *vchan,
> 				  struct dma_slave_config *sconfig,
> 				  bool is_cyclic)
> {
>-	struct owl_dma_lli_hw *hw =3D &lli->hw;
>-	u32 mode;
>+	u32 mode, ctrlb;
>=20
> 	mode =3D OWL_DMA_MODE_PW(0);
>=20
>@@ -407,22 +403,22 @@ static inline int owl_dma_cfg_lli(struct
>owl_dma_vchan *vchan,
> 		return -EINVAL;
> 	}
>=20
>-	hw->next_lli =3D 0; /* One link list by default */
>-	hw->saddr =3D src;
>-	hw->daddr =3D dst;
>-
>-	hw->fcnt =3D 1; /* Frame count fixed as 1 */
>-	hw->flen =3D len; /* Max frame length is 1MB */
>-	hw->src_stride =3D 0;
>-	hw->dst_stride =3D 0;
>-	hw->ctrla =3D llc_hw_ctrla(mode,
>-				 OWL_DMA_LLC_SAV_LOAD_NEXT |
>-				 OWL_DMA_LLC_DAV_LOAD_NEXT);
>+	lli->hw[OWL_DMADESC_CTRLA] =3D llc_hw_ctrla(mode,
>+						  OWL_DMA_LLC_SAV_LOAD_NEXT |
>+						  OWL_DMA_LLC_DAV_LOAD_NEXT);
>=20
> 	if (is_cyclic)
>-		hw->ctrlb =3D llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
>+		ctrlb =3D llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
> 	else
>-		hw->ctrlb =3D llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
>+		ctrlb =3D llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
>+
>+	lli->hw[OWL_DMADESC_NEXT_LLI] =3D 0;

Again, please preserve the old comments=2E=20

>+	lli->hw[OWL_DMADESC_SADDR] =3D src;
>+	lli->hw[OWL_DMADESC_DADDR] =3D dst;
>+	lli->hw[OWL_DMADESC_SRC_STRIDE] =3D 0;
>+	lli->hw[OWL_DMADESC_DST_STRIDE] =3D 0;
>+	lli->hw[OWL_DMADESC_FLEN] =3D len | FCNT_VAL << 20;

Please explain what you're doing here=2E=20

Thanks,=20
Mani

>+	lli->hw[OWL_DMADESC_CTRLB] =3D ctrlb;
>=20
> 	return 0;
> }
>@@ -754,7 +750,7 @@ static u32 owl_dma_getbytes_chan(struct
>owl_dma_vchan *vchan)
> 			/* Start from the next active node */
> 			if (lli->phys =3D=3D next_lli_phy) {
> 				list_for_each_entry(lli, &txd->lli_list, node)
>-					bytes +=3D lli->hw=2Eflen;
>+					bytes +=3D llc_hw_flen(lli);
> 				break;
> 			}
> 		}
>@@ -785,7 +781,7 @@ static enum dma_status owl_dma_tx_status(struct
>dma_chan *chan,
> 	if (vd) {
> 		txd =3D to_owl_txd(&vd->tx);
> 		list_for_each_entry(lli, &txd->lli_list, node)
>-			bytes +=3D lli->hw=2Eflen;
>+			bytes +=3D llc_hw_flen(lli);
> 	} else {
> 		bytes =3D owl_dma_getbytes_chan(vchan);
> 	}

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
