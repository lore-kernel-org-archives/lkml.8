Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F9C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D021D79
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HWYcWHxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgD2PVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgD2PVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:21:45 -0400
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F6C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:21:45 -0700 (PDT)
Received: from mxback9q.mail.yandex.net (mxback9q.mail.yandex.net [IPv6:2a02:6b8:c0e:6b:0:640:b813:52e4])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 54BA711C414C;
        Wed, 29 Apr 2020 18:18:15 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9q.mail.yandex.net (mxback/Yandex) with ESMTP id KbPPkAcLKB-IE4iODx5;
        Wed, 29 Apr 2020 18:18:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1588173494;
        bh=YNxfJqP4C2YqdFNFfcbfqj+X9mIviH90oiKLdZH123Y=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=HWYcWHxa6buWsZ6XBnUTmoSlMWjtrgvJXuIBfGelbwf8JJhbcj/s+bfZOK/ErCFo/
         gd0p0P2w29PQtl5ih1nCcyMf2Lcj/DHlqgO9GkMdqu3wWdboNq9pK4jIRo+7fGexPn
         bO5OpOA47H5AzVbvr6SINkp88lkfYFNDCVlnSrdg=
Authentication-Results: mxback9q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-c477e3898c96.qloud-c.yandex.net with HTTP;
        Wed, 29 Apr 2020 18:18:14 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Greg KH <greg@kroah.com>, Akira Shimahara <akira215corp@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429134655.GB2132814@kroah.com>
References: <20200429133204.140081-1-akira215corp@gmail.com> <20200429134655.GB2132814@kroah.com>
Subject: Re: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device power
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 29 Apr 2020 18:18:14 +0300
Message-Id: <330221588173223@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

29.04.2020, 16:47, "Greg KH" <greg@kroah.com>:

>>  +What: /sys/bus/w1/devices/.../w1_slave
>>  +Date: Apr 2020
>>  +Contact: Akira Shimahara <akira215corp@gmail.com>
>>  +Description:
>>  + (RW) return the temperature in 1/1000 degC.
>>  + *read*: return 2 lines with the hexa output data sent on the
>>  + bus, return the CRC check and temperature in 1/1000 degC
>
> the w1_slave file returns a temperature???
>
> And sysfs is 1 value-per-file, not multiple lines.

It was 'content crc' previously, and probably a good idea would be to add just one file with 'content'

> And as this is a temperature, what's wrong with the iio interface that
> handles temperature already? Don't go making up new userspace apis when
> we already have good ones today :)

What is that?
w1 always had a sysfs files for its contents whether it is converted temperature or raw bytes data,
there is also netlink interface which is there since the day one. 

>>  + *write* :
>>  + * `0` : save the 2 or 3 bytes to the device EEPROM
>>  + (i.e. TH, TL and config register)
>>  + * `9..12` : set the device resolution in RAM
>>  + (if supported)
>
> I don't understand these write values, how do they match up to a
> temperature readin?

You kind of writing to device about how to convert its raw content into readable content, which will eventually become a temperature
