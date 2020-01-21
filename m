Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D96524125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="kK59tpZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAUX3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:29:02 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57955 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAUX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:29:01 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 421FB22FAD;
        Wed, 22 Jan 2020 00:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579649338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpT3oQmk2I0WwytiWaqDcF8t8asf9mMFvBZ3BRNbqV4=;
        b=kK59tpZR36UfPcajosULYJ0NRbCYeA7DlE6Jy45RzNwOpNxoy4/+Mug+efwUf2MgS6f1cH
        RXCdvz2k4450g7Gq1TtVroLy4X2nYfj0pzNmcN2DJKu6pr3plK/8+IY3JDk3+qrCtUz0/m
        clje/a5PNHbs+3ol7QTjYReDhM747po=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 00:28:52 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <5476415.ab72jjm3fZ@192.168.0.113>
References: <20200103223423.14025-1-michael@walle.cc>
 <3862353.UOg0IvECEa@localhost.localdomain>
 <d3f03e392c060ff4ed4c2ae8a8999d9f@walle.cc>
 <5476415.ab72jjm3fZ@192.168.0.113>
Message-ID: <1e78fbe87c0d6dc19a27210551b02af4@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 421FB22FAD
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.730];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-01-21 19:40, schrieb Tudor.Ambarus@microchip.com:
> Hi, Michael,
> 
> On Monday, January 20, 2020 5:55:55 PM EET Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi Tudor,
>> 
>> Am 2020-01-20 12:03, schrieb Tudor.Ambarus@microchip.com:
>> > On Monday, January 20, 2020 12:24:25 AM EET Michael Walle wrote:
>> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> >> the
>> >> content is safe
>> >>
>> >> Hi Tudor,
>> >
>> > Hi, Michael,
>> >
>> >> >> Am 2020-01-13 11:07, schrieb Michael Walle:
>> >> >> >>> Btw. is renaming the flashes also considered a backwards
>> >> >> >>> incomaptible
>> >> >> >>> change?
>> >> >> >>
>> >> >> >> No, we can fix the names.
>> >> >> >>
>> >> >> >>> And can there be two flashes with the same name? Because IMHO it
>> >> >> >>> would
>> >> >> >>> be
>> >> >> >>
>> >> >> >> I would prefer that we don't. Why would you have two different
>> >> >> >> jedec-ids with
>> >> >> >> the same name?
>> >> >> >
>> >> >> > Because as pointed out in the Winbond example you cannot distiguish
>> >> >> > between
>> >> >> > W25Q32DW and W25Q32JWIQ; and in the Macronix example between
>> >> >> > MX25L8005
>> >> >> > and
>> >> >> > MX25L8006E. Thus my reasoning was to show only the common part, ie
>> >> >> > W25Q32
>> >> >> > or MX25L80 which should be the same for this particular ID. Like I
>> >> >> > said, I'd
>> >> >> > prefer showing an ambiguous name instead of a wrong one. But then
>> >> >> > you
>> >> >> > may
>> >> >> > have different IDs with the same ambiguous name.
>> >> >>
>> >> >> Another solution would be to have the device tree provide a hint for
>> >> >> the
>> >> >> actual flash chip. There would be multiple entries in the spi_nor_ids
>> >> >> with the
>> >> >> same flash id. By default the first one is used (keeping the current
>> >> >> behaviour). If there is for example
>> >> >>
>> >> >>    compatible = "jedec,spi-nor", "w25q32jwq";
>> >> >>
>> >> >> the flash_info for the w25q32jwq will be chosen.
>> >> >
>> >> > This won't work for plug-able flashes. You will influence the name in
>> >> > dt to be
>> >> > chosen as w25q32jwq, and if you change w25q32jwq with w25q32dw you will
>> >> > end up
>> >> > with a wrong name for w25q32dw, thus the same problem.
>> >>
>> >> No, because then the device tree is wrong and doesn't fit the
>> >> hardware.
>> >> You'd
>> >> have to some instance which could change the device tree node, like
>> >> the
>> >> bootloader or some device tree overlay for plugable flashes. We should
>> >> try to
>> >> solve the actual problem at hand first..
>> >>
>> >> It is just not possible to autodetect the SPI flash, just because
>> >> the vendors reuse the same IDs for flashes with different features
>> >> (and
>> >> the
>> >> SFDP is likely not enough). Therefore, you need to have a hint in some
>> >> place
>> >> to use the flash properly.
>> >>
>> >> > If the flashes are identical but differ just in terms of name, we can
>> >> > rename
>> >> > the flash to "w25q32jwq (w25q32dw)". I haven't studied the differences
>> >> > between
>> >> > these flashes; if you want to fix them, send a patch and I'll try to
>> >> > help.
>> >>
>> >> It is not only the name, here are two examples which differ in
>> >>
>> >> functionality:
>> >>   (1) mx25l8005 doesn't support dual/quad mode. mx25l8006e supports
>> >>
>> >> dual/quad
>> >>
>> >>       mode
>> >>
>> >>   (2) mx25u3235f doesn't support TB bit, mx25u3232e has a TB bit.
>> >>
>> >> well.. to repeat myself, the mx25l25635_post_bfpt_fixups is a third
>> >
>> > sorry if this exhausted you.
>> 
>> TBH, this is no fun (and I'm doing this on my spare time because I 
>> like
> 
> It's not my fault that you're not having fun when someone disagrees 
> with you.

The reason is not the disagreement, but how you're (not) answering my 
arguments.
Like in the other thread, the question about the uselessness of the 
flash_lock
and flash_unlock tools with SPI-NOR and the (IMHO) bad behaviour when 
the user
actually uses flash_lock. Please, don't take this personally, I'll buy 
you a
beer at FOSDEM :p back to the technical stuff.

> 
>> open source). I guess our opinions differ waaay too much. I don't
> 
> Up to a point, yes, our opinions differ. I'm not rejecting your 
> suggestion, I
> just say that we should implement it as a last resort, when there's 
> nothing
> auto-detectable at run-time that can differentiate between two flashes 
> that
> share the same id.
> 
>> really like band-aid fixes; eg. with vague information "it seems that
>> the F version adveritses support for Fast Read 4-4-4", what about 
>> other
> 
> We can update the comment to clear the incertitude: "The F version 
> advertises
> support for Fast Read 4-4-4""
> 
>> flashes with that idcode and this property. This might break at any 
>> time
>> or with anyone trying support for other flashes with that ID.
> 
> The jedec-id should be unique in the first place, manufacturers that 
> use the
> same jedec-id for different flavors of flashes are doing a bad thing. A 
> third
> flash with the same jedec-id is unlikely to happen.

MX25U3232F, MX25U3235F, MX25U3273F, MX25U3235E all use the same 0x2c2536
identification. And these are only the active ones. I bet there are a
bunch of older 32MBit flashes.

MX25U6432F, MX25U6472F, MX25U6433F, MX25U6435F, MX25U6473F all use the
same 0x2c2537 id.

W25Q32JW-IQ, W25Q32DW, W25Q32FW all use the same 0x156016 id.

btw. thats why I argued to just have MX25U32 or W25Q32 as a name for the
flashes.

>> 
>> That's what I've meant with first come first serve, I'm lucky now that
>> there was no flash with the same jedec id as the W25Q32JW.
>> 
>> To add the MX25U3232F I could check the JEDEC revision (or the BFPT
>> length) because it differers from the MX25U3235F. But I don't feel 
>> well
> 
> I prefer this because it's auto-detectable. If you don't feel well 
> doing it,
> don't do it.

ok, I'll do so for the MX25U3232F support.

>> doing that. Who says Macronix won't update their description for the
>> MX25U3235F to the new revision.. FYI the Winbond guys apparently use 
>> the
> 
> You are raising theoretical problems. We can fix this when we will 
> encounter
> it.
> 
>> first OTP region to store the JEDEC data, which is clever because they
>> can update it during production.
> 
> If you say so.
> 
>> 
>> >> example.
>> >
>> > Flash auto-detection is nice and we should preserve it if possible. I
>> > would
>> > prefer having a post bfpt fixup than giving a hint about the flash in
>> > the
>> > compatible.
>> 
>> see above.
>> 
>> > The flashes that you mention are quite old and I don't know if it
>> > is worth to harm the auto-detection for them. A compromise has to be
>> > made.
>> 
>> so you'd drop support for them? because SFDP is never read if there is
>> no
>> DUAL_READ or QUAD_READ flag.
> 
> mx25l8006e  defines bfpt, while mx25l8005 doesn't. We can differentiate 
> these
> too.
>> 
>> > You can gain traction in your endeavor if you have such a flash and
>> > there's
>> > nothing auto-detectable that differentiates it from some other flash
>> > that
>> > shares the sama jedec-id.
>> >
>> > If you have such a flash and you care about it, send a patch and I'll
>> > try to
>> > help.
>> 
>> Given my reasoning above.. well maybe in the future. The Macronix 
>> would
> 
> ok
> 
>> be
>> a second source candidate. For now we are using the Winbond flash.
>> 
>> I would rather like to have the flash protection topic and OTP support
>> sorted out, because that is something we are actually using.
> 
> You can speed up the process by reviewing/testing the BP3 support. In 
> turn,
> maybe Jungseung will review your OTP patches.
> 
> To sum up: the flash auto-detection (with capabilities) greatly ease 
> the
> device tree node description and it allows us to plug and play 
> different
> manufacturer flashes using the same dtb. I have a connector on one of 
> my
> boards, to which I connect different types of flashes (assuming they 
> have
> similar frequency and modes). So I would always prefer to have a post 
> bfpt
> hook to differentiate between flashes which share the same jedec-id, 
> than
> compromising the generic compatible.

and making assumptions which are true for the flashes you currently know
about.

> Of course, if there's nothing auto-
> detectable that can differentiate between the flashes, then your idea 
> can be
> implemented, but I would do this as a last resort.
> 
> There's also the idea of compromise. The jedec-id should be unique in 
> the
> first place, manufacturers that use the same jedec-id for different 
> flavors of
> flashes are taking a wrong design decision. Do I want to cripple the 
> generic
> compatible just for an old flash with a bad jedec-id? I don't know yet. 
> Also,
> the flashes that share the same id are quite old, and if nobody 
> screamed about
> this until now, it's fine by me.

See above, the assumption that newer flashes have differnet jedec-ids is 
wrong.

> You raised some theoretical questions, you
> don't really use the macronix flashes, what I say is that we should 
> consider
> fixing them when it's actually required. And that the extension of the
> compatible should be done as a last resort, as of now it has more
> disadvantages than advantages.

Well what are the disadvantages? I don't argue against the 
autodetection. I
argue to have a mechanism _already_ in place when the autodetection 
fails.
If you don't specify the hint, everything stays the same.

We could have the advantages of both worlds, have a generic "w25q32" 
which tries
its best for autodetection and a specific "w25q32fw" which could can be 
hinted.
Same for like "mx25u32" and "mx25u3232f", "mx25u3235f" etc.


-michael


> 
> Cheers,
> ta
> 
>> 
>> -michael
>> 
>> >> -michael
>> >>
>> >> > Cheers,
>> >> > ta
>> >> >
>> >> >> I know this will conflict with the new rule that there should only be
>> >> >>
>> >> >>    compatible = "jedec,spi-nor";
>> >> >>
>> >> >> without the actual flash chip. But it seems that it is not always
>> >> >> possible
>> >> >> to just use the jedec id to match the correct chip.
>> >> >>
>> >> >> Also see for example mx25l25635_post_bfpt_fixups() which tries to
>> >> >> figure
>> >> >> out different behaviour by looking at "some" SFDP data. In this case
>> >> >> we
>> >> >> might have been lucky, but I fear that this won't work in all cases
>> >> >> and
>> >> >> for older flashes it won't work at all.
>> >> >>
>> >> >> BTW I do not suggest to add the strings to the the spi_nor_dev_ids[].
>> >> >>
>> >> >> I guess that would be a less invasive way to fix different flashes
>> >> >> with
>> >> >> same jedec ids.
>> >> >>
>> >> >> -michael
