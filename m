Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FDC2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBDMwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:52:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgBDMwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:52:51 -0500
Received: from [212.187.182.162] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iyxgz-0005I1-MG; Tue, 04 Feb 2020 13:52:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 07DCE100720; Tue,  4 Feb 2020 12:52:31 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>
Cc:     Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v17] x86/split_lock: Enable split lock detection by kernel
In-Reply-To: <20200204000449.GA28014@linux.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com> <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com> <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com> <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com> <20200204000449.GA28014@linux.intel.com>
Date:   Tue, 04 Feb 2020 12:52:31 +0000
Message-ID: <87v9omy0og.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Sun, Jan 26, 2020 at 12:05:35PM -0800, Luck, Tony wrote:
>
> ...
>
>> +bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>
> No reason to take the error code unless there's a plan to use it.
>
>> +{
>> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
>> +		return false;
>
> Any objection to moving the EFLAGS.AC up to do_alignment_check()?  And
> take "unsigned long rip" instead of @regs?
>
> That would allow KVM to reuse handle_user_split_lock() for guest faults
> without any changes (other than exporting).
>
> E.g. do_alignment_check() becomes:
>
> 	if (!(regs->flags & X86_EFLAGS_AC) && handle_user_split_lock(regs->ip))
> 		return;

No objections.

Thanks,

        tglx
