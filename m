Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83916C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B03620756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd9XbxTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgHKP4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:56:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B403C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:56:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so6923857lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NvZmcfOCD2NEP3ojKEb1iY8bURsaI8vHgpClr3hjAKg=;
        b=bd9XbxTSeTiJV201E+RG8CQe8R7J2lKXmhYGPFmwb7EqG7ytFWZmE8xvKumixlBIWD
         X9picysbHo1AHcwFRrk9qlfuhUjYyS/B0cSodgNqspx5gEeNM49UwTsoICQvoAdqkPcs
         AXFcLgGyinbX6/ztX8s8ISKGleux/o6TM+0lP8lOAoyoD/XEFn7AShqvJS2JoLUiOw5p
         /Vb/XRWIpLF5oq/TGeELJMAKlp3qaggZ7HewP+ZIPfPTWyRiJjr3duX1sF+wLUv4Uip0
         Nj+hofIq0Adl7AjrkmEy/LnEZ3b/0UBfUmdzhbhaH0g69CKGI/e4ILTT/iglZhauPv8Q
         ozQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NvZmcfOCD2NEP3ojKEb1iY8bURsaI8vHgpClr3hjAKg=;
        b=LJhcjAegnRGeNRsgrjcaXjjrT8d19LG1ZZLKbNhSJXPxPXQabAjpZRjX9+7N/D1ZcO
         2951YJAzW+XLOwAJnCBXDhZluVcvME68/0hMFbc0/SPVKhbApbd+kldorIKGL0rkZNg+
         lqIgYV3/rXmypUgAtmBmKAdiJE6UVMpf948PDa+sKnRY0HOFbPZinzC7j6fL7bML/3ec
         tcETyimwwQWnT7aPpsXcHf3PcI9wzNNcqgs7Bn5JbR5+GAWxVK0/9dsy0V9KAycX4Uh6
         rxEDhX0ToFr/Uu98rwHlBe4d1bp/2at7u29gq8Lms1SFs3fUoBnjFnu+SzkqqBo64a3H
         YmAg==
X-Gm-Message-State: AOAM5300LUi/rG+FZlSOa8jGJyIxoKr3CAKxYaBcRJA5gXeIgMJ4ciOx
        996VNaEaz+zWNL18+wv+CXY=
X-Google-Smtp-Source: ABdhPJxSjjLOmiRRGBBIKA/Vtd7J6f8QG1FXZeG9OWmg+eNjajU/B99u5SHheLQUTGwDXbxpiOSWsw==
X-Received: by 2002:ac2:5548:: with SMTP id l8mr3535202lfk.39.1597161381800;
        Tue, 11 Aug 2020 08:56:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id y21sm11844828lff.34.2020.08.11.08.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:56:20 -0700 (PDT)
Subject: Re: [PATCH 7/7] regulator: remove superfluous lock in
 regulator_resolve_coupling()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <169f98e7a2064a184167abc0f206f3a92513b8d8.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd3ebf07-4d29-232d-3843-f1ffb40ab5e4@gmail.com>
Date:   Tue, 11 Aug 2020 18:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <169f98e7a2064a184167abc0f206f3a92513b8d8.1597107682.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.08.2020 04:07, Michał Mirosław пишет:
> The code modifies rdev, but locks c_rdev instead. The bug remains:
> stored c_rdev could be freed just after unlock anyway. This doesn't blow
> up because regulator_list_mutex taken outside holds it together.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index b85ec974944e..f8834559a2fb 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4942,13 +4942,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
>  			return;
>  		}
>  
> -		regulator_lock(c_rdev);
> -
>  		c_desc->coupled_rdevs[i] = c_rdev;
>  		c_desc->n_resolved++;
>  
> -		regulator_unlock(c_rdev);
> -
>  		regulator_resolve_coupling(c_rdev);
>  	}
>  }
> 

As I replied to the other email, there is no real bug here. The
regulators are uncoupled before regulator is freed and the uncoupling is
also protected by the list_mutex.

Hence the resolve_coupling() doesn't need to lock regulators and this
change looks like a good cleanup.

Perhaps the commit message could be improved a tad, either way:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
