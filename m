Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EEC206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586460451;
	bh=DYfEZHLcUulm5Vk77nM7Rz8Z8YW0ea/Jhm1+Kl/oGxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I2dRSQn/YraJx0ad1zjz5r8cN7KCI1mV2k95wpSLvoz+Uw1wd78FMoAVXZ7Q9+Qmj
	 4CQMUHC5YjPpSoh9jiytDo+A0paRK9fHl8/DEaEogcTAKcmX4GwRkqoMASKjIPm9vj
	 pvAvS3Va35YEwIJ9o66IViZOKU6MnCv5Cv5JkWrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDIT13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:27:29 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36552 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:27:29 -0400
Received: by mail-qk1-f177.google.com with SMTP id l25so5273251qkk.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RG3gSBKGM8ltosSJXHmaTU9e/PnH4whIeagTJUsf01U=;
        b=qOvDR8mZ+R2P/pBCPur/uFS4KPcxxPU4GRNDbR2brI6PuFndGkz+pTeEnmzy2GeuSf
         KyxiXDY3TBfq2J9Z8HqMzuPzIWuzO4mqGvAigP0Y1025qKyDCoHRc3mhumePZD9eTfQg
         xrp+5XxJk4iMCC4DqA+1GkKqtCsAMZzf9b3lJHupmOT31GkSIB0mXjC31BbZi3lyqOWc
         9dGVeEl/zAoZEBrmCmI+56hjpS/Uj27e8j/V+LAIcvR3SHn6NRn8JLoBUEumjSM9SplX
         ks3VLxHF/wgzP0W2Ot1vMd9R3pgBoukZjIy0TvSQNenXEc1ZRKOEbf0H2SKVto+qVC/n
         Jbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RG3gSBKGM8ltosSJXHmaTU9e/PnH4whIeagTJUsf01U=;
        b=LfOL4jLAPV3i4bsKEJCu7AkodUozdRdFplEIYkI0LVG43Pq8NG+79MgO1103LoJsXr
         3lmjUjJR32oXiEA9nVib6YyFYe3tLiXJy+kJ4HZxeDTMZaPvbRYo25KWko/ZvlB+1VKx
         X9mgUQwEmzKamXH5ZbEvc5GP9rSdDVl3CrE6x4ObmV5JikuIgff34EORQhyiSsQH/Ak0
         mi1pl9NDeC+s2DCcbW3Bs584GiGctkYRPUeyAIdqiuuU/c1mUOvN25h+3j563MtC/Hw7
         nw0iya2Na8kpSxWfcOxJHgvyT9PWLJ0SAj48BMmo/w9LWb9HdFijQTv3OnYXsEh9nn4L
         sekA==
X-Gm-Message-State: AGi0PuZp09vIDBuuhyzcJ6I7h7oGj8Nu9Gx1sjujDKAVBQhd7DR1UyTq
        D8KrUXwxUBrmG4wA485iPeQMtRKpmfc=
X-Google-Smtp-Source: APiQypJpzwpF1vlLs8mzfP+ER3V87Q4QR+jmVn/Mg7qSl/ONPPZvQQB4y1GHmpNxecmiwKIlvbklug==
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr468315qke.65.1586460448590;
        Thu, 09 Apr 2020 12:27:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::74a8])
        by smtp.gmail.com with ESMTPSA id g63sm18324078qkb.89.2020.04.09.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:27:27 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:27:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409192725.GC37608@mtj.thefacebook.com>
References: <20200409154413.GK3818@techsingularity.net>
 <20200409175621.GA37608@mtj.thefacebook.com>
 <20200409182055.GM3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409182055.GM3818@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 09, 2020 at 07:20:55PM +0100, Mel Gorman wrote:
> > Given
> > 
> >    A    C
> >   ---  ---
> >    B    D
> > 
> > the code is trying to guarantee that either B sees C or D sees A, so it does
> > need full ordering.
> > 
> 
> Ok, still not particularly clear given where they are used and how
> it's related to updated_children but like you say later it's "kinda
> irrelevant" :)

Hahaha, yeah, just to make sure that I am understanding it correctly:

There are two parties - "updater" updating the local stat and trying to queue
itself on the updated list, "reader" walking the updated list trying to
collect all the numbers which changed since it last walked it.

There are two misbehaviors which can result from lack of interlocking:

1. If the updater puts itself on the list and the reader takes it off the list
   and then reads a stale value, the reader may end up reporting a stale value
   to user possibly breaking synchronity of events. This can be addressed by
   adding matching (data-dependency) barriers - wmb in updater, rmb in reader.

2. If the updater checking whether it's already on the list races against
   reader clearing it from the updated list, while the current on-going read
   is correct, the updater may incorrectly skip adding itself to the updated
   list and the next read may miss the event. This can be addressed by
   interlocking both directions - either the reader sees the new value or the
   updater sees itself cleared off the updated list - mb between stat update
   and "am I already on the updated list?" check in updater, mb between
   clearing the updater off the updated list and reading the stats in reader.

Thanks.

-- 
tejun
