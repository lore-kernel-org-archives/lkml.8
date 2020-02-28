Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17ECC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0782051A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1ODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:03:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:43356 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgB1ODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:03:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 06:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242385619"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 06:02:57 -0800
Subject: Re: [PATCH V2 03/13] kprobes: Add symbols for kprobe insn pages
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200212124949.3589-1-adrian.hunter@intel.com>
 <20200212124949.3589-4-adrian.hunter@intel.com>
 <20200226152151.GA217283@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <76b53846-86ab-f0a6-1e8f-fece412099ae@intel.com>
Date:   Fri, 28 Feb 2020 16:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226152151.GA217283@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/20 5:21 pm, Jiri Olsa wrote:
> On Wed, Feb 12, 2020 at 02:49:39PM +0200, Adrian Hunter wrote:
>> Symbols are needed for tools to describe instruction addresses. Pages
>> allocated for kprobe's purposes need symbols to be created for them.
>> Add such symbols to be visible via /proc/kallsyms.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> SNIP
> 
>> @@ -272,6 +273,8 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
>>  {									\
>>  	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
>>  }
>> +#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
>> +#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
>>  #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
>>  #define DEFINE_INSN_CACHE_OPS(__name)					\
>>  static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
>> @@ -373,6 +376,13 @@ void dump_kprobe(struct kprobe *kp);
>>  void *alloc_insn_page(void);
>>  void free_insn_page(void *page);
>>  
>> +int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>> +		       char *sym);
>> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
>> +			     unsigned long *value, char *type, char *sym);
>> +
>> +int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
>> +			    char *type, char *sym);
>>  #else /* !CONFIG_KPROBES: */
>>  
>>  static inline int kprobes_built_in(void)
>> @@ -435,6 +445,24 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
>>  {
>>  	return true;
>>  }
>> +static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
>> +				     char *type, char *sym)
>> +{
>> +	return 0;
>> +}
>> +static inline int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c,
>> +					   unsigned int *symnum,
>> +					   unsigned long *value, char *type,
>> +					   char *sym)
>> +{
>> +	return 0;
>> +}
>> +static inline int arch_kprobe_get_kallsym(unsigned int *symnum,
>> +					  unsigned long *value, char *type,
>> +					  char *sym)
>> +{
>> +	return 0;
>> +}
> 
> there's another arch_kprobe_get_kallsym marked as __weak,
> is above function superfluous?

Yes, it is removed in V3.
