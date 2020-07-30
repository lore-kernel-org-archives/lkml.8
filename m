Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E69C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7163620809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/orq+8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgG3VlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgG3VlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:41:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3EAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:41:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so2311420plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ocydU7RBdM931wAuOmouhOZF/llilb2u8cyvM4WgXKA=;
        b=H/orq+8bAOhHRPyGVO4tjyn5z1eaRpmfdUtYljbMQUuZANTmU4UqYLW7UmEPEw2beN
         zOCKCt+Vi5GB5HkyJYqgG6CJQL064gYX9zX6mvXtp/9RaYbQ+Q6wBYZVS2j4Oj+5qPCM
         VmobqIMhmPIEBMBoP3WBwRd39jEd8popO2t/EmZHYPSfr7odgu8aYAOuX7pkkGLJJik+
         nqw2Qgr6Q1nSCQds7Nq02S5angyFUwwb9oIAuoT4SIViYdHPg+4hZ7L2fhcUPnWPi5bD
         PBaEiavqZfyLcyqlL2ejr3K2pq0Yf1t1yr+VVTbbaIkwhSbuhShC3dz04r+iPvHjpcVk
         0VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocydU7RBdM931wAuOmouhOZF/llilb2u8cyvM4WgXKA=;
        b=cqtin+KTrvq4XxFxFXJN2ls6ZCTpkceljhQs736V8I3hJXTmcDFUvN+U6cdSmaD2WK
         fmwmdK4jP+Cdr0YHKEQF+PEsuWrx1xIkLucFou/IdAJ+zhjCil0wLSM/yC4+sz63tuh8
         jS+xYUryUq9ml/Cd4NHnykqcDmccjjfi24eZiOBIbC2V/2GV3px6FHipUIZ4YpIte4mW
         NKP9crbH/uu/C6iQPz8urx+j5f/ygRt8cKvITPr31L22T5AT8xsqcq6Qw4G/G4HQXHn2
         g1l7RIv67BxHWd6FzyC6HAI7H+6rOtmEeb37K6tmShKRinoqkrNRdw9g+EsP9ngBA8ad
         woqg==
X-Gm-Message-State: AOAM533pZ/9xJBsOOCUgB0dLjXnTioZN04BML642QbfNcPZGW4klQ0Zm
        LuOdEA1oSW1TLDy3w7pOpcz45wAhSZE=
X-Google-Smtp-Source: ABdhPJw21ukEAQiWgnde2YMK5K4btFCJIGSbK2abPlqIfA7bB+OrOH6CWxxwKfxHa+4BM0apFMmvpw==
X-Received: by 2002:a17:90a:cc:: with SMTP id v12mr984410pjd.96.1596145273527;
        Thu, 30 Jul 2020 14:41:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c17sm2549549pfp.214.2020.07.30.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 14:41:12 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:41:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 09/14] coresight: etm4x: Add sysreg access helpers
Message-ID: <20200730214110.GF3155687@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-10-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-10-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:35PM +0100, Suzuki K Poulose wrote:
> ETMv4.4 architecture defines the system instructions for accessing
> ETM via register accesses. Add basic support for accessing a given
> register via system instructions.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c |  39 ++
>  drivers/hwtracing/coresight/coresight-etm4x.h | 379 ++++++++++++++++--
>  2 files changed, 394 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index b901c91d3ee4..e37aababa4c9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -57,6 +57,45 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>  
>  static enum cpuhp_state hp_online;
>  
> +u64 etm4x_sysreg_read(struct csdev_access *csa,
> +		      u32 offset,
> +		      bool _relaxed,
> +		      bool _64bit)
> +{
> +	u64 res = 0;
> +
> +	if (!_relaxed)
> +		mb();	/* Imitate the !relaxed I/O helpers */
> +
> +	switch (offset) {
> +	ETM4x_READ_CASES(res)
> +	default :
> +		WARN_ONCE(1, "etm4x: trying to read unsupported register @%x\n",
> +			 offset);
> +	}
> +
> +	return res;
> +}
> +
> +void etm4x_sysreg_write(struct csdev_access *csa,
> +			u64 val,
> +			u32 offset,
> +			bool _relaxed,
> +			bool _64bit)
> +{
> +	if (!_relaxed)
> +		mb();	/* Imitate the !relaxed I/O helpers */
> +	if (!_64bit)
> +		val &= GENMASK(31, 0);
> +
> +	switch (offset) {
> +	ETM4x_WRITE_CASES(val)
> +	default :
> +		WARN_ONCE(1, "etm4x: trying to write to unsupported register @%x\n",
> +			offset);
> +	}
> +}
> +
>  static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
>  {
>  	/* Writing 0 to TRCOSLAR unlocks the trace registers */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 2b51d03ab6d7..f5d708206339 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -44,13 +44,13 @@
>  #define TRCVDSACCTLR			0x0A4
>  #define TRCVDARCCTLR			0x0A8
>  /* Derived resources registers */
> -#define TRCSEQEVRn(n)			(0x100 + (n * 4))
> +#define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
>  #define TRCSEQRSTEVR			0x118
>  #define TRCSEQSTR			0x11C
>  #define TRCEXTINSELR			0x120
> -#define TRCCNTRLDVRn(n)			(0x140 + (n * 4))
> -#define TRCCNTCTLRn(n)			(0x150 + (n * 4))
> -#define TRCCNTVRn(n)			(0x160 + (n * 4))
> +#define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
>  /* ID registers */
>  #define TRCIDR8				0x180
>  #define TRCIDR9				0x184
> @@ -59,7 +59,7 @@
>  #define TRCIDR12			0x190
>  #define TRCIDR13			0x194
>  #define TRCIMSPEC0			0x1C0
> -#define TRCIMSPECn(n)			(0x1C0 + (n * 4))
> +#define TRCIMSPECn(n)			(0x1C0 + (n * 4)) /* n = 1-7 */
>  #define TRCIDR0				0x1E0
>  #define TRCIDR1				0x1E4
>  #define TRCIDR2				0x1E8
> @@ -68,9 +68,12 @@
>  #define TRCIDR5				0x1F4
>  #define TRCIDR6				0x1F8
>  #define TRCIDR7				0x1FC
> -/* Resource selection registers */
> +/*
> + * Resource selection registers, n = 2-31.
> + * First pair (regs 0, 1) is always present and is reserved.
> + */
>  #define TRCRSCTLRn(n)			(0x200 + (n * 4))
> -/* Single-shot comparator registers */
> +/* Single-shot comparator registers, n = 0-7 */
>  #define TRCSSCCRn(n)			(0x280 + (n * 4))
>  #define TRCSSCSRn(n)			(0x2A0 + (n * 4))
>  #define TRCSSPCICRn(n)			(0x2C0 + (n * 4))
> @@ -80,11 +83,13 @@
>  #define TRCPDCR				0x310
>  #define TRCPDSR				0x314
>  /* Trace registers (0x318-0xEFC) */
> -/* Comparator registers */
> +/* Address Comparator registers n = 0-15 */
>  #define TRCACVRn(n)			(0x400 + (n * 8))
>  #define TRCACATRn(n)			(0x480 + (n * 8))
> +/* Data Value Comparator Value registers, n = 0-7 */
>  #define TRCDVCVRn(n)			(0x500 + (n * 16))
>  #define TRCDVCMRn(n)			(0x580 + (n * 16))
> +/* ContextID/Virtual ContextID comparators, n = 0-7 */

Extra documentation is good but it has to be in a separate patch.

>  #define TRCCIDCVRn(n)			(0x600 + (n * 8))
>  #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
>  #define TRCCIDCCTLR0			0x680
> @@ -120,29 +125,345 @@
>  #define TRCCIDR2			0xFF8
>  #define TRCCIDR3			0xFFC
>  
> -#define etm4x_relaxed_read32(csa, offset)		\
> -	readl_relaxed((csa)->base + (offset))
> +/*
> + * System instructions to access ETM registers.
> + * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> + */
> +#define ETM4x_OFFSET_TO_REG(x)		((x) >> 2)
> +
> +#if defined(CONFIG_ARM64)
> +
> +#define ETM4x_CRn(n)			(((n) >> 7) & 0x7)
> +#define ETM4x_Op2(n)			(((n) >> 4) & 0x7)
> +#define ETM4x_CRm(n)			((n) & 0xf)
> +
> +#include <asm/sysreg.h>
> +#define ETM4x_REG_NUM_TO_SYSREG(n)				\
> +	sys_reg(2, 1, ETM4x_CRn(n), ETM4x_CRm(n), ETM4x_Op2(n))
> +
> +#define READ_ETM4x_REG(reg)					\
> +	read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
> +#define WRITE_ETM4x_REG(val, reg)				\
> +	write_sysreg_s(val, ETM4x_REG_NUM_TO_SYSREG((reg)))
>  
> -#define etm4x_read32(csa, offset)			\
> -	readl((csa)->base + (offset))
> +#define read_etm4x_sysreg_const_offset(offset)			\
> +	READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
>  
> -#define etm4x_relaxed_write32(csa, val, offset)		\
> -	writel_relaxed((val), (csa)->base + (offset))
> +#define write_etm4x_sysreg_const_offset(val, offset)		\
> +	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
>  
> -#define etm4x_write32(csa, val, offset)			\
> -	writel((val), (csa)->base + (offset))
> +#elif defined(CONFIG_ARM)
>  
> -#define etm4x_relaxed_read64(csa, offset)		\
> -	readq_relaxed((csa)->base + (offset))
> +#include <asm/hardware/cp14.h>
>  
> -#define etm4x_read64(csa, offset)			\
> -	readq((csa)->base + (offset))
> +#define etm4x_cp14_CRn(n)		__stringify(ETM4x_CRn(n))
> +#define etm4x_cp14_CRm(n)		__stringify(ETM4x_CRm(n))
> +#define etm4x_cp14_Op2(n)		__stringify(ETM4x_Op2(n))
>  
> -#define etm4x_relaxed_write64(csa, val, offset)		\
> -	writeq_relaxed((val), (csa)->base + (offset))
> +#define READ_ETM4x_REG(reg)				\
> +	MRC14(1, ETM4x_CRn(reg), ETM4x_CRm(reg), ETM4x_Op2(reg))
> +
> +#define read_etm4x_sysreg_const_offset(offset)				\
> +	READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
> +
> +#define WRITE_ETM4x_REG(val, reg)		\
> +	MCR14((val), 1, ETM4x_CRn((reg)), ETM4x_CRm((reg)), ETM4x_Op2((reg)))
> +
> +#define write_etm4x_sysreg_const_offset(val, offset)		\
> +	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
> +
> +#endif
> +
> +#define CASE_READ(res, x)					\
> +	case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
> +
> +#define CASE_WRITE(val, x)					\
> +	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
> +
> +#define CASE_LIST(op, val)			\
> +	CASE_##op((val), TRCPRGCTLR)		\
> +	CASE_##op((val), TRCPROCSELR)		\
> +	CASE_##op((val), TRCSTATR)		\
> +	CASE_##op((val), TRCCONFIGR)		\
> +	CASE_##op((val), TRCAUXCTLR)		\
> +	CASE_##op((val), TRCEVENTCTL0R)		\
> +	CASE_##op((val), TRCEVENTCTL1R)		\
> +	CASE_##op((val), TRCSTALLCTLR)		\
> +	CASE_##op((val), TRCTSCTLR)		\
> +	CASE_##op((val), TRCSYNCPR)		\
> +	CASE_##op((val), TRCCCCTLR)		\
> +	CASE_##op((val), TRCBBCTLR)		\
> +	CASE_##op((val), TRCTRACEIDR)		\
> +	CASE_##op((val), TRCQCTLR)		\
> +	CASE_##op((val), TRCVICTLR)		\
> +	CASE_##op((val), TRCVIIECTLR)		\
> +	CASE_##op((val), TRCVISSCTLR)		\
> +	CASE_##op((val), TRCVIPCSSCTLR)		\
> +	CASE_##op((val), TRCVDCTLR)		\
> +	CASE_##op((val), TRCVDSACCTLR)		\
> +	CASE_##op((val), TRCVDARCCTLR)		\
> +	CASE_##op((val), TRCSEQEVRn(0))		\
> +	CASE_##op((val), TRCSEQEVRn(1))		\
> +	CASE_##op((val), TRCSEQEVRn(2))		\
> +	CASE_##op((val), TRCSEQRSTEVR)		\
> +	CASE_##op((val), TRCSEQSTR)		\
> +	CASE_##op((val), TRCEXTINSELR)		\
> +	CASE_##op((val), TRCCNTRLDVRn(0))	\
> +	CASE_##op((val), TRCCNTRLDVRn(1))	\
> +	CASE_##op((val), TRCCNTRLDVRn(2))	\
> +	CASE_##op((val), TRCCNTRLDVRn(3))	\
> +	CASE_##op((val), TRCCNTCTLRn(0))	\
> +	CASE_##op((val), TRCCNTCTLRn(1))	\
> +	CASE_##op((val), TRCCNTCTLRn(2))	\
> +	CASE_##op((val), TRCCNTCTLRn(3))	\
> +	CASE_##op((val), TRCCNTVRn(0))		\
> +	CASE_##op((val), TRCCNTVRn(1))		\
> +	CASE_##op((val), TRCCNTVRn(2))		\
> +	CASE_##op((val), TRCCNTVRn(3))		\
> +	CASE_##op((val), TRCIDR8)		\
> +	CASE_##op((val), TRCIDR9)		\
> +	CASE_##op((val), TRCIDR10)		\
> +	CASE_##op((val), TRCIDR11)		\
> +	CASE_##op((val), TRCIDR12)		\
> +	CASE_##op((val), TRCIDR13)		\
> +	CASE_##op((val), TRCIMSPECn(0))		\
> +	CASE_##op((val), TRCIMSPECn(1))		\
> +	CASE_##op((val), TRCIMSPECn(2))		\
> +	CASE_##op((val), TRCIMSPECn(3))		\
> +	CASE_##op((val), TRCIMSPECn(4))		\
> +	CASE_##op((val), TRCIMSPECn(5))		\
> +	CASE_##op((val), TRCIMSPECn(6))		\
> +	CASE_##op((val), TRCIMSPECn(7))		\
> +	CASE_##op((val), TRCIDR0)		\
> +	CASE_##op((val), TRCIDR1)		\
> +	CASE_##op((val), TRCIDR2)		\
> +	CASE_##op((val), TRCIDR3)		\
> +	CASE_##op((val), TRCIDR4)		\
> +	CASE_##op((val), TRCIDR5)		\
> +	CASE_##op((val), TRCIDR6)		\
> +	CASE_##op((val), TRCIDR7)		\
> +	CASE_##op((val), TRCRSCTLRn(2))		\
> +	CASE_##op((val), TRCRSCTLRn(3))		\
> +	CASE_##op((val), TRCRSCTLRn(4))		\
> +	CASE_##op((val), TRCRSCTLRn(5))		\
> +	CASE_##op((val), TRCRSCTLRn(6))		\
> +	CASE_##op((val), TRCRSCTLRn(7))		\
> +	CASE_##op((val), TRCRSCTLRn(8))		\
> +	CASE_##op((val), TRCRSCTLRn(9))		\
> +	CASE_##op((val), TRCRSCTLRn(10))	\
> +	CASE_##op((val), TRCRSCTLRn(11))	\
> +	CASE_##op((val), TRCRSCTLRn(12))	\
> +	CASE_##op((val), TRCRSCTLRn(13))	\
> +	CASE_##op((val), TRCRSCTLRn(14))	\
> +	CASE_##op((val), TRCRSCTLRn(15))	\
> +	CASE_##op((val), TRCRSCTLRn(16))	\
> +	CASE_##op((val), TRCRSCTLRn(17))	\
> +	CASE_##op((val), TRCRSCTLRn(18))	\
> +	CASE_##op((val), TRCRSCTLRn(19))	\
> +	CASE_##op((val), TRCRSCTLRn(20))	\
> +	CASE_##op((val), TRCRSCTLRn(21))	\
> +	CASE_##op((val), TRCRSCTLRn(22))	\
> +	CASE_##op((val), TRCRSCTLRn(23))	\
> +	CASE_##op((val), TRCRSCTLRn(24))	\
> +	CASE_##op((val), TRCRSCTLRn(25))	\
> +	CASE_##op((val), TRCRSCTLRn(26))	\
> +	CASE_##op((val), TRCRSCTLRn(27))	\
> +	CASE_##op((val), TRCRSCTLRn(28))	\
> +	CASE_##op((val), TRCRSCTLRn(29))	\
> +	CASE_##op((val), TRCRSCTLRn(30))	\
> +	CASE_##op((val), TRCRSCTLRn(31))	\
> +	CASE_##op((val), TRCSSCCRn(0))		\
> +	CASE_##op((val), TRCSSCCRn(1))		\
> +	CASE_##op((val), TRCSSCCRn(2))		\
> +	CASE_##op((val), TRCSSCCRn(3))		\
> +	CASE_##op((val), TRCSSCCRn(4))		\
> +	CASE_##op((val), TRCSSCCRn(5))		\
> +	CASE_##op((val), TRCSSCCRn(6))		\
> +	CASE_##op((val), TRCSSCCRn(7))		\
> +	CASE_##op((val), TRCSSCSRn(0))		\
> +	CASE_##op((val), TRCSSCSRn(1))		\
> +	CASE_##op((val), TRCSSCSRn(2))		\
> +	CASE_##op((val), TRCSSCSRn(3))		\
> +	CASE_##op((val), TRCSSCSRn(4))		\
> +	CASE_##op((val), TRCSSCSRn(5))		\
> +	CASE_##op((val), TRCSSCSRn(6))		\
> +	CASE_##op((val), TRCSSCSRn(7))		\
> +	CASE_##op((val), TRCSSPCICRn(0))	\
> +	CASE_##op((val), TRCSSPCICRn(1))	\
> +	CASE_##op((val), TRCSSPCICRn(2))	\
> +	CASE_##op((val), TRCSSPCICRn(3))	\
> +	CASE_##op((val), TRCSSPCICRn(4))	\
> +	CASE_##op((val), TRCSSPCICRn(5))	\
> +	CASE_##op((val), TRCSSPCICRn(6))	\
> +	CASE_##op((val), TRCSSPCICRn(7))	\
> +	CASE_##op((val), TRCOSLAR)		\
> +	CASE_##op((val), TRCOSLSR)		\
> +	CASE_##op((val), TRCPDCR)		\
> +	CASE_##op((val), TRCPDSR)		\
> +	CASE_##op((val), TRCACVRn(0))		\
> +	CASE_##op((val), TRCACVRn(1))		\
> +	CASE_##op((val), TRCACVRn(2))		\
> +	CASE_##op((val), TRCACVRn(3))		\
> +	CASE_##op((val), TRCACVRn(4))		\
> +	CASE_##op((val), TRCACVRn(5))		\
> +	CASE_##op((val), TRCACVRn(6))		\
> +	CASE_##op((val), TRCACVRn(7))		\
> +	CASE_##op((val), TRCACVRn(8))		\
> +	CASE_##op((val), TRCACVRn(9))		\
> +	CASE_##op((val), TRCACVRn(10))		\
> +	CASE_##op((val), TRCACVRn(11))		\
> +	CASE_##op((val), TRCACVRn(12))		\
> +	CASE_##op((val), TRCACVRn(13))		\
> +	CASE_##op((val), TRCACVRn(14))		\
> +	CASE_##op((val), TRCACVRn(15))		\
> +	CASE_##op((val), TRCACATRn(0))		\
> +	CASE_##op((val), TRCACATRn(1))		\
> +	CASE_##op((val), TRCACATRn(2))		\
> +	CASE_##op((val), TRCACATRn(3))		\
> +	CASE_##op((val), TRCACATRn(4))		\
> +	CASE_##op((val), TRCACATRn(5))		\
> +	CASE_##op((val), TRCACATRn(6))		\
> +	CASE_##op((val), TRCACATRn(7))		\
> +	CASE_##op((val), TRCACATRn(8))		\
> +	CASE_##op((val), TRCACATRn(9))		\
> +	CASE_##op((val), TRCACATRn(10))		\
> +	CASE_##op((val), TRCACATRn(11))		\
> +	CASE_##op((val), TRCACATRn(12))		\
> +	CASE_##op((val), TRCACATRn(13))		\
> +	CASE_##op((val), TRCACATRn(14))		\
> +	CASE_##op((val), TRCACATRn(15))		\
> +	CASE_##op((val), TRCDVCVRn(0))		\
> +	CASE_##op((val), TRCDVCVRn(1))		\
> +	CASE_##op((val), TRCDVCVRn(2))		\
> +	CASE_##op((val), TRCDVCVRn(3))		\
> +	CASE_##op((val), TRCDVCVRn(4))		\
> +	CASE_##op((val), TRCDVCVRn(5))		\
> +	CASE_##op((val), TRCDVCVRn(6))		\
> +	CASE_##op((val), TRCDVCVRn(7))		\
> +	CASE_##op((val), TRCDVCMRn(0))		\
> +	CASE_##op((val), TRCDVCMRn(1))		\
> +	CASE_##op((val), TRCDVCMRn(2))		\
> +	CASE_##op((val), TRCDVCMRn(3))		\
> +	CASE_##op((val), TRCDVCMRn(4))		\
> +	CASE_##op((val), TRCDVCMRn(5))		\
> +	CASE_##op((val), TRCDVCMRn(6))		\
> +	CASE_##op((val), TRCDVCMRn(7))		\
> +	CASE_##op((val), TRCCIDCVRn(0))		\
> +	CASE_##op((val), TRCCIDCVRn(1))		\
> +	CASE_##op((val), TRCCIDCVRn(2))		\
> +	CASE_##op((val), TRCCIDCVRn(3))		\
> +	CASE_##op((val), TRCCIDCVRn(4))		\
> +	CASE_##op((val), TRCCIDCVRn(5))		\
> +	CASE_##op((val), TRCCIDCVRn(6))		\
> +	CASE_##op((val), TRCCIDCVRn(7))		\
> +	CASE_##op((val), TRCVMIDCVRn(0))	\
> +	CASE_##op((val), TRCVMIDCVRn(1))	\
> +	CASE_##op((val), TRCVMIDCVRn(2))	\
> +	CASE_##op((val), TRCVMIDCVRn(3))	\
> +	CASE_##op((val), TRCVMIDCVRn(4))	\
> +	CASE_##op((val), TRCVMIDCVRn(5))	\
> +	CASE_##op((val), TRCVMIDCVRn(6))	\
> +	CASE_##op((val), TRCVMIDCVRn(7))	\
> +	CASE_##op((val), TRCCIDCCTLR0)		\
> +	CASE_##op((val), TRCCIDCCTLR1)		\
> +	CASE_##op((val), TRCVMIDCCTLR0)		\
> +	CASE_##op((val), TRCVMIDCCTLR1)		\
> +	CASE_##op((val), TRCITCTRL)		\
> +	CASE_##op((val), TRCCLAIMSET)		\
> +	CASE_##op((val), TRCCLAIMCLR)		\
> +	CASE_##op((val), TRCDEVAFF0)		\
> +	CASE_##op((val), TRCDEVAFF1)		\
> +	CASE_##op((val), TRCLAR)		\
> +	CASE_##op((val), TRCLSR)		\
> +	CASE_##op((val), TRCAUTHSTATUS)		\
> +	CASE_##op((val), TRCDEVARCH)		\
> +	CASE_##op((val), TRCDEVID)		\
> +	CASE_##op((val), TRCDEVTYPE)		\
> +	CASE_##op((val), TRCPIDR4)		\
> +	CASE_##op((val), TRCPIDR5)		\
> +	CASE_##op((val), TRCPIDR6)		\
> +	CASE_##op((val), TRCPIDR7)		\
> +	CASE_##op((val), TRCPIDR0)		\
> +	CASE_##op((val), TRCPIDR1)		\
> +	CASE_##op((val), TRCPIDR2)		\
> +	CASE_##op((val), TRCPIDR3)
> +
> +#define ETM4x_READ_CASES(res)	CASE_LIST(READ, (res))
> +#define ETM4x_WRITE_CASES(val)	CASE_LIST(WRITE, (val))
> +
> +#define __read_etm4x_sysreg_offset(csa, offset, _64bit)				\
> +	({									\
> +		u64 __val;							\
> +										\
> +		if (__builtin_constant_p((offset)))				\
> +			__val = read_etm4x_sysreg_const_offset((offset));	\
> +		else								\
> +			__val = etm4x_sysreg_read((csa), (offset),		\
> +						  true, _64bit);		\
> +		__val;								\
> +	 })
> +
> +#define __write_etm4x_sysreg_offset(csa, val, offset, _64bit)		\
> +	do {								\
> +		if (__builtin_constant_p((offset)))			\
> +			write_etm4x_sysreg_const_offset((val),		\
> +							(offset));	\
> +		else							\
> +			etm4x_sysreg_write((csa), (val), (offset),	\
> +						true, _64bit);		\
> +	} while (0)
> +
> +
> +#define etm4x_relaxed_read32(csa, offset)				\
> +	(u32)(!(csa)->no_iomem ?					\
> +		 readl_relaxed((csa)->base + (offset)) :		\
> +		 __read_etm4x_sysreg_offset((csa), (offset), false))
> +#define etm4x_relaxed_read64(csa, offset)				\
> +	(u64)(!(csa)->no_iomem ?					\
> +		 readq_relaxed((csa)->base + (offset)) :		\
> +		 __read_etm4x_sysreg_offset((csa), (offset), true))
> +#define etm4x_read32(csa, offset)					\
> +	({								\
> +		mb(); /* enforce order */				\
> +		etm4x_relaxed_read32((csa), (offset));			\
> +	 })
> +
> +#define etm4x_read64(csa, offset)					\
> +	({								\
> +		mb(); /* enforce order */				\
> +		etm4x_relaxed_read64((csa), (offset));			\
> +	 })
> +
> +#define etm4x_relaxed_write32(csa, val, offset)				\
> +	do {								\
> +		if (!(csa)->no_iomem)					\
> +			writel_relaxed((val), (csa)->base + (offset));	\
> +		else							\
> +			__write_etm4x_sysreg_offset((csa), (val),	\
> +						    (offset), false);	\
> +	} while (0)
> +
> +#define etm4x_relaxed_write64(csa, val, offset)				\
> +	do {								\
> +		if (!(csa)->no_iomem)					\
> +			writeq_relaxed((val), (csa)->base + (offset));	\
> +		else							\
> +			__write_etm4x_sysreg_offset((csa), (val),	\
> +						    (offset), true);	\
> +	} while (0)
> +
> +#define etm4x_write32(csa, val, offset)					\
> +	do {								\
> +		mb(); /* enforce order */				\
> +		etm4x_relaxed_write32((csa), (val), (offset));		\
> +	} while (0)
> +
> +#define etm4x_write64(csa, val, offset)					\
> +	do {								\
> +		mb(); /* enforce order */				\
> +		etm4x_relaxed_write64((csa), (val), (offset));		\
> +	} while (0)
>  
> -#define etm4x_write64(csa, val, offset)			\
> -	writeq((val), (csa)->base + (offset))
>  
>  /* ETMv4 resources */
>  #define ETM_MAX_NR_PE			8
> @@ -501,4 +822,14 @@ enum etm_addr_ctxtype {
>  
>  extern const struct attribute_group *coresight_etmv4_groups[];
>  void etm4_config_trace_mode(struct etmv4_config *config);
> +
> +u64 etm4x_sysreg_read(struct csdev_access *csa,
> +		      u32 offset,
> +		      bool _relaxed,
> +		      bool _64bit);
> +void etm4x_sysreg_write(struct csdev_access *csa,
> +			u64 val,
> +			u32 offset,
> +			bool _relaxed,
> +			bool _64bit);
>  #endif
> -- 
> 2.24.1
> 
