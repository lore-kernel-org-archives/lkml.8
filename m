Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D404520936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PbmFBP4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgIHRvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbgIHRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6500C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Bt5XfXEwClw+tcHLXQSYRDHiN3930ztsk0AmpBMXPHw=; b=PbmFBP4YXNaoOsWN2J/oR/DhUn
        z/nFeSn49r23Kgm2Tssm5488Seqmb6Txwo7xppp9EK165g99bX80HpZFchB+CxjPCGCtOwyew/iTO
        1l40CLAl23AEBfLKPt7Z2CpwRDhfrgwahSlcE2O4xX95qGuulCe/V4NJYLxY2+cZHaepxtzux1YXv
        U8NQ6S+r7dpmkDWqZ3/LWq8SzTgYXBFztLrylGbELhWsp2xSOIAfXC36vOAT3cLChT0FgC5jk/RbI
        vB0iBp06Ct1iP0xwzxETg3oUNuQ4+ujNJ9vk0+AadMAxPTsKOdtdNsE2oWvtrPenqNXUiadrUegdB
        AN+2WQtw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFhlS-00061f-Vf; Tue, 08 Sep 2020 17:50:43 +0000
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
To:     Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f96a76a0-1ecb-aa3b-0f8a-d978bb1b1787@infradead.org>
Date:   Tue, 8 Sep 2020 10:50:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908121354.GA3848343@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 5:13 AM, Ingo Molnar wrote:
> 
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
>> 32-bit builds using defconfig become broken because on x86_64 build host
>> with no ARCH provided the default behaviour is to assume 64-bit independently
>> on the configuration file name. The crucial part is CONFIG_64BIT option
>> that used to be explicit. Let restore the latter option in order to unbreak
>> 32-bit builds.
> 
> So exactly which build method broke due to this? The typical way to do a defconfig build is:
> 
>   make ARCH=i386 defconfig
> 
> which still works fine AFAICS.
> 
> Thanks,
> 
> 	Ingo
> 

Here is a previous patch from someone else:

https://lore.kernel.org/lkml/20200810155943.2583275-1-daniel.diaz@linaro.org/


-- 
~Randy

