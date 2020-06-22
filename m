Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72988C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AA62075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SSPivWN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgFVUs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:48:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47053 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgFVUsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:48:55 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 05MKmkhO2220693
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 22 Jun 2020 13:48:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 05MKmkhO2220693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020052301; t=1592858928;
        bh=qK1GQ3W6Pi4xX9Ea+1auBCAyZ/O5uuSxujhiAeKID9g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SSPivWN2sEZECwBqhIcK0Id+FBFe9duWrX+JwbRCl8+i0wETIkqO+54ZgWB/+xSKQ
         ZRIW+pNAjeUyplLl6g8KlaINBJXk/5rP91u69nUTDS8EHvoCOjaB3yHqvccXrRsLre
         7EmzGWRxKaPzoh/Vd5PTea0r/nIs2/VBCZ4oBN2RppsW+9lHqWA7m3WGDVZuT47ki1
         fGMxKSZ1RtA++vx1Q2SVvXy2EsNOPbN342ZJ4iGhiBD2mZ7FSamq2TrGGmNOpyh6zc
         EWv93EIQqORSWFKagwG5uYcAl/mShXyTE5yw2qiH6PPR7rL9QK9HYTdKjvzk9GmMs3
         AtOTLg6VhIbRw==
Subject: Re: [PATCH] initrd: Remove erroneous comment
To:     Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2455d1e8-d6b4-760b-9a4c-0071c5ae986d@zytor.com>
Date:   Mon, 22 Jun 2020 13:48:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622204034.GL27801@bill-the-cat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 13:40, Tom Rini wrote:
> On Mon, Jun 22, 2020 at 01:02:16PM -0700, ron minnich wrote:
> 
>> The other thing you ought to consider fixing:
>> initrd is documented as follows:
>>
>>         initrd=         [BOOT] Specify the location of the initial ramdisk
>>
>> for bootloaders only.
>>
>> UEFI consumes initrd from the command line as well. As ARM servers
>> increasingly use UEFI, there may be situations in which the initrd
>> option doesn't make its way to the kernel? I don't know, UEFI is such
>> a black box to me. But I've seen this "initrd consumption" happen.
>>
>> Based on docs, and the growing use of bootloaders that are happy to
>> consume initrd= and not pass it to the kernel, you might be better off
>> trying to move to the new command line option anyway.
>>
>> IOW, this comment may not be what people want to see, but ... it might
>> also be right. Or possibly changed to:
>>
>> /*
>>  * The initrd keyword is in use today on ARM, PowerPC, and MIPS.
>>  * It is also reserved for use by bootloaders such as UEFI and may
>>  * be consumed by them and not passed on to the kernel.
>>  * The documentation also shows it as reserved for bootloaders.
>>  * It is advised to move to the initrdmem= option whereever possible.
>>  */
> 
> Fair warning, one of the other hats I wear is the chief custodian of the
> U-Boot project.
> 
> Note that on most architectures in modern times the device tree is used
> to pass in initrd type information and "initrd=" on the command line is
> quite legacy.
> 
> But what do you mean UEFI "consumes" initrd= ?  It's quite expected that
> when you configure grub/syslinux/systemd-boot/whatever via extlinux.conf
> or similar with "initrd /some/file" something reasonable happens to
> read that in to memory and pass along the location to Linux (which can
> vary from arch to arch, when not using device tree).  I guess looking at 
> Documentation/x86/boot.rst is where treating initrd= as a file that
> should be handled and ramdisk_image / ramdisk_size set came from.  I do
> wonder what happens in the case of ARM/ARM64 + UEFI without device tree.
> 

UEFI plus the in-kernel UEFI stub is, in some ways, a "bootloader" in
the traditional sense. It is totally fair that we should update the
documentation with this as a different case, though, because it is part
of the kernel tree and so the kernel now has partial ownership of the
namespace.

I suggest "STUB" for "in-kernel firmware stub" for this purpose; no need
to restrict it to a specific firmware for the purpose of namespace
reservation.

	-hpa
