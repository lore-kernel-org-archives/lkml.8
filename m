Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134FEC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF222522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAUBtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:49:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:58757 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAUBtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:49:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 17:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="220797381"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2020 17:49:40 -0800
Date:   Tue, 21 Jan 2020 09:49:51 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 3/4] mm/page_alloc.c: pass all bad reasons to
 bad_page()
Message-ID: <20200121014951.GD1567@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-4-richardw.yang@linux.intel.com>
 <20200120102200.GW18451@dhcp22.suse.cz>
 <254a968e-2393-919b-ab21-a2ada2f604ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254a968e-2393-919b-ab21-a2ada2f604ed@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 01:19:10PM +0100, David Hildenbrand wrote:
>On 20.01.20 11:22, Michal Hocko wrote:
>> On Mon 20-01-20 11:04:14, Wei Yang wrote:
>>> Now we can pass all bad reasons to __dump_page().
>> 
>> And we do we want to do that? The dump of the page will tell us the
>> whole story so a single and the most important reason sounds like a
>> better implementation. The code is also more subtle because each caller
>> of the function has to be aware of how many reasons there might be.
>> Not to mention that you need a room for 5 pointers on the stack and this
>> and page allocator might be called from deeper call chains.
>> 
>
>+1, I don't think we want/need this
>

Well, I am fine with both.

Sounds we have 2 vs 2 voting :-)

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
