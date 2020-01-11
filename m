Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4726C33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FA420848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="wKnwjAa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgAKW7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:59:21 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33885 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731624AbgAKW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 17:59:21 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E4ACB22FF5;
        Sat, 11 Jan 2020 23:50:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578783063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywxzCqmQ1RStsavLzyAFfaDeAMmnJPmTGn/VBr0YbBE=;
        b=wKnwjAa9veaFGvtUHRXvY0bGNe7pb/VxDYHZqpU+Ca1JkVFIOrv/b4pnx+zypDWmRzkDCA
        TQvM+HvUhpqORMEzuMG7IR1YWWd4WFASkMRkVVKhGY2QxqBu/i8JoX4VunXBrbyNG6nTIJ
        eXLOHLdKZBDR+hAJ3W7sKsjdwJVLbFk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Jan 2020 23:50:57 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, boris.brezillon@collabora.com,
        miquel.raynal@bootlin.com, marex@denx.de
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
In-Reply-To: <8187061.UfBqSTmf1g@192.168.0.113>
References: <20200103221229.7287-1-michael@walle.cc>
 <8187061.UfBqSTmf1g@192.168.0.113>
Message-ID: <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: E4ACB22FF5
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.744];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tudor,

thanks for looking into this.

Am 2020-01-11 14:46, schrieb Tudor.Ambarus@microchip.com:
> Hi, Michael,
> 
> On Saturday, January 4, 2020 12:12:29 AM EET Michael Walle wrote:
>> Traditionally, linux unlocks the whole flash because there are legacy
>> devices which has the write protections bits set by default at 
>> startup.
>> If you actually want to use the flash protection bits, eg. because 
>> there
>> is a read-only part for a bootloader, this automatic unlocking is
>> harmful. If there is no hardware write protection in place (usually
>> called WP#), a startup of the kernel just discards this protection.
>> 
>> I've gone through the datasheets of all the flashes (except the Intel
>> ones where I could not find any datasheet nor reference) which 
>> supports
>> the unlocking feature and looked how the sector protection was
>> implemented. The currently supported flashes can be divided into the
>> following two categories:
>>  (1) block protection bits are non-volatile. Thus they keep their 
>> values
>>      at reset and power-cycle
>>  (2) flashes where these bits are volatile. After reset or 
>> power-cycle,
>>      the whole memory array is protected.
>>      (a) some devices needs a special "Global Unprotect" command, eg.
>>          the Atmel AT25DF041A.
>>      (b) some devices require to clear the BPn bits in the status
>>          register.
>> 
>> Due to the reasons above, we do not want to clear the bits for flashes
>> which belong to category (1). Fortunately for us, the flashes in (2a)
>> and (2b) are compatible with each other in a sense that the "Global
>> Unprotect" command will clear the block protection bits in all the 
>> (2b)
>> flashes.
>> 
>> This patch adds a new flag to indicate the case (2). Only if we have
>> such a flash we perform a "Global Unprotect". Hopefully, this will 
>> clean
>> up "unlock the entire flash for legacy devices" once and for all.
> 
> Thanks for the detailed explanation. Unlocking the flash at probe time 
> was
> badly designed from the beginning, we should disable the write 
> protection only
> on request, to avoid destructive commands during power-up.
> 
> Breaking the backward compatibility is a no-go, and looks like you 
> break it,
> by not treating case (1).

Yes but that was the whole idea of this patch. So if I get you correct 
it is
not possible to change that even if:

(1) it was never intended that way. Eg. the original patch(es) were 
about
removing the volatile write protection (which makes perfectly sense, 
even
during probe time) to be able to write to the flash. But it was never 
intended
to disable the non-volatile write protection.

(2) it might be even harmful. It is still an open question wether the 
write
to the non-volatile bits (even if it is the same value) might wear them 
out.
Unfortunately our FAE didn't answered yet..

(3) it makes the write protection utterly useless, because if you lock 
the
flash it will be automatically unlocked after the next reboot. Even 
worse, the
user likely won't notice it.


> We can indeed continue your idea and treat both (1)
> and (2), thus disabling the write protection at power-up for all the 
> flashes
> that we support as of now (in order to not break backward compat), and 
> to not
> disable the block protection for the new flashes that will come. This 
> means to
> have some point in time before which some less fortunate flashes don't 
> benefit
> of write protection at power-up, and after which the others benefit. I
> wouldn't got this way, I prefer a generic method that handles all the 
> flashes
> in the same way.

I'd also prefer a solution for all existing flashes. But it seems that 
the rule
above makes that almost impossible. Esp. this behaviour will then be 
there until
eternity.

> I see three choices:
> 1/ dt prop which gives a per flash granularity. The prop is related to 
> hw
> protection and there might be some chances to get this accepted, maybe 
> it is
> worth to involve Rob. But I tend to share Vignesh's opinion, this would
> configure the flash and not describe it.

Still my preferred way. but also see below. But I wouldn't say it 
configures the
flash but describe that the user want to use the write protection.

> 2/ kconfig option, the behavior would be enforced on all the flashes. 
> It would
> be similar to what we have with CONFIG_MTD_SPI_NOR_USE_4K_SECTORS. I 
> did a
> patch to address this some time ago: 
> https://patchwork.ozlabs.org/patch/
> 1133278/

Mhh. If we would combine this with this patch that would be at least a 
step into
the right direction. At least a distro could enable that kernel option 
without
breaking old boards/flashes. Because as outlined about you need that for 
flashes
in category (2). Or you'd have to do a flash_unlock every time you want 
to write
to it. But that would be really a backwards incompatible change.. ;)

> 
> 3/ module param, the behavior would be enforced on all the flashes.
> 
> Preferences or suggestions?

-michael
