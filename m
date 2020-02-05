Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12811C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0CC2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTug05rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBED5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:57:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33287 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgBED5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:57:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so286234pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 19:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apPrD7wZh90jY/Np9SrQOOe7m/4eyMCS6fQyaQaa/T8=;
        b=VTug05rAZUGlDGXmWbShRAhCfmrlpIcWtRzJwxl9wGQ+VbWdqrEabcaXAQv2XcvUKL
         1VBvkZFyCvSw+T9SqObdgTlVljbR1o5sqCZPGXMFh76s9tVpnXD6w1hSTn/CHt4KRyjZ
         2h+HhdZcGSaWXz/2PL43WrkFGmAdbZJP3cJAElK7nAaK8WgEN6qk7G5xgxNBzaKvQIAN
         dBrHSUzj3Np6RyjRPM5coxrj3LTYDx2kDOKRuAEhieK2J4qqeAxZufqnTwKSeROQZdRL
         HfOInD/ce8c8HVvlrmYN6hsmH8T7QbKjEBv4WARkBG1zmTJ65fHbjD0uHuMMx/5ugjmP
         AKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apPrD7wZh90jY/Np9SrQOOe7m/4eyMCS6fQyaQaa/T8=;
        b=W0klF4e4ZL+S5QTqiGyMO9z01oAb2fXMeFw8PRB4dup9er7QF0cd7QNF4Kw1K1GB/+
         UUc46QY3xob1UjMkNSaQYwThB6EWjlaDz0cE2bd7ndSOrA5jSfsftUKEX3gWnoQ7tlv4
         3eH13K0gQ74K0h5TB7yMbUFF3zqrWAb02qvka3s2+xQXKQXBy77HXzLtfXIYy7V9WQkr
         ZzXcC+LXmdVUz4GTZKfcmyusrt/Tgu+uJ/oU1js65NgIf1zhuVf2epQCNybdpTMYPk1o
         WStQuyNrPqfSmU74yj0HD173M8QlE1/+dxa0BxYh1HlcqIYOaO51U4CZPIIOPh6+Gwzx
         RwQQ==
X-Gm-Message-State: APjAAAUUswYCiZWn1Qd0YsiPsG7rb/Xe4oKblGUjpwqaOTWJezaXJVF/
        +VU+7tWhS6NOkz9VsAT7tCE=
X-Google-Smtp-Source: APXvYqxsmUdbWOksoFfVNWJtGF2n5rhv+R5L27pihJEdGdWEyCmS4cxAwAeZJXQ9BYR2wi9jiprdwg==
X-Received: by 2002:aa7:9145:: with SMTP id 5mr34531817pfi.74.1580875021751;
        Tue, 04 Feb 2020 19:57:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm27143644pfg.66.2020.02.04.19.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 19:57:00 -0800 (PST)
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com>
 <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org> <20200205033416.GT1778@kadam>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3032823-03a9-f018-73e4-eb0d71e0bb53@roeck-us.net>
Date:   Tue, 4 Feb 2020 19:56:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205033416.GT1778@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 7:34 PM, Dan Carpenter wrote:
> On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
>> On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
>>> On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
>>>> On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
>>> On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
>>>> My advice is to delete all the COMPILE_TEST code.  That stuff was a
>>>> constant source of confusion and headaches.
>>>
>>> I was also going to suggest this. Since the COMPILE_TEST has been a
>>> source of trouble I was going to propose dropping the || COMPILE_TEST
>>> from the Kconfig for the octeon drivers.
>>
>> Not having it also causes problems.  I didn't originally add it for
>> shits and giggles.
> 
> I wonder if the kbuild bot does enough cross compile build testing these
> days to detect compile problems.  It might have improved to the point
> where COMPILE_TEST isn't required.
> 

Not really. Looking at the build failures in the mainline kernel right now:

Failed builds:
	alpha:allmodconfig
	arm:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	m68k:allmodconfig
	microblaze:mmu_defconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig

Many of those don't even _have_ specific configurations causing the build failures.

Guenter
