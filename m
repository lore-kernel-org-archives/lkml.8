Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC1C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F5124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTHMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:12:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:3039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTHMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:12:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 23:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="315646652"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2020 23:12:13 -0800
Date:   Thu, 20 Feb 2020 15:12:33 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, rppt@linux.ibm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200220071233.GA592@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-7-bhe@redhat.com>
 <20200220061832.GE32521@richard>
 <20200220070420.GD4937@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220070420.GD4937@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:04:20PM +0800, Baoquan He wrote:
>On 02/20/20 at 02:18pm, Wei Yang wrote:
>> On Thu, Feb 20, 2020 at 12:33:15PM +0800, Baoquan He wrote:
>> >No functional change.
>> >
>> 
>> Those functions are introduced in your previous patches.
>> 
>> Is it possible to define them close to each other at the very beginning?
>
>Thanks for reviewing.
>
>Do you mean to discard this patch and keep it as they are in the patch 4/7?
>If yes, it's fine to me to drop it as you suggested. To me, I prefer to put
>all subsection map handling codes together.
>

I mean when you introduce clear_subsection_map() in patch 3, is it possible to
move close to the definition of fill_subsection_map()?

Since finally you are will to move them together.

-- 
Wei Yang
Help you, Help me
