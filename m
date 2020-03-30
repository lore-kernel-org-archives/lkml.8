Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E85C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAAB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgC3Iwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:52:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgC3Iwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:52:31 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXGak-1jrW2l1u2g-00Yk2T; Mon, 30 Mar 2020 10:52:29 +0200
Received: by mail-qk1-f178.google.com with SMTP id l25so18121678qki.7;
        Mon, 30 Mar 2020 01:52:29 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1aG4irB7mHsiFMAYO9mSVM1umy0vLL3Wx4gID9JHXyw6abmB8a
        MdGJ6M+WS7kL4go8gIIUF2S3uYmWFByVtWR7x48=
X-Google-Smtp-Source: ADFU+vspLuSrK8vR03RwDBO/StenmRiwdE7jGV6xhNQgPE6lP5dk6ojwytg8GYIfZCdnyNJJEiEKM8ekH1yyAFQe8+w=
X-Received: by 2002:a37:8707:: with SMTP id j7mr10668481qkd.394.1585558348217;
 Mon, 30 Mar 2020 01:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585311091.git.michal.simek@xilinx.com> <20200327141434.GA1922688@smile.fi.intel.com>
 <b5adcc7a-9d10-d75f-50e3-9c150a7b4989@c-s.fr> <2194609.nAEUQZTCmX@debian64>
In-Reply-To: <2194609.nAEUQZTCmX@debian64>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 Mar 2020 10:52:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0i7virtvTJHb2Ssx5zmJ4joKPEjK6timAXGK7BdymzKw@mail.gmail.com>
Message-ID: <CAK8P3a0i7virtvTJHb2Ssx5zmJ4joKPEjK6timAXGK7BdymzKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] powerpc: Remove support for ppc405/440 Xilinx platforms
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Enrico Weigelt <info@metux.net>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        DTML <devicetree@vger.kernel.org>, ewald_comhaire@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3Rz54Rm8At7MaFg5/rSCXyewRkCHG1d53Rzwr0x4HSGrQvn1ACc
 A7ob3P9g+5IGKTGje+ha4aPMrNXbrKDTcKfT3/TtnHDFkySVevbzxNE7w1Tg2mEMZ7U9KZ+
 MJpSyrdDnG+/SfzdWRYCQ+jwcIdSu6xXhmESN5AHpi1wRYkhL8FAH9poX3qdzBlKOjxAts9
 FSA0K/BSW7EQ9KX23Z72Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBJhdOpu6oY=:3irgf6fBFb0tgeUW1w3YBK
 6+6N8uxoBQN2r9UTk/9/vy5cvfHQDfWLqvUKXxZAu4KUcMvAQU0CodpLFKpGzWLNwf4Fa0KX8
 ZD7SECinCtbzMO4W9Xbt6OCsb9PEdVzfqnojYfKwf9ZRni4Tt0n0PwDahvJdQs7p9Hsc9XOg7
 vjrXG1UUThDwDEyflsAkXDq/lxFkrabcBjK1ceNcJzWYbJQ6AGXTgHUXdBd0oJyshsr+xYwXn
 r1zGYo/Xgv0KfJ8zIAgyxEcNBgT3kSwHj+xS16J4FBrEwT8QIEAgJT1mV0Iu950mMUrWAm8RT
 9hjVtbHxmVjZOni0SdN5BKc8dX+DiNT2ozzUXcFz+20h1UBxV6iMCUAS1ov02mhQe90gPPk7l
 9+Se9eXdG5kH1NwH7Sdc1zH47DmtPMeUvafiEiIiOhtcb9TSPT/+I+rhs0H5dSCOlgXh7t+sy
 IaLInMgnMd3cBRoRVvAz4GsE8eWqYgl9vrXW3B5VNxQqiBlVd73Cx69jZtUM9EyGkrF48rOkc
 PTPcV2m1RJ5EfkeKQbAQABv5JXbvzVMCCuIAMJm/XV9YJHX1xygL88veAcQ9yceT1yJz4PYZ7
 iG1FtTz+piXbFgR3KfzjjDL2nw5mh60BFmMbBtgLO1EFBXYRrsLHchpxBEskAzhFAzBOpIRHX
 tdyNVVAN673RFjjJnoQ1ymeCnO5GcOCbaaQQF9L3DVGJsJxvqw+/aorPRuAEdT5t8BcXLwZeY
 PTNjwvAKNRt/cPRT4iID8dstUiFvvo3LZssAEupPYXoE5eCobq7oXJNjBGATdM/DOsVuHAqpI
 Jec9yXnGhz5Ysq1ESnnzuYoqHx3ujqQh1AsAUoZ13F0aakmi8Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 4:07 PM Christian Lamparter <chunkeey@gmail.com> wrote:
>
> (Sorry for the bounces, yes my smarthost mail setup breaks from time to time
> and I had to cut the CC since it complained about the length.)
>
> I guess we should think about upstreaming the MyBook Live DTS. Problem here
> is that we deviated a bit from the canyonlands.dts/bluestone.dts structure
> by having a skeleton apm82181.dtsi with most of the SoC defintition and a
> wd-mybooklive.dts for the device.

I don't see much of a problem with that. If the chips are quite
different, then this
would be the right way to do it, and it matches how most dts files are
structured
on arm and others as well.

It would be nice to move over the the bluestone .dts to the apm82181.dtsi file
when that gets added, if only to ensure they use the same description for each
node, but that shouldn't stop the addition of the new file if that is needed for
distros to make use of a popular device.
I see a couple of additional files in openwrt [1],

[obviously, I'm not actually the one in charge here, the decision is with the
 powerpc maintainers].

        Arnd

[1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=target/linux/apm821xx/dts;h=d359ba4ed83547438581dd40105e5100d8240beb;hb=HEAD
