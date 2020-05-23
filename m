Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67483206D5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgEWTkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:40:36 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgEWTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:40:36 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4alK-1jeEAW0tfy-001fMU for <linux-kernel@vger.kernel.org>; Sat, 23 May
 2020 21:40:34 +0200
Received: by mail-qk1-f182.google.com with SMTP id b6so14095023qkh.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:40:34 -0700 (PDT)
X-Gm-Message-State: AOAM532K8X8y3XrrucdUxZ3+DnLHfpyRoKXA+kZCi/IN3pBW3rbmQi9R
        6sZS+DVvhQ8cIUoVQrfublRuBSvSqhsSQRejSOo=
X-Google-Smtp-Source: ABdhPJxdmk1QexqtMHGdeu7MjmgSEmO7EE3boE5eJeGCXiRwjdR/yqCPJLcX8W0/EipJ3GhWH9ul/Jj6wMwUoHLjl90=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr20341230qkl.286.1590262833137;
 Sat, 23 May 2020 12:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200522124951.35776-1-sudeep.holla@arm.com> <20200522124951.35776-3-sudeep.holla@arm.com>
 <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com>
 <20200522165422.GA18810@bogus> <CAK8P3a33_5q1bNRrt+4sQ55QKrN12rOkuzmPH0BDujbug1RTyA@mail.gmail.com>
 <20200523172721.GC18810@bogus>
In-Reply-To: <20200523172721.GC18810@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 23 May 2020 21:40:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+jjgOyJcRQm60RULjwtvWzvYK1QwrjOX_aRAbDGKuJg@mail.gmail.com>
Message-ID: <CAK8P3a1+jjgOyJcRQm60RULjwtvWzvYK1QwrjOX_aRAbDGKuJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        harb@amperecomputing.com, Jose.Marinho@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francois Ozog <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t6n2qIETebphpD4XH6sBwfwPQp1O47VzFMHYgjA7SCpmXOgodpU
 CNKDbpUsu6J8TrmzG7PJ2KVbou5pqubwy05oO66HP7o6U913VXfSB82Tml9vt9cgXgl1Rxc
 zDPSpCWGpA2Yifa3hgyWPvLHLkwmAoqYy5riXLRjv196gd/TauqCUaaR/n6i1WcLiyoIhgj
 e8JbcYaHkHZIxKTlfouuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wVI1LmgKxI=:pexfkgX9SG0vXXIaufzV5S
 dPyCaUZvwUk/m3veIUOnVpK6AmsrYxRdINWX17dhNxV5SODIxNnSxTvd7JPpzfF/bt3TFEGjC
 /cFTvNBoLTQm1UPRLwtUS0r4unbbIFDruMwDrIuSOYsWkpBVN9MWNgccUJpTbkyOOaInk+tYE
 nizoH2IO7O5ov/hZHhHl3RSHi7juVZ/M1+D+cXz5NkAHvewFMKR9cTlfXWy5yBBdTPEeJ4xWU
 3TwqZz2VeqxUcrj8DmHWeyLRu6d7mMnd7hdovR0BSD0h0Ft0xcnFz4wzyvQfL/s8BeCK4xdeg
 diwcAeGEbIrFuN+JR1/ciuvtkc44DeC5YNKk69tEA0LOCapw2qHCuMT37B8t+wnCBhSd47Acr
 7HiLvgPz1HO+I4nvox00RrOXxBowKcrxAKs11dXkHS5LO2ffKqD0cblPLNBhOmYtRgM5VtbwU
 c4mGSkKD1kHdNV9NK1Bo1G6W0z7XFsobacu8rbRfdkEii21X/HNKLd91jvHidP95KOsz4tqLX
 /fmXpUoq8ZmxTUjfe6f5FTD4yH92xCzwy1oVAAK0v3vivIpX92ok1ieh7MqNOnaSjbqmKW6EN
 GR/uScViy9p57fWavaMfAVTexwMpB5IJHbnmuKd0+yUdw06HEHHahp7I5USb1hcMK3LQmZqNv
 dYXb/O7sg3lWpdrskNLnE1RprtZWREIMQT827pADnjCbaMV2S8PYGMs+FI8DmI8sWL4WiA8O6
 VeSbyQpK8x2V4Kz0CUp4XyCAOCk9Cx9KN/ktCypPn0W7sQurp784SuPqzyu+dSn9G0vvtsksw
 EeRe7KwYllL4bPK9D/28O+PZfETZEO35u3M7ytcJ0BYKUXW4/A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:27 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, May 22, 2020 at 08:41:59PM +0200, Arnd Bergmann wrote:
> > On Fri, May 22, 2020 at 6:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > jep106:5678 (the IMP_DEF_SOC_ID field in my example) would
> > probably be sufficient to not conflict with a another soc_device
> > driver, but is quite likely to clash with an ID used by another
> > manufacturer.
> >
>
> IIUC, you are fine with "jep106:1234:5678" where 1234 is jep106 manufacture
> id code and 5678 is soc_id as it may avoid all the conflicts across
> the manufacture namespaces.

I think either jep106:5678 or jep106:1234:5678 (or some variation with
different field separators if you prefer) would be fine here.

> > jep106:1234 (the manufacturer ID) in turn seems too broad from
> > the soc_id field, as that would include every chip made by one
> > company.
> >
>
> I understand, and IIUC you prefer this to be embedded with soc_id
> especially to avoid namespace conflicts which makes sense.
>
> Thanks for all the discussion and valuable inputs. I am now bit nervous
> to add SoC info from SMCCC ARCH_SOC_ID to sysfs yet as we need more info
> especially "machine" and "serial_number" for elsewhere(OEM firmware mostly
> from DT or ACPI).

I probably wouldn't mix those in with the same driver. If machine and
serial_number have no smccc interface, then they should be left out,
but there could be a separate soc_device that gets that information
by other means, usually using one of the existing hardware id register
drivers.

> TBH, the mix might be bit of a mess as there are soc drivers that rely
> on DT completely today. Anyways, this SOC_ID can be added as library that
> can be used by a *generic* soc driver once we define a standard way to
> fetch other information("machine" and "serial_number"). I am happy to
> get suggestions on that front especially from you and Francois as you
> have got some context already.

Well, I suppose we could have the entire data from the smccc interface
in a central place somewhere, such as (to stay with my example)
"1234:5678:9abcdef0" in an attribute of any soc_device driver that
adds a call to a library function for the jep106 ID, or possibly in
/sys/firmware or even a field added to /proc/cpuinfo.

       Arnd
