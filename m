Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D923DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407320658
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eXbjpFPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCZXBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:01:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:42155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZXBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585263681;
        bh=HdkTVHVytnW5Oi4T5qk+vrw0dCEFrZeiWyNHkJRlBxI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eXbjpFPeCQaqz0/sxcoGVf1WHXrzx6V34/7xxazunFmd7BIu6T0gJfhKRXU9Zbgu2
         aj8tqysYojtMof1NClslGeLiauhELTLiAzl8aXVnIgtmNwaTIwwCj6zU78T+ERLuPY
         J6+NwN8OyvIj+cGYCzaTcy8lrl98M+25kJBHcDMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.132.38]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1iprU42V89-00RsGi; Fri, 27
 Mar 2020 00:01:21 +0100
Subject: Re: [PATCH] parisc: Regenerate parisc defconfigs
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200326202006.GA160630@roeck-us.net>
 <20200326221921.GA20495@ls3530.fritz.box>
 <1585262834.3581.8.camel@HansenPartnership.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <f0825acd-d875-fa39-4659-b54d259f8b1c@gmx.de>
Date:   Fri, 27 Mar 2020 00:01:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585262834.3581.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:scES2xPd1bgQyA2y+a6JgQprQ5inp0f42XR/Np3gDBIDG3ke9tN
 Lcm8xlphOYE/k6JJk49CybTjXdksycBh9nZybto1yG/R+bqwmzOT9sHSuLy0tGRNzeZzOdJ
 uRsX26mfZZZBBK6Cl5FdziP5wc4mUHRd9N/u5u72ypUitvgNRuVXCfrz5JtSBHop0iJeNo2
 c3QDpQrrYVNccg+ixI0Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b0zDPY1BdSg=:MGg/siTMFAhw3yAOp0pY2n
 RGRT++Q0p/tiLd62ZDnaxIYwNGLUzbsvPyFQ/8QSXJbSt9VFUwVycIMkM5fb8YpidaqUXLsY2
 sPW+y7w5SVPRpLDwWrIQ/7BxeFkhlSxmxZR1COWFQscjPev/tMtVN5RwvuL7liwlzS6xMcsV/
 ebShgm7dGJy3VR0IFrg8OBKqZwLCnaqX7XhfKBieoyQdBE3/e8gPjTvkOTg84/JneoZuOp0UG
 ItM+crQP5UYb7c+sQ2aTbmdstZiMiS06PZe8JpX5+0LoEM87w1c/lp6QUfNawjvpuV+MS3XEe
 SoCkF5xJ3CKMM66emzVdHMHrsdr5gGCYX6CHounvHiDb6feQfxLQ7L5+u5D/t4KlQUt2KCCqK
 rSRjSm6Bd06nw07ksmkKvpUlXqt5uRhd/G3L9tI9+48+8HP1S/oNDV5d394/v52dzWEdHbWEe
 94PM8SYC2dRxqrzlymlJJu8Iml5A9OOR7RX9KtAjrodRBraBLfXYqtBzuhGU5rcIv2stLOxv8
 s+etDdsxB6EYr9a9W11olGxdYoIvjrsNcSm4Otv//7RXL78z8q3qdmEYufSREnsjKElnHQX90
 NLogeVaeVj1O7F4JnlBBw1BvKTYN6QtdECSa+d7VKtKUYuUfaCIpTkzxNh/I4SpnSidSLgVrK
 nDsZQdlifCSfsBBAVQXbXBChO2JXo7A6nMXeDN/xdWh2LpkmZdKyvXHqLXGPXu/gtkfjA0DAC
 6EnWHHpWj8cozfF4wdunic+rJfUf2tFMDjES065sZfjCSiNP/QSlkVVqXB7Q+KG83zNHRUyO1
 MO+s6w8LbBAhuRDjS7gV51MrIBFaGeE+ZqkXCB6rSVOZi4QaKDel/ED2DudPgcI+GtE46U3Pt
 fRXPptKPUK7/Rr6WGDl6mbBxCJEkIX3BgI5GSRoHRXKADXsFKXq0haXWHviLyUsXIna6pnnbQ
 k7lwkQzRP+6eoK5Zv4rw3DIVlLdYUFdnGRCoxy7FrtStRh+1mfaIVjn9qC5xGBgdDeGBFTPWg
 5kd6ijcVozMvvaFyop8ZjN7O4IDeAM1XoJp2GnrLCGpZYDuFQlPMw4zAlOQWhBq3juQT95q1q
 xl0WFeN3w4r3naSoeeYTE8iDyF5ZyEakgcjSiUW38dFSUi4+vZNBAMJ5OG5CCSZlwh9S3qn4M
 UGd8aJfyBhoBTfRL4U4Bz3486C4nAeTU8ayBcUxEkH8HIEOAADXRHKoI+jJAGv0EPblzcuG2D
 wUUMyyhQMpn7r8tVl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.20 23:47, James Bottomley wrote:
> On Thu, 2020-03-26 at 23:19 +0100, Helge Deller wrote:
>> * Guenter Roeck <linux@roeck-us.net>:
>>> On Mon, Feb 03, 2020 at 10:31:22PM +0100, Helge Deller wrote:
>>>> Regenerate the 32- and 64-bit defconfigs and drop the outdated
>>>> specific
>>>> machine defconfigs for the 712, A500, B160, C3000 and C8000
>>>> workstations.
>>>> ---
>>>>  arch/parisc/configs/712_defconfig           | 181 --------------
>>>> -
>>>>  arch/parisc/configs/a500_defconfig          | 177 --------------
>>>> -
>>>>  arch/parisc/configs/defconfig               | 206 --------------
>>>> ---
>>>
>>> Since the removal of arch/parisc/configs/defconfig, "make
>>> ARCH=3Dparisc
>>> defconfig" results in an endless recursive make loop.
>>
>> Can you please test the patch below?
>> Helge
>>
>> ----
>> [PATCH] parisc: Fix defconfig selection
>>
>> Fix the recursive loop when running "make ARCH=3Dparisc defconfig".
>>
>> Fixes: 84669923e1ed ("parisc: Regenerate parisc defconfigs")
>> Noticed-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 71034b54d74e..3801a2ef9bca 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -79,6 +79,11 @@ config MMU
>>  config STACK_GROWSUP
>>  	def_bool y
>>
>> +config ARCH_DEFCONFIG
>> +	string
>> +	default "arch/parisc/configs/generic-32bit_defconfig" if
>> !64BIT
>> +	default "arch/parisc/configs/generic-64bit_defconfig" if
>> 64BIT
>> +
>>  config GENERIC_LOCKBREAK
>>  	bool
>>  	default y
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index dca8f2de8cf5..628cd8bb7ad8 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -34,6 +34,13 @@ CC_ARCHES	=3D hppa hppa2.0 hppa1.1
>>  LD_BFD		:=3D elf32-hppa-linux
>>  endif
>>
>> +# select defconfig based on actual architecture
>> +ifeq ($(shell uname -m),parisc64)
>
> This won't work for cross builds.  You should be able to use
> $(CONFIG_64BIT) here, though.

I don't think so... CONFIG_64BIT is set in the config itself.

I'm using crossbuilds, and "make ARCH=3Dparisc defconfig" does work
in the sense that it auto-selects 32bit then:

[deller@ls3530 linux-2.6]$ uname -m
x86_64
[deller@ls3530 test]$ make ARCH=3Dparisc defconfig
make: Entering directory '/home/cvs/LINUX/git-kernel/linux-2.6'
make[1]: Entering directory '/home/cvs/LINUX/git-kernel/test'
  GEN     Makefile
  ....
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'generic-32bit_defconfig'
#
# configuration written to .config
#


If you want the 64bit defconfig you can run
make ARCH=3Dparisc generic-64bit_defconfig

Helge
