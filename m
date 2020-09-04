Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5BC28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBEE206E7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lo+Ecl82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIDGML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIDGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:12:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A49C061244;
        Thu,  3 Sep 2020 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ytK8UiWzHHegMm41JlHypigctQNmCJQNBkvErIXfdHw=; b=lo+Ecl82biNs2e0KfP/1bUeKyR
        0hXUqn3XQ+/Sl6r0zNPzXBQyduGVLY3nvMJ4sL1RIAXfFwGup/GUEpOu0gRrl7MN4+5oOmbCL1lrv
        t/At9U5k+3LkGBWDvry8uLVCJewPrOVSH2UkS21T6RrxfruRqLIy0855WI0c67ZTmaLSwzACwCX5X
        aUfJNAqQ+Nmn3XdqJoXFtLJRxbPFZKK8GQ++YQPRSrvoHqhg/CFC/vWmZJ8peJHQeqGO54pDqjmRY
        RC2LDv7witgtssys4nUXLOB0J1RWhayaDEKuDo/6tQrL0lO2xaSNLoS4DN9NHgOubEJiW2fIR3ANU
        iC24wndg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE4xB-0001YN-Ds; Fri, 04 Sep 2020 06:12:05 +0000
Subject: Re: linux-next: Tree for Sep 2 (lib/ubsan.c)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20200902180950.4bc7c4de@canb.auug.org.au>
 <3abfa193-a56e-66ba-1080-885906fa0196@infradead.org>
Message-ID: <fdf322d4-cc01-2c85-67cd-86b2d6f4ebff@infradead.org>
Date:   Thu, 3 Sep 2020 23:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3abfa193-a56e-66ba-1080-885906fa0196@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 8:44 AM, Randy Dunlap wrote:
> On 9/2/20 1:09 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20200828:
>>
> 
> 
> on i386:
> 
> ../lib/ubsan.c: In function ‘ubsan_prologue’:
> ../lib/ubsan.c:141:2: error: implicit declaration of function ‘kunit_fail_current_test’; did you mean ‘kunit_init_test’? [-Werror=implicit-function-declaration]
>   kunit_fail_current_test();
> 
> 
> Full randconfig file is attached.
> 

Hi Brendan,

Do you know anything about this build error?

I can't find kunit_fail_current_test() anywhere.

thanks.
-- 
~Randy

