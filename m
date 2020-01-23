Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C041C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2264421835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAWWkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:40:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:24202 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgAWWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:40:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 14:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,355,1574150400"; 
   d="scan'208";a="222474270"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2020 14:40:24 -0800
Date:   Fri, 24 Jan 2020 06:40:35 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, mhocko@suse.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: move_pages: report the number of non-attempted
 pages
Message-ID: <20200123224035.GA29851@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1579736331-85494-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200123032736.GA22196@richard>
 <01fc1c6b-1cab-7f7e-7879-4fc7b0e4a231@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fc1c6b-1cab-7f7e-7879-4fc7b0e4a231@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:56:50PM -0800, Yang Shi wrote:
>
>
>On 1/22/20 7:27 PM, Wei Yang wrote:
>> On Thu, Jan 23, 2020 at 07:38:51AM +0800, Yang Shi wrote:
>> > Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
>> > the semantic of move_pages() was changed to return the number of
>> > non-migrated pages (failed to migration) and the call would be aborted
>> > immediately if migrate_pages() returns positive value.  But it didn't
>> > report the number of pages that we even haven't attempted to migrate.
>> > So, fix it by including non-attempted pages in the return value.
>> > 
>> First, we want to change the semantic of move_pages(2). The return value
>> indicates the number of pages we didn't managed to migrate?
>
>This is my understanding.
>
>> 
>> Second, the return value from migrate_pages() doesn't mean the number of pages
>> we failed to migrate. For example, one -ENOMEM is returned on the first page,
>> migrate_pages() would return 1. But actually, no page successfully migrated.
>
>This would not happen at all since migrate_pages() would just return -ENOMEM
>instead of a positive value, right?
>

Oh, you are right.


-- 
Wei Yang
Help you, Help me
