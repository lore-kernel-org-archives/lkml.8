Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7BBC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72852072C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV5oq9wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgBRAcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:32:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36600 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBRAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:32:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so10065064pgu.3;
        Mon, 17 Feb 2020 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkbCybzk75m/DwfgLQS+k1c3Zj35iCw6kglMnXwvNH4=;
        b=UV5oq9wT6hVRcrADinmMSfqbJY3tQAss1lJyHmbizX8sMZ44RpJ2KQmvtGFReRluNf
         WfZhCpP5uSZ51pqmsXdU+Q+btYZgZHQQ3vUGKWWPMB8XQf7FbCa60fCxXS3rqJx3nFyT
         ZQkXSvWYl29/Nu2UwBGY7AFZCwsVOx68Z+Zq+ugRzHHsQh/EeQ/a7HgowEHm3+/ee6Xn
         HRZipdm2N+jw0EGme4oasVgpHWGnyoOzMFJ1NwsS7mVJRyokRTu08R8Mi78li3sks6BH
         9Nifri85WPwR0jc6SQCOb9oVw1rPeRn+vdPQq29r7ZG9oziZ/qKkVWdvvpnCVpsRx5+q
         wtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkbCybzk75m/DwfgLQS+k1c3Zj35iCw6kglMnXwvNH4=;
        b=g71NaxNpGHcix9sh7jx8pUrugN9dc9bVMuygbT0H2bfS0Q0sMzubL3CDV4zYKKEDuy
         QG5av/22avrNo3WZgOtOZrL9sm74Yv7A0oAvlgXBKu0gOsTPWsGKRDmxOuoKyCMxcEqM
         vbzwHBQb1iWpDp3VUhymvH+jy2gjmNvHCaf9Sq6DyCzVDQz9b9CEsB46ETD5CsUzO05F
         Ucl0VIn/Dg464lvVGqWnypDr+KGk1su76PXgDqHfTDYO76rF2Tqmd1B4Sfphg0LJw5In
         BKx/tLQoLcx6UCyEv8sSFxCR77/eIhwZfr1o+BmybYhMtyMM6dMFDN3d1GmqPf9xhERl
         0Hxg==
X-Gm-Message-State: APjAAAXHNi/IbMzV19gl3t92LuMgeVW2XurRCGZXBz9f3o/OI2/MeZI5
        RS7MAxaf+FUvIggt/UZi0vbogaqU
X-Google-Smtp-Source: APXvYqyU4HpyhuNG2Pk7898Kn5kHYBovyU41eVWfl/5GZVfjEERppXeSfSatnk3cMQ5MQeSmMmMfOQ==
X-Received: by 2002:a63:1044:: with SMTP id 4mr20823772pgq.412.1581985963803;
        Mon, 17 Feb 2020 16:32:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8sm596672pje.2.2020.02.17.16.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 16:32:42 -0800 (PST)
Subject: Re: [PATCH 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb029a57-e7d2-c35c-f2e2-276e2373787b@roeck-us.net>
Date:   Mon, 17 Feb 2020 16:32:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 3:46 PM, Chris Packham wrote:
> I've picked up Logan's changes[1] and am combining them with an old series of
> mine[2] to hopefully get them both over the line.
> 

No change log and/or history, so I guess your expectation is that it will be up
to me to figure out what may have changed and if previous comments have been
addressed or not.

Guenter

> This series updates the binding documentation for the adt7475 and adds two new
> sets of properties.
> 
> [1] - https://lore.kernel.org/linux-hwmon/20191219033213.30364-1-logan.shaw@alliedtelesis.co.nz/
> [2] - https://lore.kernel.org/linux-hwmon/20181107040010.27436-1-chris.packham@alliedtelesis.co.nz/
> 
> Chris Packham (2):
>    dt-bindings: hwmon: Document adt7475 invert-pwm property
>    hwmon: (adt7475) Add support for inverting pwm output
> 
> Logan Shaw (3):
>    dt-bindings: hwmon: Document adt7475 binding
>    dt-bindings: hwmon: Document adt7475 bypass-attenuator property
>    hwmon: (adt7475) Add attenuator bypass support
> 
>   .../devicetree/bindings/hwmon/adt7475.yaml    |  82 ++++++++++++++
>   .../devicetree/bindings/trivial-devices.yaml  |   8 --
>   drivers/hwmon/adt7475.c                       | 100 +++++++++++++++++-
>   3 files changed, 179 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 

