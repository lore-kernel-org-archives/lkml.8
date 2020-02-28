Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6ABC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028DD222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB1TQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:16:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:49692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1TQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:16:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="385584427"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.14.243]) ([10.252.14.243])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2020 11:16:55 -0800
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Question about enabling trave_events on module load
Message-ID: <8107a684-3ade-2457-28e4-c7e29ab1b1f5@intel.com>
Date:   Fri, 28 Feb 2020 20:16:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

I bet that is not the first time said question is asked - that's for 
sure - but I failed to find a method for solving the issue, that is: not 
missing a single trace from the moment given module is loaded. Maybe I'm 
missing something or documentation wasn't clear enough and that's why 
I'm here.

If I am, please point to towards the right direction. Then you can slap 
me for not reading the documentation carefully.

"trace_event=" cmdline option seems to target built-in tracepoints 
_only_ so ain't much of a help to me. After digging the past for some 
time, I've found a very promising thread:
	tracing: Enable tracepoints via module parameters
	https://lore.kernel.org/patchwork/patch/240185/

Sadly, I wasn't able to find _that_ solution (or anything similar for 
that matter) implemented into the kernel.

So far, the only option I came with was separating traces into a 
built-in piece that declares all events upfront so "trace_event=" option 
has something to hook into. Said piece is of course made of a standard 
trace header file filled with macro usage and a .c file with handful of 
EXPORT_TRACEPOINT_SYMBOL(s).

While that solution could suffice, localization is the problem here - if 
a tree my module is built in is configured via -m, the built-in piece 
won't expose symbols at all and 'make' will leave me with bunch of 
"ERROR: <symbol> undefined" for every module my traces were used in. To 
fix the problem, I've relocated my trace .c file to /kernel/trace/. 
Finally it compiles and works as intended..

Not really satisfying, though. While there are some examples of 
subsystems keeping their trace .c in /kernel/trace (e.g.: 
power-traces.c), I don't believe that place is open for _every single 
driver_ to dump their trace sources into.

If indeed traces cannot be enabled on module load, then this is a gap.
While not everyone looked satisfied in the 9year old thread, I believe 
having the gap closed is important - and userspace can always be 
improved upon as time passes.


Thank you in advance for your input and time.

Czarek
