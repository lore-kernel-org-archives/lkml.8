Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2793AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034192088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590694921;
	bh=vEeHCYhh4W9hknEzn2D84XrYsPb35CXWQHbBn6eUN/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2mfQyKTiuXOwmJDfvV3b+lJ4o2UE1nZe7Dw8BklkFePUfRFWE/40gu4ffsarFv33
	 ikZIQHE2L1HW757yzUqFIFpqU66Coy0/qPLkViWjA9bj3cnvBUxiBmLZKvWNcsZE1/
	 3BKkK7zN/XJrlY2NGzI/7WNf4/CPym6BEJ90SaVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406703AbgE1TmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406540AbgE1Tl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:41:58 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446202078C;
        Thu, 28 May 2020 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590694918;
        bh=vEeHCYhh4W9hknEzn2D84XrYsPb35CXWQHbBn6eUN/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yD2JQCHUWxhNY9JA0dk5XPD//RJLMDI25b6K37Eg7kaHDXQnhe6qEAucfDAUOjw2+
         Nn4y/ABJk32VxAAvyjbsiPh6XnGc6eEdn4t8hAXfwspOkC2bcp7W+htxtPX7iKjsZM
         EeAA5KuR1UbsMwjnZ/SrAu+W+fJ5KLEQQpS9sdGQ=
Date:   Thu, 28 May 2020 15:41:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200528194157.GB1407771@sasha-vm>
References: <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
 <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <20200528191910.GC2147934@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528191910.GC2147934@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:19:10PM +0300, Jarkko Sakkinen wrote:
>On Thu, May 28, 2020 at 01:40:16PM -0400, Don Porter wrote:
>> Hi Thomas,
>>
>> On 5/28/20 6:29 AM, Thomas Gleixner wrote:
>> > > Until recently, we were doing proof-of-concept research, not product
>> > > development, and there are limited hours in the day.  I also hasten to
>> > > say that the product of research is an article, the software artifact
>> > > serves as documentation of the experiment.  In contrast, the product of
>> > > software development is software.  It takes significant time and effort
>> > > to convert one to the other.  Upstreaming code is of little scientific
>> > > interest.  But things have changed for our project; we had no users in
>> > > 2015 and we are now un-cutting corners that are appropriate for research
>> > > but inappropriate for production.  For a research artifact with an
>> > > audience that knew the risks, we shipped a module because it was easier
>> > > to maintain and install than a kernel patch.
>> >
>> > I understand that and with a big fat warning and documentation from
>> > start I wouldn't have complained so vehemently.
>>
>> This is a fair point.  We will fix this ASAP, and I will be more careful
>> about this going forward.
>
>Are you going to experiment with this patch set and Graphene? Just
>sanity checking so that I don't unnecessarily do duplicate work.
>
>I ignored most of the discussion since I came here only with the
>motivation of testing Graphene together with this patch set. I'm
>assuming that motivation is always good no matter which angle you come
>from. Thus, I might have missed the part I'm asking.

This series was heavily tested with Graphene-like workloads.

-- 
Thanks,
Sasha
