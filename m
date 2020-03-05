Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC022072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5Ib57qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCETTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:19:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCETTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Q0cdYZagAxQ35sfIY3akXlSzgSgXU3F+wa//Hvdh9+Q=; b=H5Ib57qvdKw7Mz/AanO+yK+B0W
        z84d3BuM78jl16s+/PVAaag/tyX0+t8qSY6EGzm3/BVB8ClfUvXDlcgxV4/TogYWR8ecIV+obfUVz
        lyxzhXrk/S43l8eO3plUmbBAC326NM2iaUmzGS2jr49MN+qf6/iZyTmdFDNTsbFE+t29xCOJ8unTo
        1GVV5kgJoEt5iaZhiq6ULX4e2w66mbzEhje0jSYsZizWtdR8tFx/MzpGX0gbX+CR4QK7iK3jqj7yh
        /stDd00jI3HpNbAPjhgZtNvebZvCRnUGduAk3Xmjh7v/96vF340GUU5fIQzLiJVhNqu1qs9W+s3M/
        55uBzH6g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9w1s-0007X5-Lz; Thu, 05 Mar 2020 19:19:32 +0000
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
 <ac1c953b-fa5d-818d-5232-19a28f52f556@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32047314-c91e-0405-bcfe-43d515128231@infradead.org>
Date:   Thu, 5 Mar 2020 11:19:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ac1c953b-fa5d-818d-5232-19a28f52f556@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 11:06 AM, Markus Elfring wrote:
>>>>> Which of the possibly unanswered issues do you find not concrete enough so far?
>>>>
>>>> e.g.:
>>>>>>>  Will the clarification become more constructive for remaining challenges?
>>>
>>> Do you expect that known open issues need to be repeated for each patch revision?
>>
>> Ideally not, but not very much is ideal.
> 
> Did you notice any aspects where I would be still looking for more helpful answers?

Sorry, I haven't been tracking all of the email Q&A/response/replies
all that carefully.

> 
>> IOW, it is sometimes required (if one cares enough; sometimes
>> one just gives up).
> 
> I find this communication detail unfortunate occasionally.

Sure. I do too.

> 
>>> How do you think about the desired tracking of bug reports
>>> also for this software?
> …
>> Masami seems to be responsive.
> 
> The involved contributors show different response delays, don't they?

That's always the case, in any of the Linux subsystems that I have
been involved with.

-- 
~Randy

