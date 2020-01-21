Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D072C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324E6217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hOZjWF1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAUTdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:33:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5547 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:33:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2751ed0002>; Tue, 21 Jan 2020 11:33:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 11:33:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 Jan 2020 11:33:16 -0800
Received: from MacBook-Pro-10.local (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan
 2020 19:33:16 +0000
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
To:     Wei Yang <richardw.yang@linux.intel.com>
CC:     <akpm@linux-foundation.org>, <yang.shi@linux.alibaba.com>,
        <vbabka@suse.cz>, <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <mhocko@kernel.org>
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
 <20200121015326.GE1567@richard> <20200121023408.GA3636@richard>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0aa42c19-4144-5c7a-10f5-162b1b068d4c@nvidia.com>
Date:   Tue, 21 Jan 2020 11:33:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121023408.GA3636@richard>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579635181; bh=LlAW74O5W3Hcc7t1Zx9fPiJAiXGsAliik4al1DRvKWo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hOZjWF1xebzIxPRh61QJ4Uv2JFRLLy8p5EkTbciG1ao9gwKv9A2vXDw2zaQsQD22Q
         guSwUN3mdbi887uA33aUsXHa0TzFtr4lxvvLb8g5vW2+VNF7cKHe5rpMmZeFMHZVw/
         dml0iWlyV0DSx5jd67h6Je2vGXcKD13WWM+63zPOmYVPRRiki0CVhVb9IVNz8eiVFi
         gH9NUT8P/Q0Fsv/6ikCCrrH20A4AABP4Vcg20YgtzVssMdErt1W/EVxp2n/4wYbUx/
         n+BQXNdjoY+QS3Ni7c12gGMLacOY36g/FEC7C38qIVeRRkm9EMc4rvPJq+Zf/7kC4b
         d43VMQzv9cgMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 6:34 PM, Wei Yang wrote:
> On Tue, Jan 21, 2020 at 09:53:26AM +0800, Wei Yang wrote:
>> On Sun, Jan 19, 2020 at 02:57:53PM +0800, Wei Yang wrote:
>>> If we get here after successfully adding page to list, err would be
>>> 1 to indicate the page is queued in the list.
>>>
>>> Current code has two problems:
>>>
>>>   * on success, 0 is not returned
>>>   * on error, if add_page_for_migratioin() return 1, and the following err1
>>>     from do_move_pages_to_node() is set, the err1 is not returned since err
>>>     is 1
>>>
>>> And these behaviors break the user interface.
>>>
>>> Fixes: e0153fc2c760 ("mm: move_pages: return valid node id in status if the
>>> page is already on the target node").

The Fixes tag should be different, right? Because I don't think that
commit introduced this problem.

thanks,
--
John Hubbard
NVIDIA

>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>
>>> ---
>>> v2:
>>>   * put more words to explain the error case
>>> ---
>>> mm/migrate.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 86873b6f38a7..430fdccc733e 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1676,7 +1676,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>> 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>>> 	if (!err1)
>>> 		err1 = store_status(status, start, current_node, i - start);
>>> -	if (!err)
>>> +	if (err >= 0)
>>> 		err = err1;
>>
>> Ok, as mentioned by Yang and Michal, only err == 0 means no error.
>>
>> Sounds this regression should be fixed in another place. Let me send out
>> another patch.
>>
> 
> Hmm... I took another look into the case, this fix should work.
> 
> But yes, the semantic here is a little confusion. Look forward your comments
> here.
> 
>>> out:
>>> 	return err;
>>> -- 
>>> 2.17.1
>>
>> -- 
>> Wei Yang
>> Help you, Help me
> 

thanks,
-- 
John Hubbard
NVIDIA
