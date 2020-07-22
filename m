Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C12D206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYWWbUfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgGVU4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:56:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E7C0619DC;
        Wed, 22 Jul 2020 13:56:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so1650768qvb.11;
        Wed, 22 Jul 2020 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZBwAyBmW5QGii29dq/6/vjhlBsEQAcWnEtkGqS6hbsA=;
        b=CYWWbUfhObEpjOnExlAzOAoex90OSw36s19gJfPBmXTvIZE6Hq6H/HAaf7UJTThsek
         j/iO0TAlBGdnGgC+v3qcmoHe3VWZGbTx87acPDQ55yC036cxQcSNNJ0AnmN8buJv+ky2
         o8/VDygP/+crlDr+I0uV/Z/NoQx7GdkTeHKknK/qocUylp0FlBXN9MZoIDHF1MpKsNsQ
         AEJy2CxtqAx2+WvmhqCVWmCME6XMnnSiB+RRRfSI7TsovYthO33ck62qgXQi3RIXGz61
         ye5ONnR4PG1EwEV7waUCO7m0AbId9cqtJNPsCkzs7g6pWVj6bEzjrvTf8gaFuFkcLij4
         PSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBwAyBmW5QGii29dq/6/vjhlBsEQAcWnEtkGqS6hbsA=;
        b=OZX1cHjDNnHjsugcTF4tZwBYGZuJFbr7oVmrLoOZOhHXUKoiiax11w4ppxdfesZyVM
         IygpMcf0aw4tlXU2zRr+YbRW3zvT1fJOALMjJkWdaUdRKFSPvEuyRP1VHcJWxskT9zPm
         /hC4epzriRIedoUHImnQxiHX9hpfzLvlMeav855oeOGrO70sn/U5ShP/uHu9bJDOAwDq
         8/btkrGZPjAMSKCCKu4NEM9KFqv8xSdWtkvJjampx+rB35Du/W90UzWA6yDoBFs/rWNR
         jm1ItOmKx+GGWL97choASuSAO96w4/jM+RDJFB9hQuRiiPWBHcRdMgyVMDOmVXBPGw/N
         Swpg==
X-Gm-Message-State: AOAM533YHr8xFAUlJt3oixwip2ExnnXIGTO7V26HjrWCIe0d1KzhHDik
        ZmVJwIrDAcZqHvnDiGVxI/2IUR3bZ7E=
X-Google-Smtp-Source: ABdhPJwVb8QZvPVMQFW6iEWA97E9YrdAmtv605XnyvwXpXCHHf96K0BMurYgjaKBPJkJI5vVjUdCYg==
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr1804325qvl.93.1595451365410;
        Wed, 22 Jul 2020 13:56:05 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id f130sm821835qke.99.2020.07.22.13.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 13:56:05 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200722201313.754671-1-saravanak@google.com>
 <20200722201313.754671-2-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <084158b7-f6dc-167f-b06d-db617fb2df29@gmail.com>
Date:   Wed, 22 Jul 2020 15:56:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200722201313.754671-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-22 15:13, Saravana Kannan wrote:
> Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
> to add support for pinctrl-%d properties.
> 
> Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
> are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
> (9486) are made up of pinctrl-[0-2].
> 
> Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
> unnecessarily complicated. So, just add support for pinctrl-[0-8] for
> now. In the unlikely event we ever exceed pinctrl-8, we can come back
> and improve this.

If you were to implement the more general pinctrl-* case, roughly what would
it look like (pseudo-code or english description is fine).

-Frank

> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index b06edeb1f88b..d40d923ffeaf 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1274,6 +1274,15 @@ DEFINE_SIMPLE_PROP(interrupts_extended, "interrupts-extended",
>  DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl2, "pinctrl-2", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl3, "pinctrl-3", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl4, "pinctrl-4", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> +DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>  DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> @@ -1303,6 +1312,15 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_nvmem_cells, },
>  	{ .parse_prop = parse_phys, },
>  	{ .parse_prop = parse_wakeup_parent, },
> +	{ .parse_prop = parse_pinctrl0, },
> +	{ .parse_prop = parse_pinctrl1, },
> +	{ .parse_prop = parse_pinctrl2, },
> +	{ .parse_prop = parse_pinctrl3, },
> +	{ .parse_prop = parse_pinctrl4, },
> +	{ .parse_prop = parse_pinctrl5, },
> +	{ .parse_prop = parse_pinctrl6, },
> +	{ .parse_prop = parse_pinctrl7, },
> +	{ .parse_prop = parse_pinctrl8, },
>  	{ .parse_prop = parse_regulators, },
>  	{ .parse_prop = parse_gpio, },
>  	{ .parse_prop = parse_gpios, },
> 

