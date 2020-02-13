Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A7D218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="arqhuLqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgBMNfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:35:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34357 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:35:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so4311021lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWOsuSgQgOL7wag+7Zev3PUsMegHiG8hmXGzf91gx4A=;
        b=arqhuLqs/E6D16lkxGCHsGDvmVRl5t8HacQehp4Kn1EcoS1+CJNLzm7gsMOFzDWvC7
         DpALBVmLi5L7NS2eVOYRucGEcO0Rv8HQ9CtREqiBBnkxbm3dRVgAUuu0jYsQLH9bK29z
         5e6GPawBTyLK9rlvKBYi1tdT/GYjimkxb2B8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWOsuSgQgOL7wag+7Zev3PUsMegHiG8hmXGzf91gx4A=;
        b=mr5cE2C4tJtpQnDHQabyUcyY6qK6EKtL72Xu5JRI1Z5+QdXFqR74yYMoPh5r2eD6Pu
         YLGzOkhmE8g3YFNJXPsx66HEv2e0wjUz2Ck4QksGkNXlgirCAI7m2Ww2WVMAlO8eICzZ
         KUa1B5uuN45pJOdVoAWQVvO/VbUz19VlpR1cxyIPJ5zbxro+YevMyEeqtkJcqMjvX3st
         9GQr6Da67Ieask+Ni3LtuNCouBu4/i9QTzhiZeHlM7OkOjylCFB/trUVjScfCkz/ZuMW
         +AOQ3JQuRmIBGLsInYlH4LqS9195bHdThxQWj49v/D7CkI8tCvhqxOgIVVe4wPlGrbkp
         Hgjw==
X-Gm-Message-State: APjAAAX7fX+HndlKRshATxxN2gzJmIBrnLxrZJkkvmZiCKRYWNQdl79I
        YsqfTRtV6545YKTu19EAZuu6Og==
X-Google-Smtp-Source: APXvYqx3PElfBtYEI2+40feXtT0FWrIIVGFXM/JYc5sICaZISeJZIwZA/ZWXq+Y6aqF/Qg31Jd0Evw==
X-Received: by 2002:ac2:5e2e:: with SMTP id o14mr9546346lfg.198.1581600920427;
        Thu, 13 Feb 2020 05:35:20 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e25sm1420775ljp.97.2020.02.13.05.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 05:35:19 -0800 (PST)
Subject: Re: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
 <20200213125659.GB3325929@kroah.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
Date:   Thu, 13 Feb 2020 14:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213125659.GB3325929@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2020 13.56, Greg Kroah-Hartman wrote:

>> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
>> index 04733876c9c6..a8e1048278d0 100644
>> --- a/drivers/usb/host/fhci-hcd.c
>> +++ b/drivers/usb/host/fhci-hcd.c
>> @@ -396,6 +396,7 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
>>  	case PIPE_CONTROL:
>>  		/* 1 td fro setup,1 for ack */
>>  		size = 2;
>> +		fallthrough;
> 
> We have an attribute for that?
> 
> Shouldn't this be /* fall through */ instead?
> 
> Gustavo, what's the best practice here, I count only a few
> "fallthrough;" instances in the kernel, although one is in our coding
> style document, and thousands of the /* */ version.

Yes, I went with the attribute/macro due to that, and the history is
that Linus applied Joe's patches directly
(https://lore.kernel.org/lkml/CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com/),
so I assumed that meant the Penguin decided that the attribute/macro is
the right thing to do for new code, while existing comment annotations
can be left alone or changed piecemeal as code gets refactored anyway.

Rasmus
