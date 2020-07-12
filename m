Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30DF206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCYBCeRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGLP0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgGLP0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:26:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D97C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:26:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id u8so4726997qvj.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uend25YPFOnQbKCK1j3TxuFTPd3bY1/HgRlOuS1T8ZM=;
        b=bCYBCeRGw+X2u1RGKRiMYEIxtxYsEB41vmG34CMYdxAZutS6DWdUyRIyPxGsC9phA/
         KzyXl06ft3q9YIQ3sMnGNsNb7IzXZDU7hk4sqiVlXZE9F31dk5zg6L9CyP9e6XUTNEcS
         dMprJ+tjuOHMxmgGR6OJooOveufCSnz8l9u56srMoKeUqrGOIuwyfNo1cstOPpsSHAc3
         zWQawJpNcJOirFcQsqRZdwbYEfyBmOUyNb5yd8L2O7bIy4AwuDQuDpBiiIivqgzacaMX
         UxdsBd3uctFkfocs70w5Iadgvxfv5EujvdTXUfLrZKIpCahic9HSrpLha25wpoBZrtt7
         xVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uend25YPFOnQbKCK1j3TxuFTPd3bY1/HgRlOuS1T8ZM=;
        b=jVKVKRMyp1ZXLPt8CLY92vQOPZvbyVHDpz7/iHWP1RSqjXsPfzY0fjpp410xg8CmiA
         Ar89qDrovg6auvItJedDN/ebhKXD8WtZhp3bgqSxfvIog2TGCeNfOGip192WXGe1LyVU
         Jbrb6hcUn/7zS56fRRgsiIG8NLzIuI65DnfPvhXZLhBYjkunREnFJMr+JSFYIn/cM/Ll
         miUXyct0LMOMObTD9eYk1WMnVL006h7Em0k2ITx6ByriwzogRGe6XvDrGfyy1R7QT7/J
         P/kYG2cRIWC2kNZnrRMCBwPcJLmpAFsHaavdQM/BfaBwO2dPyOEb+6XkrFMN51/efKaU
         iFwg==
X-Gm-Message-State: AOAM531px2pucFqDxEliHmHa8S4fLno1E4zhYroQDV8IoMhAqHmxaNOS
        UCB2+JLuMmiIq0LQLLGeTA==
X-Google-Smtp-Source: ABdhPJx5A+6LxXBg+xrLALAwjS0uzVs9LrvnwEi/qedGHAnAX8yGEAkjpxEM1Ncq+eDqLrMvVUIDQA==
X-Received: by 2002:a0c:83a5:: with SMTP id k34mr75362120qva.130.1594567565992;
        Sun, 12 Jul 2020 08:26:05 -0700 (PDT)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id f54sm16691595qte.76.2020.07.12.08.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 08:26:05 -0700 (PDT)
Subject: Re: kvm crash on 5.7-rc1 and later
From:   Woody Suwalski <terraluna977@gmail.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     pbonzini@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        fenghua.yu@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <9178ae3e-db32-c64b-7caf-737f3bc3ba8e@gmail.com>
 <20200711182158.GF597537@hirez.programming.kicks-ass.net>
 <b1d4e747-0c6d-b9f8-d795-1f4ed9e2420b@intel.com>
 <1418b143-7563-9fd7-ad94-bfab86c0862c@gmail.com>
Message-ID: <73146755-764d-6f8d-e189-b1d36bba0d43@gmail.com>
Date:   Sun, 12 Jul 2020 11:26:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101 Firefox/60.0
 SeaMonkey/2.53.2
MIME-Version: 1.0
In-Reply-To: <1418b143-7563-9fd7-ad94-bfab86c0862c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woody Suwalski wrote:
> Xiaoyao Li wrote:
>> On 7/12/2020 2:21 AM, Peter Zijlstra wrote:
>>> On Fri, Jul 03, 2020 at 11:15:31AM -0400, Woody Suwalski wrote:
>>>> I am observing a 100% reproducible kvm crash on kernels starting with
>>>> 5.7-rc1, always with the same opcode 0000.
>>>> It happens during wake up from the host suspended state. Worked OK 
>>>> on 5.6
>>>> and older.
>>>> The host is based on Debian testing, Thinkpad T440, i5 cpu.
>>>>
>>>> [   61.576664] kernel BUG at arch/x86/kvm/x86.c:387!
>>>> [   61.576672] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>> [   61.576678] CPU: 0 PID: 3851 Comm: qemu-system-x86 Not tainted 
>>>> 5.7-pingu
>>>> #0
>>>> [   61.576680] Hardware name: LENOVO 20B6005JUS/20B6005JUS, BIOS 
>>>> GJETA4WW
>>>> (2.54 ) 03/27/2020
>>>> [   61.576700] RIP: 0010:kvm_spurious_fault+0xa/0x10 [kvm]
>>>>
>>>> Crash results in a dead kvm and occasionally a very unstable system.
>>>>
>>>> Bisecting the problem between v5.6 and v5.7-rc1 points to
>>>>
>>>> commit 6650cdd9a8ccf00555dbbe743d58541ad8feb6a7
>>>> Author: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Date:   Sun Jan 26 12:05:35 2020 -0800
>>>>
>>>>      x86/split_lock: Enable split lock detection by kernel
>>>>
>>>> Reversing that patch seems to actually "cure" the issue.
>>>>
>>>> The problem is present in all kernels past 5.7-rc1, however the 
>>>> patch is not
>>>> reversing directly in later source trees, so can not retest the 
>>>> logic on
>>>> recent kernels.
>>>>
>>>> Peter, would you have idea how to debug that (or even better - 
>>>> would you
>>>> happen to know the fix)?
>>>>
>>>> I have attached dmesg logs from a "good" 5.6.9 kernel, and then 
>>>> "bad" 5.7.0
>>>> and 5.8-rc3
>>>
>>> I have no clue about kvm. Nor do I actually have hardware with SLD on.
>>> I've Cc'ed a bunch of folks who might have more ideas.
>>>
>>
>> I think this bug is the same as the one found by Sean, and is already 
>> fixed in 5.8-rc4.
>>
>> https://lore.kernel.org/kvm/20200605192605.7439-1-sean.j.christopherson@intel.com/ 
>>
>
> You are right, kvm works OK on 5.8-rc4.
> The fix will need to be backported to 5.7.
>
> Thanks, Woody
>
I see it is already in 5.7.8. Great :-)
Thanks, Woody

