Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD707C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 06:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53B20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cMIbu2S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBCG50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 01:57:26 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:30172 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgBCG50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 01:57:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580713045; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=C4QB4M4fKOaUUkrXU+/PFkSTNwpbFRIW0mgYlUgOiLc=; b=cMIbu2S4lkdP5zaCNcYHfXBsoBGgvvhiLM1YO0H/fRPX+2Hm9y1n1wwixPvvR5f2OEspBlgU
 5SkMXlAHw9eZFW27BEI8Oe2Xmn9N3Moi/vQ4E2UK6tJOP7h8M3qhprPwrcs4tGZ6Us7v6IFa
 4Bxr918IzBoCtj82xrHshhNQdg8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e37c454.7fcd154bd848-smtp-out-n02;
 Mon, 03 Feb 2020 06:57:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 523B3C433A2; Mon,  3 Feb 2020 06:57:24 +0000 (UTC)
Received: from [10.204.79.71] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2E5FC433CB;
        Mon,  3 Feb 2020 06:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2E5FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] mm: slub: reinitialize random sequence cache on slab
 object update
To:     Christopher Lameter <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        kernel-team@android.com
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
 <alpine.DEB.2.21.2001301826130.9861@www.lameter.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <7bf56496-7b8a-c60f-b261-9505068f9130@codeaurora.org>
Date:   Mon, 3 Feb 2020 12:27:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001301826130.9861@www.lameter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2020 11:58 PM, Christopher Lameter wrote:
> On Thu, 30 Jan 2020, vjitta@codeaurora.org wrote:
> 
>> Random sequence cache is precomputed during slab object creation
>> based up on the object size and no of objects per slab. These could
>> be changed when flags like SLAB_STORE_USER, SLAB_POISON are updated
>> from sysfs. So when shuffle_freelist is called during slab_alloc it
> 
> Sorry no. That cannot happen. Changing the size of the slab is only
> possible if no slab pages are allocated. Any sysfs changes that affect the
> object size must fail if object and slab pages are already allocated.
> 
> If you were able to change the object size then we need to prevent that
> from happening.
> 

Yes, size of slab can't be changed after objects are allocated, that holds
true even with this change. Let me explain a bit more about the use case here

ZRAM compression uses the slub allocator, by enabling the slub debug flags like
SLAB_STORE_USER etc.. the memory consumption will rather be increased which doesn't
serve the purpose of ZRAM compression. So, such flags are to be disabled before the
allocations happen, this requires updation of random sequence cache as object
size and number of objects change after these flags are disabled.

So, the sequence will be

1. Slab creation (this will set a precomputed random sequence cache) 
2. Remove the debug flags 
3. update the random sequence cache 
4. Mount zram and then start using it for allocations.

Thanks,
Vijay
