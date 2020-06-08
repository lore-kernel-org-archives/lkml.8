Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A956C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DECA206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgFHIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:00:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:2645 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgFHIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:00:46 -0400
IronPort-SDR: zx2WAlW5SnhD3da3BJ+BHVxwDC0dcXcIOdl3jNulpRtn39oH3ZpfQzBTv3Il7XbOhATE+LCdnr
 beuSd5fp5XXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 01:00:44 -0700
IronPort-SDR: kn4gR5HrN4iNxo0LPh7RU5ZNfKt9QdfZfM0OAB5AMXCUTL1nmkqIJ3jmYfCbVyGLD3xkfwsnYq
 OeojOBGAHxdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="270430320"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.230.126]) ([10.249.230.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2020 01:00:40 -0700
Subject: Re: [PATCH v10 0/3] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, lkp@intel.com
References: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
 <20200605175314.GQ2750@hirez.programming.kicks-ass.net>
From:   "Antonov, Alexander" <alexander.antonov@linux.intel.com>
Message-ID: <8ffcdb0d-1f2d-1a64-63d8-8064ee42afc3@linux.intel.com>
Date:   Mon, 8 Jun 2020 11:00:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605175314.GQ2750@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Greg Kroah-Hartman had comments for earlier versions of this patch set.
All his comments were addressed, for example in according his remarks
the mapping procedure was reworked to use attr_update flow for new
optional attributes. Also the way of exposing of I/O stacks through
sysfs was redesigned to show up a single file for each mapping of IIO
PMON block to die.

Thanks,
Alexander


On 6/5/2020 8:53 PM, Peter Zijlstra wrote:
> On Mon, Jun 01, 2020 at 11:35:40AM +0300, alexander.antonov@linux.intel.com wrote:
>
> Didn't GregKH have comments on earlier versions of these patches? I
> don't see him on Cc anymore. Were all his comments addressed?
