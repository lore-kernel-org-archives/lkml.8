Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DE1206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgEKQSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:18:03 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:38936 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:18:02 -0400
Received: from [10.2.58.39] (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 000DC1C074D;
        Mon, 11 May 2020 10:17:59 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at avon.wwwdotorg.org
Subject: Re: arm64: tegra186: bpmp: kernel crash while decompressing initrd
To:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     talho@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de
References: <20200508084041.23366-1-ykaukab@suse.de>
 <e01aba39-1f81-de00-2f7e-dd7295baa7ed@arm.com>
 <20200511152330.GA1718@suse.de>
From:   Stephen Warren <swarren@wwwdotorg.org>
Autocrypt: addr=swarren@wwwdotorg.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3a0c32ca-8475-a034-8c87-558441feca44@wwwdotorg.org>
Date:   Mon, 11 May 2020 10:17:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511152330.GA1718@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 9:23 AM, Mian Yousaf Kaukab wrote:
> On Mon, May 11, 2020 at 12:25:00PM +0100, Robin Murphy wrote:
>> On 2020-05-08 9:40 am, Mian Yousaf Kaukab wrote:
>>> I am seeing following kernel crash on Jetson TX2. Board is flashed with
>>> firmware bits from L4T R32.4.2 with upstream u-boot. Crash always
>>> happens while decompressing initrd. Initrd is approximately 80 MiB in
>>> size and compressed with xz (xz --check=crc32 --lzma2=dict=32MiB).
>>> Crash is not observed if the same initrd is compressed with gzip.
>>> [1] was a previous attempt to workaround the same issue.
>>>
...
>>>
>>> With some debugging aid ported from Nvidia downstream kernel [2] the
>>> actual cause was found:
>>>
>>> [    0.761525] Trying to unpack rootfs image as initramfs...
>>> [    2.955499] CPU0: SError: mpidr=0x80000100, esr=0xbf40c000
>>> [    2.955502] CPU1: SError: mpidr=0x80000000, esr=0xbe000000
>>> [    2.955505] CPU2: SError: mpidr=0x80000001, esr=0xbe000000
>>> [    2.955506] CPU3: SError: mpidr=0x80000101, esr=0xbf40c000
>>> [    2.955507] ROC:CCE Machine Check Error:
>>> [    2.955508] ROC:CCE Registers:
>>> [    2.955509]  STAT: 0xb400000000400415
>>> [    2.955510]  ADDR: 0x400c00e7a00c
>>> [    2.955511]  MSC1: 0x80ffc
>>> [    2.955512]  MSC2: 0x3900000000800
>>> [    2.955513] --------------------------------------
>>> [    2.955514] Decoded ROC:CCE Machine Check:
>>> [    2.955515]  Uncorrected (this is fatal)
>>> [    2.955516]  Error reporting enabled when error arrived
>>> [    2.955517]  Error Code = 0x415
>>> [    2.955518]  Poison Error
>>> [    2.955518]  Command = NCRd (0xc)
>>> [    2.955519]  Address Type = Non-Secure DRAM
>>> [    2.955521]  Address = 0x30039e80 -- 30000000.sysram + 0x39e80
>>> [    2.955521]  TLimit = 0x3ff
>>> [    2.955522]  Poison Error Mask = 0x80
>>> [    2.955523]  More Info = 0x800
>>> [    2.955524]  Timeout Info = 0x0
>>> [    2.955525]          Poison Info = 0x800
>>> [    2.955526]          Read Request failed GSC checks
>>> [    2.955527]  Source = L2_1 (A57) (0x1)
>>> [    2.955528]  TID = 0xe
>>>
>>> IIUC, there was read request for 0x30039e80 from EL1/2 which failed.
>>> This address falls in the sysram security aperture and hence a read
>>> from normal mode failed.
>>>
>>> sysram is mapped at 0x3000_0000 to 0x3004_ffff and is managed by the
>>> sram driver (drivers/misc/sram.c). There are two reserved pools for
>>> BPMP driver communication at 0x3004_e000 and 0x3004_f000 of 0x1000
>>> bytes each.
>>>
>>> sram driver maps complete 0x3000_0000 to 0x3004_ffff range as normal
>>> memory.
>
>> That's your problem. It's not really worth attempting to reason about, the
>> architecture says that anything mapped as Normal memory may be speculatively
>> accessed at any time, so no amount of second-guessing is going to save you
>> in general. Don't make stuff accessible to the kernel that it doesn't need
>> to access, and especially don't make stuff accessible to the kernel if
>> accessing it will kill the system.
>>
> I agree and [1] was an attempt in that direction. What I wonder here is that
> processor is speculating on an address range which kernel has never accessed.
> Is it correct behavior that cpu is speculating in EL1/EL2 on an address
> accessed in EL3?

That is indeed the way the ARM architecture is defined (at least the
version that this CPU implements; maybe other versions too), and this
certainly does happen in practice. I've seen this same kind of issue
arise in other cases too (see below). The only solution is to not map
memory as normal which isn't normal, so either (a) don't map it at all,
or (b) map it as some other type which can't be accessed speculatively.

Just as a related example, consider the following patch I had to make to
U-Boot to fix a similar issue that causes SError during boot:

> commit d40d69ee350b62af90c2b522e05cbb3eb5f27112
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Mon Oct 10 09:50:55 2016 -0600
> 
>     ARM: tegra: reduce DRAM size mapped into MMU on ARM64
>     
>     ARM CPUs can architecturally (speculatively) prefetch completely arbitrary
>     normal memory locations, as defined by the current translation tables. The
>     current MMU configuration for 64-bit Tegras maps an extremely large range
>     of addresses as DRAM, well beyond the actual physical maximum DRAM window,
>     even though U-Boot only needs access to the first 2GB of DRAM; the Tegra
>     port of U-Boot deliberately limits itself to 2GB of RAM since some HW
>     modules on at least some 64-bit Tegra SoCs can only access a 32-bit
>     physical address space. This change reduces the amount of RAM mapped via
>     the MMU to disallow the CPU from ever speculatively accessing RAM that
>     U-Boot will definitely not access. This avoids the possibility of the HW
>     raising SError due to accesses to always-invalid physical addresses.
>     
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Tom Warren <twarren@nvidia.com>
