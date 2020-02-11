Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D5C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711482082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM/OgekB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBKAYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:24:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBKAYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:24:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3499486plp.7;
        Mon, 10 Feb 2020 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QM57+kCt2YfV1qWeebY+xeJ7yy84SDCiwTrKa5DINCo=;
        b=CM/OgekBfS2/IRAj5wu0d0KwBkEjtQkIaUq9gBhcUF4aOcTlXhmINyqooS3pOw+24L
         UdrGVolFdKj+PUPQc1CFci3UFzhGWYESplsW/L1RxaonHGfb2Xz6TCcbl0OD3vy5N4Xd
         7h0A3nQJWI/8hNGYtcvIgyi7pGalUco35bmqNPA++/jYk8c6k03cph2QLUmNqs2Ykara
         CDhyzX1MmISuU6/7B7N7yoDhb8fbz32U2zGWgmVURvVRFVPTJuyJcVTGLW1Rnny8Dcea
         RrbjtS0QREMdtqK45S99M7MChb42yJmGsaU9xeJbB/CXO50K22UJDSbfQLbg7z2rTMV9
         pR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QM57+kCt2YfV1qWeebY+xeJ7yy84SDCiwTrKa5DINCo=;
        b=nM5YwWfMZWe9ZmSOk7W8pLvwODq5VF+T0bnsqJDZFYN6owysBUgHMFJuPDTs5GFSvi
         6i4PH/OSoLGz43B2KYgaxDeGJIaJJBFBpvHIbuNhqsnKmhE8rWemtRBdYZ5SBcgDc3/S
         bzyvcoX4UjGzE7hiTqYIhZXyrT0RRkYE8ZB12jweGrpPE19CwJXIXOUlqDe25vdJimu4
         DmzaumwJuzWA8TYrF++j9AsUnNIFLe/BwDILo8HYoBUvLdPyte/g7LEk/CJEF4aLubei
         lp5wb5i/IZseLkKju1ZhvjCrpNT/2DyFNW6yoJsqtcsC9Bvus8fLAJ+QGsOEo6QQrOJ3
         PAUQ==
X-Gm-Message-State: APjAAAVlGMKZEEf+EvgK8buynBWaxdYW/Trq1yEdoQiaHSJIzNKOxCO8
        ptQKYTOAuuFabMw3lTXDnsc=
X-Google-Smtp-Source: APXvYqzhGc5D2j/JUAxoedZIUFBv6qFILTodgWoDGx7UwaXELA1KCd96RLTf3CY7VaBzymzBd/8rEA==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr514755pjq.115.1581380685072;
        Mon, 10 Feb 2020 16:24:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm1630772pfq.110.2020.02.10.16.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 16:24:44 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>
References: <20200211092328.34ba4b9e@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <339eac27-8630-abf1-0202-f9e34193c2ff@roeck-us.net>
Date:   Mon, 10 Feb 2020 16:24:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211092328.34ba4b9e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 2:23 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/hwmon/axi-fan-control.c: In function 'axi_fan_control_probe':
> drivers/hwmon/axi-fan-control.c:419:26: warning: 'res' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    419 |   (unsigned long long)res->start, ctl->base);
>        |                          ^~
> 
> Introduced by commit
> 
>    690dd9ce04f6 ("hwmon: Support ADI Fan Control IP")
> 

Fixed up (res was actually leftover from an earlier patch version
and unused).

Guenter
