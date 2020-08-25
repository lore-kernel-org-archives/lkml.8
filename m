Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7730C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8192074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vKEqLu4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYVMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:12:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1A/TzOrLz4/HTnGjqf5Jh0MWwKNMrSR3L1Aa04htfVs=; b=vKEqLu4uoyKAw9/vd4pI59Beoy
        Sbp0UbruoWDQ7onQ50L6HYl9YSSd40nz5S6KVpMC68c17NYmUd4TQJW+lRkWDxKm8wkdA5+ZFw3tL
        V/TnzS/y7Q2Yj6jHzU6AK8jT3QIudpdsebRx9/Z++VeZTw1fEFCVp6risVH7mSTu3p7Bo/llBlXzb
        zqYc705xzVDVXfQDBwRInhoT+TrNhU0WoD96WFvI2BKw2+NtaPWovfVmMLGC5uz+mwtGIy6SLHrx5
        BDjrYCUrytRPVvbJFhVBpTsYsI2keHdEvHdseMCN8D4yRP54tceJQfCDHkdzAp5YpVXOYRdxNZWzn
        wctFIGHA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAgEx-00034W-CP; Tue, 25 Aug 2020 21:12:23 +0000
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
 <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
 <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55b09be8-5bb2-60e3-8386-05bc9f6fd854@infradead.org>
Date:   Tue, 25 Aug 2020 14:12:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALaQ_hr-xuLJ3ZYHuvCaY7jLm7od1bgGQvgT0c6N16xTtdAD0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 25, 2020 at 2:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> so intel_rapl_perf is listed in your lsmod.cfg file:
>> intel_rapl_perf        16384  2
>>
>> You say Linux 5.8.3.  I'm guessing that your "make localmodconfig" tree
>> is Linux 5.8.3 (?).  What kernel version are you running?
>> I think that it's older, and some file/module names have changed since then.

On 8/25/20 1:34 PM, Nathan Royce wrote:
> Correct. I'm building for 5.8.3 and I'm currently on 5.7.4 (1 month
> doesn't seem particularly old).

Yes, things can change quickly.


I don't see any support in streamline_config.pl for Kconfig symbols
and/or modules whose names have changed.  Trying to do something
like that would be a never-ending job (a la job security).

At least it gave you a warning that it couldn't find a Kconfig symbol
for that module.


From your original email:
| I'm going to assume it has something to do with the naming and it's
| supposed to be associated with "Intel/AMD rapl performance events
| (CONFIG_PERF_EVENTS_INTEL_RAPL)" which I already have set to 'Y'.

Yes, commit fd3ae1e1587d64ef8cc8e361903d33625458073e changed the module name
since it now supports both Intel and AMD.


| Right below that, I also get 'Use of uninitialized value
| $ENV{"LMC_KEEP"} in split at ./scripts/kconfig/streamline_config.pl
| line 596.', but again that is the sort of thing that may warrant a new
| email specific to localmodconfig author(s). But again maybe not
| because I take it more as a warning given I don't make use of
| LMC_KEEP.


@Changbin: can you fix this little bug in streamline_config.pl, please? ^^^^^


-- 
~Randy

