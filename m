Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0922072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:56:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:30095 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgETO42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:56:28 -0400
IronPort-SDR: wxiIDAoZ4m6hb5vTYNX1bedkJEjNHqIH4Wt2T/FNKrka7FHta6QXU0Lvb3RQ/5v7rqDVkgGY8V
 xiW7V6KjCQWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 07:56:28 -0700
IronPort-SDR: Rh6lb+FSju5UaS+4nFzb30lu/Hb4am82atJLR48s10oGeGNSERWVWza7PZvMwhaQFA4zCngZ1w
 cd681tCEA0+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="308744482"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 May 2020 07:56:27 -0700
Received: from [10.249.231.6] (abudanko-mobl.ccr.corp.intel.com [10.249.231.6])
        by linux.intel.com (Postfix) with ESMTP id E2B91580100;
        Wed, 20 May 2020 07:56:25 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] perf evlist: implement control command handling
 functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <ffcdb43a-8f7d-b16f-d59b-19293037af84@linux.intel.com>
 <20200520123807.GD157452@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <630cdfa9-3eed-ddb2-d3b9-0ec008fa0e68@linux.intel.com>
Date:   Wed, 20 May 2020 17:56:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520123807.GD157452@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.05.2020 15:38, Jiri Olsa wrote:
> On Wed, May 13, 2020 at 11:00:02AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +
>> +static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>> +			      char *cmd_data, size_t data_size)
>> +{
>> +	int err;
>> +	char c;
>> +	size_t bytes_read = 0;
>> +
>> +	memset(cmd_data, 0, data_size--);
>> +
>> +	do {
>> +		err = read(evlist->ctl_fd, &c, 1);
>> +		if (err > 0) {
>> +			if (c == '\n' || c == '\0')
>> +				break;
>> +			cmd_data[bytes_read++] = c;
>> +			if (bytes_read == data_size)
>> +				break;
>> +		} else {
>> +			if (err == -1)
>> +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd);
>> +			break;
>> +		}
>> +	} while (1);
>> +
>> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
>> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>> +
>> +	if (err > 0) {
>> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
>> +			*cmd = EVLIST_CTL_CMD_ENABLE;
>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
>> +			*cmd = EVLIST_CTL_CMD_DISABLE;
>> +		}
> 
> are there more comands comming?

Currently no.

~Alexey 

