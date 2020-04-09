Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EF3206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgDIOw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:52:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgDIOw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:52:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 02BAEAD10;
        Thu,  9 Apr 2020 14:52:54 +0000 (UTC)
Subject: Re: [PATCH] x86/xen: fix booting 32-bit pv guest
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200409070001.16675-1-jgross@suse.com>
 <ee2aa0c4-b633-a5e6-436c-0776407c98ac@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <cce1a59b-983f-85aa-95a4-f7b5bc82c39e@suse.com>
Date:   Thu, 9 Apr 2020 16:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ee2aa0c4-b633-a5e6-436c-0776407c98ac@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.20 16:44, Boris Ostrovsky wrote:
> 
> On 4/9/20 3:00 AM, Juergen Gross wrote:
>> Commit 2f62f36e62daec ("x86/xen: Make the boot CPU idle task reliable")
>> introduced a regression for booting 32 bit Xen PV guests: the address
>> of the initial stack needs to be a virtual one.
>>
>> Fixes: 2f62f36e62daec ("x86/xen: Make the boot CPU idle task reliable")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
>> ---
>>   arch/x86/xen/xen-head.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
>> index 7d1c4fcbe8f7..1ba601df3a37 100644
>> --- a/arch/x86/xen/xen-head.S
>> +++ b/arch/x86/xen/xen-head.S
>> @@ -38,7 +38,7 @@ SYM_CODE_START(startup_xen)
>>   #ifdef CONFIG_X86_64
> 
> 
> While at it, I'd swap the ifdefs and fold x86_64 case into the one below.

I wanted to remove 32-bit PV support from the kernel soon, so I think
this can wait until then. :-)


Juergen
