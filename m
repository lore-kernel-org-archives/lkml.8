Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEBE206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vdVL1oGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEPSSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgEPSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:18:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F0C061A0C;
        Sat, 16 May 2020 11:18:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s3so5190865eji.6;
        Sat, 16 May 2020 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51NZmWw8OgodGFU6Kwk+1cHIUOclm2JMHWgqoLAcNto=;
        b=vdVL1oGOOCFNBnvnlLIFS59MY8Zba5m/lomLUqa2xGj9MprTK15U9qOHtzZVZGXMki
         SRN/aRKYtdCByVFzAojZ+XpUchGlaufRsvLH4w6QYnpoIB/13LLwh0DXVQoOqvTKRRc+
         groVxEd9/Nw5xIgB34HgKy0XZB57mqx0iKOZoknX88EYycJCqcjl6FFL65siJsJFwWBV
         ikUNwN8YdC3l8It0+L9bzbGKXcWn+1BxDWPaCZHuQTwjhGfv0C9oetzA7JqSfdkfwptx
         U5aI2RX6UfOokaz6JXDSAZ4VjK+i5BYcIyMe3aAH740tOG3iGlR0vf0ebzASP4lDZcVa
         m9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51NZmWw8OgodGFU6Kwk+1cHIUOclm2JMHWgqoLAcNto=;
        b=Sx2/47ggQg/wnsWIU7LxmkQNl90UFW1bBbNbE8s/NfdW/dykVdowIzXIsHieLb79m2
         SCXGBb3K12X2Y2SoxW8fysbXUcvBA8gesY56yIGd03gaLSRcPg4NkW/y4/Eb+dnKY+vz
         zHTmhihV4w+E/KJIO/4XVPA1pk2EvTXazXncW5S9WBrhUttdO/IrpU69SbyNDvwmVdV9
         Vun3UwNmkJL3jMLwOJqW2f6rrHVTC0ORrZ25bSiwOXnb6YzzauYz4aTkKAyN9ttTNyb9
         JgwZAlJx8sqTvwN2zgay5vmRNgLKcZeFkIBDPWAEpppNE8cfcN6WkBF/x8wR42TjatZZ
         ZLsw==
X-Gm-Message-State: AOAM531wS/t7mMilV7eyANQwZRpbg/tAUwtdLZU3I7zzEhJO22009Qbp
        nLdZVocB9j8PRIFUVGnKdzSZyV1gsvtBAkMAj9M=
X-Google-Smtp-Source: ABdhPJwQWIgkduRjpke8VQImqkOHtcDvKOuMb3iSs2Z68bR+4jBb3XiYccBtJSOORYXmN3huf0xtevqJXXpDGN86/Zw=
X-Received: by 2002:a17:906:ca14:: with SMTP id jt20mr7861078ejb.233.1589653126099;
 Sat, 16 May 2020 11:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBHuPLS8BDzO4Gb86TG3tNTtqmW5BSWy8jhPuN3STOTUA@mail.gmail.com>
 <158948864581.215346.7236327959062539884@swboyd.mtv.corp.google.com>
In-Reply-To: <158948864581.215346.7236327959062539884@swboyd.mtv.corp.google.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 May 2020 20:18:35 +0200
Message-ID: <CAFBinCD6XiSnp=9vcFnztKobaq-Do9qd7WEi5Yvi5pvcw197og@mail.gmail.com>
Subject: Re: clk_hw.init and -EPROBE_DEFER / driver re-load
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, May 14, 2020 at 10:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
[...]
> Do you have some sort of array of clk_hw pointers to register? Maybe we
> could make a new clk registration structure to simplify this for users,
> but I'm not super interested in introducing yet another registration
> API! :/
>
> struct clk_hw_desc {
>         struct clk_hw *hw;
>         struct clk_init_data *init;
> };
I could make an array of clk_hw pointers but I think it will make
things more complicated then they have to be.
In another version of my MMC controller patches I had a dedicated
array of clk_init_data: [0]

compare this with the latest version (which has made it to linux-next
yesterday) where I'm initializing all clocks inside a few functions
(meson_mx_sdhc_register_clkc, rather than a static table): [1]
it's not great because it means I can't use a loop to register
everything. but it's fairly easy to read so I think it's the best I
can do for now.

With the "solution" from [1] I also don't run into the issue which I
described in my original mail because now clk_init_data only exists on
the stack.
I'm not sure if this is a recurring pattern or not, but for now I feel
like a new API is not needed.


Thank you for your time,
Martin


[0] https://patchwork.kernel.org/patch/11515631/
[1] https://patchwork.kernel.org/patch/11543939/
