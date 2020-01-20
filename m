Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C60C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901B620678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgATAbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 19:31:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:12619 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgATAbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 19:31:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 16:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="228167572"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2020 16:31:20 -0800
Date:   Mon, 20 Jan 2020 08:31:31 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 2/8] mm/migrate.c: not necessary to check start and i
Message-ID: <20200120003131.GA26292@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-3-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.2001191413360.43388@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001191413360.43388@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 02:14:28PM -0800, David Rientjes wrote:
>On Sun, 19 Jan 2020, Wei Yang wrote:
>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ba7cf4fa43a0..c3ef70de5876 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1664,11 +1664,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  		err = do_move_pages_to_node(mm, &pagelist, current_node);
>>  		if (err)
>>  			goto out;
>> -		if (i > start) {
>> -			err = store_status(status, start, current_node, i - start);
>> -			if (err)
>> -				goto out;
>> -		}
>> +		err = store_status(status, start, current_node, i - start);
>> +		if (err)
>> +			goto out;
>>  		current_node = NUMA_NO_NODE;
>>  	}
>>  out_flush:
>
>Not sure this is useful, it relies on the implementation of store_status() 
>when i == start and the overhead of the function call should actually be 
>slower than the simple conditional to avoid it in that case?

Not sure about this.

While this patch is a transient state for the following cleanup. The purpose
of this is to make the consolidation a little easy to review.

-- 
Wei Yang
Help you, Help me
