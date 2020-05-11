Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3BB20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WkH6I4MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgEKP20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgEKP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:28:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:28:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u15so134379plm.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sU6/Ap1ejE6vLfYumdjwgHoh2Gd0VUeSHIvSaou8lbY=;
        b=WkH6I4MXB4YwCmjTwfC9sYSwt75AgJ+dqhYinn/45vvg7OHLvtfhBrLP8vBgxvEfhf
         tuLrZuazYIHXGpIvEqWrLUIGPplFgTesIX+FvwDKx8QYQgDfeDrTcEnYtl5snfKUqOb4
         +27RxtciXPvLwM6njCKRBqpsb9ffD0AsaauSLROIkeCDVEergyaYGoHx62blUScRW10A
         WzD0iLST7rdFLY0Yrkv2UHmXsqXXTdCcM9BuzAIwJ+6UvAVR+fTahnWlOVV9d6xc4o5g
         rUVVFlL36ApWWGBYHi2V6M/pmnu1jHrT7oEdXuL+bpCgMhMLchnz4SVJVfWUxlY7a2SJ
         /yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sU6/Ap1ejE6vLfYumdjwgHoh2Gd0VUeSHIvSaou8lbY=;
        b=TcIMUYaF0wV+Llf/rGiu8V6II5Iix/a5I1OJsAY1JbxOOvFWbputjq80MTPR0N0TNe
         ekGnnOoX76+4Sglce5j0HoG+zgpViCmJHVrzmu3xpHra6GvX+6PmYbWy8OskqGlj+VvJ
         9QwHFyvJ0xge4iamnNmLaorSQxFwndjdc05esSHFLw20Gp+YhO8z3ULMOdmdAeq8yXDI
         9lFIK+JH59vE9jWV1AHhn7dmaV8LigmA938Ty9FlcYXDyTuu9EEtaYsJpLjazdeOOJXx
         y7W3iwg1lRQk9T2aR8Wv+L60965Lv9bKuzh3wd8Tg4P1ydCr+LlT5Cp/0QIb8lrvR+/M
         xHTQ==
X-Gm-Message-State: AGi0PuZF0iCtuDN7g1CDPobLRgOpUPMLPvR0Hml6XV2b1QlfjxkHpP31
        WEbpSmJ0yuA61TYmqzXs8wjHHHAuGeE=
X-Google-Smtp-Source: APiQypJ839OdEAVyroEW6HDW3lotjBrNt50hVB0MDGzX9Xkb+EriFzeC7/X6yWfaIRwuKdO5G74DuQ==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr15384209plb.243.1589210905743;
        Mon, 11 May 2020 08:28:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2dd6:4c58:486d:263e? ([2605:e000:100e:8c61:2dd6:4c58:486d:263e])
        by smtp.gmail.com with ESMTPSA id y7sm9563873pfq.21.2020.05.11.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:28:24 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200511142756.1b7ef706@canb.auug.org.au>
 <74a0ddc6-8637-c821-7128-4431261b0c12@kernel.dk>
 <20200511151749.GA29295@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20234840-c9f4-1e68-14f1-57b1ccd1c730@kernel.dk>
Date:   Mon, 11 May 2020 09:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511151749.GA29295@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 9:17 AM, Christoph Hellwig wrote:
> On Mon, May 11, 2020 at 09:06:41AM -0600, Jens Axboe wrote:
>> On 5/10/20 10:27 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the block tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> drivers/block/aoe/aoeblk.c: In function 'aoeblk_gdalloc':
>>> drivers/block/aoe/aoeblk.c:410:21: error: 'struct backing_dev_info' has no member named 'name'
>>>   410 |  q->backing_dev_info->name = "aoe";
>>>       |                     ^~
>>>
>>> Caused by commit
>>>
>>>   1cd925d58385 ("bdi: remove the name field in struct backing_dev_info")
>>
>> Gah, thanks Stephen. This series is looking less and less impressive,
>> fallout for both 5.7 and 5.8, in terms of build testing (none).
> 
> And the sad part is that it has been sitting out there exposed to the
> buildbot for weeks.  Sigh.

Indeed, I do wish the build bot was a bit more expedient (as in 24h turn
around would be good), and reliable. Seems hit or miss, don't fully trust
it and this series is an example of why.

-- 
Jens Axboe

