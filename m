Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E309AC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AAC20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBEJ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:26:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:44604 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgBEJ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:26:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 01:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="225776927"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2020 01:26:00 -0800
Date:   Wed, 5 Feb 2020 17:26:16 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 07/10] mm/memory_hotplug: We always have a zone in
 find_(smallest|biggest)_section_pfn
Message-ID: <20200205092616.GB24162@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-8-david@redhat.com>
 <20200205085709.GA24162@richard>
 <80d3baea-2076-ed07-1216-27d8aa8c8734@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d3baea-2076-ed07-1216-27d8aa8c8734@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:59:41AM +0100, David Hildenbrand wrote:
>On 05.02.20 09:57, Wei Yang wrote:
>> On Sun, Oct 06, 2019 at 10:56:43AM +0200, David Hildenbrand wrote:
>>> With shrink_pgdat_span() out of the way, we now always have a valid
>>> zone.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> 
>> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Just FYI, the patches are now upstream, so the rb's can no longer be
>applied. (but we can send fixes if we find that something is broken ;)
>). Thanks!
>

Thanks for reminding. :-)

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
