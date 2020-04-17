Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025EC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C702206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eepHxWx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgDQHnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgDQHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:43:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30092C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:43:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t63so890800wmt.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=7VxUyCozUFRQ3HWyk/FR84Y855XH8vC8ACtL+uxdHOg=;
        b=eepHxWx0UCQ3bBjYPAxbl27Om6GC70uRgirDesMlw0GcwtwctP16SCiHB+9lipG9Q0
         MgNdJoEZVSmbzmwNbFctN8vwR/E4WL5PrBitcvaR4Mv5RZyqao5nKchsF6SAoVjQw6q8
         1sBR/TQ8qY8RmucdLYRWbxuvwjwkdplwZck/fYRcvy1zb+UVhxu540CJET3ACX9t6WuQ
         IAlO3q/oQ0fiIwt/0iD1Y5oFpSq3BcdbdHfOVxTsU7YR4v7fa0aOShrllZ4IZQDEdY1z
         wcrFjOJJqsSYcm+HvrKBxOn3cHvgNXvN8UbAciWfiS7exv4J4Q6YoZlD4nsCuLB51+ze
         HL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=7VxUyCozUFRQ3HWyk/FR84Y855XH8vC8ACtL+uxdHOg=;
        b=ZFnJHdRDlTzMJJdH5OUTPBqea4gN58isrGWTesbV5mRckseGDMnXCuGDxFAVSqYmzX
         j4DRVzeuhYTdllQ6l+6KLFkX2FXgth1DiFlGeJCr02qPAGLGFYhcImhEsFV2fkj6H661
         kcRMqJoq6mTWkIAAVdFEkxj3f871UeBLbwbO3ZOpg0eu2BLIAf6loSgI3sDSgNRsyZsD
         6NMCjW6nrbtdNxqna2UAffzKUADa0vV48+qYbEXM1JANYingF6++BGfuRcGQ7eVWa/43
         AfvuqmSFuX5qoqRqIw0qatnM2QdZbFm2ZEAHW3EyzuW+4sihDhpy4uSWFNU2Z5cpLhWz
         rqVw==
X-Gm-Message-State: AGi0Pub1kVJJi7cWsrtaTJ5LdNVv33gpsNHoXwDBuAJ0QYYygis3dMq/
        zmCevdZF2lRVi8UK4qME7CeOvg==
X-Google-Smtp-Source: APiQypKB/8+cZvXsHO1NRHGVVpm+LapGF68siOZwDYjt2dTxd7u+tUAFWwcTxeJ3csNYW5kgsVQ09w==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2124159wml.189.1587109423806;
        Fri, 17 Apr 2020 00:43:43 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l185sm6779244wml.44.2020.04.17.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:43:43 -0700 (PDT)
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com> <20200414200017.226136-3-martin.blumenstingl@googlemail.com> <1ja73bbtqt.fsf@starbuckisacylon.baylibre.com> <CAFBinCAtSPTHfbr5KGNFFg3eo_d2p2q59fQfMXu+XkOb8WVrDQ@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: meson: meson8b: Fix the polarity of the RESET_N lines
In-reply-to: <CAFBinCAtSPTHfbr5KGNFFg3eo_d2p2q59fQfMXu+XkOb8WVrDQ@mail.gmail.com>
Date:   Fri, 17 Apr 2020 09:43:42 +0200
Message-ID: <1j8siublqp.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Apr 2020 at 20:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Thu, Apr 16, 2020 at 12:38 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> >
>> >       if (id >= ARRAY_SIZE(meson8b_clk_reset_bits))
>> >               return -EINVAL;
>> >
>> >       reset = &meson8b_clk_reset_bits[id];
>> >
>> > +     if (assert == reset->active_low)
>> > +             value = 0;
>> > +     else
>> > +             value = BIT(reset->bit_idx);
>>
>> if (assert ^ reset->active_low)
>>         value = BIT(reset->bit_idx);
> I can do that, but I prefer "!=" over "^" because the result is
> expected to be a bool (and because I'm not used to reading "^" for
> logical comparisons)
> will this work for you as well?

yes

>
>
> Martin

