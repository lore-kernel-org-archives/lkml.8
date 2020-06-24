Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D529C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3522082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgFXNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:35:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:37153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgFXNfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:35:05 -0400
IronPort-SDR: NmzMXEqMeja3felCToR0TENhMLxe36J9XVwuX7uckWYXQVTNpl3lEjrXsZCFVg3nS4QuNLmDxp
 7/qjCrobM/Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124726953"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="124726953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 06:35:05 -0700
IronPort-SDR: iiqLHgkY5cruYRbEYUSVOFq+ZhhN6jmmZlefY03zrPEtBmdjIkBlSOo+B2DIzSyekFVMLTsASb
 nNksj6W4j0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="311643064"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2020 06:35:04 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 021B05805B5;
        Wed, 24 Jun 2020 06:35:02 -0700 (PDT)
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
 <20200623145601.GH2619137@krava> <20200623150345.GA26230@kernel.org>
 <20200623151442.GL2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9343aea5-7e89-5319-ad44-87aefa5935cd@linux.intel.com>
Date:   Wed, 24 Jun 2020 16:35:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623151442.GL2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.06.2020 18:14, Jiri Olsa wrote:
> On Tue, Jun 23, 2020 at 12:03:45PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jun 23, 2020 at 04:56:01PM +0200, Jiri Olsa escreveu:
>>> On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> +	memset(cmd_data, 0, data_size--);
>>>> +
>>>> +	do {
>>>> +		err = read(evlist->ctl_fd.fd, &c, 1);
>>>> +		if (err > 0) {
>>>> +			if (c == '\n' || c == '\0')
>>>> +				break;
>>>> +			cmd_data[bytes_read++] = c;
>>>> +			if (bytes_read == data_size)
>>>> +				break;
>>>> +		} else {
>>>> +			if (err == -1)
>>>> +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
>>>> +			break;
>>>> +		}
>>>> +	} while (1);
>>>> +
>>>> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
>>>> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>>>> +
>>>> +	if (err > 0) {
>>>> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>>>> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
>>>
>>> you could use sizeof(EVLIST_CTL_CMD_ENABLE_TAG) instead, no function call
>>
>> -1, as sizeof will get the \0, right?
> 
> yep, I think that's right

Ok, let's have it like (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1).

~Alexey

> 
> jirka
> 
>>
>>>
>>>> +			*cmd = EVLIST_CTL_CMD_ENABLE;
>>>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>>>> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
>>>
>>> ditto
>>>
>>> jirka
>>>
>>
>> -- 
>>
>> - Arnaldo
>>
> 
