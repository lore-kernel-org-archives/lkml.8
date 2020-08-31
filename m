Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD8C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D91B206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHaWqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:46:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:58414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHaWqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:46:08 -0400
IronPort-SDR: /vSQlP4cXjlK7tKqyakMiSxTtKh0e1q17vjiqcSqeO5NLEIyYMPzLvoldZFL8ytvPCJSDNGb39
 PLT8bVdbIc7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144818260"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="144818260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 15:45:50 -0700
IronPort-SDR: 3kPxLytFyQve8EiS/uttvND6c2LCCoHrm5YB6W2Mw06GdR2cgpi/ZxoMVwBxijCRcTsaM9QPxn
 1UyXl7v06HHg==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="476932222"
Received: from rmalladi-mobl.amr.corp.intel.com (HELO [10.254.176.90]) ([10.254.176.90])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 15:45:49 -0700
Subject: Re: [PATCH] soundwire: fix error handling
To:     Nick Desaulniers <ndesaulniers@google.com>, trix@redhat.com
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, shreyas.nc@intel.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        yung-chuan.liao@linux.intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200829153515.3840-1-trix@redhat.com>
 <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <aae0bf86-5900-c437-492f-fbf23d3ff196@linux.intel.com>
Date:   Mon, 31 Aug 2020 17:45:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/20 12:47 PM, Nick Desaulniers wrote:
> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this problem
>>
>> stream.c:844:9: warning: Use of memory after
>>    it is freed
>>          kfree(bus->defer_msg.msg->buf);
>>                ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> This happens in an error handler cleaning up memory
>> allocated for elements in a list.
>>
>>          list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>>                  bus = m_rt->bus;
>>
>>                  kfree(bus->defer_msg.msg->buf);
>>                  kfree(bus->defer_msg.msg);
>>          }
>>
>> And is triggered when the call to sdw_bank_switch() fails.
>> There are a two problems.
>>
>> First, when sdw_bank_switch() fails, though it frees memory it
>> does not clear bus's reference 'defer_msg.msg' to that memory.
>>
>> The second problem is the freeing msg->buf. In some cases
>> msg will be NULL so this will dereference a null pointer.
>> Need to check before freeing.
>>
>> Fixes: 99b8a5d608a6 ("soundwire: Add bank switch routine")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/soundwire/stream.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 37290a799023..6e36deb505b1 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -717,6 +717,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>>          kfree(wbuf);
>>   error_1:
>>          kfree(wr_msg);
>> +       bus->defer_msg.msg = NULL;
> 
> This fix looks correct to me because L668 sets `bus->defer_msg.msg =
> wr_msg;`, but on error L719 frees `wr_msg`, so now
> `bus->defer_msg.msg` is a dangling pointer.
> 
>>          return ret;
>>   }
>>
>> @@ -840,9 +841,10 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>>   error:
>>          list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>>                  bus = m_rt->bus;
>> -
>> -               kfree(bus->defer_msg.msg->buf);
>> -               kfree(bus->defer_msg.msg);
>> +               if (bus->defer_msg.msg) {
>> +                       kfree(bus->defer_msg.msg->buf);
>> +                       kfree(bus->defer_msg.msg);
>> +               }
> 
> I'd prefer a conditional check for each, but sdw_ml_sync_bank_switch()
> has this same pattern, so it looks like the lifetime of these two
> match.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Also looks good to me.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
