Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51804C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296CE206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="ERJuHXbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgBLJpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:45:07 -0500
Received: from srv1.deutnet.info ([116.203.153.70]:48106 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgBLJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=In-Reply-To:Date:Message-ID:From:Cc:To:Subject;
         bh=TAJr0AondWJzOCdJcDIVwWs7uRbDrPcYBrltHTHHTq0=; b=ERJuHXbzfCXkZNQayCKVCerLa
        TIf1mb1N4Fd5ov9eFmMS+OIITb5KLI/9nyQs+mSHHVdXXpvgw3W7UHcF0bqbIbNizNJRveGpiewHH
        V6ZW+Jt1CCpzX+Yxa5C+Vp+H+7siWDEEPwe8cFc3uaWJyGqovnniRIfCsPZa6lMi4gf0ZeVmRpiRp
        U1ONBOJlzgZHewIoxZXJWw6YWLep2wlKYBcq3bIuU+DTn3a+3HTtQ6m2rthcDeOTstyx5naHxspRE
        ewRPvQrbz+Arjtq8bBZcAZ1plDWMPCTyGsRf5J7X6suOjAMrErXVhFhdtLJn187y3osg9lKE4kLiK
        7pxAFUyIw==;
Received: from [2001:41d0:fe79:6710:be5f:f4ff:fe8b:2fc1]
        by srv1.deutnet.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j1oZs-00053r-Cf; Wed, 12 Feb 2020 10:45:04 +0100
Subject: Re: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200210103552.3210406-1-agriveaux@deutnet.info>
 <20200211131517.e7lpjtz2njekadee@gilmour.lan>
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
Message-ID: <864838c2-1b1d-433a-ca04-0d91c8b5b8ca@deutnet.info>
Date:   Wed, 12 Feb 2020 10:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211131517.e7lpjtz2njekadee@gilmour.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2020 à 14:15, Maxime Ripard a écrit :
> On Mon, Feb 10, 2020 at 11:35:52AM +0100, agriveaux@deutnet.info wrote:
>> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
>>
>> Add Inet 86V Rev 2 support, based upon Inet 86VS.
>>
>> Missing things:
>> - Accelerometer (MXC6225X)
>> - Touchpanel (Sitronix SL1536)
>> - Nand (29F32G08CBACA)
>> - Camera (HCWY0308)
>>
>> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> Please read the documentation I sent you yesterday. In particular,
> when submitting multiple versions, you should remove have the version
> number in the title and a changelog.
>
> Also, please ask questions if you're unsure about something, or
> discuss something you do not agree with instead of ignoring the
> comment.
>
> Maxime

Hello,


Seem I misusing 'git send-email' because i already changed the subject
line (same apply to u-boot):

git send-email --from agriveaux@deutnet.info --to
robh+dt@kernel.org,mark.rutland@arm.com,mripard@kernel.org,wens@csie.org
--cc
linux-kernel@vger.kernel.org,devicetree@vger.kernel.org,agriveaux@deutnet.info
--subject '[v2] ARM: dts: sun5i: Add dts for inet86v_rev2' --compose
/tmp/linux/0001-ARM-dts-sun5i-Add-dts-for-inet86v_rev2.patch

It's the first time i use git send-email, previously i used mutt to send
patchsets (on mips mostly).


Effectively i've forgot the changelog...


At why do we need another device tree:

inet86vs use a GSL1680 touchpanel controller and 4GB nand [0]

inet86vsuse a Sitonix SL1536 touchpanel controller and 8GB nand (can
have 16GB nand)[1]


Seem i've forgot to use:

git format-patch --subject-prefix="PATCH v2"


Thanks.

[0]https://fccid.io/2AARJ-AP7S118/Schematics/Schematics-2042312.pdfinet86vs
schematic

[1]https://fccid.io/XHW026/Schematics/Schematics-1820577.pdfinet86v
schematic

