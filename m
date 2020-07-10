Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61C82065C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoMxyh6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGJDdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGJDdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:33:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4CC08C5CE;
        Thu,  9 Jul 2020 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OsNunWJ9eGAHX4ut8rpPqYEAeOB8ig5CVeRR1qqQlX0=; b=XoMxyh6ZlnoqzIreMr9ki7lnEw
        Vcz+XOCRndPiRKQm02UDDvlBmsMgI96U/21D75cn3yDmd/aTdFRyF7xLo2+KivMAQvuwMbhG08BVL
        nm1P66zCf1Kb0HHdL4833/IrYHYnW72HJ+DaFTyyKP9i3ujJqdlPnJzY4rMKQL4U+OkgFm5KO8z0Y
        LS/OFX5BSs2zJKgwNeQ5ghBRrdTS0dhWG3RoLhtTPbsQFHkKS23AmLDCFuL7o4IcPMPmDE+D0RsID
        AkjYJ/VZxi0Mve+JC1X/g3wUf46mfVbWYe5uL9h47UJ1q1M8/HbLBydUL2kElnbPb5b1DV11pxudJ
        HxcOso8w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtjmb-0001Nb-7g; Fri, 10 Jul 2020 03:33:05 +0000
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <50cc0a0d-e04e-9e5d-26a6-73a91944ba8c@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f360b009-e7b2-db5c-6d46-1daca76bea24@infradead.org>
Date:   Thu, 9 Jul 2020 20:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <50cc0a0d-e04e-9e5d-26a6-73a91944ba8c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 8:30 PM, Anshuman Khandual wrote:
> 
> On 07/09/2020 09:04 PM, Randy Dunlap wrote:
>> Hi,
>>
>> I have a few comments on this.
>>
>> a. I reported it very early and should have been Cc-ed.
> 
> I should have Cc-ed you on this V4 patch, sorry about that.
> 
>>
>> b. A patch that applies to mmotm or linux-next would have been better
>> than a full replacement patch.
> I have followed that (i.e patch on mmotm/next as fix) only when the
> required change is smaller as compared to the series on mmotm/next.
> But for others a new patch should be better which can be replaced
> on mmotm and next. At least that is my understanding and would like
> to be corrected otherwise.
> 
>>
>> c. I tried replacing what I believe is the correct/same patch file in mmotm
>> and still have build errors.
> 
> That should not have happened, all new THP migration events are with
> CONFIG_MIGRATION rather than CONFIG_TRANSPARENT_HUGEPAGE previously.

Yes, I could have been mistaken about that last part.  Sorry about that.

-- 
~Randy

