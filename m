Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE279C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B072C22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAUBoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:44:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:63155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgAUBoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:44:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 17:44:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="307056935"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2020 17:44:05 -0800
Date:   Tue, 21 Jan 2020 09:44:16 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        richardw.yang@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: move_pages: fix the return value if there are
 not-migrated pages
Message-ID: <20200121014416.GC1567@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1579325203-16405-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200120130624.GD18451@dhcp22.suse.cz>
 <20200120131744.GE18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120131744.GE18451@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:17:44PM +0100, Michal Hocko wrote:
>On Mon 20-01-20 14:06:26, Michal Hocko wrote:
>> On Sat 18-01-20 13:26:43, Yang Shi wrote:
>> > The do_move_pages_to_node() might return > 0 value, the number of pages
>> > that are not migrated, then the value will be returned to userspace
>> > directly.  But, move_pages() syscall would just return 0 or errno.  So,
>> > we need reset the return value to 0 for such case as what pre-v4.17 did.
>> 
>> The patch is wrong. migrate_pages returns the number of pages it
>> _hasn't_ migrated or -errno. Yeah that semantic sucks but...
>> So err != 0 is always an error. Except err > 0 doesn't really provide
>> any useful information to the userspace. I cannot really remember what
>> was the actual behavior before my rework because there were some gotchas
>> hidden there.
>
>OK, so I've double checked. do_move_page_to_node_array would carry the
>error code over to do_pages_move and it would store the status stored
>in the pm array. It contains page_to_nid(page) so the resulting code
>indeed behaves properly before my change and this is a regression. I

Thanks, I see the change.

>have a very vague recollection that this has been brought up already.
><...looks in notes...>
>Found it! The report is
>http://lkml.kernel.org/r/0329efa0984b9b0252ef166abb4498c0795fab36.1535113317.git.jstancek@redhat.com
>and my proposed workaround was http://lkml.kernel.org/r/20180829145537.GZ10223@dhcp22.suse.cz

Well, the above two links return 404.

>
>> If you want to fix this properly then you have to query node status of
>> each page unmigrated when migrate_pages fails with > 0. This would be
>> easier if the fix is done on the latest cleanup posted to the list which
>> consolidates all do_move_pages_to_node and store_status calls to a
>> single function.
>
>Sorry forgot to put a reference to the patch: http://lkml.kernel.org/r/20200119030636.11899-5-richardw.yang@linux.intel.com
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
