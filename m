Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ABC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679E2208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpQn6B9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgIFL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:58:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D68C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:58:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so6074882lfy.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KFExpp7/k1CbB3zQh0057buiF6HqNV6kub3d4r1E3GM=;
        b=BpQn6B9B1hyBmZTF34BlwmnSSJUa4o/a9U9CGz1QG88Uh0rSF/aVQCSfn5CW4ErVK6
         QX57HI7j8VLIpWu/+3b8t6OvrANJt9JR4T8XczjJuveeSXXdLyV9ttRA6dtqf6LoeF62
         46CNhotQee/2E4ZhTqScgrPKI5HJLH4BRI3KmwEq01SKcoQbmyujBX6o34DFQcVRwZMn
         CztvNvzJ/M0Vnad8qWhUdGY6xS4CnA+laAAODtonocjA8mVwHFeGne8uGhOTXdDA/pWM
         3lifJO+7FZlKkq0L9jNOoABUa0S3uCxKqQe4K88uVPrFUvv73hAPlzR2XJFonHyzdth5
         YN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFExpp7/k1CbB3zQh0057buiF6HqNV6kub3d4r1E3GM=;
        b=XtzxYEAtbHo8O/r1URZ9yYVuuN7MOEGAV9hs/wEUMYNCV69CSGC/sUM3MWfsuRQ63d
         Ymhh3ipHwHdG6W11U3xEc2dnCeCblHIRJXEBwHtHzD3tD4wAlfTwhESBkIZJ4nbGlTLg
         pkfbtJa0ecY0jSdt/OLpky69vwo0l8VTQVTy9rVwPJNfKw++dQqnp7yEyXkc1LO6QB1z
         zJWE13OitmQ7La/mG4E8kqe+ik9F2nd0YCgjZs/0JSs46IC9YQGL8xTMVYEgJ+SI2zL5
         HJPisfnwthZT6AUJqYnZF7ZFy6hENM9kL4pZv/r5HSvnvrdzFQpAPCw2e2hmUvbzs50V
         7/kQ==
X-Gm-Message-State: AOAM530ZZEG7Ir6HxbrIgYFDHSQMjAJnngD5N4R15+ewWTRrRosWfIcT
        2HVwk2dUlO5xJ9C4FAV7Z0Y=
X-Google-Smtp-Source: ABdhPJzef0JbdDcDmuaOnpBXscYwOY9xHfLMJE93kAGxtexLEaRNHN7k2BQsA9MG/NkTcIec/jS1PQ==
X-Received: by 2002:ac2:5315:: with SMTP id c21mr8077100lfh.162.1599393484572;
        Sun, 06 Sep 2020 04:58:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id g15sm3695622ljj.39.2020.09.06.04.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 04:58:03 -0700 (PDT)
Subject: Re: [PATCH 2/3] regulator: remove locking around
 regulator_notifier_call_chain()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <42393f66dcc4d80dcd9797be45216b4035aa96cb.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cec8598d-7bd1-f51a-8e24-1fd2bc8b5c26@gmail.com>
Date:   Sun, 6 Sep 2020 14:58:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <42393f66dcc4d80dcd9797be45216b4035aa96cb.1597032945.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 07:33, Michał Mirosław пишет:
> regulator_notifier_call_chain() doesn't need rdev lock and rdev's
> existence is assumed in the code anyway. Remove the locks from drivers.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/da9055-regulator.c   |  2 --
>  drivers/regulator/da9062-regulator.c   |  2 --
>  drivers/regulator/da9063-regulator.c   |  2 --
>  drivers/regulator/da9210-regulator.c   |  4 ----
>  drivers/regulator/da9211-regulator.c   |  4 ----
>  drivers/regulator/lp8755.c             |  6 ------
>  drivers/regulator/ltc3589.c            | 10 ++--------
>  drivers/regulator/ltc3676.c            | 10 ++--------
>  drivers/regulator/pv88060-regulator.c  | 10 ++--------
>  drivers/regulator/pv88080-regulator.c  | 10 ++--------
>  drivers/regulator/pv88090-regulator.c  | 10 ++--------
>  drivers/regulator/slg51000-regulator.c |  4 ----
>  drivers/regulator/stpmic1_regulator.c  |  4 ----
>  drivers/regulator/wm831x-dcdc.c        |  4 ----
>  drivers/regulator/wm831x-isink.c       |  2 --
>  drivers/regulator/wm831x-ldo.c         |  2 --
>  drivers/regulator/wm8350-regulator.c   |  2 --
>  17 files changed, 10 insertions(+), 78 deletions(-)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
