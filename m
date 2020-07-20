Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F3321775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQBiu1cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGTJ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGTJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:57:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so8467054plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XyZ1vebKO6SQCUsj068hhsBNuOKRm7ZmD8BgAuoHaY=;
        b=NQBiu1cOCISh1k3U4y2l52I5TOrTbmZzL+gIeTHwlzmCjlDf3IZD/ASeQl0xonnttT
         BEBTV4O6+LnVxFo/P67buZg17mjeeDzQ6YW9F5upr2VTBMiQYdnb6LmiMrZPNLo2+AvX
         FsJAD3xO/Y1XACZxNmQn5zgKtsx0Eu+Q/07copNlruVNsS3eDO7l4BJy7FS/XMOlVJAH
         5Th+Fgrh0sVI/M+/7oxKgEHskmAki/NZIoebAOMDGHZHUq3J8eEwmT9bpNlf6LYbSdrz
         KlJie1QrAVSirzAarzo8Xi9oPUU18PND6e9uVj5H5NfTEeulHQWwkzA5hfrywQOqvzd0
         rptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XyZ1vebKO6SQCUsj068hhsBNuOKRm7ZmD8BgAuoHaY=;
        b=a32GnrQHRfdRniM0SFDRLyCs3APicvTC2CbKELSF6UjKhfiJVeZ4GnRzsIpDiQJECp
         xSyuNBQMfSGbHyvfOUHkagrsiKELK6r1x+I+5Q68zq3O8zRU90NiKn2D2KBYCkuRjrn0
         vmpLLHwHkQfDZOkluYB7J/yArMkDM9qL7b4nbdIjiE0QGHOJiLxHMUtJHd5CnTg/M5mA
         9l0JZuJetDFFhthO0acTR80oGXPjqCtA+ANEH94CV4lLfJDn09uGVk0J3sbYdUXy17oN
         a8OspNMsIBiLSNu6oe7UzSBueioljbK43Ya918/DWotxc+4aK8480fG5FAqkaGTStfF/
         bu3g==
X-Gm-Message-State: AOAM532o71dgZVV1hhOxOXiQ98CAadIU50AAHqiMMfIC2/LVzCrmGq3I
        2vRggvL8Wb4psLtB5gofeFkTGYAToFY=
X-Google-Smtp-Source: ABdhPJzkmZ+GQFeE1cVYyN6xa/AAWSvHNvngWQItcmxRGFYYYD7B/0wV++gqFg1j+Ya++WKQMwlFCA==
X-Received: by 2002:a17:90a:2367:: with SMTP id f94mr23548839pje.20.1595239049209;
        Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
Received: from localhost ([223.179.133.67])
        by smtp.gmail.com with ESMTPSA id u20sm17765622pfk.91.2020.07.20.02.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 02:57:28 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:27:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: opp: Modify opp API, dev_pm_opp_get_freq(), find freq in opp,
 even it is disabled
Message-ID: <20200720095717.eer4pnh3y4stkems@vireshk-mac-ubuntu>
References: <1595235326-6333-1-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595235326-6333-1-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 16:55, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Modify dev_pm_opp_get_freq() to return freqeuncy
> even this opp item is not available.
> So that we can get the information of disable opp items.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index eed42d6b2e6b..5213e0462382 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>   */
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  {
> -	if (IS_ERR_OR_NULL(opp) || !opp->available) {
> +	if (IS_ERR_OR_NULL(opp)) {
>  		pr_err("%s: Invalid parameters\n", __func__);
>  		return 0;
>  	}

Applied. Thanks.

-- 
viresh
