Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE335C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B42253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgATW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:27:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:21432 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgATW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:27:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 14:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400"; 
   d="scan'208";a="426870272"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2020 14:26:59 -0800
Date:   Tue, 21 Jan 2020 06:27:10 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 3/8] mm/migrate.c: reform the last call on
 do_move_pages_to_node()
Message-ID: <20200120222710.GB32314@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-4-richardw.yang@linux.intel.com>
 <20200120094608.GN18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120094608.GN18451@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:46:08AM +0100, Michal Hocko wrote:
>On Sun 19-01-20 11:06:31, Wei Yang wrote:
>> No functional change, just reform it to make it as the same shape as
>> other calls on do_move_pages_to_node().
>> 
>> This is a preparation for further cleanup.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/migrate.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index c3ef70de5876..4a63fb8fbb6d 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1675,8 +1675,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  
>>  	/* Make sure we do not overwrite the existing error */
>>  	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>> -	if (!err1)
>> -		err1 = store_status(status, start, current_node, i - start);
>> +	if (err1) {
>> +		if (err >= 0)
>> +			err = err1;
>> +		goto out;
>> +	}
>> +	err1 = store_status(status, start, current_node, i - start);
>
>Please don't. This just makes the code harder to follow. The current err
>and err1 is already quite ugly so do not make it more so.
>

Yes, I struggled a little on doing this change. Sounds we can merge this one
with the following consolidation.

>>  	if (err >= 0)
>>  		err = err1;
>>  out:
>> -- 
>> 2.17.1
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
