Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE7AC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4D421734
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="f9cR2Urh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMNPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:15:18 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:50817 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgAMNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:15:17 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6FFDF22F2E;
        Mon, 13 Jan 2020 14:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578921315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgGLE1F1nPsMuk+W9Nc7eMSChF5dQJRdLDQSJEpek40=;
        b=f9cR2Urhc6pN9yLq9i1YK4okEws6isQzUNskW0JJNqKEX8OcOJvfQWfVanVseMkHcTPp/5
        NBFwh3YrvcBKF8/CiNYDGU2sbHjLnAGH8L9fXeUeuOxIxWCk14heVPRV9GRZX5m327236b
        dTI0c1fgjU37Sy3bXLPacnNzPliE0wg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Jan 2020 14:15:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <2dffc658f21da502dff8c5721ec1b0a7@walle.cc>
References: <20200103223423.14025-1-michael@walle.cc>
 <12341010.b9DRC5f9X7@192.168.0.113>
 <9d39be0f45f4c8e087b269f0c802ed6b@walle.cc>
 <4050087.dyKUiXJtgz@localhost.localdomain>
 <2dffc658f21da502dff8c5721ec1b0a7@walle.cc>
Message-ID: <8ce5f803c9a59a1ebd55ae287fa2e6a9@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 6FFDF22F2E
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.780];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-01-13 11:07, schrieb Michael Walle:
>>> 
>>> Btw. is renaming the flashes also considered a backwards incomaptible
>>> change?
>> 
>> No, we can fix the names.
>> 
>>> And can there be two flashes with the same name? Because IMHO it 
>>> would
>>> be
>> 
>> I would prefer that we don't. Why would you have two different 
>> jedec-ids with
>> the same name?
> 
> Because as pointed out in the Winbond example you cannot distiguish 
> between
> W25Q32DW and W25Q32JWIQ; and in the Macronix example between MX25L8005 
> and
> MX25L8006E. Thus my reasoning was to show only the common part, ie 
> W25Q32
> or MX25L80 which should be the same for this particular ID. Like I 
> said, I'd
> prefer showing an ambiguous name instead of a wrong one. But then you 
> may
> have different IDs with the same ambiguous name.


Another solution would be to have the device tree provide a hint for the
actual flash chip. There would be multiple entries in the spi_nor_ids 
with the
same flash id. By default the first one is used (keeping the current
behaviour). If there is for example

   compatible = "jedec,spi-nor", "w25q32jwq";

the flash_info for the w25q32jwq will be chosen.

I know this will conflict with the new rule that there should only be

   compatible = "jedec,spi-nor";

without the actual flash chip. But it seems that it is not always 
possible
to just use the jedec id to match the correct chip.

Also see for example mx25l25635_post_bfpt_fixups() which tries to figure
out different behaviour by looking at "some" SFDP data. In this case we
might have been lucky, but I fear that this won't work in all cases and
for older flashes it won't work at all.

BTW I do not suggest to add the strings to the the spi_nor_dev_ids[].

I guess that would be a less invasive way to fix different flashes with
same jedec ids.

-michael
