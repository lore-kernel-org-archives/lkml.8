Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55237C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC492081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi0oUU+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbgFXVBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgFXVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:01:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5BC061573;
        Wed, 24 Jun 2020 14:01:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q198so3308996qka.2;
        Wed, 24 Jun 2020 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n0fUs+whXgml4Oa4jYkaqimzsvOOOchJfB6d9dlWGNE=;
        b=Wi0oUU+PzfqMxbyBYMNnpEVWwbG1p7vOkC7dz5h9BxDjDtR3yPACUoxFjQvIzRAFBM
         cA0VEYehZnHft94KN9UvKKmbesgtwr2FZ5Si63kc7flju1fd/Ld+QSgrl1DRTmNeUikp
         I1KO4q1iU3XFYHpP12lAOTT21zZLa4RoTGw9ZbbAWG4wnwgCcB7vaZKGoYp+aU799adN
         VGCRSrcS6AdZg81+yxw5JJ3K1hj+wQDJvz3fdMagzOT8ZR0HPoYUlcQZOsAZqFXGJOSs
         sgZ7J4TWrda0C/givZRqr6HKx4MRyOuKlb/pIGipWLbBomFazTbPoKAorlygNgdeRj0m
         +ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0fUs+whXgml4Oa4jYkaqimzsvOOOchJfB6d9dlWGNE=;
        b=Ur1nv/uvld/iIyxLIsf0LJq/tDg6D6jbSxLNVCHMjT8K7XXWsi+LRYxqePlZ8ZlvZw
         xzc3fwjyGTtYIB6Q3IQOMj1RTvnvE9tN6CZdpbOTWo7v7msjicSqY4VujqKFs1F6vTG3
         2LKXDFeTDfdJ9UizUJ9k7jQaApGQEIUnwMJ3V/0L0uzlAUPB9iYyToAq9HT8rFcVfoAM
         JQPsokgZP+1CtJKRs+v7MTu9noH7WGzhxmNRWVDJnOVRKI6ZtfJ0lQEq7V4y6qOJBHCg
         vTVtm2y1bROznO3uXBqNiCG1xmQXjqToHM26gce8b3+hJfWKHUxprdQCbJE0Vp9Vj2UZ
         vPUA==
X-Gm-Message-State: AOAM533H1OpM0cyMzZ+kS8LS1cWZ8jSuTFnA3RIgmbF9H4e/RrK1miw0
        7AOpS2LAovjsqliBCRJx5Wk=
X-Google-Smtp-Source: ABdhPJyWQXlRS0vi88ECx5uld8ijPMkmBPpmyu3PCcToPqeeac3vSf/64hrkPmn3S84XzLt9ew7tdg==
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr6391145qke.118.1593032505008;
        Wed, 24 Jun 2020 14:01:45 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z77sm4254479qka.59.2020.06.24.14.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 14:01:44 -0700 (PDT)
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>
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
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20200609110136.GJ4106@dell>
 <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
 <0709f20bc61afb6656bc57312eb69f56@walle.cc>
 <970bf15b1106df3355b13e06e8dc6f01@walle.cc>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0e9e25cc-b3f2-926a-31dd-c6fafa7d581b@gmail.com>
Date:   Wed, 24 Jun 2020 16:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <970bf15b1106df3355b13e06e8dc6f01@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Frank (me)

On 2020-06-22 16:03, Michael Walle wrote:
> Am 2020-06-14 12:26, schrieb Michael Walle:
>> Hi Rob,
>>
>> Am 2020-06-10 00:03, schrieb Rob Herring:
>> [..]
>>> Yes, we should use 'reg' whenever possible. If we don't have 'reg',
>>> then you shouldn't have a unit-address either and you can simply match
>>> on the node name (standard DT driver matching is with compatible,
>>> device_type, and node name (w/o unit-address)). We've generally been
>>> doing 'classname-N' when there's no 'reg' to do 'classname@N'.
>>> Matching on 'classname-N' would work with node name matching as only
>>> unit-addresses are stripped.
>>
>> This still keeps me thinking. Shouldn't we allow the (MFD!) device
>> driver creator to choose between "classname@N" and "classname-N".
>> In most cases N might not be made up, but it is arbitrarily chosen;
>> for example you've chosen the bank for the ab8500 reg. It is not
>> a defined entity, like an I2C address if your parent is an I2C bus,
>> or a SPI chip select, or the memory address in case of MMIO. Instead
>> the device driver creator just chooses some "random" property from
>> the datasheet; another device creator might have chosen another
>> property. Wouldn't it make more sense, to just say this MFD provides
>> N pwm devices and the subnodes are matching based on pwm-{0,1..N-1}?
>> That would also be the logical consequence of the current MFD sub
>> device to OF node matching code, which just supports N=1.
>>
> 
> Rob? Lee?
> 
> -michael

