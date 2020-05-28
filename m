Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5681C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C152063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE1IBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:01:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:37510 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgE1IBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:01:10 -0400
IronPort-SDR: QkOsmTX1k85qA9+ytpbBpER0fUp5NYs60gS7IZ3B/RNyVQ2HlryQPMzruNXNtnRgtGz31fkKjV
 ranOIWFSNdQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 01:01:08 -0700
IronPort-SDR: U66cwPNTldMopD2Pk7j+1GJfI15MNyrS9H5lzy6Y0LiNiHnZjDqwZXdHQbWTY9AhDSk0XfhGmT
 DwmCwISjox0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="469030784"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga005.fm.intel.com with ESMTP; 28 May 2020 01:01:05 -0700
Subject: Re: [PATCH V7 03/15] kprobes: Add symbols for kprobe insn pages
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-4-adrian.hunter@intel.com>
 <20200527174345.GB706478@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2c55fb9f-4801-6278-3a70-aec7e9bb8fe9@intel.com>
Date:   Thu, 28 May 2020 11:00:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527174345.GB706478@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 8:43 pm, Peter Zijlstra wrote:
> On Tue, May 12, 2020 at 03:19:10PM +0300, Adrian Hunter wrote:
>> @@ -2179,6 +2181,49 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>>  	return 0;
>>  }
>>  
>> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
>> +			     unsigned long *value, char *type, char *sym)
>> +{
>> +	struct kprobe_insn_page *kip;
>> +	int ret = -ERANGE;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(kip, &c->pages, list) {
>> +		if ((*symnum)--)
>> +			continue;
>> +		strlcpy(sym, c->sym, KSYM_NAME_LEN);
>> +		*type = 't';
>> +		*value = (unsigned long)kip->insns;
>> +		ret = 0;
>> +		break;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
> 
> This fails on sparc64-defconfig.
> 
> In file included from ../include/linux/kprobes.h:19:0,
>                  from ../kernel/kprobes.c:21:
> ../kernel/kprobes.c: In function 'kprobe_cache_get_kallsym':
> ../include/linux/rculist.h:382:49: error: dereferencing pointer to incomplete type 'struct kprobe_insn_page'
> 
> Please provide a new patch.
> 

Yes, sorry about that.
