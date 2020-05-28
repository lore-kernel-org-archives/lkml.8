Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57149C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A6C208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s4qyV/Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406086AbgE1S6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406065AbgE1S6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:58:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5A3C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:58:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so329990wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=8zVkKrr6kkY53KW61WwI9h86+LLii2InI9vDH+nbUZs=;
        b=s4qyV/HveX+qC01bVYV7ugGlI6wbQKDlWM625heq9zN6Ye8rlqernbdmL5+kNW4oa2
         2zFOhNxlFXiITPmvJ/nrwmb06zy4sbGzs5UB0tVv6wNtSD98WfAw0uU0oA646vb9tpXB
         1fv7FrSgUmuUhZRv1n2onnuoBAXdZvYjpChjKhTrZWt65dKdfdS3S1l1c46BHCPLQHEb
         +4UvwwwQqOnos8sWvzNo35NW6cuOAH/vrKBnpXEatKuzC/TpTIPnxfyA4l3wfl1ioV5D
         KecSDXuA1M6HWiFJNGSOyHXc9XNpGIpqp5lL2WZ/5uF7OmTUmhezdIU1Z8LR86nbQ7Vc
         +suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=8zVkKrr6kkY53KW61WwI9h86+LLii2InI9vDH+nbUZs=;
        b=cr9oIujGVmBNENVfhcWzEQHJIM/zeHYScMlIzoM5VM7v9v0bABSiCirEjz7ecA+GGB
         5ylsx/JKAbPMcgH/3/ldm9ctq1J1ZM1nMLjW+BtstXaOhJdkjbEmuIPVa+BJ1s8A08z7
         /1EAdx78CwYKp3LtAhIKnz8wOZEt+5OVM1CrLjvIWp0ufwZE1On5hFy31gsqPnULvZE7
         +yUnIWIgFlZqE+PHqcjmN3KG3ciAEGSEedOy5obWBlEU35RSDJlkJZnjHU2IAwnGvmJr
         +gfw3okhsDGYF/pEkkFfgL5dyfo5MRdBtgOR8AT0BVK+E9eAnP3mPHyJ6zkWFL0/D6Zw
         RmtA==
X-Gm-Message-State: AOAM5305RDM+QLIgeOw9tQp+I0beOmfL/xIiDC505x0iHV5ZEjPrrZqR
        t4lXaHDp7r92hSW920EZsUCi1g==
X-Google-Smtp-Source: ABdhPJwyIDYbcv6RHExUdzM5MDO6GX5U7N8x0XRuH9hAZ2XM1vFmAj8kjFvEJCxOFE4cgpdfOcT8Yg==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr5245616wrp.57.1590692326851;
        Thu, 28 May 2020 11:58:46 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id g82sm8074648wmf.1.2020.05.28.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:58:46 -0700 (PDT)
References: <20200519170440.294601-1-jbrunet@baylibre.com> <CAFBinCBXTwKz81bQK3U1bv7vGiryhShijqh2hqaypPvLopvwNA@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: add api to get clk consummer from clk_hw
In-reply-to: <CAFBinCBXTwKz81bQK3U1bv7vGiryhShijqh2hqaypPvLopvwNA@mail.gmail.com>
Date:   Thu, 28 May 2020 20:58:45 +0200
Message-ID: <1j8shbkhsq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 27 May 2020 at 22:07, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Tue, May 19, 2020 at 7:09 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> + * Calls to this function must be balanced with calls clk_put()
>> + */
>> +struct clk *clk_hw_get_clk(struct clk_hw *hw)
> I haven't looked at it myself yet, but would it be hard to have a
> devm_ variant of this function as well?

Seems easy enough.
Stephen is this OK with you ?

I'm just wondering if this devm_ function should use the device pointer
embedded in the clk_hw structure or have it as an argument ?

The 1st option seems simpler but I'm not sure it is correct.

Thoughts ?

> a non-devm managed function would add boilerplate to the meson-mx-sdhc-mmc code
>
> also this may or may not simplify how to fetch the struct device
> pointer for this use-case.
> (that said, I only know about drivers for Amlogic related IP and there
> the devm_ variant can be used, but I don't know about other potential
> consumers of this new API)
>
>
> Thank you!
> Martin

