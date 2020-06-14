Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F36C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 10:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA82204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 10:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="BlnySnM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFNK0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 06:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 06:26:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76259C05BD43;
        Sun, 14 Jun 2020 03:26:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0729722F99;
        Sun, 14 Jun 2020 12:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1592130396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJxvGjLG+zCr4pQZGoAns/cjbZC5rD9SgUiVfLcsZLU=;
        b=BlnySnM1M9f1ZLAY/nIMAW9bAmVM+K1Bf0A3llGF/CTB6QOnLrIBj40JijOMu1qlQSjljA
        ZtMT+RwKwVKn+uGRrfs5xtJu6Q8SxuYPJCt9FvQTRBheTbAujw+6glWcKcLZOU7A3BmMWG
        pvRuQ/8ZNiI21iavo62b6Q0nAC/+PSc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 14 Jun 2020 12:26:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
In-Reply-To: <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
References: <20200609110136.GJ4106@dell>
 <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <0709f20bc61afb6656bc57312eb69f56@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 2020-06-10 00:03, schrieb Rob Herring:
[..]
> Yes, we should use 'reg' whenever possible. If we don't have 'reg',
> then you shouldn't have a unit-address either and you can simply match
> on the node name (standard DT driver matching is with compatible,
> device_type, and node name (w/o unit-address)). We've generally been
> doing 'classname-N' when there's no 'reg' to do 'classname@N'.
> Matching on 'classname-N' would work with node name matching as only
> unit-addresses are stripped.

This still keeps me thinking. Shouldn't we allow the (MFD!) device
driver creator to choose between "classname@N" and "classname-N".
In most cases N might not be made up, but it is arbitrarily chosen;
for example you've chosen the bank for the ab8500 reg. It is not
a defined entity, like an I2C address if your parent is an I2C bus,
or a SPI chip select, or the memory address in case of MMIO. Instead
the device driver creator just chooses some "random" property from
the datasheet; another device creator might have chosen another
property. Wouldn't it make more sense, to just say this MFD provides
N pwm devices and the subnodes are matching based on pwm-{0,1..N-1}?
That would also be the logical consequence of the current MFD sub
device to OF node matching code, which just supports N=1.

-michael
