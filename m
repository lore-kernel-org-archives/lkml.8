Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74756C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5242C20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgA2WAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:00:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:54061 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:00:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 14:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="218080404"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2020 14:00:27 -0800
Date:   Thu, 30 Jan 2020 06:00:40 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com
Subject: Re: [Patch v2 2/4] mm/migrate.c: wrap do_move_pages_to_node() and
 store_status()
Message-ID: <20200129220040.GB20736@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
 <20200122011647.13636-3-richardw.yang@linux.intel.com>
 <15777c05-2f2c-b818-dacd-3ec31f83be8d@redhat.com>
 <20200129003812.GC12835@richard>
 <68d4f7fb-2f37-2b11-dd0f-2e059415daf2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d4f7fb-2f37-2b11-dd0f-2e059415daf2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:28:53AM +0100, David Hildenbrand wrote:
>On 29.01.20 01:38, Wei Yang wrote:
>> On Tue, Jan 28, 2020 at 11:14:55AM +0100, David Hildenbrand wrote:
>>> On 22.01.20 02:16, Wei Yang wrote:
>>>> Usually do_move_pages_to_node() and store_status() is a pair. There are
>>>> three places call this pair of functions with almost the same form.
>>>
>>> I'd suggest
>>>
>>> "
>>> Usually, do_move_pages_to_node() and store_status() are used in
>>> combination. We have three similar call sites.
>>>
>>> Let's provide a wrapper for both function calls -
>>> move_pages_and_store_status - to make the calling code easier to
>>> maintain and fix (as noted by Yang Shi, the return value handling of
>>> do_move_pages_to_node() has a flaw).
>>> "
>> 
>> Looks good.
>> 
>>>
>>>>
>>>> This patch just wrap it to make it friendly to audience and also
>>>> consolidate the move and store action into one place. Also mentioned by
>>>> Yang Shi, the handling of do_move_pages_to_node()'s return value is not
>>>> proper. Now we can fix it in one place.
>>>>
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>> ---
>>>>  mm/migrate.c | 30 +++++++++++++++++++-----------
>>>>  1 file changed, 19 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 4c2a21856717..a4d3bd6475e1 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1583,6 +1583,19 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static int move_pages_and_store_status(struct mm_struct *mm, int node,
>>>> +		struct list_head *pagelist, int __user *status,
>>>> +		int start, int nr)
>>>
>>> nit: indentation
>>>
>> 
>> You mean indent like this?
>> 
>> static int move_pages_and_store_status(struct mm_struct *mm, int node,
>> 				       struct list_head *pagelist,
>> 				       int __user *status,
>> 
>> This would be along list and I am afraid this is not the only valid code
>> style?
>
>Yes, that's what I meant. Documentation/process/coding-style.rst doesn't
>mention any specific way, but this is the most commonly used one.
>
>Indentation in this file mostly sticks to something like this as well,
>but yeah, it's often a mess and not consistent.
>
>That's why I note it whenever I see it, to make it eventually more
>consistent (and only make it a nit) :)
>

You are right. I would leave as it now, if someone else still have the same
suggestion to fix it.

Thanks :-)

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
