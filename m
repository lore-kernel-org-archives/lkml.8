Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA4CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BCB206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RG+hnEbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgGUPLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGUPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:11:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:11:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i18so16704511ilk.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TtuW/04TloS1NB/dHC1X7GqHd/JNsPJfPJ5kf68fL0=;
        b=RG+hnEbVnEZLYIhoEq3P/qS25v83EeM0lCkrH/UaTFYDBfV6sbTUD+oo9ORs6dw6gm
         0EKKSx2+/wqN+x6xbY0jm5aWdiI3SYq3Dex7GzozacLnKDzNblodKzzqp0z7MYP5jnk0
         PmoUMNOLiQRmGns+AWoFrFdCGuQA/eQk0IX+ZJGSmpOFo8h4ooB1XHLXao3AmWjIjsfh
         7LclEA8krqyv+owanQBYCGQ9LQtb3WhPPzXIXAe3QZAdygKZI3Yhd78Q+jxy/+4LgMyN
         TnbrojqYL6QImAKsEobrA5w6TjAOx+aV2S/drjYki2VTbsNR1BR/pOZm/ARgwV6q//uk
         zuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TtuW/04TloS1NB/dHC1X7GqHd/JNsPJfPJ5kf68fL0=;
        b=ESE10gtHir+h7LH898ivqcohqHHfQvj+ilRng5lMkxX8sU2gBRSRi3FRKmjm3vtF9P
         56lsSNX0tZGCw0sV/7xG5IT/595KOMmE8Sss4xdkCuG0HNZX3x4QD4xrB0puhVQME324
         TgWMBSVu5z6KD1Nv8UhUdC3g6rrgkE83bCdS3NFpIo4T/1JKbnB8c3tr1Xy9I7kBxzAj
         zd7aVisBue1J6ml8lbBgRQhuqz7Yr/6yVZOC7yM/oUozIWSI17gXOu1v4Ayi7Xs7aM1R
         hzxHFyuzQyiIFEzd7DgUaZMuL3f55WKcvii4YQt05DEu5JksP+NkGZwQLiZTtbI3QvPP
         omXw==
X-Gm-Message-State: AOAM531UzsDqw/T3y5kMKDRLRj/jZdwo5BPZwvlSxaj9BfMG5qQNrDXy
        lQAazjmh9t9v9lnTqM//qw1SHA==
X-Google-Smtp-Source: ABdhPJxIxxojy01TA5Kfy3vGATAhncgGbHv34+MpQsQr5TUWfX/orYO4mAruN1epadl77lVHjGEc7Q==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr29564102ill.26.1595344304098;
        Tue, 21 Jul 2020 08:11:44 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t11sm10597765ils.3.2020.07.21.08.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:11:43 -0700 (PDT)
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200721111131.bo3g6qkcvbhpupon@black.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16e40194-05ac-536b-303f-d2fd31493229@kernel.dk>
Date:   Tue, 21 Jul 2020 09:11:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721111131.bo3g6qkcvbhpupon@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/20 5:11 AM, Kirill A. Shutemov wrote:
> On Mon, Jul 20, 2020 at 04:51:44PM -0700, Andrew Morton wrote:
>> On Sun, 19 Jul 2020 14:10:19 -0700 syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com> wrote:
>>
>>> syzbot has found a reproducer for the following issue on:
>>>
>>> HEAD commit:    4c43049f Add linux-next specific files for 20200716
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com
>>
>> Thanks.
>>
>> __handle_mm_fault
>>   ->pmd_migration_entry_wait
>>     ->migration_entry_to_page
>>
>> stumbled onto an unlocked page.
>>
>> I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
>> perhaps something else.
>>
>> Is it possible to perform a bisection?
> 
> Maybe it's related to the new lock_page_async()?

Shouldn't be used for any of those paths at all, though of course can't
rule out a bug that triggers it somehow. A bisection would be nice.


-- 
Jens Axboe

