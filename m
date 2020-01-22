Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E346424656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVM4rvKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAVTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:54:55 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34731 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:54:54 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so388405ywc.1;
        Wed, 22 Jan 2020 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AXqcs9WJmqdUels2VMQQnGKt+9ND4M0NUtQ6v5MXWoY=;
        b=MVM4rvKHeS6Q/bNILmRzNPca+0GRjbYna1jX+lwZUDerB/tvIH03gBrxx0LO23f+De
         rzdqENMv6hdhyFi5bVlEuk8R0akqk+LOVymPn6rG5TrOrdoy53bgJGlCeUPf1PT1aFVZ
         WLrnmDnYssRJWM44AV9gyJxMV6c9KpHo5nph0az6vm382j1rjOi0NQrxb1joow4ujq9m
         awv6ITa+gRJ29ZUt3dKEbmMhRy5vJCi3fYWRCtL54JDGlY8QgK98pgfQReSI9W+Vy0gO
         x8Xyi4uGYcotezBusfXs5OG2QKBcQfN2dPJkunBbpcq6M8V43lMlLlaZYxbX05mcjDWx
         wnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AXqcs9WJmqdUels2VMQQnGKt+9ND4M0NUtQ6v5MXWoY=;
        b=eUFvVJ69yaow9ORtcHqhq0H9Lf804ACdzGb0IjtIjbC+MIzvXdmjtu/aEj0U0ChLZe
         hfrTdIziU/zP294okx+5WSm8TBQ9BDwu6ALCTGBl6pGxFcnVcMmQL7yCAHk54RSCwuhr
         nwsb6/oX5TkYvzkyGoQ7NXxArwF0pny4uFJAscxks2AdJmy7GG5LmSu6I5kR6ksZY7hZ
         j7RJY5Kvd2SRYd7D3NcsGNKJ9hDO26WzjqUbLkUYfbqJDfLs0QC+ki3I35+Gn1xHm8ao
         Smu8kb0PeV89+lBuT8jPzeu9reKpeXc8LFqCsW6ib+pAeft5fDZrlXPV1n2Ylqw8hzzB
         8Bpg==
X-Gm-Message-State: APjAAAVBwfUvpWLQnCdeEJTMKqIN+luPJErPQBmNEK7IeSwv2Lm3v8V1
        x0LgwSd4hyJMFZq5lLLjLr8=
X-Google-Smtp-Source: APXvYqxnksodXJBAYgms0pJ7bm7w+vD+JepuHbC/K0Wf5xHZaFFKGAw3pHeMXslzJ4KjRA8JeNTOoA==
X-Received: by 2002:a81:8986:: with SMTP id z128mr8694139ywf.320.1579722893330;
        Wed, 22 Jan 2020 11:54:53 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id j11sm18895112ywg.37.2020.01.22.11.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 11:54:53 -0800 (PST)
Subject: Re: [RFC PATCH 1/3] dtc: Add dtb build information option
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Steve McIntyre <steve.mcintyre@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>, ian@freebsd.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>
References: <20200113181625.3130-1-alexandre.torgue@st.com>
 <20200113181625.3130-2-alexandre.torgue@st.com>
 <20200116005741.GB54439@umbus> <d2594b79-a45d-dcac-3642-90016a1408b8@st.com>
 <20200117090937.GU54439@umbus>
 <CAL_JsqKTsX9efYDMjGahFDxj0cEfzozeNrY1Nq1bECzgOZGqdQ@mail.gmail.com>
 <20200120181708.GN3697@linaro.org>
 <9d83a36c-78c5-3452-bb48-209d68c46038@st.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c3732a75-83bc-890f-9a02-d3a61c626a6c@gmail.com>
Date:   Wed, 22 Jan 2020 13:54:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9d83a36c-78c5-3452-bb48-209d68c46038@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 12:00 PM, Alexandre Torgue wrote:
> Hi
> 
> On 1/20/20 7:17 PM, Steve McIntyre wrote:
>> On Fri, Jan 17, 2020 at 08:43:23AM -0600, Rob Herring wrote:
>>> On Fri, Jan 17, 2020 at 6:26 AM David Gibson
>>> <david@gibson.dropbear.id.au> wrote:
>>
>> ...
>>
>>>> What might be better would be to have a dtc option which force appends
>>>> an extra .dts to the mail .dts compiled.  You can then put an overlay
>>>> template in that file, something like:
>>>>
>>>> &{/} {
>>>>          linux,build-info = /incbin/ "build-info.txt;
>>>> }
>>>
>>> I like this suggestion either as an include another dts file or an
>>> overlay. The latter could be useful as a way to maintain current dtb
>>> files while splitting the source files into base and overlay dts
>>> files.
>>
>> ACK, that sounds like it could be helpful.
>>
>>> But no, let's not prepend this with 'linux'. It's not a property
>>> specific for Linux to consume.
>>
>> Right. We might be seeing the data coming through from U-Boot (or any
>> other random bootloader) too.
>>
>> Cheers,
>>
> 
> Thanks for reviews. I gonna prepare a V2 with David proposition (to use overlay format) by keeping in mind not to modify existing dts(i) files.
> 
> Remaining questions are:
> 
> 1- "build-info" or "linux,build-info"? IMO, If information is
> "generic" then first one should be used.


I would prefer build-info.  The data may be generated by a non-linux
build environment, such as uboot.


> 2- Looking at Franck proposition[1] some years ago and objections on
> it, do you think that this one could accepted ?

I think that with the few small changes suggested in this thread, that
the old objections are not relevant to your version.


> 
> regards
> Alex
> 
> [1] https://lore.kernel.org/linux-arm-kernel/550A42AC.8060104@gmail.com/
> 
> 
> 
> 
> 

