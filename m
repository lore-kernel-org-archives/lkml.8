Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C872C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223DE20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgF2UIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:08:36 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:10847 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbgF2TaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:23 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: jRfbOdaUpIV5NuTDp9xgStPlFJ7H7FU9MkvbzFpf6SC+gjm1TCq/JlRMLcrC7UJAyIMPw89gJS
 eVqG7hgGVyCXEhehd/EmuVIEnOji1laX9+U6DlPOHnWFpCDzpSpeyOH0d8zzrcIGvO7xQHwgsP
 gi2SrcUOyubaHunpUUz+FhFEs966VAB/WiHbNGUCfdnOxx+HefctRE9q9UD7ZO7H7bgwYWaDMm
 N4lJ50WCn4F60J6BG2F2i+5cvSz64wE5F03LZqxfUBuFeQbFgaruwG+fYamMknztCeLiExj6Jt
 dMw=
X-SBRS: 2.7
X-MesageID: 21469946
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,294,1589256000"; 
   d="scan'208";a="21469946"
Subject: Re: [PATCH fsgsbase v2 4/4] x86/fsgsbase: Fix Xen PV support
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>, <x86@kernel.org>
CC:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
References: <cover.1593192140.git.luto@kernel.org>
 <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
 <714d4c04-5907-885f-e23b-baef662f1080@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <9740c5ee-9072-b4f6-5b20-b609d42bf8bb@citrix.com>
Date:   Mon, 29 Jun 2020 12:07:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <714d4c04-5907-885f-e23b-baef662f1080@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2020 06:17, Jürgen Groß wrote:
> On 26.06.20 19:24, Andy Lutomirski wrote:
>> On Xen PV, SWAPGS doesn't work.  Teach __rdfsbase_inactive() and
>> __wrgsbase_inactive() to use rdmsrl()/wrmsrl() on Xen PV.  The Xen
>> pvop code will understand this and issue the correct hypercalls.
>>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: xen-devel@lists.xenproject.org
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>   arch/x86/kernel/process_64.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index cb8e37d3acaa..457d02aa10d8 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -163,9 +163,13 @@ static noinstr unsigned long
>> __rdgsbase_inactive(void)
>>         lockdep_assert_irqs_disabled();
>>   -    native_swapgs();
>> -    gsbase = rdgsbase();
>> -    native_swapgs();
>> +    if (!static_cpu_has(X86_FEATURE_XENPV)) {
>> +        native_swapgs();
>> +        gsbase = rdgsbase();
>> +        native_swapgs();
>> +    } else {
>> +        rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
>> +    }
>>         return gsbase;
>>   }
>> @@ -182,9 +186,13 @@ static noinstr void __wrgsbase_inactive(unsigned
>> long gsbase)
>>   {
>>       lockdep_assert_irqs_disabled();
>>   -    native_swapgs();
>> -    wrgsbase(gsbase);
>> -    native_swapgs();
>> +    if (!static_cpu_has(X86_FEATURE_XENPV)) {
>> +        native_swapgs();
>> +        wrgsbase(gsbase);
>> +        native_swapgs();
>> +    } else {
>> +        wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
>> +    }
>>   }
>>     /*
>>
>
> Another possibility would be to just do (I'm fine either way):
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index acc49fa6a097..b78dd373adbf 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -318,6 +318,8 @@ static void __init xen_init_capabilities(void)
>          setup_clear_cpu_cap(X86_FEATURE_XSAVE);
>          setup_clear_cpu_cap(X86_FEATURE_OSXSAVE);
>      }
> +
> +    setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);

That will stop both userspace and Xen (side effect of the guest kernel's
CR4 choice) from using the instructions.

Even when the kernel is using the paravirt fastpath, its still Xen
actually taking the hit.  MSR_{FS,GS}_BASE/SHADOW are thousands of
cycles to access, whereas {RD,WR}{FS,GS}BASE are a handful.

~Andrew
