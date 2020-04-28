Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C78C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2CE2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF4mMFe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD1VWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1VWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:22:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47949C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:22:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so3328306wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wqo3QGpgGgY0n9F9GZsxVfmUGg34F9tMuEvp1gjIVao=;
        b=HF4mMFe3GSfYDUWCblAliFkmnqAyGsbrogQvgKuTcz4iWAlhYSLPMg6BSVInYJRrSP
         x9V6TlNLFAsYKKCqQqoKGGJyzdMR5V63y15fZ4451ROkAUCf36g+mf+0QoUss0L1ITeL
         eVpSXw+PPxzZLeNyWfx1Dm6mLfWPYohYzFATxotqJZKX4P0+5wzM4+pSB14CzHgMKbX2
         Cxjd7H44rIpUS+Um+ni/GChJH7QNk/pTAUqjxKugyrJFgWa4ZueIL2rKJL8/zMYXlGfs
         L1ksFbiR+eAlbnx0cpp/edYxCDGaVqGqh7by72SOneuz6W+Dz/Xe3jPDYB/jTiEX4KkP
         3m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wqo3QGpgGgY0n9F9GZsxVfmUGg34F9tMuEvp1gjIVao=;
        b=Any4Dd5Zw1ndw5Q0K9CBLhlOQSDcE78tEjYiq5AOCAm8S9RqaQIxZCCMZaHvAWQhts
         FfuTpRymP1GZURmdFTeX4hT6nEXDWICjPPspUzeh82t4BytYAtC9BX6rkRkbVYpovbLd
         2VV7tzXjaQFTykRvq4jbVrsKEAqQIUc4N/MRkv/n6uMvNjpwEWIt4beXK6gino++VYG0
         4MLwpiNo2PRIwDbRVwvuHyz0K6GVPh+tPut+6Mpc1z5ZC4WsiZ+Z4wWcmtbXsI0/qKWG
         5ZDv4GsLVflYqYBpLV5Oy9S8lehot9NrSkw5kJ/QF+ZeDmU9hBFDwJsdzha6d5ifPvXi
         zAEQ==
X-Gm-Message-State: AGi0PuZbMtEwVKrj30QjuZN/kdJhogTQBIlQ37k4utpjZKENFO0Fn2f5
        Fy7wKCiSV4wR6RcNmx7Q9fg=
X-Google-Smtp-Source: APiQypJtuqxSkz53Y3MQLIfR/2k5OFPQ//4L9pIAI/gKNXx6mjvBoLOYqyVAmr3ViO1IKBp6GQyRnA==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr6492624wmf.3.1588108952033;
        Tue, 28 Apr 2020 14:22:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a7sm4769244wmj.12.2020.04.28.14.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 14:22:31 -0700 (PDT)
Date:   Tue, 28 Apr 2020 21:22:30 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200428212230.3aobygpy62bto4gz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
 <87d07y2181.fsf@yhuang-dev.intel.com>
 <20200423131507.2rgrk3okh42oo6gh@master>
 <87r1wdzlm5.fsf@yhuang-dev.intel.com>
 <20200425003012.uuqh547feq3kz4y5@master>
 <87tv17xdfk.fsf@yhuang-dev.intel.com>
 <20200426211958.m7aheswirqaj2nte@master>
 <87d07tycfu.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d07tycfu.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:55:33AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Sun, Apr 26, 2020 at 09:07:11AM +0800, Huang, Ying wrote:
>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>
>>>> On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>>>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>>>
>>>> [...]
>>>>>>>
>>>>>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>>>>>scan_base need to be returned.
>>>>>>>
>>>>>>
>>>>>> When this case would happen in the original code?
>>>>>
>>>>>In the original code, the loop can still stop.
>>>>>
>>>>
>>>> Sorry, I don't get your point yet.
>>>>
>>>> In original code, there are two separate loops
>>>>
>>>>     while (++offset <= si->highest_bit) {
>>>>     }
>>>>
>>>>     while (offset < scan_base) {
>>>>     }
>>>>
>>>> And for your condition, (offset > highest_bit) && (offset < scan_base), which
>>>> terminates the first loop and fits the second loop well.
>>>>
>>>> Not sure how this condition would stop the loop in original code?
>>>
>>>Per my understanding, in your code, if some other task changes
>>>si->highest_bit to be less than scan_base in parallel.  The loop may
>>>cannot stop.
>>
>> When (offset > scan_base), (offset >  si->highest_bit) means offset will be
>> set to si->lowest_bit.
>>
>> When (offset < scan_base), next_offset() would always increase offset till
>> offset is scan_base.
>>
>> Sorry, I didn't catch your case. Would you minding giving more detail?
>
>Don't think in single thread model.  There's no lock to prevent other
>tasks to change si->highest_bit simultaneously.  For example, task B may
>change si->highest_bit to be less than scan_base in task A.
>

Yes, I am trying to think about it in parallel mode.

Here are the cases, it might happen in parallel when task B change highest_bit
to be less than scan_base.

(1)
                                                     offset
                                                       v
          +-------------------+------------------+
	  ^                   ^                  ^
          lowest_bit       highest_bit    scan_base


(2)
                                       offset
                                         v
          +-------------------+------------------+
	  ^                   ^                  ^
          lowest_bit       highest_bit    scan_base


(3)
                       offset
                         v
          +-------------------+------------------+
	  ^                   ^                  ^
          lowest_bit       highest_bit    scan_base

Case (1), (offset > highest) && (offset > scan_base),  offset would be set to
lowest_bit. This  looks good.

Case (2), (offset > highest) && (offset < scan_base),  since offset is less
than scan_base, it wouldn't be set to lowest. Instead it will continue to
scan_base.

Case (3), almost the same as Case (2).

In Case (2) and (3), one thing interesting is the loop won't stop at
highest_bit, while the behavior is the same as original code.

Maybe your concern is this one? I still not figure out your point about the
infinite loop. Hope you would share some light on it.


>Best Regards,
>Huang, Ying
>
>>>
>>>Best Regards,
>>>Huang, Ying
>>>
>>>>>Best Regards,
>>>>>Huang, Ying
>>>>>
>>>>>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>>>>>
>>>>>>>Best Regards,
>>>>>>>Huang, Ying

-- 
Wei Yang
Help you, Help me
