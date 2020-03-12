Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB257C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A809206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCLQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:10:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:40823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgCLQKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 09:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="415988900"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 09:10:05 -0700
Received: from [10.255.182.54] (unknown [10.255.182.54])
        by linux.intel.com (Postfix) with ESMTP id C799B58033E;
        Thu, 12 Mar 2020 09:10:00 -0700 (PDT)
Subject: Re: [PATCH v1] perf record: fix binding of AIO user space buffers to
 nodes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
 <20200312143152.GA28601@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2e01e17a-962d-571b-4407-70aa270cec6a@linux.intel.com>
Date:   Thu, 12 Mar 2020 19:09:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312143152.GA28601@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.03.2020 17:31, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 12, 2020 at 03:21:45PM +0300, Alexey Budankov escreveu:
>>
>> Correct maxnode parameter value passed to mbind() syscall to be
>> the amount of node mask bits to analyze plus 1. Dynamically allocate
>> node mask memory depending on the index of node of cpu being profiled.
>> Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/mmap.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 3b664fa673a6..6d604cd67a95 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
>>  {
>>  	void *data;
>>  	size_t mmap_len;
>> -	unsigned long node_mask;
>> +	unsigned long *node_mask;
>> +	unsigned long node_index;
>> +	int err = 0;
>>  
>>  	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
>>  		data = map->aio.data[idx];
>>  		mmap_len = mmap__mmap_len(map);
>> -		node_mask = 1UL << cpu__get_node(cpu);
>> -		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
>> -			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
>> -				data, data + mmap_len, cpu__get_node(cpu));
>> +		node_index = cpu__get_node(cpu);
>> +		node_mask = bitmap_alloc(node_index + 1);
>> +		if (!node_mask) {
>> +			pr_err("Failed to allocate node mask for mbind: error %m\n");
>>  			return -1;
>>  		}
>> +		set_bit(node_index, node_mask);
>> +		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1/*nr_bits + 1*/, 0)) {
> 
>                                                                                   ^^^^^^^^^^^^^^
> 										  Leftover?

Intentionally put it here to document kernel behavior for mbind() syscall
because currently it is different from the man page [1] documented:

"nodemask points to a bit mask of nodes containing up to maxnode bits.
 The bit mask size is rounded to the next multiple of sizeof(unsigned
 long), but the kernel will use bits only up to maxnode.  A NULL value
 of nodemask or a maxnode value of zero specifies the empty set of
 nodes.  If the value of maxnode is zero, the nodemask argument is
 ignored.  Where a nodemask is required, it must contain at least one
 node that is on-line, allowed by the thread's current cpuset context
 (unless the MPOL_F_STATIC_NODES mode flag is specified), and contains
 memory."

~Alexey

[1] http://man7.org/linux/man-pages/man2/mbind.2.html
