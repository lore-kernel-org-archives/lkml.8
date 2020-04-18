Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E80C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F57321D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDRKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgDRKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:17:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 03:17:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPkXg-00073w-Oy; Sat, 18 Apr 2020 12:17:44 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 31C62101304; Sat, 18 Apr 2020 12:17:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook\@chromium.org" <keescook@chromium.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/5] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <bdf950167b86a01db93a9633b708c17a66ad73d0.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-5-sblbir@amazon.com> <87mu7akwdx.fsf@nanos.tec.linutronix.de> <bdf950167b86a01db93a9633b708c17a66ad73d0.camel@amazon.com>
Date:   Sat, 18 Apr 2020 12:17:44 +0200
Message-ID: <87mu79xflj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Singh, Balbir" <sblbir@amazon.com> writes:
> On Fri, 2020-04-17 at 16:41 +0200, Thomas Gleixner wrote:
>> Balbir Singh <sblbir@amazon.com> writes:
>> static void *l1d_flush_pages;
>> static DEFINE_MUTEX(l1d_flush_mutex);
>> 
>> int l1d_flush_init(void)
>> {
>>         int ret;
>> 
>>         if (static_cpu_has(X86_FEATURE_FLUSH_L1D) || l1d_flush_pages)
>>                 return 0;
>> 
>>         mutex_lock(&l1d_flush_mutex);
>>         if (!l1d_flush_pages)
>>                 l1d_flush_pages = l1d_flush_alloc_pages();
>>         ret = l1d_flush_pages ? 0 : -ENOMEM;
>>         mutex_unlock(&l1d_flush_mutex);
>>         return ret;
>> }
>> EXPORT_SYMBOL_GPL(l1d_flush_init);
>> 
>> which removes the export of l1d_flush_alloc_pages() and gets rid of the
>> cleanup counterpart. In a real world deployment unloading of VMX if used
>> once is unlikely and with the task based one you end up with these pages
>> 'leaked' anyway if used once.
>> 
> I don't want the patches to be enforce that one cannot unload the kvm module,
> but I can refactor those bits a bit more

Not freeing the l1d flush pages does not prevent unloading the kvm
module. It just keeps the around. It's the same problem with your L1D
flush for tasks. If one tasks uses it then the pages stay around until
the system reboots.

>> If any other architecture enables this, then it will have _ALL_ of this
>> code duplicated. So we should rather have:
>
> But that is being a bit prescriptive to arch's to implement their L1D flushing
> using TIF flags, arch's should be free to use bits in struct_mm for their arch
> if they feel so.

>>   - All architectures have to use TIF_SPEC_FLUSH_L1D if they want to
>>     support the prctl.
>> 
>
> That is a concern (see above), should we enforce this?

Fair enough, but it's trivial enough to have:

  static inline void arch_task_l1d_flush_update(bool enable)
  static inline bool arch_task_l1d_flush_state(void)

and the rest of the logic is just identical.

Thanks,

        tglx

