Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6488C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D521569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAUPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:03:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:14629 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgAUPDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:03:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 07:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="220942721"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2020 07:02:55 -0800
Received: from [10.251.23.105] (kliang2-mobl.ccr.corp.intel.com [10.251.23.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0FB2F5803C5;
        Tue, 21 Jan 2020 07:02:53 -0800 (PST)
Subject: Re: [RESEND PATCH V5 1/2] perf/core: Add new branch sample type for
 HW index of raw branch records
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20200116155757.19624-1-kan.liang@linux.intel.com>
 <20200116155757.19624-2-kan.liang@linux.intel.com>
 <CABPqkBQT159soMpnwf_phMx54asgdte5HApwhBz=Hpbx9y0aTg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9e06729d-36cf-9af8-b551-eb467f1cc725@linux.intel.com>
Date:   Tue, 21 Jan 2020 10:02:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBQT159soMpnwf_phMx54asgdte5HApwhBz=Hpbx9y0aTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2020 4:32 AM, Stephane Eranian wrote:
> On Thu, Jan 16, 2020 at 7:59 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The low level index of raw branch records is very useful for
>> reconstructing the call stack. For example, in Intel LBR call stack mode,
>> the depth of reconstructed LBR call stack limits to the number of LBR
>> registers. With the HW index information, perf tool may stitch the
>> stacks of two samples. The reconstructed LBR call stack can break the HW
>> limitation.
>>
>> Add a new branch sample type to retrieve the low level index of raw
>> branch records. Only need to save the index for the most recent branch
>> aka entries[0]. Others can be calculated by the max number of HW
>> supported branch records later in perf tool.
>>
> You need to define what the low level index is about w.r.t. the branch_entries[]
> abstraction. You need to say it is a value between -1 (unknown) and max depth
> (which can be retrieved in /sys/devices/cpu/caps/branches). It returns the index
> in the underlying hardware buffer of the most recently captured taken branch
> which is always saved in branch_entries[0]. As such, it is not necessary to
> process branches in order. It may be used in certain modes to stitch
> together multiple
> BRANCH_STACK records in call stack mode.

Thanks Stephane. I will change the description based on your suggestion.

Add a new branch sample type to retrieve low level index of raw branch 
records. The low level index is the index in the underlying hardware 
buffer of the most recently captured taken branch which is always saved 
in branch_entries[0]. The low level index is between -1 (unknown) and 
max depth which can be retrieved in /sys/devices/cpu/caps/branches.
It may be used in certain modes to stitch together multiple BRANCH_STACK 
records in call stack mode.


Thanks,
Kan

> 
>>
>> If we don't know the order of raw branch records, the hw_idx should be
>> -1ULL. This patch sets -1ULL for all architectures for now. It can be
>> changed later if needed.
>>
>> Only when the new branch sample type is set, the HW index information is
>> dumped into the PERF_SAMPLE_BRANCH_STACK output.
>> Perf tool should check the attr.branch_sample_type, and apply the
>> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
>> Otherwise, some user case may be broken. For example, users may parse a
>> perf.data, which include the new branch sample type, with an old version
>> perf tool (without the check). Users probably get incorrect information
>> without any warning.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/powerpc/perf/core-book3s.c |  1 +
>>   arch/x86/events/intel/lbr.c     |  3 +++
>>   include/linux/perf_event.h      | 12 ++++++++++++
>>   include/uapi/linux/perf_event.h | 10 +++++++++-
>>   kernel/events/core.c            | 11 +++++++++++
>>   5 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 48604625ab31..fe7de222229a 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -524,6 +524,7 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
>>                  }
>>          }
>>          cpuhw->bhrb_stack.nr = u_index;
>> +       cpuhw->bhrb_stack.hw_idx = -1ULL;
>>          return;
>>   }
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 534c76606049..7639e2097101 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -585,6 +585,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>>                  cpuc->lbr_entries[i].reserved   = 0;
>>          }
>>          cpuc->lbr_stack.nr = i;
>> +       cpuc->lbr_stack.hw_idx = -1ULL;
>>   }
>>
>>   /*
>> @@ -680,6 +681,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>>                  out++;
>>          }
>>          cpuc->lbr_stack.nr = out;
>> +       cpuc->lbr_stack.hw_idx = -1ULL;
>>   }
>>
>>   void intel_pmu_lbr_read(void)
>> @@ -1120,6 +1122,7 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
>>          int i;
>>
>>          cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
>> +       cpuc->lbr_stack.hw_idx = -1ULL;
>>          for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>                  u64 info = lbr->lbr[i].info;
>>                  struct perf_branch_entry *e = &cpuc->lbr_entries[i];
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 011dcbdbccc2..554621d99864 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -93,14 +93,26 @@ struct perf_raw_record {
>>   /*
>>    * branch stack layout:
>>    *  nr: number of taken branches stored in entries[]
>> + *  hw_idx: The low level index of raw branch records
>> + *          for the most recent branch.
>> + *          -1ULL means invalid.
>>    *
>>    * Note that nr can vary from sample to sample
>>    * branches (to, from) are stored from most recent
>>    * to least recent, i.e., entries[0] contains the most
>>    * recent branch.
>> + * The entries[] is an abstraction of raw branch records,
>> + * which may not be stored in age order in HW, e.g. Intel LBR.
>> + * The hw_idx is to expose the low level index of raw
>> + * branch record for the most recent branch aka entries[0].
>> + * For the architectures whose raw branch records are
>> + * already stored in age order, the hw_idx should be 0.
>> + * If we don't know the order of raw branch records,
>> + * the hw_idx should be -1ULL.
>>    */
>>   struct perf_branch_stack {
>>          __u64                           nr;
>> +       __u64                           hw_idx;
>>          struct perf_branch_entry        entries[0];
>>   };
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index bb7b271397a6..14110837b130 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
>>
>>          PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch type */
>>
>> +       PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT       = 17, /* save low level index of raw branch records */
>> +
>>          PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
>>   };
>>
>> @@ -207,6 +209,8 @@ enum perf_branch_sample_type {
>>          PERF_SAMPLE_BRANCH_TYPE_SAVE    =
>>                  1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>>
>> +       PERF_SAMPLE_BRANCH_HW_INDEX     = 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
>> +
>>          PERF_SAMPLE_BRANCH_MAX          = 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>>   };
>>
>> @@ -849,7 +853,11 @@ enum perf_event_type {
>>           *        char                  data[size];}&& PERF_SAMPLE_RAW
>>           *
>>           *      { u64                   nr;
>> -        *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>> +        *        { u64 from, to, flags } lbr[nr];
>> +        *
>> +        *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
>> +        *        u64                   hw_idx;
>> +        *      } && PERF_SAMPLE_BRANCH_STACK
>>           *
>>           *      { u64                   abi; # enum perf_sample_regs_abi
>>           *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index cfd89b4a02d8..4be3ba12333f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6391,6 +6391,11 @@ static void perf_output_read(struct perf_output_handle *handle,
>>                  perf_output_read_one(handle, event, enabled, running);
>>   }
>>
>> +static inline bool perf_sample_save_hw_index(struct perf_event *event)
>> +{
>> +       return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
>> +}
>> +
>>   void perf_output_sample(struct perf_output_handle *handle,
>>                          struct perf_event_header *header,
>>                          struct perf_sample_data *data,
>> @@ -6480,6 +6485,8 @@ void perf_output_sample(struct perf_output_handle *handle,
>>
>>                          perf_output_put(handle, data->br_stack->nr);
>>                          perf_output_copy(handle, data->br_stack->entries, size);
>> +                       if (perf_sample_save_hw_index(event))
>> +                               perf_output_put(handle, data->br_stack->hw_idx);
>>                  } else {
>>                          /*
>>                           * we always store at least the value of nr
>> @@ -6667,7 +6674,11 @@ void perf_prepare_sample(struct perf_event_header *header,
>>                  if (data->br_stack) {
>>                          size += data->br_stack->nr
>>                                * sizeof(struct perf_branch_entry);
>> +
>> +                       if (perf_sample_save_hw_index(event))
>> +                               size += sizeof(u64);
>>                  }
>> +
>>                  header->size += size;
>>          }
>>
>> --
>> 2.17.1
>>
