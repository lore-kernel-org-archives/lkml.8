Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429B9C35658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194A120722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2/SIg7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBURVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:21:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38904 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBURU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:20:59 -0500
Received: by mail-yb1-f195.google.com with SMTP id v12so1453069ybi.5;
        Fri, 21 Feb 2020 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWVlgYAJf77FUNFo3/GoZgBj7JaoEHC4YwQbTnJvbbc=;
        b=O2/SIg7l0/i5PbP4X5bVieM9HRmU9hfDvouoosrMYOossZA4EyT5dE/t+LsWCQnUeW
         8mZbom/4oUeT1QMZPE0a8M5re6u9/XxzZHyMJewYMwKs+nWJbv/G44pfNCzD7LfCYTZV
         6APUhf3rXva0+NHi+1/eYjTGU20lXmjPgtz78XrJFxXMQgryVwsnrBSKoVLu2kDWBroJ
         QuIkrlvMzqCc1ZCJmgjfPUHIOxBY7ILAZ6dbeCEdudlQ4BJ5J5gdsCVBbx0WtGtUx7Lq
         gtyfLuRUIUcr8H626+8YYIea6ctJOItRgmfhfvnHUVcDICue1KP5iN33iwQQtxa965OT
         gUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWVlgYAJf77FUNFo3/GoZgBj7JaoEHC4YwQbTnJvbbc=;
        b=NpNT50LZT+kb0uFcgmKIuxBy1UaBnqoFta3A6PVfbTdAmTunj4TP863ntFaeUMO4G8
         GU9DOOa7BHE9b0cTRSPxboiLRQAadfzAt6+O+QToIPdvv3PAUUtA4AMGrLtSoBa7feTZ
         Z6Wvw91C5M1CGwRf7rbs+pb6lUqXcROpkDvmPhCzEygXJBuHaRWnglv9oO8bI0Pe+203
         7Jaz+CXCChUg3+0OaznsaNNDPvgtHE41IAfiuTbzCUL0MEZsSQpIvPagcivgr6zfVdx4
         NhJsCNrtqxAgKqF3tnTknPoDnl2cN0926zjxX7e05igxTbwSWS14LV5dwv5nw8uE4jZA
         IitQ==
X-Gm-Message-State: APjAAAWUstZrmnJ2rE9evyQpQv7IfevYdZOqReUkqKoB4abEt+ZG0rDx
        myLjN1zuUBky6pUlbkLBJIs=
X-Google-Smtp-Source: APXvYqyxmw+5hIn9x8XNU+OdTvUPMMG4/1DpfpgIXHun2JCbsH+bBhK1YGyWv6rE/4E1+7rg1kiVSg==
X-Received: by 2002:a25:b9c8:: with SMTP id y8mr31348517ybj.369.1582305658699;
        Fri, 21 Feb 2020 09:20:58 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id s68sm1539521ywg.69.2020.02.21.09.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:20:58 -0800 (PST)
Subject: Re: [PATCH v2 1/2] gpio: of: Extract of_gpiochip_add_hog()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200220130149.26283-1-geert+renesas@glider.be>
 <20200220130149.26283-2-geert+renesas@glider.be>
 <CACRpkdbgsR1n1qj3HmQWcEjeDdN85N1Mw8kLOUAeDjESW36MDg@mail.gmail.com>
 <d2b87102-fdf3-f22f-8477-5b2105d9583b@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3d56743a-ffb2-4f26-dfb0-b8430f0a4583@gmail.com>
Date:   Fri, 21 Feb 2020 11:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2b87102-fdf3-f22f-8477-5b2105d9583b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 11:18 AM, Frank Rowand wrote:
> Hi Linus, Rob,
> 
> On 2/21/20 10:08 AM, Linus Walleij wrote:
>> On Thu, Feb 20, 2020 at 2:01 PM Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>
>>> Extract the code to add all GPIO hogs of a gpio-hog node into its own
>>> function, so it can be reused.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v2:
>>>   - No changes.
>>
>> Patch applied with Frank's Review tag.
> 
> I created a devicetree unittest to show the problem that Geert's patches
> fix.

I left out the link to my patch series:

   https://lore.kernel.org/linux-devicetree/1582224021-12827-1-git-send-email-frowand.list@gmail.com/

   [PATCH v2 0/2] of: unittest: add overlay gpio test to catch gpio hog problem

-Frank

> 
> I would prefer to have my unittest patch series applied somewhere,
> immediately followed by Geert's patch series.  This way, after
> applying my series, a test fail is reported, then after Geert's
> series is applied, the test fail becomes a test pass.
> 
> Can you coordinate with Rob to accept both series either via
> your tree or Rob's tree?
> 
> -Frank
> 
>>
>> Yours,
>> Linus Walleij
>>
> 

