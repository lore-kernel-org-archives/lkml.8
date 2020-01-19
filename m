Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0667C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C796D206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="SiAa/TgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgASKhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:37:15 -0500
Received: from the.earth.li ([46.43.34.31]:56474 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgASKhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:37:14 -0500
X-Greylist: delayed 1098 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jan 2020 05:37:14 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H8tprnwxmiZt+wQA3U/ny9HmbZHVUfxyPk/oc8s5ef0=; b=SiAa/TgYvmlkajYrnB1SVulhx3
        nPeacyVfg6lPsIkRUFzBw9DIWkrq8wCRy2jO5o79/1iQgf+F4EaUK4YXKd80GVXmpKNC45xAaB7As
        7E6fROYs/94r1sJ1D1enmxwe3Q68QcITWu/H4rTEDPCLc4kbOHEjFojq0MKrzVxVx66qf74BzftdQ
        yBSIEZVbq0T4hT1G8YXr7teohSn/CLXVMbg7DUMvTnJaXP2CGbiZU9mMTUaL3MM7PoHjAuhw3n4/Q
        IimMDcDcIDlxXP7XfRu2yE2fbQjhbFELWR5x++OfJ+9gh2sP/JD8hkB+FkMoB4znsGHs6oqz0UzNu
        CAj/TAHA==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1it7fT-0004QP-DQ; Sun, 19 Jan 2020 10:18:55 +0000
Date:   Sun, 19 Jan 2020 10:18:55 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ken Moffat <zarniwhoop73@googlemail.com>
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
Message-ID: <20200119101855.GA15446@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20200118172615.26329-1-linux@roeck-us.net> (earth.lists.linux-kernel) you wrote:
> This patch series implements various improvements for the k10temp driver.
...
> The voltage and current information is limited to Ryzen CPUs. Voltage
> and current reporting on Threadripper and EPYC CPUs is different, and the
> reported information is either incomplete or wrong. Exclude it for the time
> being; it can always be added if/when more information becomes available.

> Tested with the following Ryzen CPUs:

Tested-By: Jonathan McDowell <noodles@earth.li>

Tested on a Ryzen 7 2700 (patched on top of 5.4.13):

| k10temp-pci-00c3
| Adapter: PCI adapter
| Vcore:        +0.80 V
| Vsoc:         +0.81 V
| Tdie:         +37.0°C
| Tctl:         +37.0°C
| Icore:        +8.31 A
| Isoc:         +6.86 A

Like the 1300X case I see a discrepancy compared to what the nct6779
driver says Vcore is:

| nct6779-isa-0290
| Adapter: ISA adapter
| Vcore:                  +0.33 V  (min =  +0.00 V, max =  +1.74 V)
| in1:                    +0.32 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| AVCC:                   +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| +3.3V:                  +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in4:                    +1.88 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in5:                    +0.82 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in6:                    +0.30 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| 3VSB:                   +3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| Vbat:                   +3.25 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in9:                    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
| in10:                   +0.22 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in11:                   +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in12:                   +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in13:                   +1.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| in14:                   +1.79 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
| fan1:                     0 RPM  (min =    0 RPM)
| fan2:                  1708 RPM  (min =    0 RPM)
| fan3:                     0 RPM  (min =    0 RPM)
| fan4:                     0 RPM  (min =    0 RPM)
| fan5:                     0 RPM  (min =    0 RPM)
| SYSTIN:                 +33.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM
| sensor = thermistor
| CPUTIN:                 -62.5°C  (high = +80.0°C, hyst = +75.0°C)
| sensor = thermistor
| AUXTIN0:                +79.0°C    sensor = thermistor
| AUXTIN1:                +96.0°C    sensor = thermistor
| AUXTIN2:                +23.0°C    sensor = thermistor
| AUXTIN3:                -22.0°C    sensor = thermistor
| SMBUSMASTER 0:          +39.0°C
| PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
| PCH_CHIP_TEMP:           +0.0°C
| PCH_CPU_TEMP:            +0.0°C
| intrusion0:            ALARM
| intrusion1:            ALARM
| beep_enable:           disabled

I suspect the nct6779 is not reporting correctly (or needs some
configuration) here, as I see that's what Ken is using with his 1300X as
well.

(ASRock B450M Pro4 motherboard, fwiw.)

J.

-- 
Verily go thee not unto the internet for they will tell you both yea
and nay
