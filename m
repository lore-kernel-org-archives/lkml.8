Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F706C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159E620661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f7Z/dQWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBDOHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:07:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38944 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgBDOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:07:03 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so21025034ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W4lLUrDIIX+rWx9u4syymGkAUYdtYfWSlqq4G1nIF0s=;
        b=f7Z/dQWifxeAqa76tIV5UG6gJPB2p1keyqaKb3RPxsIiK3cLSh/vEft+WHfs0eqknN
         GUBt9dX8A+11CDLM2qGU6kkuEOsEM566jm0DEbzK7iPzaJ7IHYtkcxOT4MnmEPHtWxYj
         uBatm2Wi8YzOFnYC6IZpaqs0MJCRxOjwAd+mu4ygP5lXJRLSkkOfkRXfUr/LVwSI48St
         Oj1wfo8PT7B+Eaq8+3vsU7ogYFRWlaUDVSHgLpMd1NXoyVizP7ndqNyGwrOSm/336s2g
         wKOQ+DHPQZ2M5R0pUnKYIX5rCtyhk1tboF39CRrR0zCdJbRW5S1cQvq0qSWY7tH4iVmJ
         t+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W4lLUrDIIX+rWx9u4syymGkAUYdtYfWSlqq4G1nIF0s=;
        b=pUMRYUBbTd1yrYumEOKuLFsEUcxO4ucUrczWyQVyBW11N3ky3bGKCRXWFVpk+ND2BB
         juScYmhRtpBC1bDa+l7S1mh9utzdhwaQv+Z5FszkkWlSCCvPT5aSqbQyQNspilO5+dNV
         qKw8OqLXir06sKaHugbdoilgm/QMqmExsfNoz04JS6gB5BFwCpZI2PEnoCVJrDEdOuuO
         WO+c4r8/4dmzbBaKQmQ9Aa10GsIzEofJlSBr/9XHEvZLR0ELHt3oHfomHwdmBBHinzmt
         PjzIV4KI1dfnoBmYeufuNZ7UXo9jwmFowxNY4SGvu9wrHt/VuaDA2AUQ28HWZPdqGApd
         rnoQ==
X-Gm-Message-State: APjAAAWUFH4/Q15RZ+5HbgpiDVKnPD2Ny4sd1rd2m/Sm2RwpYN+VNStj
        RhBcTL6H3crhK1pBuw+8EQz7+VEiIfY=
X-Google-Smtp-Source: APXvYqxBvirCD+6eRgfU3gjK99UNE8vzCOv4lwGnRydaxvUfrz15otwdsKrHu1V61bJR2N+DQfduvw==
X-Received: by 2002:a6b:ac45:: with SMTP id v66mr23742889ioe.76.1580825221368;
        Tue, 04 Feb 2020 06:07:01 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f21sm6726083ioc.31.2020.02.04.06.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 06:07:00 -0800 (PST)
Subject: Re: [PATCH] Fix io_read() and io_write() when io_import_fixed() is
 used.
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <0cf51853bebe4c889e4d00e4bbc61fb3@AcuMS.aculab.com>
 <bd164f90-f464-6c40-cb0c-9fd6e1ca98da@kernel.dk>
 <3d5daf51252846cb851bf37d18842c4c@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0db5b894-1914-1970-677e-01cdb8c93254@kernel.dk>
Date:   Tue, 4 Feb 2020 07:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3d5daf51252846cb851bf37d18842c4c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 7:05 AM, David Laight wrote:
> From: Jens Axboe
>> Sent: 04 February 2020 14:01
>> On 2/4/20 4:20 AM, David Laight wrote:
>>> io_import_fixed() returns 0 on success so io_import_iovec() may
>>> not return the length of the transfer.
>>>
>>> Instead always use the value from iov_iter_count()
>>> (Which is called at the same place.)
>>>
>>> Fixes 9d93a3f5a (modded by 491381ce0) and 9e645e110.
>>
>> What kernel is this against? This shouldn't be an issue
>> in anything newer than 5.3-stable.
> 
> Sources are 5.4.0-rc7.
> So not entirely 'the latest'.
> I didn't update late in the 5.5 cycle and won't until
> we get to rc4 (or so).

Ah ok, I think that's why. 5.4-stable will have a fix, 5.4.0
probably not. 5.5-rc and forward should be fine.

-- 
Jens Axboe

