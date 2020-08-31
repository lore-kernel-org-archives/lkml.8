Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61305C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2DF20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d/Xt9cMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgHaQjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:39:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:39:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g13so6619860ioo.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qxtZ0Y0M2+LqAT+Q9A4ZqW2dKjL1ZSr0y2Kjk7DS69Y=;
        b=d/Xt9cMTocGYER1hMoLZcZKzfwFfkLWeGBJtTod7fH4LofpxuHyX8XgBITSqHqTrZE
         mWL+28n0lAmSZkhtlDr2UdAALCIFLj04okyYTvMM9rYWmh3BLf1+KujCUFGB3PfXHIcy
         SLaWNl2ACZfT0oDvl7are2bZurXdxkT+lFYpWmALN/1ogzbwKtsRBOWjSXhhKm34zQDU
         aowFvSwmUh3uyTKm2BtlJk59HchB04FJcW+6Nvc4aKBJRoFcq8kGmZhggtudJBs/zuNJ
         J+YTg5J2UX9fBOEJ5w/bCtbwZU9EzV52yRpW4isyMG0vZcpR3rpcfslztU9TdS2nbp3a
         FuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxtZ0Y0M2+LqAT+Q9A4ZqW2dKjL1ZSr0y2Kjk7DS69Y=;
        b=q8/NgHXE9f608wkF0MueRU5U56hWHufwb6SEHya5haQBzUb30C9Gwzax40AGQZnnWg
         v7L15Lqtf+NTe86O6WzCNMzmVqZMucTbWZRR5G/1uCI/p94CfBx2B2QT8J6NeyvSK102
         o+p8vyGvfwj0QQ/FPIr4JjHscVEb5y1WYtQzrSQm486qgTf3H3wJ4jBnVZMdZF/SAtaM
         dgLF+VvZN0JhutI6PwIZMjDeS9DjxDUAH6YQAxgcP66RKAJGIcLMVhQDXblVzmX9CRwg
         dhNqeAVJpRbV7IyYvPOyoNkfEQaYHsq+fDSId05DSl7iJaGIRhb8ZBgXYg0IGbKKkwmP
         LyDQ==
X-Gm-Message-State: AOAM533CGztxCi+YW5tJpLMZpGfaRzB9L+7IF0lvzoWQHiF87vFWUbu6
        cPbSY5zFTDDy7ay7e6u8ryOliI2gimGN38rR
X-Google-Smtp-Source: ABdhPJyGSlqq+En8CVd8IPR2hzBVNmnOqUoQtvyOHz4ImMgp7gfkld/uuEv+ZQ54ABXFHnRy9r8wGQ==
X-Received: by 2002:a05:6638:268:: with SMTP id x8mr2013732jaq.44.1598891967731;
        Mon, 31 Aug 2020 09:39:27 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k11sm4228924iof.40.2020.08.31.09.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 09:39:27 -0700 (PDT)
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
 <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
 <87o8mq6aao.fsf@mail.parknet.co.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
Date:   Mon, 31 Aug 2020 10:39:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8mq6aao.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 10:37 AM, OGAWA Hirofumi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On Sat, Aug 29, 2020 at 7:08 PM OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>>
>>> On one system, there was bdi->io_pages==0. This seems to be the bug of
>>> a driver somewhere, and should fix it though. Anyway, it is better to
>>> avoid the divide-by-zero Oops.
>>>
>>> So this check it.
>>>
>>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  fs/fat/fatent.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
>>> index f7e3304..98a1c4f 100644
>>> --- a/fs/fat/fatent.c   2020-08-30 06:52:47.251564566 +0900
>>> +++ b/fs/fat/fatent.c   2020-08-30 06:54:05.838319213 +0900
>>> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
>>>         if (fatent->entry >= ent_limit)
>>>                 return;
>>>
>>> -       if (ra_pages > sb->s_bdi->io_pages)
>>> +       if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
>>>                 ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
>>>         reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);
>>
>> I don't think we should work-around this here. What device is this on?
>> Something like the below may help.
> 
> The reported bug is from nvme stack, and the below patch (I submitted
> same patch to you) fixed the reported case though. But I didn't verify
> all possible path, so I'd liked to use safer side.
> 
> If block layer can guarantee io_pages!=0 instead, and can apply to
> stable branch (5.8+). It would work too.

We really should ensure that ->io_pages is always set, imho, instead of
having to work-around it in other spots.

-- 
Jens Axboe

