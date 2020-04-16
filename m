Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE98C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7108420774
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502065AbgDPPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:07:08 -0400
Received: from nbd.name ([46.4.11.11]:49192 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408793AbgDPNv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:51:58 -0400
Received: from [2a04:4540:1400:7b00:2d8:61ff:feed:60f5]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jP4vV-0004e0-L6; Thu, 16 Apr 2020 15:51:33 +0200
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        cheol.yong.kim@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        masonccyang@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>, qi-ming.wu@intel.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, Hauke Mehrtens <hauke@hauke-m.de>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
 <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
 <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com>
 <20200416135711.039ba85c@collabora.com>
 <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com>
 <20200416144036.3ce8432f@collabora.com>
 <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <5cb0fe27-8b65-d777-b1c5-8dc47bda2d54@phrozen.org>
Date:   Thu, 16 Apr 2020 15:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.20 15:20, Arnd Bergmann wrote:
> On Thu, Apr 16, 2020 at 2:40 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
>> On Thu, 16 Apr 2020 15:26:51 +0300
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Apr 16, 2020 at 3:03 PM Boris Brezillon
>>> <boris.brezillon@collabora.com> wrote:
>>>> On Thu, 16 Apr 2020 19:38:03 +0800
>>>> Note that the NAND subsystem is full of unmaintained legacy drivers, so
>>>> every time we see someone who could help us get rid or update one of
>>>> them we have to take this opportunity.
>>>
>>> Don't we rather insist to have a MAINTAINERS record for new code to
>>> avoid (or delay at least) the fate of the legacy drivers?
>>>
>>
>> Well, that's what we do for new drivers, but the xway driver has been
>> added in 2012 and the policy was not enforced at that time. BTW, that
>> goes for most of the legacy drivers in have in the NAND subsystems
>> (some of them even predate the git era).
>>
>> To be clear, I just checked and there's no official maintainer for this
>> driver. Best option would be to Cc the original author and contributors
>> who proposed functional changes to the code, as well as the MIPS
>> maintainers (Xway is a MIPS platform).
> 
> A lot of the pre-acquisition code for lantiq was contributed by Hauke
> Mehrtens and John Crispin. There was an intermediate generation of
> MIPS SoCs with patches posted for review  by Intel in 2018 (presumably
> by the same organizatiob), but those were never resubmitted after v2
> and never merged:
> 
> https://lore.kernel.org/linux-mips/20180803030237.3366-1-songjun.wu@linux.intel.com/
> 
>          Arnd
> 

Hi,

the legacy Mips SoC had a External Bus Unit (EBU), similar to an 
Intel/Hitachi style bus. It was used back then for lots of things, 
sometimes driving Leds via 74* latches, Arcadyan used it for external 
reset lines and very rarely was it used for nand.

Looking at this series and comparing it with xway_nand.c we see that the 
init sequence is near identical. Best guess is that the mountain lion 
uses an internal block very similar to what the legacy mips silicon used 
just in a newer generation and the new proposed driver is more feature 
complete.

If this is the case ideally the xway_nand.c is dropped and that silicon 
is made working with the newer driver. Chances are that we just need to 
add a "support less features" style flag.

Unfortunately i no longer have the evalkit for the Mips SoCs.

    John
