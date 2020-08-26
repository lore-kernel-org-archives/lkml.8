Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0BE221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHZOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:34:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgHZOdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F8181FB;
        Wed, 26 Aug 2020 07:33:37 -0700 (PDT)
Received: from [10.57.5.66] (unknown [10.57.5.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4136E3F68F;
        Wed, 26 Aug 2020 07:33:36 -0700 (PDT)
Subject: Re: [PATCH] perf: correct SNOOPX field offset
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
From:   Al Grant <al.grant@foss.arm.com>
Message-ID: <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
Date:   Wed, 26 Aug 2020 15:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20200826142631.GA5351@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
>> On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
>>> perf_event.h has macros that define the field offsets in the
>>> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
>>> were both 37. These are distinct fields, and the bitfield layout
>>> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
>>
>> Looks good.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>
>> Probably should have a Fixes: header
> 
> Please do so, find the patch that introduced the error, add the Fixes
> tag, will help me not having to do it myself :-)

Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info 
encodings")
