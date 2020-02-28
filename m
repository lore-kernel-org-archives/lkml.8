Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1441AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B742469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGAlaKd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgB1SFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:05:00 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38899 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1SE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:04:59 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so3482805ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2O1NCkfJ2WMrflY789rXqGNgLsaY7bc+9Uwap1q5Dd8=;
        b=iGAlaKd7frggtGr9qU5OveJX3QYIeBEb2Q2D8IhyxAYHRivIPq/6YdJh2H+NLDrimJ
         N/80pLg4XkJLfrZIfMG8rPAYyFQRuDeRhGiXa9kHPXfNeXs1NhnynSJYcD6h5NpB7O9Q
         cX0uSgDyh5t10T4kY5orZvUGl9jespPLFXzaglyEGyFaxlw7xy+RgY9OwY75b6YogHIQ
         i/p5PBWH2W56ogvBSJ5HCNYhGJq6cvZYjYCSIqgXJ2gN1sL0UxVKBJhGObuhSJCJiyHj
         0aMBaAW5FBDV1tEP/856F8K74VLp/CJEFSSPIxUTFchrTeGWRfAX0peneQQ7sNvM5Jia
         6n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2O1NCkfJ2WMrflY789rXqGNgLsaY7bc+9Uwap1q5Dd8=;
        b=P1JT4qJYW0j6g5gm6oOBHFXlQD/leoyfeUugDrySo9V2BOy40Kto+FNSrJA1KifLyq
         02TKYMTm1kdidwEPdszGZkrtmIr0aid22+NrpO8c7u/PNh2u23pTaQCLQpP8QyrBRgbs
         CSla8QTObHmC3c7PG29r2gjOsyaCQh2dlG1ajHTiQe2NeI+1Az0PK8rpPCg/hwGS9GIj
         rTk75PCGbnOTsrojXC4JmwZ+SWJd8FHQcbqe6FwnYeO9y22KDjRE4U8ds4MhpODN4p8P
         OXcVtukJp3JlQGshy55Nr1UfAgIgGn3l2UNBdZirqR+MWXjmnS2uiaDRN5snIMBv0nF5
         Sg1g==
X-Gm-Message-State: APjAAAWHxLssW+Md8D3igSzqUprtkAoS5J/Fiu+Af5vB3chfFkcr7S5A
        +LD/JTCRdCu23ysbduLEFVL2nJoaSGY=
X-Google-Smtp-Source: APXvYqyyTjxmeypUh9ojVqSOjNB6BYZh6l5eLyAMeDHIxqZT3lYXN44WiyanvKGR3i1OOhAU7Jnp2Q==
X-Received: by 2002:a92:d609:: with SMTP id w9mr5884208ilm.46.1582913098663;
        Fri, 28 Feb 2020 10:04:58 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v3sm3320819ili.0.2020.02.28.10.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 10:04:58 -0800 (PST)
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200228165343.8272-1-elder@linaro.org>
 <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
Date:   Fri, 28 Feb 2020 12:04:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 11:56 AM, Jakub Kicinski wrote:
> On Fri, 28 Feb 2020 10:53:43 -0600 Alex Elder wrote:
>> Define FIELD_MAX(), which supplies the maximum value that can be
>> represented by a field value.  Define field_max() as well, to go
>> along with the lower-case forms of the field mask functions.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>
>>  NOTE:	I'm not entirely sure who owns/maintains this file so
>> 	I'm sending it to those who have committed things to it.
>> 	I hope someone will just take it in after review; I use
>> 	field_max() in some code I'm about to send out.
> 
> Could you give us an example use?
> 
> Is it that you find the current macros misnamed or there's something
> you can't do? Or are you trying to set fields to max?

I'm trying to validate variable values are in range before attempting
to use them in a bitfield.


I find field_max() to be a good name for what I'm looking for.

					-Alex

#define FOO_FMASK	0x000ff000

static u32 register = 0x12345678;

int foo(u32 value)
{
	if (value > field_max(FOO_FMASK))
		return -EINVAL;

	u32_replace_bits(&register, value, FOO_FMASK);
	
	return 0;
}
