Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BCF20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbgE0Oqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:46:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:55605 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388680AbgE0Oql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:46:41 -0400
IronPort-SDR: 5JuA2gagmIckusVrjs2kRWPOMzaw+v0oBzdFvf593jUM2LW80LB4aLz1JR3RkVPJum0LLAuPv4
 2a+FfyIGCg6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 07:46:41 -0700
IronPort-SDR: UHRysOgJLUfbGaG/jv+qNoX5gdQI/PMPa7q/aQJP53gyQ2JVDwj58UzdTplKjM3N785n67w0x8
 gyQMA/+GEdUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="291617786"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2020 07:46:41 -0700
Received: from [10.251.8.26] (kliang2-mobl.ccr.corp.intel.com [10.251.8.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 819575805EF;
        Wed, 27 May 2020 07:46:40 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix oops when counting IMC uncore
 events on some TGL
To:     David Laight <David.Laight@ACULAB.COM>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1590582647-90675-1-git-send-email-kan.liang@linux.intel.com>
 <869fafc80da84d188678c1cbb0267a0b@AcuMS.aculab.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ed3d86b7-2f75-cfe9-bc74-5f2c29ef2540@linux.intel.com>
Date:   Wed, 27 May 2020 10:46:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <869fafc80da84d188678c1cbb0267a0b@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2020 8:59 AM, David Laight wrote:
> From: kan.liang@linux.intel.com
>> Sent: 27 May 2020 13:31
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> When counting IMC uncore events on some TGL machines, an oops will be
>> triggered.
>>    [ 393.101262] BUG: unable to handle page fault for address:
>>    ffffb45200e15858
>>    [ 393.101269] #PF: supervisor read access in kernel mode
>>    [ 393.101271] #PF: error_code(0x0000) - not-present page
>>
>> Current perf uncore driver still use the IMC MAP SIZE inherited from
>> SNB, which is 0x6000.
>> However, the offset of IMC uncore counters for some TGL machines is
>> larger than 0x6000, e.g. 0xd8a0.
>>
>> Enlarge the IMC MAP SIZE for TGL to 0xe000.
> 
> Replacing one 'random' constant with a different one
> doesn't seem like a proper fix.
> 
> Surely the actual bounds of the 'memory' area are properly
> defined somewhere.
> Or at least should come from a table.
> 
> You also need to verify that the offsets are within the mapped area.
> An unexpected offset shouldn't try to access an invalid address.

Thanks for the review.

I agree that we should add a check before mapping the area to prevent 
the issue happens again.

I think the check should be a generic check for all platforms which try 
to map an area, not just for TGL. I will submit a separate patch for the 
check.

Thanks,
Kan

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
