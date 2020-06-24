Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D260320768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="YiPY5C5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbgFXHre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:47:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35161 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbgFXHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:47:33 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AA52E23078;
        Wed, 24 Jun 2020 09:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1592984846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hYUAFhvzMgCCSNiWjkpdtB/bWo87aFoIZZzVYlQ/9w=;
        b=YiPY5C5+haPj3daChZY5rmJFBt0WrJulwOA2RX5uN/smSDchnArLSFfL6zGXIl3JYWUG08
        yufzrfcgUFeFe+Mj1Dp0Q0kQJxUQ3kWFZgG1I2b1vkWlBkHxv2MpI1tHV5CO5wEogREtSR
        ABcWeM+hkAKVKl6No1WvUlvw4KVkvJw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jun 2020 09:47:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
In-Reply-To: <20200624064145.GC954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
 <20200624064145.GC954398@dell>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <7a31b34940984b3f0921ed2d4fb29a58@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2020-06-24 08:41, schrieb Lee Jones:
> On Tue, 23 Jun 2020, Frank Rowand wrote:
> 
>> On 2020-06-11 14:10, Lee Jones wrote:
>> > Currently, when a child platform device (sometimes referred to as a
>> > sub-device) is registered via the Multi-Functional Device (MFD) API,
>> > the framework attempts to match the newly registered platform device
>> > with its associated Device Tree (OF) node.  Until now, the device has
>> > been allocated the first node found with an identical OF compatible
>> > string.  Unfortunately, if there are, say for example '3' devices
>> > which are to be handled by the same driver and therefore have the same
>> > compatible string, each of them will be allocated a pointer to the
>> > *first* node.
>> 
>> As you mentioned elsewhere in this thread, this series "fixes" the
>> problem related to the "stericsson,ab8500-pwm" compatible.
>> 
>> I know, I said I would drop discussion of that compatible, but bear
>> with me for a second.  :-)
>> 
>> The "problem" is that the devices for multiple mfd child nodes with
>> the same compatible value of "stericsson,ab8500-pwm" will all have
>> a pointer to the first child node.  At the moment the same child
>> of_node being used by more than one device does not cause any
>> incorrect behavior.
>> 
>> Just in case the driver for "stericsson,ab8500-pwm" is modified
>> in a way that the child of_node needs to be distinct for each
>> device, and that changes gets back ported, it would be useful
>> to have Fixes: tags for this patch series.
>> 
>> So, at your discretion (and I'll let you worry about the correct
>> Fixes: tag format), this series fixes:
>> 
>> bad76991d7847b7877ae797cc79745d82ffd9120 mfd: Register ab8500 devices 
>> using the newly DT:ed MFD API
> 
> This patch isn't actually broken.
> 
> The issue is the DTB, which [0] addresses.
> 
> [0]
> https://lkml.kernel.org/lkml/20200622083432.1491715-1-lee.jones@linaro.org/

Now, I'm confused; because this patch doesn't use the reg property
but a different node name. I'd actually prefer this for any MFD
driver which has multiple nodes of the same compatible string. See
my reasoning here [1]. But until now, no one has responded. Thus,
I'd rather see a OF_MFD_CELL_NAME() which matches the node name
instead of the OF_MFD_CELL_REG() macro.

This would also circumvent the fact that the unit-address has one
number space. Eg. it is not possible to have:

mfd {
   compatible = "mfd,compatible";

   gpio@0 {
     reg = <0>;
   };
   gpio@1 {
     reg = <1>;
   };
   pwm@0 {
     reg = <0>;
   };
};

Although Rob mentioned to maybe relax that, but I sill fail to see
the advantage to have an arbitrary reg property instead of a unique
node name.

[1] 
https://lore.kernel.org/linux-devicetree/0709f20bc61afb6656bc57312eb69f56@walle.cc/

-- 
-michael
