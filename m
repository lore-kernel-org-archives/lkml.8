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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F47C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF732083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTAw/eTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgHKPoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgHKPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:44:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:44:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so14059060ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MOndPYlZWn1KUGkvBWd7W30cieUHtsfgNEZmQV/QvA4=;
        b=CTAw/eTr4fScH6Gje6odi7huo03BbW4g/c4lcrnA1XW6L5OmD5ZjIRMapE1LLfhWNn
         up0Snd71a4cVf1z5rIRFMf4Kire2tKV2bMSYxOYzFGEDJjimD2W8gFuEglVwbwFunqY4
         WCS4W4Fy9RHJLg/2FIF4rf15LRDuJwLBN2Xv6wVAXoKgWZH/26K4IV57ct/DBn/WJXPB
         gXpAS6na7VkmGk4ex0cYpDTVh7FrRcWsNzodcK8wpF90lZhtPMvVNAjEeAgLrXy+fvB0
         C5c7Qxo2SRD9J4qiNubSgcxr5j2jN1nWodTsb0WJKhhTac+5CWlKCNSHyNvTFmrFjgm4
         aMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOndPYlZWn1KUGkvBWd7W30cieUHtsfgNEZmQV/QvA4=;
        b=RY3xv05pxDdC7W1Xv/rCr5DboGUzCkHManroKtJL5VaVT8TBz0AubMv5OMpXAAHmzi
         f9VtyJ2tCCuebgPYr16mXKlFQrFdO7MI49uq+n5crSmRkQKvQUzGDbzakxKgHeyFVopm
         quKH3IcJPNvdqebkBj+StiBKIk3JNGHDpla1TgiXxwIBC+YGYE0GvRNJSrQqQucVoQ/v
         Mfgj9BqwuiRJT/gfmIblNI9/+aEjLkN7rbt09Z5GnSFkQVdX2PU00o/FXKhIttHSLGkX
         HdkXsUJrGB4+gX0bWRPuEWwPNTGxV2tSRAE2Fu6NWXuCzDr4Hln7CiMuiJwim/gjH8S/
         K7OQ==
X-Gm-Message-State: AOAM532kFpcmrYIigTmE5uo92cIZmLDs3Jr2D2jpMVmFL5dH1QRDQCN3
        bBiU5YZKJUqWDMH6MHehfzAWMq/x
X-Google-Smtp-Source: ABdhPJzB47eqeHkywNhgNoJ1FGuiZtopfBkuQxNrlTDjJ2aX7AMOeJ/h0Oo4OXpWXSJQn2om3cAJBw==
X-Received: by 2002:a2e:b53b:: with SMTP id z27mr3248228ljm.441.1597160651390;
        Tue, 11 Aug 2020 08:44:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id s4sm11817211lfc.56.2020.08.11.08.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:44:10 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
 <20200810201846.GA12091@qmqm.qmqm.pl>
 <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
 <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
 <20200811000722.GA30574@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d6b4ec96-d81b-5025-628b-ba6c5f77a3dc@gmail.com>
Date:   Tue, 11 Aug 2020 18:44:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811000722.GA30574@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.08.2020 03:07, Michał Mirosław пишет:
...
> I just noticed that locking in regulator_resolve_coupling() is bogus.
> This all holds up because regulator_list_mutex is held during the call.
> Feel free to test a patch below.
> 
> I'm working my way to push allocations outside of the locks, but the
> coupling-related locking will need to be fixed regardless.
> 
> Best Regards,
> Michał Mirosław
> 
> ---->8<----
> 
> [PATCH] regulator: remove superfluous lock in regulator_resolve_coupling()
> 
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
> index 94f9225869da..e519bc9a860d 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4859,13 +4859,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
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

The change looks like a good cleanup to me, thanks. I think that c_rdev
locking was accidentally left from some older version of the patch that
introduced the coupling support. There shouldn't be any real bug in this
code.

IIRC, at some point I changed the code to disallow consumers to get a
partially coupled regulator and then protected the resolve_coupling()
with list_mutex, but seems missed to remove that c_rdev locking. Hence
there shouldn't be a need to lock regulators individually during the
resolve because nothing should touch the coupled regulators until all
the coupling has been resolved.
