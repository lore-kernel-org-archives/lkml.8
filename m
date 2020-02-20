Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA607C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B776F208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgBTVv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:51:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:18764 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgBTVv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:51:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 13:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="383273071"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2020 13:51:53 -0800
Date:   Fri, 21 Feb 2020 05:52:13 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, rppt@linux.ibm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200220215213.GA14195@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-7-bhe@redhat.com>
 <20200220061832.GE32521@richard>
 <20200220070420.GD4937@MiWiFi-R3L-srv>
 <20200220071233.GA592@richard>
 <20200220085559.GE4937@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220085559.GE4937@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:55:59PM +0800, Baoquan He wrote:
>On 02/20/20 at 03:12pm, Wei Yang wrote:
>> On Thu, Feb 20, 2020 at 03:04:20PM +0800, Baoquan He wrote:
>> >On 02/20/20 at 02:18pm, Wei Yang wrote:
>> >> On Thu, Feb 20, 2020 at 12:33:15PM +0800, Baoquan He wrote:
>> >> >No functional change.
>> >> >
>> >> 
>> >> Those functions are introduced in your previous patches.
>> >> 
>> >> Is it possible to define them close to each other at the very beginning?
>> >
>> >Thanks for reviewing.
>> >
>> >Do you mean to discard this patch and keep it as they are in the patch 4/7?
>> >If yes, it's fine to me to drop it as you suggested. To me, I prefer to put
>> >all subsection map handling codes together.
>> >
>> 
>> I mean when you introduce clear_subsection_map() in patch 3, is it possible to
>> move close to the definition of fill_subsection_map()?
>> 
>> Since finally you are will to move them together.
>
>Oh, got it. Yeah, I just put them close to their callers separately. I
>think it's also good to put them together as you suggested, but it
>doesn't matter much, right? I will consider this and see if I can adjust
>it if v3 is needed. Thanks.

Yes, doesn't matter much.

-- 
Wei Yang
Help you, Help me
