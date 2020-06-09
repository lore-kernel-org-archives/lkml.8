Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4122078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgFIOg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:36:59 -0400
Received: from ns.iliad.fr ([212.27.33.1]:43864 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFIOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:36:59 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2020 10:36:58 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id D3AA3201AA;
        Tue,  9 Jun 2020 16:31:29 +0200 (CEST)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id BBCDE200C3;
        Tue,  9 Jun 2020 16:31:29 +0200 (CEST)
Subject: Re: Scanning for TV channels over DVB-T and DVB-T2
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     linux-media <linux-media@vger.kernel.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jan Pieter van Woerkom <jp@jpvw.nl>,
        Brad Love <brad@nextdimension.cc>,
        Antti Palosaari <crope@iki.fi>
References: <11fbc112-c410-8c67-9bcb-9450924d12ef@free.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <4904d37d-1cd4-b8f3-9c3c-82eb4569bca7@free.fr>
Date:   Tue, 9 Jun 2020 16:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <11fbc112-c410-8c67-9bcb-9450924d12ef@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jun  9 16:31:29 2020 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2020 17:30, Marc Gonzalez wrote:

> Suppose we know that several channels are transmitted on a given frequency
> by terrestrial antenna. However, we don't know if the signal is "encoded"
> (not sure this is the right term) in DVB-T or DVB-T2 modulation.
> 
> Do we have to scan the frequency /twice/
> first with DTV_DELIVERY_SYSTEM = SYS_DVBT
>  then with DTV_DELIVERY_SYSTEM = SYS_DVBT2 ?
> 
> Or is there some optimization where both modulations are handled
> in a single step?
> 
> Or maybe it depends on the tuner driver?

Digging a bit deeper...

My system sports a Silicon Labs Si2168 DVB-T2/T/C demodulator

The data sheet states:

"For DVB-T2 and T2-Lite:
	DVB-T2 versus DVB-T automatic detection"

"In DVB-T and DVB-T2 reception, parameters necessary for device synchronization
are broadcast in the transmission parameters (respectively TPS and P1 symbol).
When these transmission parameters are found and decoded, the demodulator is
automatically and accordingly configured to achieve full synchronization."


This HW is supported upstream by drivers/media/dvb-frontends/si2168.c
https://elixir.bootlin.com/linux/latest/source/drivers/media/dvb-frontends/si2168.c

I have a nagging feeling because si2168_set_frontend() appears to
behave differently for SYS_DVBT and for SYS_DVBT2...

https://elixir.bootlin.com/linux/latest/source/drivers/media/dvb-frontends/si2168.c#L250
https://elixir.bootlin.com/linux/latest/source/drivers/media/dvb-frontends/si2168.c#L297
https://elixir.bootlin.com/linux/latest/source/drivers/media/dvb-frontends/si2168.c#L345

Maybe setting SYS_DVBT2 would also work for DVB-T transmissions?
(TODO: test that)

Any insight would be greatly appreciated.

Regards.
