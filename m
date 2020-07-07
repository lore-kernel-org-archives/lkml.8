Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA27206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bS2w02uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGGS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:28:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HdjdBEuc09gbzMxr+upySCFBU+l5DWJracRk3eLkb5k=; b=bS2w02uSm9hW3I8+AMkkcpCEbn
        XN8pQCM13CWfkQ5uQ4ppHLpxPdZxCOI0PdbNq4Cc9uqWreqM3RSOwm/765ebRg7mHq0DgcUrBxWXj
        ZkwSeHfiVnrmqwB4gdgmDvdG+A941vlG2CSLf5OYI+2O6BEbvTX8mUCfFKpD+sV0MnoSEtEoLmcUu
        3zBMEV/xD3Lda8CQ427aiFG1pFyXh5q4ucuFJCquMmqi9uQx/yEnDB2A1ujfwyVLlvml+/kiFKkEF
        dkzfYpdcARrhYT1Rw+HRlkT2shnPNGRgf7eKmU+mVe2Xvoq6fGs7Koa+5l0CiOuiCM+7BSBOc2+fC
        ZOcMbgJg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jssKE-0005ig-5g; Tue, 07 Jul 2020 18:28:15 +0000
Subject: Re: [PATCH] ASoC: amd: fixed kernel warnings
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1594147044-25582-1-git-send-email-Vijendar.Mukunda@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f2cde61-590d-6a68-295b-62f026f729b3@infradead.org>
Date:   Tue, 7 Jul 2020 11:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594147044-25582-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 11:37 AM, Vijendar Mukunda wrote:
> This patch will fix unused variables kernel warnings when
> CONFIG_ACPI is disabled.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/amd/renoir/rn-pci-acp3x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
> index 165c93f..b943e59 100644
> --- a/sound/soc/amd/renoir/rn-pci-acp3x.c
> +++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
> @@ -168,8 +168,10 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
>  {
>  	struct acp_dev_data *adata;
>  	struct platform_device_info pdevinfo[ACP_DEVS];
> +#if defined(CONFIG_ACPI)
>  	acpi_handle handle;
>  	acpi_integer dmic_status;
> +#endif
>  	unsigned int irqflags;
>  	int ret, index;
>  	u32 addr;
> 


-- 
~Randy
