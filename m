Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C824EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A806220C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbgFXNU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:20:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:14085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387687AbgFXNU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:20:57 -0400
IronPort-SDR: dhq/oymItepQ3iYKtIX4FXrPxaxnGJAgpXFABLcF1dzrVZZF2rYyuDc2gVrovvlsO93AKIKVKS
 4sS0Obk5TMcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="145958119"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="145958119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 06:20:55 -0700
IronPort-SDR: BY5EJYm6T9Uz5+auy6YyodqB73Oa5pKcLMtEMuL7y+bmne7kG8UtBXZs7FalPeclp8y7xLziU8
 UZhPYFH4lT0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="311639730"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2020 06:20:54 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id B58275805B5;
        Wed, 24 Jun 2020 06:20:52 -0700 (PDT)
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
 <20200623145613.GI2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3ab05af5-b882-ffde-8311-307b6c373fd3@linux.intel.com>
Date:   Wed, 24 Jun 2020 16:20:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145613.GI2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.2020 17:56, Jiri Olsa wrote:
> On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>> +		err = read(evlist->ctl_fd.fd, &c, 1);
>> +		if (err > 0) {
>> +			if (c == '\n' || c == '\0')
>> +				break;
>> +			cmd_data[bytes_read++] = c;
>> +			if (bytes_read == data_size)
>> +				break;
>> +		} else {
>> +			if (err == -1)
>> +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
>> +			break;
>> +		}
>> +	} while (1);
>> +
>> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
>> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> 
> do you want to display the message above only if (err > 0) ?

I do, only for err >= 0. For err == -1 there is already the error message.

> 
>> +
>> +	if (err > 0) {
>> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
>> +			*cmd = EVLIST_CTL_CMD_ENABLE;
>> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
>> +			*cmd = EVLIST_CTL_CMD_DISABLE;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
> 
> SNIP
> 
>> +	int ctlfd_pos = evlist->ctl_fd.pos;
>> +	struct pollfd *entries = evlist->core.pollfd.entries;
>> +
>> +	if (ctlfd_pos == -1 || !entries[ctlfd_pos].revents)
>> +		return 0;
>> +
>> +	if (entries[ctlfd_pos].revents & POLLIN) {
>> +		err = evlist__ctlfd_recv(evlist, cmd, cmd_data,
>> +					 EVLIST_CTL_CMD_MAX_LEN);
>> +		if (err > 0) {
>> +			switch (*cmd) {
>> +			case EVLIST_CTL_CMD_ENABLE:
>> +				evlist__enable(evlist);
>> +				break;
>> +			case EVLIST_CTL_CMD_DISABLE:
>> +				evlist__disable(evlist);
>> +				break;
>> +			case EVLIST_CTL_CMD_ACK:
>> +			case EVLIST_CTL_CMD_UNSUPPORTED:
>> +			default:
>> +				pr_debug("ctlfd: unsupported %d\n", *cmd);
>> +				break;
>> +			}
>> +			if (!(*cmd == EVLIST_CTL_CMD_ACK || *cmd == EVLIST_CTL_CMD_UNSUPPORTED))
>> +				evlist__ctlfd_ack(evlist);
>> +		}
>> +	}
>> +
>> +	if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
>> +		evlist__finalize_ctlfd(evlist);
> 
> should this error be propagated via err?

I don't think so. Currently it returns 0 only and there is no need to 
stop collection or skip processing in caller in this case.

~Alexey

> 
> jirka
> 
