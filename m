Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1EC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107D206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="g9+ksF0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgASWYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:24:31 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:59119 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgASWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:24:30 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F06CD22FB3;
        Sun, 19 Jan 2020 23:24:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579472668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZYItGOiBU5eiIIozCyMNJmuK4OQSk0zR+3B7khf2K4=;
        b=g9+ksF0Ae3GDSzoAxmLuiVvJAe5Iw2epbLMc9Lx1xSPEc7sOzFhDNQHR/at2jnVCrl1h6q
        AEt8swBBEZ/lrKdSWaAeFH3Prxpp3YWkv3etkwW2ZFOKNj1Z8ERdIw6/TBVo2v6WZbcLY6
        9aOjZJefd6rYy8lRgpKqo7JKLR8a+NU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Jan 2020 23:24:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <8021667.67K7kvUAe6@192.168.0.113>
References: <20200103223423.14025-1-michael@walle.cc>
 <2dffc658f21da502dff8c5721ec1b0a7@walle.cc>
 <8ce5f803c9a59a1ebd55ae287fa2e6a9@walle.cc>
 <8021667.67K7kvUAe6@192.168.0.113>
Message-ID: <66c1ad8e74fb20a061f35f8b23a925ab@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: F06CD22FB3
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.664];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

>> Am 2020-01-13 11:07, schrieb Michael Walle:
>> >>> Btw. is renaming the flashes also considered a backwards incomaptible
>> >>> change?
>> >>
>> >> No, we can fix the names.
>> >>
>> >>> And can there be two flashes with the same name? Because IMHO it
>> >>> would
>> >>> be
>> >>
>> >> I would prefer that we don't. Why would you have two different
>> >> jedec-ids with
>> >> the same name?
>> >
>> > Because as pointed out in the Winbond example you cannot distiguish
>> > between
>> > W25Q32DW and W25Q32JWIQ; and in the Macronix example between MX25L8005
>> > and
>> > MX25L8006E. Thus my reasoning was to show only the common part, ie
>> > W25Q32
>> > or MX25L80 which should be the same for this particular ID. Like I
>> > said, I'd
>> > prefer showing an ambiguous name instead of a wrong one. But then you
>> > may
>> > have different IDs with the same ambiguous name.
>> 
>> Another solution would be to have the device tree provide a hint for 
>> the
>> actual flash chip. There would be multiple entries in the spi_nor_ids
>> with the
>> same flash id. By default the first one is used (keeping the current
>> behaviour). If there is for example
>> 
>>    compatible = "jedec,spi-nor", "w25q32jwq";
>> 
>> the flash_info for the w25q32jwq will be chosen.
> 
> This won't work for plug-able flashes. You will influence the name in 
> dt to be
> chosen as w25q32jwq, and if you change w25q32jwq with w25q32dw you will 
> end up
> with a wrong name for w25q32dw, thus the same problem.

No, because then the device tree is wrong and doesn't fit the hardware. 
You'd
have to some instance which could change the device tree node, like the
bootloader or some device tree overlay for plugable flashes. We should 
try to
solve the actual problem at hand first..

It is just not possible to autodetect the SPI flash, just because
the vendors reuse the same IDs for flashes with different features (and 
the
SFDP is likely not enough). Therefore, you need to have a hint in some 
place
to use the flash properly.

> If the flashes are identical but differ just in terms of name, we can 
> rename
> the flash to "w25q32jwq (w25q32dw)". I haven't studied the differences 
> between
> these flashes; if you want to fix them, send a patch and I'll try to 
> help.

It is not only the name, here are two examples which differ in 
functionality:
  (1) mx25l8005 doesn't support dual/quad mode. mx25l8006e supports 
dual/quad
      mode
  (2) mx25u3235f doesn't support TB bit, mx25u3232e has a TB bit.

well.. to repeat myself, the mx25l25635_post_bfpt_fixups is a third 
example.

-michael

> 
> Cheers,
> ta
> 
>> 
>> I know this will conflict with the new rule that there should only be
>> 
>>    compatible = "jedec,spi-nor";
>> 
>> without the actual flash chip. But it seems that it is not always
>> possible
>> to just use the jedec id to match the correct chip.
>> 
>> Also see for example mx25l25635_post_bfpt_fixups() which tries to 
>> figure
>> out different behaviour by looking at "some" SFDP data. In this case 
>> we
>> might have been lucky, but I fear that this won't work in all cases 
>> and
>> for older flashes it won't work at all.
>> 
>> BTW I do not suggest to add the strings to the the spi_nor_dev_ids[].
>> 
>> I guess that would be a less invasive way to fix different flashes 
>> with
>> same jedec ids.
>> 
>> -michael
