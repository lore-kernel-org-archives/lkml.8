Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18850C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9498206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qs7njf8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHWCO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHWCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:14:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 19:14:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so2986476pfx.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0udEZhCWU7ToWHJZunuxqvCLux/ei03eZezxT8Juln0=;
        b=qs7njf8C37lXkdYSQLj0xx7W/7/x4pukOwdmBQi1Gn8WtrDcZLRvNI0OuM1EGzlc3S
         XZwUBIH9g1DE5JrSypNgNdS+qoTgwhG3DO9gVIXzgvG5J9M0tAUwRjvSdgs+FL8y8eBp
         cFc9XS1VLD3MiZNNccKSJQyxpq6DyhL4fpXwbas3hd9H2Glqwk+9hGUfEqAQUO2SOfmv
         WKiryB18qS9jO+MkoPwo/tlCwByMbY2rfUkd04abuKKxQJc9IzjqWeJamSyt9Gvvd76d
         Yj0aKr0YPkv769JIeoGiuwx7z1kWueTEYzfW2dC4Q/nv/sV4WdVcmnhHOLQ1VnqYcOxw
         ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0udEZhCWU7ToWHJZunuxqvCLux/ei03eZezxT8Juln0=;
        b=ul93UFjoVaal8301Yz0lStYLt1+UkgAuho1uBEW9fFxPjgnSTMy5XIiWnmaffhNtwX
         SBFNmDfB129BDSMi0Ipp+csCU4lKHa+WqhpmDw0AccRf6vU7dTvV/+CLtAzzFmqPHLbj
         npJgyp8t7jQeTiwAn1jvL4Axzs5+TShoe2h7aeU0MLnWL7FIMUPo9xp5APHOeuIEpMhc
         17VTEGUceKfTaDnj3cWzyFhEJ3rJU3vDWjIwfSuvIDp7o7QBIFG/sYsKP/7MbTd8q2Fv
         rQjs8zdV2Hh8uhuiAt5j0hmt7k3VdacqDyOWUbFQ0wVeFrKN8fu/PFnGVd+jgzBLZkMt
         jRbg==
X-Gm-Message-State: AOAM530aHU2gIkvgRabmN0XxMKH1yVvc1zUQMsZadB7VBYQe1nidX2/D
        TjI8rM1Z5MNWJJlCgjJRBKKh1CZYNLAE9MWQ
X-Google-Smtp-Source: ABdhPJyXb61tBnZjrGneUw4g+xGFZUW5XOdHyuqCoUosYIgRRqRu24A1hXJlXJeGK7+6NZXCpGgqCQ==
X-Received: by 2002:a63:4506:: with SMTP id s6mr28218pga.161.1598148861980;
        Sat, 22 Aug 2020 19:14:21 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t20sm6310242pgj.27.2020.08.22.19.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 19:14:21 -0700 (PDT)
Subject: Re: IOPRIO_CLASS_RT without CAP_SYS_ADMIN?
To:     Bart Van Assche <bvanassche@acm.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACGdZYL_bE2bamw_1uanwWByrCteNF=hmWYLH=VEVm9=R987ew@mail.gmail.com>
 <992ed2ed-f644-a5ad-3239-b38ddeafe28b@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b138bc8f-0062-3e0e-5838-bf73c09b40f0@kernel.dk>
Date:   Sat, 22 Aug 2020 20:14:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <992ed2ed-f644-a5ad-3239-b38ddeafe28b@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/20 7:58 PM, Bart Van Assche wrote:
> On 2020-08-20 17:35, Khazhismel Kumykov wrote:
>> It'd be nice to allow a process to send RT requests without granting
>> it the wide capabilities of CAP_SYS_ADMIN, and we already have a
>> capability which seems to almost fit this priority idea -
>> CAP_SYS_NICE? Would this fit there?
>>
>> Being capable of setting IO priorities on per request or per thread
>> basis (be it async submission or w/ thread ioprio_set) is useful
>> especially when the userspace has its own prioritization/scheduling
>> before hitting the kernel, allowing us to signal to the kernel how to
>> order certain IOs, and it'd be nice to separate this from ADMIN for
>> non-root processes, in a way that's less error prone than e.g. having
>> a trusted launcher ionice the process and then drop priorities for
>> everything but prio requests.
> 
> Hi Khazhy,
> 
> In include/uapi/linux/capability.h I found the following:
> 
> /* Allow raising priority and setting priority on other (different
>    UID) processes */
> /* Allow use of FIFO and round-robin (realtime) scheduling on own
>    processes and setting the scheduling algorithm used by another
>    process. */
> /* Allow setting cpu affinity on other processes */
> #define CAP_SYS_NICE         23
> 
> If it is acceptable that every process that has permission to submit
> IOPRIO_CLASS_RT I/O also has permission to modify the priority of
> other processes then extending CAP_SYS_NICE is an option. Another
> possibility is to extend the block cgroup controller such that the
> capability to submit IOPRIO_CLASS_RT I/O can be enabled through the
> cgroup interface. There may be other approaches. I'm not sure what
> the best approach is.

I think CAP_SYS_NICE fits pretty nicely, and I was actually planning on
using that for the io_uring SQPOLL side as well. So there is/will be
some precedent for tying it into IO related things, too. For this use
case, I think it's perfect.

-- 
Jens Axboe

