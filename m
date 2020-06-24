Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6397C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02A520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbgFXLsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:48:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:16355 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbgFXLsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:48:32 -0400
IronPort-SDR: uNFRB1KSHtI/v6LSzelT/Jg1IHbj+UDLdWab+oivFKCpoUPFuHxRzrIQDgkH19gnoxCm1b1RCj
 rkAULY2/6XsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162536346"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="162536346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 04:48:24 -0700
IronPort-SDR: QT/deIjt5nrJ9D6QdVky0fqryPbzhhYFW5SpjVCQxw1u+JeKXLgLHFPu2krkj7PyuiMtWkN1EH
 CPgCA78mQGJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="265048609"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 04:48:22 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 862245805B5;
        Wed, 24 Jun 2020 04:48:21 -0700 (PDT)
Subject: Re: [PATCH v7 03/13] perf evlist: implement control command handling
 functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <88988ce1-52d3-21e7-f0dc-bac5fde63cb2@linux.intel.com>
 <20200623145450.GF2619137@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <83328e86-36af-091f-8729-f4ba3d30a3f1@linux.intel.com>
Date:   Wed, 24 Jun 2020 14:48:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623145450.GF2619137@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2020 17:54, Jiri Olsa wrote:
> On Wed, Jun 03, 2020 at 06:54:47PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
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
>> +	if (stat_entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
>> +		evlist__finalize_ctlfd(evlist);
>> +	else
>> +		stat_entries[ctlfd_pos].revents = 0;
>> +
>> +	return err;
>> +}
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 0d8b361f1c8e..bccf0a970371 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -360,4 +360,21 @@ void perf_evlist__force_leader(struct evlist *evlist);
>>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>>  						 struct evsel *evsel,
>>  						bool close);
>> +#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
>> +#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
>> +#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
> 
> why the \n at the end of ack?

This \n stops reading by read command from within shell script.
\n can be avoided in ack if using "read -n 3 -u $fd res" instead
of just "read -u $fd res" by the script.

~Alexey

> 
> jirka
> 
