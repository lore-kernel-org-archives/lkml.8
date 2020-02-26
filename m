Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1611C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A451D206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="RoeEF8Ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBZKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:00:45 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:47948 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:00:45 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7BC445C2BCF;
        Wed, 26 Feb 2020 11:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1582711242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePmS7XO1+c6T51otcQraIoZVvQV4pOzpfHZOivGH1Ow=;
        b=RoeEF8Ve+22KNPqaEf9qu9/4e6wKLg0KLscyhkoSR4oRsFxTu40avKIErXJqAPDAw2rela
        XM+se4G3O6pIJJUC9f9N9bScqxRfA8+z4rrj633JD4ah3BjgHnrMdeE1QP1J02BFXuwfTd
        cNuJxD5nmnTujmFM8Q/pMsvIm35G9FI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Feb 2020 11:00:42 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] arm: dts: vf: toradex: re-license GPL-2.0+ to
 GPL-2.0
In-Reply-To: <CAGgjyvHE+B-VCSfmR9MeO2-u6=dVCUCmCorEa1J+NG5vwQoRfA@mail.gmail.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
 <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
 <CAGgjyvHE+B-VCSfmR9MeO2-u6=dVCUCmCorEa1J+NG5vwQoRfA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <8a33d75f0bdf10b0b15514ac790a248d@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-26 10:29, Oleksandr Suvorov wrote:
> On Mon, Feb 24, 2020 at 7:33 PM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>>
>> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>>
>> Specify explicitly that GPL-2.0 license can be used and not
>> GPL-2.0+ (which also includes next less permissive versions of GPL)
>> in Toradex Vybrid-based SoM device trees.
>>
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> And please ignore my note about copyright for the previous change of this file.
> 

The Linux on Vybrids Cortex-M4 was an entirely private endeavour of me,
so there is no Toradex Copyright here.

I agree on the License change.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

>> ---
>>
>>  arch/arm/boot/dts/vf610m4-colibri.dts | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
>> index 2c2db47..75c6d82 100644
>> --- a/arch/arm/boot/dts/vf610m4-colibri.dts
>> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
>> @@ -1,7 +1,8 @@
>> -// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>  /*
>>   * Device tree for Colibri VF61 Cortex-M4 support
>>   *
>> + * Copyright (C) 2020 Toradex AG
>>   * Copyright (C) 2015 Stefan Agner
>>   */
>>
>> --
>> 2.7.4
>>
