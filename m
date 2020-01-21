Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6B24656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9Yu3+P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAUVTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:19:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728741AbgAUVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579641578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUDc746gEw7bmqdrDee21GPcvrO5Acs+G0v791qb43c=;
        b=S9Yu3+P3dLrjAR0ppmzmmGFvZZLAxmuqWcSDg1CU4pamGDSk/tCUOFGOgKxI67dkp715zC
        LoJjriDv/mt7c+B2cnmaUz5IPSURqu9taw+sXq0GbPc08LPUzCcChh4gIap8xLZRt8kit5
        79JZzmnJiDIR5YucLWQf3zA8k7haDnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-Gi9gd13EP7WRgH7trcvLnA-1; Tue, 21 Jan 2020 16:19:36 -0500
X-MC-Unique: Gi9gd13EP7WRgH7trcvLnA-1
Received: by mail-wm1-f69.google.com with SMTP id s13so35536wme.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 13:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUDc746gEw7bmqdrDee21GPcvrO5Acs+G0v791qb43c=;
        b=r6YLqex6pew4Ag0exNhqmYqeOvytb+WRBCPskzgZ+vWais9vUr73y/g81GaGs033I1
         /YPe4lCr595W3s7GPwt4DyfCcZ4GWb5Vn82knUCLGVEZYw7J+wHBHqddhRqz2Lf+Qidv
         5KelIzm4WKZV5LsnjhAAkeajvb2Ig6mFmNeKv5rOQcAiME0f6K40pXaghe517u0/3spl
         a2xLV9MUZqdJknKby1O4PU8ECcWfpd1tqtRRxRkR3pWIuQaYzPnFU5umvN/LfmCJ6p07
         JrTJxJvoYvUQNL+DcBvZG+qIfIXO4Qm9pP8G6NszyOYuRMQZRC9bScsCLA6B1ifTm7ib
         2IMA==
X-Gm-Message-State: APjAAAWGTSuxCOgXyTQkXo7/U0XtiS4HAV5aoPhmasnAH2pSCJYYHbfG
        pqp770OPzG2f5i1J1OA+wAZ1DwqHw8oyJsY1dOCkjNdySY2t14V+D83YbKM1SQ7cKhfFiIksBWG
        OuodUOTomTyS0YyHMSzvLCjkw
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr7108163wru.52.1579641574577;
        Tue, 21 Jan 2020 13:19:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoPnkxLxUGe7WRD6VylEoIv+x6W5+cow3h5Z9Uz8mj37YpcfxZ7pVN18YIIyxft0zVUg14Tg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr7108137wru.52.1579641574308;
        Tue, 21 Jan 2020 13:19:34 -0800 (PST)
Received: from x1.bristot.me ([83.136.205.253])
        by smtp.gmail.com with ESMTPSA id v22sm872400wml.11.2020.01.21.13.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:19:33 -0800 (PST)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <20200121135034.GA14946@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e10414a6-dbfc-a666-18b8-a0499c93a203@redhat.com>
Date:   Tue, 21 Jan 2020 22:19:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121135034.GA14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 2:50 PM, Peter Zijlstra wrote:
> On Tue, Jan 21, 2020 at 02:29:49PM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
>>
>>> +/*
>>> + * Controls the threshold for the number of intra-node lock hand-offs before
>>> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
>>> + * another NUMA node. By default, the chosen value provides reasonable
>>> + * long-term fairness without sacrificing performance compared to a lock
>>> + * that does not have any fairness guarantees. The default setting can
>>> + * be changed with the "numa_spinlock_threshold" boot option.
>>> + */
>>> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
>> There is a distinct lack of quantitative data to back up that
>> 'reasonable' claim there.
>>
>> Where is the table of inter-node latencies observed for the various
>> values tested, and on what criteria is this number deemed reasonable?
>>
>> To me, 64k lock hold times seems like a giant number, entirely outside
>> of reasonable.
> Daniel, IIRC you just did a paper on constructing worst case latencies
> from measuring pieces. Do you have data on average lock hold times?
> 

I am still writing the paper, but I do not have the (avg) lock times. It is it
is in the TODO list, though!

-- Daniel

