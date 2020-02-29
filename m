Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC153C3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38FD2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 01:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LufvHVTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB2Bzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 20:55:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgB2Bzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 20:55:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id o24so2598109pfp.13;
        Fri, 28 Feb 2020 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7Lymz3/UG6p46gG34Fh3vPe/udGkZ9zfaHdLppHN94=;
        b=LufvHVTSOlh0C3/3G14NtjXvq7M+N6HMy7772o1pa7nHRbTNz2WxZX7biXsHow6Qxs
         kacX9TlgaGCG84qkqsCMb027hADZ+ByoB0DLff3O0Jgq3L4e/FPvWli2XnNltrEAFgjy
         u1uumTOLL8yaPHVhyQWI6/bYZZhRl0te5ol0hg3uyvW/MzkETyUC+hJ5dEYgZJLr1lcG
         wEPToThI6+YimypW3Tp9Dx7EPzoOEwiHhLPsTYJKqNa7OY6jfe+mJ0znjEEda68z98pq
         jL9GnTIhjVQ7k36rG42haSgoIadRGf8kq5NboseVJjnGhbMyq6cKwCEeaa/XHyR0G124
         sM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i7Lymz3/UG6p46gG34Fh3vPe/udGkZ9zfaHdLppHN94=;
        b=jBDjHReuGDd6h7J7XmwjkOmr3SsEN8mMvwIJAhjOSzeH+uToiANqvPMkQ8d2K5C80e
         mxXhHXH9/RgfAKXpcL2e59zmt5Jae9qnpBZXkjw3T71aWogxpqb3+PgQc9buXUC61Bpa
         sFaZ+UX6pHvbObvvxoxqZIytHSuMfP6+gz/rT1JUpomXvyyvgSsoqU1x38iPBtc5bOML
         11WOAS286vUAmgTLmmoub+Xe/22qpYLKiWo62D+e5O7pYpkN8HO7u16wr7znlA5DJMkg
         4rsQvDlJJ93Ldh77EBFF+XQJLnW1Io3ptILxl58IeyEn0Ns9X4fsY0P3U3NN+waOJWvL
         dZMg==
X-Gm-Message-State: APjAAAXWbsrOg+7FFKtXm1z7iaqUGW6J8azM92hOXGZplw2T2/XBwvNP
        tbbUhOt8Ys3AWRb3k+NUlkc3ralh
X-Google-Smtp-Source: APXvYqy+ME+nd+WvS73ec3iljk4A+ibK5fhKwZcOrWCrz9abadzyBIen6SE11Wxu1bz2WP5ZBIAM2w==
X-Received: by 2002:a62:1c11:: with SMTP id c17mr7196816pfc.192.1582941346414;
        Fri, 28 Feb 2020 17:55:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10sm8993909pgv.25.2020.02.28.17.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 17:55:45 -0800 (PST)
Subject: Re: [PATCH] hwmon: (pmbus) Add support for 2nd Gen Renesas digital
 multiphase
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, adam.vaughn.xh@renesas.com,
        zaitsev@google.com
References: <20200228212349.GA1929@raspberrypi>
 <20200228225848.GA14676@roeck-us.net> <20200228235206.GA3468@raspberrypi>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1a456016-682a-2d53-767b-fe09784883ef@roeck-us.net>
Date:   Fri, 28 Feb 2020 17:55:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228235206.GA3468@raspberrypi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 3:52 PM, Grant Peltier wrote:
> Hi Guenter,
> 
> Thank you for your expedient review. I will need to consult with my
> coworkers to determine a more appropriate driver name. In the meantime I
> will make the desired changes and I will also create a document for the
> driver, which I will submit as a linked but separate patch.
> 
> With regard to the part numbers, this family of parts is currently in
> the process of being released and we have not yet published all of the
> corresponding datasheets. However, I have been assured that all of the
> parts listed are slated to have a datasheet published publicly in the near
> future.
> 
That would be great.

As for the driver name, I had a look into drivers/hwmon/pmbus/isl68137.c,
and I don't immediately see why the new chips would warrant a new driver.
The only differences seem to be that VMON is a new command, and of course
only the ISL68137 supports AVL. But then there is, for example, ISL68127,
which is again quite similar. The only other difference as far as I can
see is input voltage scaling, but that doesn't warrant a separate driver
(and, of course, I have no means to validate if input voltage scaling
is indeed different for all the new chips).

Overall I would suggest to extend the isl68137 driver. I would also
suggest to not add separate tables for each of the rail configurations
but use the three-phase entry as starting point, copy it, and adjust its
values as needed.

For the multi-phase chips, I question if reporting the input voltage
for each phase make sense. Is it really a different voltage ? For IIN
and PIN, the question is if the registers are indeed paged, since they
are not paged in the older chips.

Guenter
