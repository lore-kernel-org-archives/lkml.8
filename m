Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A11C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54E42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgAXP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:28:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:57686 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387792AbgAXP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:28:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 07:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="222645471"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2020 07:28:32 -0800
Date:   Fri, 24 Jan 2020 23:28:43 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        jhubbard@nvidia.com, vbabka@suse.cz, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200124152843.GC12509@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
 <20200124072127.GO29276@dhcp22.suse.cz>
 <20200124141538.GA12509@richard>
 <20200124144643.GV29276@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124144643.GV29276@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 03:46:43PM +0100, Michal Hocko wrote:
>On Fri 24-01-20 22:15:38, Wei Yang wrote:
>> On Fri, Jan 24, 2020 at 08:21:27AM +0100, Michal Hocko wrote:
>> >[Sorry I have missed this patch previously]
>> >
>> 
>> No problem, thanks for your comment.
>> 
>> >On Sun 19-01-20 14:57:53, Wei Yang wrote:
>> >> If we get here after successfully adding page to list, err would be
>> >> 1 to indicate the page is queued in the list.
>> >> 
>> >> Current code has two problems:
>> >> 
>> >>   * on success, 0 is not returned
>> >>   * on error, if add_page_for_migratioin() return 1, and the following err1
>> >>     from do_move_pages_to_node() is set, the err1 is not returned since err
>> >>     is 1
>> >
>> >This made my really scratch my head to grasp. So essentially err > 0
>> >will happen when we reach the end of the loop and rely on the
>> >out_flush flushing to migrate the batch. Then err contains the
>> >add_page_for_migratioin return value. And that would leak to the
>> >userspace.
>> >
>> >What would you say about the following wording instead?
>> >"
>> >out_flush part of do_pages_move is responsible for migrating the last
>> >batch that accumulated while processing the input in the loop.
>> >do_move_pages_to_node return value is supposed to override any
>> >preexisting error (e.g. when the user input is garbage) but the current
>> 
>> I am afraid I have a different understanding here.
>> 
>> If we jump to out_flush on the test of node_isset(), err is -EACCESS. Current
>> logic would return this instead of the error from do_move_pages_to_node().
>> Seems we don't override -EACCESS.
>
>And this is the expected logic. The unexpected behavior is the one you
>have fixed by this patch because err = 1 wouldn't get overriden and that
>should have been.

Ok, if the sentence cover this case, the wording looks good to me.

Thanks :-)

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
