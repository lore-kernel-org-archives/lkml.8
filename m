Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C91C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1110520644
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="M7xEpjZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0ISe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgD0ISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:18:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7354EC061A10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:18:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so9919538wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nexsKNIAawz43xJ/+27exH8imkbeH1NfQDDNoT4uP+g=;
        b=M7xEpjZ3CessG+SINts/wDYLCwIEjZ4vyzamIT03NbDgDQXm+ZOncvEv2SnYwT6aIg
         t1+8LpZogfYOGM8hM5Tz6Yf5qJLRMrGdBROuGvMxDi/Q8ktk52fOF/q+xl0y73qhm5HI
         zftiw88FUwfmzj4EAsz+nQmqhzhCSc5x+MtGROadcU381AyVJwfq6DqCQIXzcyw738r1
         XqZzFXY1oZkg3bNwEJOXnfmxWG0/2pzBnQV4HNPIJeJixxQ5Vfe1k05lhwbd8/Eqm9yr
         /H2yQ+EOYTGig1gCYO+lUKlIlLkypKs9QMQZyixX30bsql7iQpFbenJF2PG2FMxU3oIR
         TvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nexsKNIAawz43xJ/+27exH8imkbeH1NfQDDNoT4uP+g=;
        b=WenyGEX9jw0NWm0zqffEZ/yhfRt/PGxn60kQCwuMoHjneJ7PwY+ibX9t4hv1HJi+zb
         WGBN41bK8XPGXsvwkOKp7GIxbNe77XBjoGMqQqEc3UU0u76UE6cCueGv+nGxVm6HvlxT
         +qQjmqRdFnbCHrpDdDtAmGqfQmOrNXHvUVpKyWKzltlTfDuwHquuOq+M2jLHqBLTfOlH
         kGp4JhEH44PGroM5hRLwAuDlGP2QpVYhPoq/h15stqulWyT4RLn0EZNwjvpqhfudmuy4
         6Y6lX/NX0kGJSD3v8WTtAc4DGjRm/omcYHvmjU2q+oKerhY4URUzWDvYceicSehyK83X
         ioug==
X-Gm-Message-State: AGi0PubTkR/Os4K2UB4GaynrLxzUoKcFddUl7cismVkVg/Jaf77M1fLv
        zF92XZ+A4eq0Dr37lmlS1/+iAA==
X-Google-Smtp-Source: APiQypLDYwqKL13+uGJEVkrYOMe2jJVaaMrDZ7cNTTbGJGhFOHOdAk1CPY8M9TMIs5nGg5KfyVuhdQ==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr23965375wmd.19.1587975512127;
        Mon, 27 Apr 2020 01:18:32 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id p16sm19639474wro.21.2020.04.27.01.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:18:31 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
 <20200427001234.GB29705@bombadil.infradead.org>
 <20200427022709.GC2005@dread.disaster.area>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <ac7728a0-c184-214a-70a9-ae219db72331@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427022709.GC2005@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattew and Dave,

On 4/27/20 4:27 AM, Dave Chinner wrote:
> On Sun, Apr 26, 2020 at 05:12:34PM -0700, Matthew Wilcox wrote:
>> On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
>>>> @@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
>>>>   
>>>>   	if (offset == 0 && length == PAGE_SIZE) {
>>>>   		kfree((struct orangefs_write_range *)page_private(page));
>>>> -		set_page_private(page, 0);
>>>> -		ClearPagePrivate(page);
>>>> -		put_page(page);
>>>> +		clear_fs_page_private(page);
>>> Ditto:
>>> 		wr = clear_fs_page_private(page);
>>> 		kfree(wr);
>> You don't want to be as succinct as the btrfs change you suggested?
>>
>> 		kfree(clear_fs_page_private(page));
> That could be done, yes. I was really just trying to point out the
> use after free that was occurring here rather than write compact
> code...

Really appreciate for your review, thanks.

Best Regards,
Guoqing
