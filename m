Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B8DC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8792520679
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VilCGki/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBCEND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:13:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBCEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 23:13:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so5307567plj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 20:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIrUPTnZvDwUp0R7l94JshTdtBhQRESPBxjrDmzBrdM=;
        b=VilCGki/nsp0khzP7Z+TmtsWQMMqU+mbNC3ccbFitSDEf+1jKnXg4usCKBo++RDKFf
         MDsgSLjPhqltMgm6sqDYd6xMwPuCS7WO+oixZ77xwfvOaE0NFCNiD3T2GXORqS1NmDT4
         VKrBOz9qRANHpMIG2rlJutTaY9xi5eh7uwXORboNHOlMq7DZstA+qFek0wY6LlUNehLv
         4tBxdPkwZ19YEOz23nNe6zEtYjxfiA9dzEne9XUBNaQAtalgcKyfeTKbwXLSNGD86GET
         IzWR1/FPU36B6xicm4Z5KPfQ5zE4aLsKcx7NG4vNmK9RmECWGKfWNWpwhG1j28AvIZQe
         1vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIrUPTnZvDwUp0R7l94JshTdtBhQRESPBxjrDmzBrdM=;
        b=Be+CVvzeoWbr2PXqinqNOHKvNHpXjeH5m6Nk3y+oRu6nkzOc4HzpiK3YlRma7RnrJG
         fumX5ujQuMswHYKboC74aNCJW+xCckh5xWjUZ2R2CPZ8ZZJ3bzzZQelxaBi6W6M1ras0
         UF+5GbghVkNN8cQ3ULoDXOK1jnIsoGWYGJgBIquqAg7QOSXfWkq19xdgwn8azaJiR+cd
         nfJhBP4I1J9BbmrpW0k3UXcrYr2swimQdfxQiJCTZss8gv1GTa2D4H4XY7RUyoEIP6MV
         VAEVCdvUmDiHwpvo+UrtPLC2zuk2ILckKGlLhq7SsatQqM+w5A45TSVkwmqwMPJydDro
         htMQ==
X-Gm-Message-State: APjAAAUeR8mP0D1+G857oLNdLPAhbqrR147w4kpMpJdFURvy3aWJZfvh
        xsRkesw4GC/HtEcwASyc1/vtosVP9Q8=
X-Google-Smtp-Source: APXvYqxQZHCWlp5qmDphiuPsGQqccqa4TLIW+Tcop2vkbJNf3d28rxW0c3Fi9SkYBo50utQyV/WKGQ==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr27802458pja.132.1580703181309;
        Sun, 02 Feb 2020 20:13:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id l37sm18338795pjb.15.2020.02.02.20.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2020 20:13:00 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200203110426.6ceca414@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa90c06f-c0bd-7a32-b35e-85d71ffe3bf9@kernel.dk>
Date:   Sun, 2 Feb 2020 21:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203110426.6ceca414@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/20 5:04 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from drivers/vhost/vhost.c:13:
> include/linux/eventfd.h:43:22: error: unknown type name 'eventfd_wake_count'
>    43 | DECLARE_PER_CPU(int, eventfd_wake_count);
>       |                      ^~~~~~~~~~~~~~~~~~
> include/linux/eventfd.h: In function 'eventfd_signal_count':
> include/linux/eventfd.h:47:9: error: implicit declaration of function 'this_cpu_read' [-Werror=implicit-function-declaration]
>    47 |  return this_cpu_read(eventfd_wake_count);
>       |         ^~~~~~~~~~~~~
> include/linux/eventfd.h:47:23: error: 'eventfd_wake_count' undeclared (first use in this function); did you mean 'eventfd_signal_count'?
>    47 |  return this_cpu_read(eventfd_wake_count);
>       |                       ^~~~~~~~~~~~~~~~~~
>       |                       eventfd_signal_count
> include/linux/eventfd.h:47:23: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   9a9f718763cf ("eventfd: track eventfd_signal() recursion depth")
> 
> I have used the block tree from next-20200131 for today.

Doh, missed include, didn't fail on x86-64. Fixed it up, should work
tomorrow.

-- 
Jens Axboe

