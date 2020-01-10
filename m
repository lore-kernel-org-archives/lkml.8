Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8492080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgAJNNm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:13:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgAJNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:13:41 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipu6P-0004Sw-D7; Fri, 10 Jan 2020 14:13:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0DD6A105BE5; Fri, 10 Jan 2020 14:13:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
In-Reply-To: <CAFH1YnM=wOTpWEsoYeqaazdH3rdY-sG57=hTAwEcagJKLFbQ9g@mail.gmail.com>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com> <874kx4bb1m.fsf@nanos.tec.linutronix.de> <CAFH1YnM=wOTpWEsoYeqaazdH3rdY-sG57=hTAwEcagJKLFbQ9g@mail.gmail.com>
Date:   Fri, 10 Jan 2020 14:13:24 +0100
Message-ID: <8736cne9or.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@gmail.com> writes:

> On Fri, Jan 10, 2020 at 5:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Zhenzhong Duan <zhenzhong.duan@gmail.com> writes:
>>
>> > Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
>> > CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
>> > If any of the two macros is undefined, below warning triggers during
>> > build, fix it by moving 'i' in the guard.
>> >
>> > arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]
>> >
>> > Also use true/false instead of 1/0 for boolean return.
>>
>> No. This is not the scope of the unused variable issue. This want's to
>> be a separate patch.
>
> I'm trying to combine trivial changes into one, so you maintainers
> don't mind to pick two trivial patches? :)

See Documentation/process/submitting-patches.rst:

  Solve only one problem per patch.

Thanks,

        tglx
