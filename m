Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE321C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930A520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gn5l/IGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAaAZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:25:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39690 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgAaAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:25:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id 84so2359755pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8xT5Ubn9DukKbcAsd6bGB0RwaMzxXREbkgWWCe0L+g=;
        b=gn5l/IGF9KykwcBj18LcB42fliuaVC8HE2uZIhiPXHd7vSaKidkWEJDLlwFsu47suQ
         ChhAoRjB3EA8x8e1vKweoYrUtveNTjevaonAdsXTs/ukEc17iTAM2/Dfbn05WvonNpzj
         W25OT71K00u1D6/dQdcdyskAWuH6fZhxOZIks8A3cHxxE1bEWL2McEbE2aqZ1My7Iph2
         lLN9yezgmPlqHo9O9PnbTmmWHllXO/KpOLpWKnOGNcguh4WO1Vg8DIp6nZuzVJGIcX4Q
         lNQYq3u0FdgJkx47IRYQ/eFMnwiOToO+vMjNW5osyXtgQ4ymm9K6di+vmmnHh37MqvaC
         pa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8xT5Ubn9DukKbcAsd6bGB0RwaMzxXREbkgWWCe0L+g=;
        b=XTHKodWtEe0+kB33MKkOwb6nrSf91h+axMhviDx0kR0M1G2y6M2487gIrzkVo93tKR
         jsjvV6FoHUkyrldavEdJRCt0dDconNK0qXyVARyGAMu3VqPysH3a3Nts1Og5UUC/yCft
         cLyLbS9+SqHWPXaxxXixsngmZmCb3AA3lOU5Ik3RCw1Wmd/vU4u5Li9xz97TLSNMNp0h
         pn0MhTb7kPq1h/Iw7w6Qk/IeZFba24HBUnY4tt+9aHtPm5vFdIn1aE2jPA3unzBgWnxu
         e9Hxe//TCYhSzn9x2ZuKjfDiEX1ZiaFs4tPSP3mIpVZbOXKjgzqbbeVqiZDG5nQ+WZfU
         mJ3w==
X-Gm-Message-State: APjAAAXHGvE3Pvlu6DD6+YxVPkgopGjtr7ChpJ9nVelQj2xjgnMc3Hzi
        7o3L+L24FODNwYpo9c4/tSDdkDJDyx8=
X-Google-Smtp-Source: APXvYqxu/vmouCWvTcNoQCm3tuieIQqBPvowtVLmEaSEsTTgeENnXXU90/k+hG41yffYs88+YfpKLw==
X-Received: by 2002:a62:4d87:: with SMTP id a129mr7607326pfb.116.1580430355699;
        Thu, 30 Jan 2020 16:25:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y10sm6449165pfq.110.2020.01.30.16.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 16:25:55 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200131111652.6995fc6d@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3652266-3e13-9aa8-887e-9f7a69f57285@kernel.dk>
Date:   Thu, 30 Jan 2020 17:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131111652.6995fc6d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/20 5:16 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> fs/io_uring.c: In function '__io_uring_show_fdinfo':
> fs/io_uring.c:6558:32: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>  6558 |   seq_printf(m, "%5u: 0x%llx/%lu\n", i, buf->ubuf, buf->len);
>       |                              ~~^                   ~~~~~~~~
>       |                                |                      |
>       |                                long unsigned int      size_t {aka unsigned int}
>       |                              %u
> 
> Introduced by commit
> 
>   0380f1b6d0c6 ("io_uring: add ->show_fdinfo() for the io_uring file descriptor")

Thanks, did fix that up, forgot to push to for-next... Will rectify that now.

-- 
Jens Axboe

