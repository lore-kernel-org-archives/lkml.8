Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61AF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vVEMCikI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHUR1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgHUR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:27:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ul+gFaNtlJOoBCsfhqEauq0nuZHw8rqKz8hEMkaSUTk=; b=vVEMCikIdu3Oo709RpqpXJN25W
        JStqkEtsWWYGUgy63+1r1+NYbMGeDuPRT2vmR+W6piIUO0xQpJlBENv63uGMJQdtYCAMk5pOMlz7N
        Pd0C7dCE30Bf5lcfwhns6N75K3xlSLnrc932JkOZDvM3F6B4YbKN8Fu5XC+ftLbkbKRrTEIQcZD7E
        J6GCsFPX61KkD9QE6St5l7V5nhRHw6EWZIErTxt4nvSvTpGomzx1+OsMBMaTZJgsZ8Mt7XGDX3/ni
        Ry7SzDr2CpZIDdBsnRNdyUaYS7VMn8dLuCdQGgio690WbC3w8SzVSacLcQeZg1JeKAbaJcS4vR0gM
        3j7035Iw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Ap0-000578-G1; Fri, 21 Aug 2020 17:27:22 +0000
Subject: Re: make defconfig (Re: +
 x86-defconfigs-explicitly-unset-config_64bit-in-i386_defconfig.patch added to
 -mm tree)
To:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Cc:     daniel.diaz@linaro.org, sedat.dilek@gmail.com
References: <20200820212940.Kq1ky-JHH%akpm@linux-foundation.org>
 <20200821172231.GA1444408@localhost.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dc2fbc95-8c8a-5613-f4bd-f29328bb695c@infradead.org>
Date:   Fri, 21 Aug 2020 10:27:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821172231.GA1444408@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 10:22 AM, Alexey Dobriyan wrote:
> On Thu, Aug 20, 2020 at 02:29:40PM -0700, akpm@linux-foundation.org wrote:
>> Subject: x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig
>>
>> A recent refresh of the defconfigs got rid of the following (unset)
>> config:
>>
>>   # CONFIG_64BIT is not set
>>
>> Innocuous as it seems, when the config file is saved again the
>> behavior is changed so that CONFIG_64BIT=y.
>>
>> Currently,
>>
>>   $ make i386_defconfig
>>   $ grep CONFIG_64BIT .config
>>   CONFIG_64BIT=y
>>
>> whereas previously (and with this patch):
>>
>>   $ make i386_defconfig
>>   $ grep CONFIG_64BIT .config
>>   # CONFIG_64BIT is not set
> 
> It is highly, highly, highly advisable to always pass ARCH when dealing
> with 32/64-bit archs:
> 
> 	+---------------------------------------+
> 	|	make ARCH=x86_64 defconfig	|
> 	|	make ARCH=i386 defconfig	|
> 	+---------------------------------------+

I certainly always do that and I also avoid
ARCH=x86
although it is supported/allowed.

-- 
~Randy

