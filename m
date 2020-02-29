Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D87C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0637C246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjF6W4eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgB2NLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:11:16 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42187 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2NLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:11:16 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so5317463ila.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 05:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gAthWfE+X3hUo+Zk7kImgRO8yd/RhjUJy6DiT2UPzlM=;
        b=XjF6W4eZZOh403wB7S9uUclEKfJl7CvHM09oXnUzKBAxuIJUUzYPy5oAlRCnAJkSKV
         vSqc3kwWW/xz7GqWuVWb2sQUznNqO8vjUwqL9Siu6EavD17ng5P12SMhzLympGD3Ebm4
         z3+i0b6gmLd2N2YzUat9QzSm79QfNk7b/G0W974dhheDpxdHJwhPecfnKsyjhoG5c6BX
         NPI0rn5qIMfIANzJn3RAvGO5Sq5DfWXD9FmRukLZsDi1hI7ht36phe1BJDwXeYkiAru0
         EVd9EGCdlRR2GhJ4hwxVrNO9pcyrC68iXgxdzvnKZp/KUCbRRBjYMtQnMCpU7q4gNJXu
         eE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAthWfE+X3hUo+Zk7kImgRO8yd/RhjUJy6DiT2UPzlM=;
        b=FRinEUv+zqeiX4SVEm8h00iQJ8xe0W0ZCO+pQ+32jVUGTzvMnMBQDa4dbGRiQERNLH
         Kc2Zrv5EldeNTuf2a5Wcb0kmO1lMA19iWAoEDW/QjzpKITybDA+awqX2baCzG0qGlIEg
         cP62R0Uf9/dOLK3Cf9cud/etwoyTaRay1tg6VCQ3f+A6fRwJFQN1k21pTlredIri7O2Q
         cpuE/1zWxtv7LFcvfTXzfYyoANsUhQQkqqJ0PeuipNmDJ4Ewsm/u2O2lE03RwNW0QFl/
         3T0RbAenR9w0EBOatGFrajZOLyTaPYUmsRVP5FeoGinc/W46QJRpwVpOF1GDXAajfXER
         3ncg==
X-Gm-Message-State: APjAAAXATX+x5rCO5+oP29LcLCZYxlIOzwg5MFKqknk3aRdon6bWK6mV
        L3dv4YL6G/4A9hoQUzsaib/5Rpokt58=
X-Google-Smtp-Source: APXvYqyGQXXgxQJCvCchGnJs8fsnT9NnFNfel+h+BRcqtDnEjsMbpZcJpOTIUa3CsP936FA2ruoRjg==
X-Received: by 2002:a92:ce05:: with SMTP id b5mr2896744ilo.303.1582981874931;
        Sat, 29 Feb 2020 05:11:14 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g12sm3013644iom.5.2020.02.29.05.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 05:11:14 -0800 (PST)
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200228165343.8272-1-elder@linaro.org>
 <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
Message-ID: <be229ebb-53a5-e048-9c68-1b4c7cc2ab9d@linaro.org>
Date:   Sat, 29 Feb 2020 07:10:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 12:04 PM, Alex Elder wrote:
> On 2/28/20 11:56 AM, Jakub Kicinski wrote:
>> On Fri, 28 Feb 2020 10:53:43 -0600 Alex Elder wrote:
>>> Define FIELD_MAX(), which supplies the maximum value that can be
>>> represented by a field value.  Define field_max() as well, to go
>>> along with the lower-case forms of the field mask functions.
>>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>
>>>  NOTE:	I'm not entirely sure who owns/maintains this file so
>>> 	I'm sending it to those who have committed things to it.
>>> 	I hope someone will just take it in after review; I use
>>> 	field_max() in some code I'm about to send out.
>>
>> Could you give us an example use?
>>
>> Is it that you find the current macros misnamed or there's something
>> you can't do? Or are you trying to set fields to max?
> 
> I'm trying to validate variable values are in range before attempting
> to use them in a bitfield.

I should have actually checked my code before I sent this.  Yes
I am using the macro as I described, to see if something fits.
But I'm also using it this way:

	foo = u32_get_bits(register, FOO_COUNT_FMASK);
	if (foo == field_max(FOO_COUNT_MASK))
		;	/* This has special meaning */

And another way:

	size_limit = field_max(FOO_COUNT_MASK) * sizeof(struct foo);

So field_max() is really what I need here.  It does imply a
signed interpretation of the field value, but that's true
for all of the lower-case bitfield functions.

I understand the value of FIELD_FIT() but I think field_max()
(and FIELD_MAX()) serves a purpose.  In fact one could argue it
makes FIELD_FIT() unnecessary (compare against field_max(mask)
instead) but I won't propose removing it.

So after further consideration I believe the original patch
is fine.  What are your thoughts?

					-Alex

> I find field_max() to be a good name for what I'm looking for.
> 
> 					-Alex
> 
> #define FOO_FMASK	0x000ff000
> 
> static u32 register = 0x12345678;
> 
> int foo(u32 value)
> {
> 	if (value > field_max(FOO_FMASK))
> 		return -EINVAL;
> 
> 	u32_replace_bits(&register, value, FOO_FMASK);
> 	
> 	return 0;
> }
> 

