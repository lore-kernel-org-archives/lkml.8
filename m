Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF0A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kbzpx2bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502197AbgDNMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729455AbgDNMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:47:39 -0400
X-Greylist: delayed 72711 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 05:47:39 PDT
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39173C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:47:39 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0C1D0021F05AC4D60C335F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1d00:21f0:5ac4:d60c:335f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FF3E1EC0CDE;
        Tue, 14 Apr 2020 14:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586868456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP4PbFC2Ql0uKPjbBVGyLCqT4YXRCyjqKtYPNE0k1+U=;
        b=kbzpx2bD9bU7020BOrk7rhM9RaEK4j4gkgGAAdw+xoI82QHY5EPcneTPrNsr67rtlQ0D8L
        ilzLeGKq2VM9IrLsqwjzmyqSHkpLC1eCPGhc1rt3fwcYMMrRk9o7TJiuXiuF6dTr57mIEE
        hSh31XhQW/1XV4liU2uL6zPiJAv9jV8=
Date:   Tue, 14 Apr 2020 14:47:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     khuong@os.amperecomputing.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC, xgene: remove set but not used 'address'
Message-ID: <20200414124731.GB31737@zn.tnic>
References: <20200409093259.20069-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409093259.20069-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:32:59PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but
> not used [-Wunused-but-set-variable]
>    u32 address;
>        ^~~~~~~
> And remove the unused macro RBERRADDR_RD after that.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/edac/xgene_edac.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index e4a1032ba0b5..1d2c27a00a4a 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -1349,7 +1349,6 @@ static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
>  #define WORD_ALIGNED_ERR_MASK		BIT(28)
>  #define PAGE_ACCESS_ERR_MASK		BIT(27)
>  #define WRITE_ACCESS_MASK		BIT(26)
> -#define RBERRADDR_RD(src)		((src) & 0x03FFFFFF)
>  
>  static const char * const soc_mem_err_v1[] = {
>  	"10GbE0",
> @@ -1483,13 +1482,11 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
>  		return;
>  	if (reg & STICKYERR_MASK) {
>  		bool write;
> -		u32 address;
>  
>  		dev_err(edac_dev->dev, "IOB bus access error(s)\n");
>  		if (regmap_read(ctx->edac->rb_map, RBEIR, &reg))
>  			return;
>  		write = reg & WRITE_ACCESS_MASK ? 1 : 0;
> -		address = RBERRADDR_RD(reg);
>  		if (reg & AGENT_OFFLINE_ERR_MASK)
>  			dev_err(edac_dev->dev,
>  				"IOB bus %s access to offline agent error\n",
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
