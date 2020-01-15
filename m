Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B784C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3EA2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAOPVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:21:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49480 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:21:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47yWJ93y9wz1qrJ9;
        Wed, 15 Jan 2020 16:21:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47yWJ9364kz1qtds;
        Wed, 15 Jan 2020 16:21:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id quKjM1C8Obmr; Wed, 15 Jan 2020 16:21:27 +0100 (CET)
X-Auth-Info: ZwfjEOAw3ySj2X4yZtG+NNy+Kpmgp833t+DsGDP+I1c=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Jan 2020 16:21:27 +0100 (CET)
Subject: Re: [PATCH] regulator: core: fixup regulator_is_equal() helper
To:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
References: <87ftgh8qnn.wl-kuninori.morimoto.gx@renesas.com>
 <20200115141235.GK3897@sirena.org.uk>
From:   Marek Vasut <marex@denx.de>
Message-ID: <66c63cfc-840b-8c57-8e70-f2f2824462c8@denx.de>
Date:   Wed, 15 Jan 2020 16:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200115141235.GK3897@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 3:12 PM, Mark Brown wrote:
> On Wed, Jan 15, 2020 at 10:17:00AM +0900, Kuninori Morimoto wrote:
>>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> commit b059b7e0ec320 ("regulator: core: Add regulator_is_equal() helper")
>> added regulator_is_equal() helper.
>> But it has unneeded ";" if CONFIG_REGULATOR was not defined.
>> Thus, we will have this error
> 
> Thanks but Stephen already sent a fix.

Sorry for the mess again.
