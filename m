Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BCA20775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/KLhL+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgDTQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgDTQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:14:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062ECC061A0C;
        Mon, 20 Apr 2020 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=xudTG6A7+qcVFoLFZf/JKAo5nIg1+DsDp60lgvIOJr0=; b=O/KLhL+axrhzsZuHOxClDbjVqK
        ozfgl/qe8lFedt22O8MwyzwyluTuFhQXJupG68Ud3C/MwqLUK5CnCkoofGAar3iN3+4VsBpe+6GaF
        CHC1U9TXWl9Rovu1NcduCxhIgYqeDZ7AWdY8+y8KuKwwFcMY23st/k3IqgO7XSrQR8uLT/HhOlb5s
        +e4MqJwhrZv67Dee5d4eFzP05UkSHRC43iMEr+Ykg9h2lPVLd2hUiFjQVIF2X3IX5QgDneL9zIT1E
        ymGUtLDHJUKV+fcwYk4K8z5H/0OzWC8QBgVhTvDZDLgRRCLC2LjaVfvaH44TlKtxbUl6Mw/7H+kBU
        UL3guzYg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQZ3g-0006GE-UI; Mon, 20 Apr 2020 16:14:09 +0000
Subject: Re: linux-next: Tree for Apr 20 (objtool warning)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200420142610.390e5922@canb.auug.org.au>
 <30d5a881-95fe-9f98-a899-2c955c5eb2c1@infradead.org>
 <20200420155330.5uepjeyfsso5l4rm@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96be5a96-07f6-7343-e159-ffb110646d76@infradead.org>
Date:   Mon, 20 Apr 2020 09:14:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420155330.5uepjeyfsso5l4rm@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 8:53 AM, Josh Poimboeuf wrote:
> On Mon, Apr 20, 2020 at 08:29:04AM -0700, Randy Dunlap wrote:
>> On 4/19/20 9:26 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20200417:
>>>
>>
>> on x86_64:
>>
>> arch/x86/kvm/svm/vmenter.o: warning: objtool: __svm_vcpu_run()+0xe4: BP used as a scratch register
>>
>> Full randconfig file is included.
> 
> Yeah, frame pointers are toast in that function.  We'll need something
> like:

That works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index a789759b7261..221e2bd7e76d 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -3,6 +3,10 @@
>  ccflags-y += -Iarch/x86/kvm
>  ccflags-$(CONFIG_KVM_WERROR) += -Werror
>  
> +ifeq ($(CONFIG_UNWINDER_FRAME_POINTER),y)
> +OBJECT_FILES_NON_STANDARD_vmenter.o := y
> +endif
> +
>  KVM := ../../../virt/kvm
>  
>  kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> 
> 


-- 
~Randy
