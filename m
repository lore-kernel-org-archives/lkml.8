Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C7C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60582072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbgDBPUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:20:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:46162 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgDBPUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:20:09 -0400
IronPort-SDR: fpgbcZoFPBopVCoOaJ6yuwkvXJMua+5qObOSorrdneHCeieWOFDBN4+ki9GyeXEC/K/htNuGXF
 SP0+wrocXtJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:20:09 -0700
IronPort-SDR: SnkEz5OyJ+NtvnY4nO2Yl2qLHSSAzAtmYe2C0f2byKCipNQvTSxMEjrbBWj9+JBIvcYcj2u1TA
 uisOTGCFQY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="328854200"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2020 08:20:08 -0700
Received: from [10.249.226.252] (abudanko-mobl.ccr.corp.intel.com [10.249.226.252])
        by linux.intel.com (Postfix) with ESMTP id CC6665802C8;
        Thu,  2 Apr 2020 08:20:06 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] perf evlist: implement control command handling
 functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <1760b862-7a4a-3930-1a53-04667c71cf6f@linux.intel.com>
 <20200402141729.GN2518490@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a1fd0e15-026f-6f84-ef82-9c01b7d9d48e@linux.intel.com>
Date:   Thu, 2 Apr 2020 18:20:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402141729.GN2518490@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.04.2020 17:17, Jiri Olsa wrote:
> On Fri, Mar 27, 2020 at 11:46:43AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +
>> +int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>> +{
>> +	int err = 0;
>> +	int ctlfd_pos = evlist->ctl_fd_pos;
>> +	struct pollfd *entries = evlist->core.pollfd.entries;
>> +
>> +	if (!entries[ctlfd_pos].revents)
>> +		return 0;
>> +
>> +	if (entries[ctlfd_pos].revents & POLLIN) {
>> +		err = perf_evlist__ctlfd_recv(evlist, cmd);
>> +		if (err > 0) {
>> +			switch (*cmd) {
>> +			case CTL_CMD_RESUME:
>> +				evlist__enable(evlist);
>> +				break;
>> +			case CTL_CMD_PAUSE:
>> +				evlist__disable(evlist);
>> +				break;
> 
> would CTL_CMD_ENABLE, CTL_CMD_DISABLE be better fit in here?

Makes sense. Let's have it named like the corresponding ioctls, for clarity.

> 
> especialy because we have the 'pause' ioctl for sampling,
> which I was thinking initialy you are using for record,
> 
> and it's still might be better fit for sampling than disable, no?

PAUSE_OUTPUT ioctl doesn't stop NMIs but it should be avoided 
in order not to affect workload execution during paused intervals.

PERF_EVENT_IOC_PAUSE_OUTPUT (since Linux 4.7)
              This allows pausing and resuming the event's ring-buffer.  A
              paused ring-buffer does not prevent generation of samples, but
              simply discards them.  The discarded samples are considered
              lost, and cause a PERF_RECORD_LOST sample to be generated when
              possible.  An overflow signal may still be triggered by the
              discarded sample even though the ring-buffer remains empty.

              The argument is an unsigned 32-bit integer.  A nonzero value
              pauses the ring-buffer, while a zero value resumes the ring-
              buffer.

~Alexey
