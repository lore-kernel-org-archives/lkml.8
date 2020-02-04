Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F3C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B362082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r12UGfNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBDOBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:01:10 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44187 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgBDOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:01:09 -0500
Received: by mail-il1-f194.google.com with SMTP id s85so12494126ill.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n0ZWkKfL1Bo/DyraO/d0oDEkbGINoDALNn/C6EtNwXg=;
        b=r12UGfNlXLswwkx7BMDc89j69q2rEzvMYdKCkc0yFzWjsPVu3B+5KwlUSaC2an6fnn
         jCIs5AN737+p+c2QBbQAwy8rUd1TrzEfk5KCixdLjag8/cgrhOznyBX16h/W/cvMK65z
         MV8CzAfm/x/CuQK9kd386n20dHcOh+nK6mftSZ0HcIVICi1qsxyhozue6s3Ot3Oa50Lc
         BFLwvqvz14HfNxU0xQD/UL01fEa05pUMHjKd4qUu897IIvMdrYPQJ+ppT2y7kjay2133
         /0cewr8CkwjwFAS0Ri+iEa0+muyNKlvj5eC1g7ym0raElkCNBMJX48hTntOfXqceLGq/
         ekwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0ZWkKfL1Bo/DyraO/d0oDEkbGINoDALNn/C6EtNwXg=;
        b=kPgAt9WW+XZ1JQl3dyjH8JFsifWD4gJ2y2TDW2IbkhzRPDeh09SOtPNcC3b7Rp61QK
         LEDUOn74sFqPRrNE2jk1qbpEntuWBzk3esKLfIBNc5JCwfonzkXCmNGHqHCX3c/8SlJT
         MiIx8DuAgMW1oQFXN3snt5avJB4C+7H4Lx4EwBaUyIcy8UMj5B4h2f4XTk2BeXCsVTCE
         eX8Vz7Sk/aOGo+Ml2BTyIrhKfTnrvq+GI0Uvuo4cdFjgxEkwZQGAKf+PaqsWIpj5GkYC
         Ri5VUNcIpMz8yehhGubGCacK6yd0KVscgBAmiIEt3dqhpek4O8m93qB8xQ6UMw46bEgY
         pkug==
X-Gm-Message-State: APjAAAUdklrzbXZkSL/dQvPcSs54mcFYpdOCyaspZwRzUNy3dFbTtMqX
        b7fS/2Yp/2qJIXdnJz88rCDfN+UwhV8=
X-Google-Smtp-Source: APXvYqzJDo7EXvOrE3u5xbMnRuYSvQbc+Z9ltsKU54Wiy1L5mPY2ZtdEYz/1GoxAFOblL0Y0y8iW3A==
X-Received: by 2002:a92:8f44:: with SMTP id j65mr27068384ild.144.1580824865871;
        Tue, 04 Feb 2020 06:01:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c19sm6726691iob.70.2020.02.04.06.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 06:01:05 -0800 (PST)
Subject: Re: [PATCH] Fix io_read() and io_write() when io_import_fixed() is
 used.
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <0cf51853bebe4c889e4d00e4bbc61fb3@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd164f90-f464-6c40-cb0c-9fd6e1ca98da@kernel.dk>
Date:   Tue, 4 Feb 2020 07:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0cf51853bebe4c889e4d00e4bbc61fb3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 4:20 AM, David Laight wrote:
> io_import_fixed() returns 0 on success so io_import_iovec() may
> not return the length of the transfer.
> 
> Instead always use the value from iov_iter_count()
> (Which is called at the same place.)
> 
> Fixes 9d93a3f5a (modded by 491381ce0) and 9e645e110.

What kernel is this against? This shouldn't be an issue
in anything newer than 5.3-stable.

-- 
Jens Axboe

