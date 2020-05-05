Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42CCC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF3E20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fYmwFUg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgEEHFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEHFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:05:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD97C061A0F;
        Tue,  5 May 2020 00:05:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49GW2k5q0Xz9sSW;
        Tue,  5 May 2020 17:05:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588662335;
        bh=H00OX7RP5R/3kEmopsCjXrH1lsQwJrq85ywrofnmMQM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fYmwFUg7g8bmO38b1fqi+JE6bHIiWF6qt6ts8fmVsmDsU8XYEpKppPJW42rheIt8s
         L5uA4RRsd1/15ANSzo4d7vPTAQVJ9QOQmnVmJ3H94lJhnxtATO0QxWd3k/qrBd9MbU
         +pXE3BIlWFCKnHt6uF+EFF/DqlqcqNzxXaL49wx7JccfwsiQygZeAd2Mm3c6DLcsuc
         6J+ODZJ5GYoOzFzeSJ32WLYQq4YhxhLGubcucVrJn1UsWqBnQnSI2+RTHCvie2thmM
         SwlGYirksU5r4Ug1xCgjLD9NMUGs1qC9sk+FGWnBDkqzKBx4hrPSTEhikKOULzKYg/
         RIDaTMmK2KQNg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     kajoljain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v7 5/5] powerpc/hv-24x7: Update post_mobility_fixup() to handle migration
In-Reply-To: <9586f8ef-1f3e-d45c-e0dc-665889a4f190@linux.ibm.com>
References: <20200327063642.26175-1-kjain@linux.ibm.com> <20200327063642.26175-6-kjain@linux.ibm.com> <877dxyfrpz.fsf@mpe.ellerman.id.au> <9586f8ef-1f3e-d45c-e0dc-665889a4f190@linux.ibm.com>
Date:   Tue, 05 May 2020 17:05:52 +1000
Message-ID: <874ksueu9b.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kajoljain <kjain@linux.ibm.com> writes:
> On 4/29/20 5:07 PM, Michael Ellerman wrote:
>> Kajol Jain <kjain@linux.ibm.com> writes:
>>> Function 'read_sys_info_pseries()' is added to get system parameter
>>> values like number of sockets and chips per socket.
>>> and it gets these details via rtas_call with token
>>> "PROCESSOR_MODULE_INFO".
>>>
>>> Incase lpar migrate from one system to another, system
>>> parameter details like chips per sockets or number of sockets might
>>> change. So, it needs to be re-initialized otherwise, these values
>>> corresponds to previous system values.
>>> This patch adds a call to 'read_sys_info_pseries()' from
>>> 'post-mobility_fixup()' to re-init the physsockets and physchips values.
>>>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/mobility.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index b571285f6c14..226accd6218b 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -371,6 +371,18 @@ void post_mobility_fixup(void)
>>>  	/* Possibly switch to a new RFI flush type */
>>>  	pseries_setup_rfi_flush();
>>>  
>>> +	/*
>>> +	 * Incase lpar migrate from one system to another, system
>> 
>> In case an LPAR migrates
>> 
>>> +	 * parameter details like chips per sockets and number of sockets
>>> +	 * might change. So, it needs to be re-initialized otherwise these
>>                              ^                                       ^
>>                              they need                               the
>>> +	 * values corresponds to previous system.
>>                   ^
>>                   will correspond to the
>> 
>>> +	 * Here, adding a call to read_sys_info_pseries() declared in
>> 
>> Adding is the wrong tense in a comment. When someone reads the comment
>> the code has already been added. Past tense would be right, but really
>> the comment shouldn't say what you did, it should say why.
>> 
>>> +	 * platforms/pseries/pseries.h to re-init the physsockets and
>>> +	 * physchips value.
>> 
>> Call read_sys_info_pseries() to reinitialise the values.
>> 
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_HV_PERF_CTRS) && IS_ENABLED(CONFIG_PPC_RTAS))
>>> +		read_sys_info_pseries();
>> 
>> The RTAS check is not needed. pseries always selects RTAS.
>> 
>> You shouldn't need the IS_ENABLED() check here though, do it with an
>> empty version in the header when CONFIG_HV_PERF_CTRS is not enabled.
>> 
>
> Hi Michael,
> 	Thanks for reviewing the patch. Is something like this you are suggesting. Please
> let me know if my understanding is fine.
>
> +#ifndef CONFIG_HV_PERF_CTRS
> +#define read_sys_info_pseries() 
> +#endif

It should be an empty static inline. So more like:

#ifdef CONFIG_HV_PERF_CTRS
void read_sys_info_pseries(void);
#else
static inline void read_sys_info_pseries(void) { }
#endif

cheers
