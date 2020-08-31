Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8952071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHaNdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:33:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:25348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHaN2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:28:40 -0400
IronPort-SDR: 30MqgE3vaJIDvUvR0a/xUyIm60Gs1ocCEKZuaoeOwovJWINkzSGF48pADUGA9/jbguT7sHq1lg
 3Q98Rtk5wBuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241777786"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241777786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 06:28:31 -0700
IronPort-SDR: 0a6RGUdFd+sq21CVvn9Wa8r3qdq8zINIwWTh3WaR5k6tS+7E1dxa8yrM/u9Ep82tNl+279rtDx
 B7Fxos0AYCww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="476726708"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2020 06:28:28 -0700
Subject: Re: [PATCH 4/6] perf tools: Add FIFO file names as alternative
 options to --control
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200829105015.10800-1-adrian.hunter@intel.com>
 <20200829105015.10800-5-adrian.hunter@intel.com>
 <20200831131927.GD406859@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <660d6f71-f34d-dd3d-bc3d-3d2b9e868267@intel.com>
Date:   Mon, 31 Aug 2020 16:27:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831131927.GD406859@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/20 4:19 pm, Jiri Olsa wrote:
> On Sat, Aug 29, 2020 at 01:50:13PM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>> +		*p = '\0';
>> +
>> +	/*
>> +	 * O_RDWR avoids POLLHUPs which is necessary to allow the other
>> +	 * end of a FIFO to be repeatedly opened and closed.
>> +	 */
>> +	fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
>> +	if (fd < 0) {
>> +		pr_err("Failed to open '%s'\n", s);
>> +		ret = -errno;
>> +		goto out_free;
>> +	}
>> +	*ctl_fd = fd;
>> +	*ctl_fd_close = true;
>> +
>> +	if (p && *++p) {
>> +		/* O_RDWR | O_NONBLOCK means the other end need not be open */
>> +		fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
>> +		if (fd < 0) {
>> +			pr_err("Failed to open '%s'\n", p);
>> +			ret = -errno;
>> +			goto out_free;
>> +		}
>> +		*ctl_fd_ack = fd;
>> +	}
>> +
>> +out_free:
>> +	free(s);
>> +	return ret;
>> +}
>> +
>> +int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
>>  {
>>  	char *comma = NULL, *endptr = NULL;
>>  
>>  	if (strncmp(str, "fd:", 3))
>> -		return -EINVAL;
>> +		return evlist__parse_control_names(str, ctl_fd, ctl_fd_ack, ctl_fd_close);
> 
> do we want to mention somewhere that the fifo name is everything
> except for 'fd:' ?

It is only mentioned in the documentation i.e.

--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -627,7 +627,9 @@ option. The -e option and this one can be mixed and matched.  Events
 can be grouped using the {} notation.
 endif::HAVE_LIBPFM[]
 
+--control=ctl-fifo[,ack-fifo]::
 --control=fd:ctl-fd[,ack-fd]::
+ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
 Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started with events disabled using
 --delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor

> 
> also how likely is that we will add another channel type that
> will need another keyword (likd 'fd:')? I originaly thought
> we'd use 'fifo:filename' for this ... would be great to somehow
> avoid future confusions

Sure, I will add fifo: in V2



