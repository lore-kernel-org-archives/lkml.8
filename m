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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D346208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqp4ZMfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgIFL7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:59:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3608C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:59:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so12850652ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MCaoZEVJDwqdc2rW6I9ebf1hxo2iXwWiSma/Gdg6To0=;
        b=Eqp4ZMfJ4qN4FpsNHTdYiKEKTG3c2x1qls2fv3j92PC4zu7yu2h80jZ5pgql4Q7ePW
         70lpA54tbR+X3lc5GbbvzirS3p/X25I8li2o6J3Q+7pLCxP6KSMAgf87mAPtA04IXhGm
         9k4wfgqiyRGT0v89oXlDRzTc36NE4Nhm5EjrbQnOfK9ZxeLaNPP+0nctb7XE1nV3UXuq
         wBANZ3UvmJdc4XqkanN14o7q6yp/kIv69jplbrtdjwgVHreFR6PFqkIToI5BxAqCHbSg
         GXah4MLmq8LseCcj5YrSPr6SNQqJk8ANIHsSH+LpZ2pyQEG/Iw4FgHPp1u+gtVQsUbks
         bjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MCaoZEVJDwqdc2rW6I9ebf1hxo2iXwWiSma/Gdg6To0=;
        b=au4fPpP0Ys2lcRKTsYzFKJ92ltguhIQmJDS8J+0pvDQOn2D6z7I14c+XAmPP+z8cvU
         J8002MmHy1LOR7UwNjgjbRQ3rKrZhgn5udbDf2JlblpgdpA/M74x8heqCE4q9piGEKIx
         PiDZ8g64mVb1TXvCxWN3rltQqpi/N5zSahVJ6azYg4GYf6O1dJkMpQ+6/qb+5MEY7HYo
         GCd/xTjyjlxUKBlevicepsGk2vjfHNHmAGFp0rE8o+bj8O+nW0kCY2/dNPOz1IHqfubA
         AmuDsfbn0IJtwRjrL1E1DEh0Z/Ha1NWtZuPy8Z7hgRG0jye9RSNarisgGlFBBfCRV3/w
         ZjPQ==
X-Gm-Message-State: AOAM531npaMyadlUSzdnlFZ9lEmsaYhBxxu8QlMJZ92KOfRH8kh3tf5P
        M10pME75xQ7NHbVPWrI8qRw=
X-Google-Smtp-Source: ABdhPJxPl5PeVJR97ed5Pp8RE3o5rvH19f6k4CSlghswofGiuw4y8jYMXQKTnitOQVAPJ5k6o8bk6A==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr7559304ljo.307.1599393572185;
        Sun, 06 Sep 2020 04:59:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id n2sm3053842lji.97.2020.09.06.04.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 04:59:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] regulator: unexport regulator_lock/unlock()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <090775a675cf8ea644c4b65903f18b314acbc504.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f1b7c54a-dc42-4b41-0dfd-b779977d0487@gmail.com>
Date:   Sun, 6 Sep 2020 14:59:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <090775a675cf8ea644c4b65903f18b314acbc504.1597032945.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 07:33, Michał Mirosław пишет:
> regulator_lock/unlock() was used only to guard
> regulator_notifier_call_chain(). As no users remain, make the functions
> internal.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c         | 6 ++----
>  include/linux/regulator/driver.h | 3 ---
>  2 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
