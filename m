Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44338C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2104621744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgBZCw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:52:27 -0500
Received: from mail5.windriver.com ([192.103.53.11]:45572 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbgBZCw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:52:27 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01Q2nYvk014201
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Feb 2020 18:49:45 -0800
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 25 Feb
 2020 18:49:24 -0800
Subject: Re: [PATCH 2/2] perf: probe-file: Check return value of strlist__add
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <kstewart@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
 <1582641703-233485-2-git-send-email-zhe.he@windriver.com>
 <20200226074906.0acb08b31d01c96c475da0cb@kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <b07f670b-6539-1590-88a8-20c58dec3a7e@windriver.com>
Date:   Wed, 26 Feb 2020 10:49:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226074906.0acb08b31d01c96c475da0cb@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/20 6:49 AM, Masami Hiramatsu wrote:
> On Tue, 25 Feb 2020 22:41:43 +0800
> <zhe.he@windriver.com> wrote:
>
>> From: He Zhe <zhe.he@windriver.com>
>>
>> strlist__add may fail with -ENOMEM or -EEXIST. Check it and give debugging
>> hint when necessary.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  tools/perf/builtin-probe.c   | 30 ++++++++++++++++--------------
>>  tools/perf/util/probe-file.c | 26 +++++++++++++++++++++-----
>>  2 files changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
>> index 26bc5923e6b5..8b4511c70fed 100644
>> --- a/tools/perf/builtin-probe.c
>> +++ b/tools/perf/builtin-probe.c
>> @@ -442,24 +442,26 @@ static int perf_del_probe_events(struct strfilter *filter)
>>  	}
>>  
>>  	ret = probe_file__get_events(kfd, filter, klist);
>> -	if (ret == 0) {
>> -		strlist__for_each_entry(ent, klist)
>> -			pr_info("Removed event: %s\n", ent->s);
>> +	if (ret < 0)
>> +		goto out;
> No, this is ignored by design.
> Since probe_file__get_events() returns -ENOENT when no event is matched,
> this should be just ignored, and goto uprobe event matching.

Thanks for pointing it out. However when strlist__add in probe_file__get_events
returns a -ENOMEM and we ignore that, though it happens not very likely, we
would miss some entries. So I add checks here and in probe_file__get_events to
give a heads-up in advance.

And the same reason is for the checks below for probe_cache__load,
probe_cache__add_entry and probe_cache__scan_sdt.


Regards,
Zhe

>
>>  
>> -		ret = probe_file__del_strlist(kfd, klist);
>> -		if (ret < 0)
>> -			goto error;
>> -	}
>> +	strlist__for_each_entry(ent, klist)
>> +		pr_info("Removed event: %s\n", ent->s);
>> +
>> +	ret = probe_file__del_strlist(kfd, klist);
>> +	if (ret < 0)
>> +		goto error;
>>  
>>  	ret2 = probe_file__get_events(ufd, filter, ulist);
>> -	if (ret2 == 0) {
>> -		strlist__for_each_entry(ent, ulist)
>> -			pr_info("Removed event: %s\n", ent->s);
>> +	if (ret2 < 0)
>> +		goto out;
> Ditto.
>
> Thank you,
>
>>  
>> -		ret2 = probe_file__del_strlist(ufd, ulist);
>> -		if (ret2 < 0)
>> -			goto error;
>> -	}
>> +	strlist__for_each_entry(ent, ulist)
>> +		pr_info("Removed event: %s\n", ent->s);
>> +
>> +	ret2 = probe_file__del_strlist(ufd, ulist);
>> +	if (ret2 < 0)
>> +		goto error;
>>  
>>  	if (ret == -ENOENT && ret2 == -ENOENT)
>>  		pr_warning("\"%s\" does not hit any event.\n", str);
>> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
>> index cf44c05f89c1..00f086cba88f 100644
>> --- a/tools/perf/util/probe-file.c
>> +++ b/tools/perf/util/probe-file.c
>> @@ -307,10 +307,14 @@ int probe_file__get_events(int fd, struct strfilter *filter,
>>  		p = strchr(ent->s, ':');
>>  		if ((p && strfilter__compare(filter, p + 1)) ||
>>  		    strfilter__compare(filter, ent->s)) {
>> -			strlist__add(plist, ent->s);
>> -			ret = 0;
>> +			ret = strlist__add(plist, ent->s);
>> +			if (ret < 0) {
>> +				pr_debug("strlist__add failed (%d)\n", ret);
>> +				goto out;
>> +			}
>>  		}
>>  	}
>> +out:
>>  	strlist__delete(namelist);
>>  
>>  	return ret;
>> @@ -517,7 +521,11 @@ static int probe_cache__load(struct probe_cache *pcache)
>>  				ret = -EINVAL;
>>  				goto out;
>>  			}
>> -			strlist__add(entry->tevlist, buf);
>> +			ret = strlist__add(entry->tevlist, buf);
>> +			if (ret < 0) {
>> +				pr_debug("strlist__add failed (%d)\n", ret);
>> +				goto out;
>> +			}
>>  		}
>>  	}
>>  out:
>> @@ -678,7 +686,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
>>  		command = synthesize_probe_trace_command(&tevs[i]);
>>  		if (!command)
>>  			goto out_err;
>> -		strlist__add(entry->tevlist, command);
>> +		ret = strlist__add(entry->tevlist, command);
>> +		if (ret < 0) {
>> +			pr_debug("strlist__add failed (%d)\n", ret);
>> +			goto out_err;
>> +		}
>> +
>>  		free(command);
>>  	}
>>  	list_add_tail(&entry->node, &pcache->entries);
>> @@ -859,7 +872,10 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
>>  			break;
>>  		}
>>  
>> -		strlist__add(entry->tevlist, buf);
>> +		ret = strlist__add(entry->tevlist, buf);
>> +		if (ret < 0)
>> +			pr_debug("strlist__add failed (%d)\n", ret);
>> +
>>  		free(buf);
>>  		entry = NULL;
>>  	}
>> -- 
>> 2.24.1
>>
>

