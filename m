Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6874BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988FE20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plating.de header.i=@plating.de header.b="W6BaY8dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbgCDN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:28:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:19921 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgCDN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583328516;
        s=strato-dkim-0002; d=plating.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/PFOT/Fwl3I28T+GZRZzY/v69ATekZLiMgHIHUZonME=;
        b=W6BaY8dYhvQ/ZHqQZl35NOo0aEMv1Jp7f5CJ63qnK62AC8dldFodwCBoD9GEoSupti
        zGDtw4P6+9pIcgJevD1hcebaEC2vH+7mzcoj5e5aJjI0x9/yNd7TOCAo8tlc4RLrIYEW
        +ZdNYqskW7xL6SWODQ+taD2spA7OSqV1EqyKZ00OdyTkV6uBSRvtORPQ8dP1eO3Qk/Rr
        ap7xiyDWDNo9AfG5vH/aE5wsJ0vRKu1PCv8FoBLiiq5Qkr/vkpBHDTAQTqTmy4tkDUEu
        Mv/KhLSzoRaWqvEAn55SlN3FZuOCLQqVtJ4w7avSG9NO0zbUQ/1bRiyAFKe3ODrQREI/
        zpyg==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.2.0 AUTH)
        with ESMTPSA id R06d1cw24DSaJom
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Mar 2020 14:28:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id EC531122280;
        Wed,  4 Mar 2020 14:28:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OLKiWA0A50Hy; Wed,  4 Mar 2020 14:28:29 +0100 (CET)
Received: from [172.16.4.186] (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id B50A412221B;
        Wed,  4 Mar 2020 14:28:28 +0100 (CET)
Subject: Re: Question about regmap_range_cfg and regmap_mmio
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <d2eb2248-0120-7b0f-9bcf-4f9c71954117@plating.de>
 <20200304120321.GA5646@sirena.org.uk>
From:   =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>
Message-ID: <61cb178b-dc9b-12fb-0443-d38e0c43e046@plating.de>
Date:   Wed, 4 Mar 2020 14:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200304120321.GA5646@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.03.20 13:03, Mark Brown wrote:
> On Wed, Mar 04, 2020 at 12:25:09PM +0100, Lars Möllendorf wrote:
> 
>> this mail is copied from internal issue written in markdown - I hope
>> this is still readable as mail.
> 
> Not really frankly.  
Ok, sorry. Here the same text without code snippets and links:

In `__regmap_init()` `_regmap_bus_reg_read()`is assigned to
`regmap.reg_read()` if there are no `bus->read/write` functions, else
`_regmap_bus_read()` is assigned.

`_regmap_bus_reg_read()` calls the `reg_read` function of the bus
directly, `_regmap_bus_read()` instead calls `_regmap_raw_read()`.

`_regmap_raw_read()` in turn calls `_regmap_range_lookup()` and
`_regmap_select_page()` which do the paging.

`regmap_mmio` does not contain `bus->read/write`, but does contain
`bus->reg_read/reg_write` only.

>> `regmap_i2c` does -contain both-.

Sorry, I have to correct myself here. It does only contain the
`bus->read/write` functions.

> I *think* you are saying that paging doesn't work
> due to relying on having register read and write operations?

If I understand correctly it is relying on having plain
`bus->read/write` operations. MMIO *has* `bus->reg_read/reg_write` but
is missing the former. But maybe I just mix up the wording here.


>> My assumption is that paging is not a common use case for Memory-mapped
>> I/O and thus has not been implemented for this case.
> 
>> - Are my assumptions correct?
>> - If so, what would you recommend me to do:
>>   - Continue using `regmap-mmio` and implement my custom paging
>> functions on top of that?
> 
> This will obviously work.

Yes, this works. But it comes at the cost of implementing (and
maintaining) something which already exists. And the existing
implementation which uses virtual memory addresses is much smarter than
my current implementation.

>>   - Enhance the current `regmap-mmio` implementation so it does paging
>> and submit a patch?
> 
> That's not really possible since MMIO never writes the register address
> to the bus

Sorry, but I do not get why this shouldn't work with MMIO? If I
understood the code correctly in  `_regmap_raw_read` the address is
checked before it is used anywhere. If
`_regmap_range_lookup()` returns a range it does the paging, i.e.
translates the virtual address into the real address
(`_regmap_select_page`). If so the real address is passed to
`bus->read/write`, else the given address is used directly. Do I miss
something here?

>>   - Write my own `better-regmap-mmio` implementation?
> 
> It's not clear what that would mean.

Maybe for some reason the current MMIO implementation should not be
touched, or paging for MMIO is not wanted?

> You could also look into making the paging code not rely on explicit
> register read and write operations.

Maybe it is sufficient to implement `bus->read/write` as a wrapper of
`bus->reg_read/reg_write` in regmap-mmio.c?
