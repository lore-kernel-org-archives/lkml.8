Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7025EC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF020674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuZlg3ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCQSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:19:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgCQSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:19:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so5251753wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c+ARzy+MYfu8Uf7LwWJXwSNOvyXP5I9gtUw3sUdT2FA=;
        b=SuZlg3ryhT0t/PQC5ZB7cEUhiq8HezOQ0TNd9+oTe4daeeLFjDf3KkH9f+KoKjj+6U
         vZ9SJpTRm0TsS00WcUX6lIbuLJdeO7+UwuxZspmXnRoRu0tCBlXMgBAHJOuWeZxm5/m1
         ikH6ckz3WYkM8Ec2DnPxDbDCT47l4BCw9p0Ccio43LreajyyGnfOqQPE2d8gNwZ+scNs
         Y7wx9uhqApiwrnuE8LRJajKz9dXn5Gqu0Dl0W0w8t12b7TD65XE/uNBgnOzK458kQXER
         Qobr5xbIvbZFHnmEaz7WeGro26Pd+Wqb8h/zg9qDYf2Zjf6LUYwCCxBsxDNiNVsogkaq
         hQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c+ARzy+MYfu8Uf7LwWJXwSNOvyXP5I9gtUw3sUdT2FA=;
        b=mT6VSySCWHFpnOnVz1WJblzoPlftxZjZ0Bb670IwolxK3IwyTxONONBXaUZXxbhvXY
         gV4Hu/7/h6jCj6aB1eAiBKTdQNXcT8wIqAOLsfOoiYVnsMrgu7pqK6NMNRjxvTEqDxzm
         aSktHHfodqhMsuDETzIEqldwT+hg+ZdY5ursPeQG5LDFN/1fbGoVnvznxq5Si1qhUsfg
         g6VqlOIX6jmU7igscyDoCN4+Mr7TNOnuR0Jmn7ezBNSrSjDaIX5/dClvDgQ/zJl/rT7h
         ZGu7z3g/f0NqfqVG4fZEpaY8K6K8BYm2Uaqai8QauFnbapnMCuudAJJHUK91tyPpPPG3
         LMkg==
X-Gm-Message-State: ANhLgQ0oJHJ3MkdWQjHZk8B0DzvwQM1zFOylYjUox6hbBu8ylpDGWipv
        WYuJAT3oOpswr/E8MWNePvO/JyKiTLQ=
X-Google-Smtp-Source: ADFU+vvKyQ9u/bjOnc6f8taFh7EavFMGBOUTsBp3/L6biLI6eThLGOVGUPETA6nJT8FHOeNkzdi83g==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr285824wro.115.1584469137921;
        Tue, 17 Mar 2020 11:18:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bd37:618d:f415:31ea? ([2a01:e34:ed2f:f020:bd37:618d:f415:31ea])
        by smtp.googlemail.com with ESMTPSA id f10sm1632413wrw.96.2020.03.17.11.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 11:18:57 -0700 (PDT)
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Saravana Kannan <saravanak@google.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200111052125.238212-1-saravanak@google.com>
 <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
 <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org>
 <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
 <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org>
 <CAGETcx-i5ows0bh_gRao5jV7GZtsNJ+0u8tC+w8E0YLxd7U94w@mail.gmail.com>
 <73509a5b-7bb2-fae5-9bd1-cb809a5b67e8@linaro.org>
 <CAGETcx-UAjWhtDMoTaLX-2HwXWq-3aAi9FcwszEJ1-YKcekqmQ@mail.gmail.com>
 <5e70b653.1c69fb81.b03d8.d2bbSMTPIN_ADDED_MISSING@mx.google.com>
 <CAGETcx9-TB3XWFvU0ME+eCTyJVs7a_ExD-5Dvm9VVvB=UkkMWg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4b9752f6-1723-9c5f-03a5-005fe6182488@linaro.org>
Date:   Tue, 17 Mar 2020 19:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx9-TB3XWFvU0ME+eCTyJVs7a_ExD-5Dvm9VVvB=UkkMWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2020 19:08, Saravana Kannan wrote:
> On Tue, Mar 17, 2020 at 4:36 AM Paul Cercueil <paul@crapouillou.net> wrote:

[ ... ]

>>>>  >> Why not just set the OF_POPULATED if the probe succeeds?
>>>>  >>
>>>>  >> Like:
>>>>  >>
>>>>  >> diff --git a/drivers/clocksource/timer-probe.c
>>>>  >> b/drivers/clocksource/timer-probe.c
>>>>  >> index ee9574da53c0..f290639ff824 100644
>>>>  >> --- a/drivers/clocksource/timer-probe.c
>>>>  >> +++ b/drivers/clocksource/timer-probe.c
>>>>  >> @@ -35,6 +35,7 @@ void __init timer_probe(void)
>>>>  >>                         continue;
>>>>  >>                 }
>>>>  >>
>>>>  >> +               of_node_set_flag(np, OF_POPULATED);
>>>>  >>                 timers++;
>>>>  >>         }
>>>>  >>
>>>>  >> instead of setting the flag and clearing it in case of failure?
>>>>  >
>>>>  > Looking at IRQ framework which first did it the way you suggested
>>>> and
>>>>  > then changed it to the way I did it, it looks like it allows for
>>>>  > drivers that need to split the initialization between early init
>>>> (not
>>>>  > just error out, but init partly) and later driver probe. See [1].
>>>>  >
>>>>  > Also, most of the other frameworks that set OF_POPULATED, set it
>>>>  > before calling the initialization function for the device. Maybe
>>>> it's
>>>>  > to make sure the device node data "looks the same" whether a
>>>> device is
>>>>  > initialized during early init or during normal device probe
>>>> (since the
>>>>  > OF_POPULATED is set before the probe is called) -- i.e. have
>>>>  > OF_POPULATED  set before the device initialization code is
>>>> actually
>>>>  > run?
>>>>  >
>>>>  > Honestly I don't have a strong opinion either way, but I lean
>>>> towards
>>>>  > following what IRQ does.
>>>>
>>>>  Thanks for the pointer. Indeed it is to catch situation where the
>>>> driver
>>>>  is clearing the flag like:
>>>>
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/ingenic-timer.c#n245
>>>>
>>>>  But I'm not able to figure out why it is cleared here :/
>>>
>>> I think I know what's going on. He wants to implement PM support for
>>> this timer. But PM support is tied to devices. So, clearing out the
>>> flag allows creating the device which then hooks into PM ops.
>>
>> That's correct - the OF_POPULATED flag is cleared so that the driver
>> will probe as a platform_device. When I did write the driver this was
>> required or the platform_device would not probe.
> 
> Interesting. I went and looked at the kernel when your patch merged.
> As far as I can tell, you shouldn't have needed to clear OF_POPULATED
> because the timer framework never set OF_POPULATED even back then.
> 
> If this driver was based in drivers/irqchip/irq-ingenic-tcu.c and you
> were initially just trying to get it to create a device, then you'd
> have needed to clear OF_POPULATED because IRQ chip framework does set
> the flag.
> 
> In any case, it's good that you cleared it -- it'll continue to work
> with my patch.
> 
> Daniel,
> 
> Looks like this answers all the concerns you had. I also checked every
> driver in drivers/clocksource that had the word "probe" in it to make
> sure it won't need any updates to ingenic-timer.c. Can we merge this?

Applied [1], thanks

 -- Daniel

[1]
https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=timers/drivers/next&id=4f41fe386a94639cd9a1831298d4f85db5662f1e


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

