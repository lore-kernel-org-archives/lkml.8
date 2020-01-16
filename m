Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C114C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42FB207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoNzUpc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgAPI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:56:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726370AbgAPI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579164963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afuWeP9r07izvBy00eHnBoGUT4XeV+C8WTzPNKhb2Kk=;
        b=QoNzUpc1HFkHFPpWTxE6VH0QHy3+1z3myxarIfWaOzlo9j0+LvbuSRZl95y1cq5I2K6vF/
        M2HkhfpqOqkAn/lEbIzLDl046X7wpxgU2zi1MKE0VJyFTNX4yuI6IYY1SOv9FrWecbJq09
        0ymIOhdAblitTCHbIFtzGUfF1b7XtzA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-4kJhJ4HDM-2Z0VGOFDeuTA-1; Thu, 16 Jan 2020 03:56:00 -0500
X-MC-Unique: 4kJhJ4HDM-2Z0VGOFDeuTA-1
Received: by mail-wm1-f69.google.com with SMTP id p5so405212wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=afuWeP9r07izvBy00eHnBoGUT4XeV+C8WTzPNKhb2Kk=;
        b=DkpRB87/o7/DmmlFpznRa+9EKHyz8G8Dq8WZyQdDyIS7qfn5eU60nLksBKzWYmvpKN
         oU8un3TkJsyEv2Z9ZZvydg/iaNczn2b4n+hyvPoxxt/flwy/QRNSaVkGxlHRNfo1ED56
         lBQymlGamjEn3ZpgLpk/tjW4nybwYGT8zEzOjuV+IkA5Wx9MR7Z7/sMWpgM1yuYQhy+q
         4z0qb4UOP/VOQB14cqhHd05ENCs5w/s9HOqWHCqOLHk06Xv2nKarZItjJ94D09P2A+TF
         rLFVBlknffByCkSF58rsstPDTnVEzu8r4on1mcewJ7lsI/nJmlqrPPAnDT60fCwUw7uc
         qvxg==
X-Gm-Message-State: APjAAAUkRb2gIKdxAI0LLqk3srxXpTX0kHyIZPTAM3DqEJxutxOhNPko
        lIChkuuBpgKOwRsomgI1qlJXqSFeXZ5pdsgv4oxFdaqul/cE8C2IKJKTtbAkose3ehrEESBHfmz
        o90CGwJAt5OWKdlGOPq1D0N7V
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr4955231wml.114.1579164959364;
        Thu, 16 Jan 2020 00:55:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRaWqnsW99WiiG+BDNvBNCn+Q0DEidIbuHNwvDxAG1uCDbQ3SHAGRWFyXtx+LQ5jeXz51LhA==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr4955216wml.114.1579164959178;
        Thu, 16 Jan 2020 00:55:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 5sm28507830wrh.5.2020.01.16.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:55:58 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 3/3] x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for nested guests
In-Reply-To: <CF37ED31-4ED0-45C2-A309-3E1E2C2E54F8@oracle.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-4-vkuznets@redhat.com> <CF37ED31-4ED0-45C2-A309-3E1E2C2E54F8@oracle.com>
Date:   Thu, 16 Jan 2020 09:55:57 +0100
Message-ID: <874kwvixuq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 15 Jan 2020, at 19:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Sane L1 hypervisors are not supposed to turn any of the unsupported VMX
>> controls on for its guests and nested_vmx_check_controls() checks for
>> that. This is, however, not the case for the controls which are supported
>> on the host but are missing in enlightened VMCS and when eVMCS is in use.
>> 
>> It would certainly be possible to add these missing checks to
>> nested_check_vm_execution_controls()/_vm_exit_controls()/.. but it seems
>> preferable to keep eVMCS-specific stuff in eVMCS and reduce the impact on
>> non-eVMCS guests by doing less unrelated checks. Create a separate
>> nested_evmcs_check_controls() for this purpose.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> arch/x86/kvm/vmx/evmcs.c  | 56 ++++++++++++++++++++++++++++++++++++++-
>> arch/x86/kvm/vmx/evmcs.h  |  1 +
>> arch/x86/kvm/vmx/nested.c |  3 +++
>> 3 files changed, 59 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
>> index b5d6582ba589..88f462866396 100644
>> --- a/arch/x86/kvm/vmx/evmcs.c
>> +++ b/arch/x86/kvm/vmx/evmcs.c
>> @@ -4,9 +4,11 @@
>> #include <linux/smp.h>
>> 
>> #include "../hyperv.h"
>> -#include "evmcs.h"
>> #include "vmcs.h"
>> +#include "vmcs12.h"
>> +#include "evmcs.h"
>> #include "vmx.h"
>> +#include "trace.h"
>> 
>> DEFINE_STATIC_KEY_FALSE(enable_evmcs);
>> 
>> @@ -378,6 +380,58 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
>> 	*pdata = ctl_low | ((u64)ctl_high << 32);
>> }
>> 
>> +int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>> +{
>> +	int ret = 0;
>> +	u32 unsupp_ctl;
>> +
>> +	unsupp_ctl = vmcs12->pin_based_vm_exec_control &
>> +		EVMCS1_UNSUPPORTED_PINCTRL;
>> +	if (unsupp_ctl) {
>> +		trace_kvm_nested_vmenter_failed(
>> +			"eVMCS: unsupported pin-based VM-execution controls",
>> +			unsupp_ctl);
>
> Why not move "CC” macro from nested.c to nested.h and use it here as-well instead of replicating it’s logic?
>

Because error messages I add are both human readable and conform to SDM!
:-)

On a more serious not yes, we should probably do that. We may even want
to use it in non-nesting (and non VMX) code in KVM.

Thanks,

-- 
Vitaly

