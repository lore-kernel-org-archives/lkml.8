Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED5DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3F520672
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="KDjyolna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgF0Q7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0Q7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:59:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17702C061794;
        Sat, 27 Jun 2020 09:59:00 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9486622708;
        Sat, 27 Jun 2020 18:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593277134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nGL+tnFIAt0ZoojBnWf47XaRiyJlS+iVijOfL+WgN8=;
        b=KDjyolnahGMCwSPrN3p3Fo+EAzc4V2j/Qj1pS0mkzPzRQ7FFlvsijQDE8mL1WhFn6ZT6Sm
        +s0a+4agmyvkqpNPN410Cod0aFiiGM8WmlQmpsVTQD1HqjFTBDoxk9otowPmCIj/fVADf8
        u4Sf253hGdU+Hqycn2N/c4J/2tX2OwQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Jun 2020 18:58:54 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sungbo Eo <mans0n@gorani.run>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] gpio: add GPO driver for PCA9570
In-Reply-To: <CAHp75VciJmV1wTB0AWvbjyOZzzk1A1KC70+dtr0jNziAvQ2tHw@mail.gmail.com>
References: <20200623060526.29922-1-mans0n@gorani.run>
 <80bbca9a625b2a0feb9b816906549b7c@walle.cc>
 <2291c01d-30df-518e-a952-644bd955f1f3@gorani.run>
 <69f5d1a1970838b8c4bd8d6e8dba6cac@walle.cc>
 <CAHp75Vfc2udv2mLLJCFO6P+n8_kcO7OZKhH_XkOy7Cf4fnxgtA@mail.gmail.com>
 <9956439a3c887dde7b2b8fa48de20db2@walle.cc>
 <CAHp75VciJmV1wTB0AWvbjyOZzzk1A1KC70+dtr0jNziAvQ2tHw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <83f1fba7fb04780b84c5e96a184f61f9@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2020-06-24 16:52, schrieb Andy Shevchenko:
> On Wed, Jun 24, 2020 at 4:46 PM Michael Walle <michael@walle.cc> wrote:

[..]

>> So you just write one byte of data (or you might repeat it, but
>> that is just as if you start a new i2c transaction, just that
>> you save the i2c addressing).
> 
> You can write the same value twice.
> It means that the first byte can represent the register address. But
> it's still too volatile.

In this case the output pin will hold the value of the "fake" address
register for a short period of time. No?

> Perhaps regmap can gain something like register-less communication.

I don't know if that is worth it (and if that is an intended use of
regmap).

-michael
