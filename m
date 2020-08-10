Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C69C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D768E206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgHJEgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:36:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHJEgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:36:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E5CABE2;
        Mon, 10 Aug 2020 04:36:54 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] x86/xen: remove 32-bit Xen PV guest support
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-2-jgross@suse.com>
 <893bc936-81bf-1e86-8423-a61fbfb5dc02@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8dc06c59-54a5-8716-5e26-ec1442aaadd4@suse.com>
Date:   Mon, 10 Aug 2020 06:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <893bc936-81bf-1e86-8423-a61fbfb5dc02@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.20 04:01, Boris Ostrovsky wrote:
> On 8/7/20 4:38 AM, Juergen Gross wrote:
>>   
>>   void __init xen_reserve_top(void)
>>   {
>> -#ifdef CONFIG_X86_32
>> -	unsigned long top = HYPERVISOR_VIRT_START;
>> -	struct xen_platform_parameters pp;
>> -
>> -	if (HYPERVISOR_xen_version(XENVER_platform_parameters, &pp) == 0)
>> -		top = pp.virt_start;
>> -
>> -	reserve_top_address(-top);
>> -#endif	/* CONFIG_X86_32 */
>>   }
>>   
> 
> 
> We should be able now to get rid of xen_reserve_top() altogether.

Oh, yes.

> 
> 
> Other than that
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks,

Juergen
