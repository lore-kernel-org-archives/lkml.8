Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55650C3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB862465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SjzIXiSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBTFNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:13:02 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:34662 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgBTFNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:13:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582175581; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ao1uwixRp+mRr4IVPkNGuxraZYvp+rb//Bou7aXajek=;
 b=SjzIXiSSBhskYb4oNvCHmSzBmyzNbOFVXBAsMnW3OdKYT2dwR66oIwdRaHnCmuNlQjomVXCG
 PGiAtUyxnrfTuRGWXYVXknFGR/7r60rsDXalrEyqKwD6pcuOCENUktpeX7ffSNXdppChPfL2
 i5rA2/q5YKw/dQTVyP6spg9zFUg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4e1556.7fad6d94e848-smtp-out-n01;
 Thu, 20 Feb 2020 05:12:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EA5CC4479F; Thu, 20 Feb 2020 05:12:53 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11D60C43383;
        Thu, 20 Feb 2020 05:12:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Feb 2020 10:42:52 +0530
From:   vjitta@codeaurora.org
To:     Christopher Lameter <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        kernel-team@android.com, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] mm: slub: reinitialize random sequence cache on slab
 object update
In-Reply-To: <7bf56496-7b8a-c60f-b261-9505068f9130@codeaurora.org>
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
 <alpine.DEB.2.21.2001301826130.9861@www.lameter.com>
 <7bf56496-7b8a-c60f-b261-9505068f9130@codeaurora.org>
Message-ID: <f5c4c74ecb1f43992285bb5f57ee874c@codeaurora.org>
X-Sender: vjitta@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-03 12:27, Vijayanand Jitta wrote:
> On 1/30/2020 11:58 PM, Christopher Lameter wrote:
>> On Thu, 30 Jan 2020, vjitta@codeaurora.org wrote:
>> 
>>> Random sequence cache is precomputed during slab object creation
>>> based up on the object size and no of objects per slab. These could
>>> be changed when flags like SLAB_STORE_USER, SLAB_POISON are updated
>>> from sysfs. So when shuffle_freelist is called during slab_alloc it
>> 
>> Sorry no. That cannot happen. Changing the size of the slab is only
>> possible if no slab pages are allocated. Any sysfs changes that affect 
>> the
>> object size must fail if object and slab pages are already allocated.
>> 
>> If you were able to change the object size then we need to prevent 
>> that
>> from happening.
>> 
> 
> Yes, size of slab can't be changed after objects are allocated, that 
> holds
> true even with this change. Let me explain a bit more about the use 
> case here
> 
> ZRAM compression uses the slub allocator, by enabling the slub debug 
> flags like
> SLAB_STORE_USER etc.. the memory consumption will rather be increased
> which doesn't
> serve the purpose of ZRAM compression. So, such flags are to be
> disabled before the
> allocations happen, this requires updation of random sequence cache as 
> object
> size and number of objects change after these flags are disabled.
> 
> So, the sequence will be
> 
> 1. Slab creation (this will set a precomputed random sequence cache)
> 2. Remove the debug flags
> 3. update the random sequence cache
> 4. Mount zram and then start using it for allocations.
> 
> Thanks,
> Vijay

Waiting for your response.

Thanks,
Vijay
