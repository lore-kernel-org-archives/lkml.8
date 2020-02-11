Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E24C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409BF2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VO6oLe3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBKDzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:55:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45104 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbgBKDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:55:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so8375132qko.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 19:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6HJ00E5SaMJNd5jovvaBQPAR0zDWE5jfRsYbSlTxML4=;
        b=VO6oLe3NkOb/LbLNPK1KR16jo0KlzLn1LJ5uVe4IuhOO3oxJFJZsm+spOrlR3bt+oa
         hZn7blI23Icaz1LM4HTjXmprpS/J5mXdVnrn/l0ii0a6oJ///z8lMLQrnA+pWoD9LtI/
         mKgCRwf/JaMT6Ai4t3nQfYdPKkp5kds36lrdwOlFWgRIIQpGXiLLaDQiiEhLvf4GMb/P
         cNTiigB2wP4MmELLeMhWBgVFKpR0oCP91rrINsHY73xYwSVOywyPV/KxgLxnbGZwAJL1
         LTPnTB5shlCi6HqgPrVMYNWtt4sD4mnDy+fINpwKZL6hp/1/f7Op+5tdAwHuD0Q8kZjK
         2nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6HJ00E5SaMJNd5jovvaBQPAR0zDWE5jfRsYbSlTxML4=;
        b=q7vna0Zetpv9hViYPcmvQYgJiW+Q+GtUB2tiJCR0OZBDBbpv6aNGUTuwnnR4cw/5tu
         Bs9KndzOByxuFa6Y2kjmvmwic2J62tU/l8gOKQIkDZjfknPbnNL2SWJbUZM3VdDA5p6G
         Sd4qhddNx3k5kPKTihq15H6zDb73AdEQohVqOLfXZICdo8cxW3rB7Z/UQxg0AOvoRFz4
         uf4E36enwgclwEdBu7UydTJkSAqp5a2X5honpNnQXCEzcaFIh0597Y6uauJN0oS/7aZb
         6EANjDSh7kNtP3lU31pF71r6mE3DDQPvfdvJSJ+tN3G1zCkjznP4PKYoFgzwSPKqY4dJ
         OrHA==
X-Gm-Message-State: APjAAAV5XC1cYW8YUW7DZAZgeC0E18KhnRmWfXTIKYW/777GIrQJtyQW
        iZyykYJIEX18/+2loi7KZj+g+g==
X-Google-Smtp-Source: APXvYqx8bxSLg1xrPhfvR/4ejVl1qRQWHN8fmi2yNwQgrBpbmQV+hAjmIguunvgGgizIY+zk/9M0og==
X-Received: by 2002:a05:620a:108f:: with SMTP id g15mr1028131qkk.321.1581393346926;
        Mon, 10 Feb 2020 19:55:46 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f59sm1355949qtb.75.2020.02.10.19.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 19:55:46 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] mm/filemap: fix a data race in filemap_fault()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200211034900.GQ8731@bombadil.infradead.org>
Date:   Mon, 10 Feb 2020 22:55:45 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EFC8936-4569-418F-82EC-6F7868BEEAE2@lca.pw>
References: <20200211030134.1847-1-cai@lca.pw>
 <20200211034900.GQ8731@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 10, 2020, at 10:49 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Mon, Feb 10, 2020 at 10:01:34PM -0500, Qian Cai wrote:
>> struct file_ra_state ra.mmap_miss could be accessed concurrently =
during
>> page faults as noticed by KCSAN,
>>=20
>> BUG: KCSAN: data-race in filemap_fault / filemap_map_pages
>>=20
>> write to 0xffff9b1700a2c1b4 of 4 bytes by task 3292 on cpu 30:
>>  filemap_fault+0x920/0xfc0
>>  do_sync_mmap_readahead at mm/filemap.c:2384
>>  (inlined by) filemap_fault at mm/filemap.c:2486
>>  __xfs_filemap_fault+0x112/0x3e0 [xfs]
>>  xfs_filemap_fault+0x74/0x90 [xfs]
>>  __do_fault+0x9e/0x220
>>  do_fault+0x4a0/0x920
>>  __handle_mm_fault+0xc69/0xd00
>>  handle_mm_fault+0xfc/0x2f0
>>  do_page_fault+0x263/0x6f9
>>  page_fault+0x34/0x40
>>=20
>> read to 0xffff9b1700a2c1b4 of 4 bytes by task 3313 on cpu 32:
>>  filemap_map_pages+0xc2e/0xd80
>>  filemap_map_pages at mm/filemap.c:2625
>>  do_fault+0x3da/0x920
>>  __handle_mm_fault+0xc69/0xd00
>>  handle_mm_fault+0xfc/0x2f0
>>  do_page_fault+0x263/0x6f9
>>  page_fault+0x34/0x40
>>=20
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 32 PID: 3313 Comm: systemd-udevd Tainted: G        W    L =
5.5.0-next-20200210+ #1
>> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS =
A40 07/10/2019
>>=20
>> ra.mmap_miss is used to contribute the readahead decisions, a data =
race
>> could be undesirable. Both the read and write is only under
>> non-exclusive mmap_sem, two concurrent writers could even overflow =
the
>> counter. Fixing the underflow by writing to a local variable before
>> committing a final store to ra.mmap_miss given a small inaccuracy of =
the
>> counter should be acceptable.
>>=20
>> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>=20
> That's more than Suggested-by.  The correct way to submit this patch =
is:
>=20
> From: Kirill A. Shutemov <kirill@shutemov.name>
> (at the top of the patch, so it gets credited to Kirill)

Sure, if Kirill is going to provide his Signed-off-by in the first =
place, I=E2=80=99ll be happy to
submit it on his behalf.

>=20
> then in this section:
>=20
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> Tested-by: Qian Cai <cai@lca.pw>
>=20
> And now you can add:
>=20
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

