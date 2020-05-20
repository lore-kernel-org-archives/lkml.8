Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326E920671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTN8MLqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgETQPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:15:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2368C061A0E;
        Wed, 20 May 2020 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=KUsG4feXigEdZ3QpYALXvpu/1zKdm/ox7vuSCPQehrI=; b=cTN8MLqDM8INSNrXIHuE2+fp09
        UNc+u5wyrqEtriUMCkNXq63TjVhwN90f8CssOrLD37dfcPJkAW9o2Cgplh5Urq3dBC2NZJVXmUPE4
        Pn1oQxZYoUQ8NzPVUuB/PB6r3wsG1pao7sGlEs2Z5oG4z4/yCaFGGzaOiRv2YC8u+YwUre+rCPPat
        DOAKg/QWoTChuBCw8tVTBhqJfhLVAXOGfmvTdJLPVSmjzL+O4fMpqU8EyvwB3kBWbCF3t4N6WUt6r
        4uusMh5Bpe8D/t4OTl7ulP1uifl9IHKfAW6+3JuRA037ZRPEe84Z9uUZyjPmvLlEjavPow5eycrBO
        IcHZf5lw==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbRN6-00083y-Lu; Wed, 20 May 2020 16:15:09 +0000
Subject: Re: [next] i2c: mediatek: Use div_u64 for 64-bit division to fix
 32-bit kernels
To:     qii.wang@mediatek.com, wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com
References: <1589970713-19944-1-git-send-email-qii.wang@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c92c499b-825d-bd28-3c0d-e63076cba1b6@infradead.org>
Date:   Wed, 20 May 2020 09:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589970713-19944-1-git-send-email-qii.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 3:31 AM, qii.wang@mediatek.com wrote:
> From: Qii Wang <qii.wang@mediatek.com>
> 
> Use div_u64 for 64-bit division, and change sample_ns type to
> unsigned int. Otherwise, the module will reference __udivdi3
> under 32-bit kernels, which is not allowed in kernel space.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 7020618..deef69e 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -551,7 +551,8 @@ static int mtk_i2c_check_ac_timing(struct mtk_i2c *i2c,
>  	const struct i2c_spec_values *spec;
>  	unsigned int su_sta_cnt, low_cnt, high_cnt, max_step_cnt;
>  	unsigned int sda_max, sda_min, clk_ns, max_sta_cnt = 0x3f;
> -	long long sample_ns = (1000000000 * (sample_cnt + 1)) / clk_src;
> +	unsigned int sample_ns = div_u64(1000000000ULL * (sample_cnt + 1),
> +					 clk_src);
>  
>  	if (!i2c->dev_comp->timing_adjust)
>  		return 0;
> 


-- 
~Randy
