Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA55C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAEA2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAVAkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:40:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:52828 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgAVAkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:40:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 16:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="425678743"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2020 16:40:01 -0800
Date:   Wed, 22 Jan 2020 08:40:12 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 7/8] mm/migrate.c: move page on next iteration
Message-ID: <20200122004012.GB11409@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-8-richardw.yang@linux.intel.com>
 <20200120100203.GR18451@dhcp22.suse.cz>
 <20200121012200.GA1567@richard>
 <20200121084352.GE29276@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121084352.GE29276@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:43:52AM +0100, Michal Hocko wrote:
>On Tue 21-01-20 09:22:00, Wei Yang wrote:
>> On Mon, Jan 20, 2020 at 11:02:03AM +0100, Michal Hocko wrote:
>> >On Sun 19-01-20 11:06:35, Wei Yang wrote:
>> >> When page is not successfully queued for migration, we would move pages
>> >> on pagelist immediately. Actually, this could be done in the next
>> >> iteration by telling it we need some help.
>> >> 
>> >> This patch adds a new variable need_move to be an indication. After
>> >> this, we only need to call move_pages_and_store_status() twice.
>> >
>> >No! Not another iterator. There are two and this makes the function
>> >quite hard to follow already. We do not want to add a third one.
>> >
>> 
>> Two iterators here are? I don't get your point.
>
>i is the main iterator to process the whole imput. start is another one
>to control the batch to migrate. We do not need/want more. More clear?

Yes, more clear.

I hope you are angry with me. Sorry for my poor English.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
