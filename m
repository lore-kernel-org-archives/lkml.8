Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74645C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51630207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgESOsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:48:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:48:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jb3XK-0002vY-Jc; Tue, 19 May 2020 16:48:06 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C35C9100D01; Tue, 19 May 2020 16:48:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Sasha Levin' <sashal@kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp\@alien8.de" <bp@alien8.de>,
        "luto\@kernel.org" <luto@kernel.org>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "ak\@linux.intel.com" <ak@linux.intel.com>,
        "ravi.v.shankar\@intel.com" <ravi.v.shankar@intel.com>,
        "chang.seok.bae\@intel.com" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
In-Reply-To: <238a6e2609eb4e0497b13fbe5f531917@AcuMS.aculab.com>
References: <20200511045311.4785-11-sashal@kernel.org> <87v9ktw1ev.fsf@nanos.tec.linutronix.de> <20200518202435.GD33628@sasha-vm> <238a6e2609eb4e0497b13fbe5f531917@AcuMS.aculab.com>
Date:   Tue, 19 May 2020 16:48:05 +0200
Message-ID: <87r1vg6kwq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:
> From: Sasha Levin
>> >> +		native_swapgs();
>> >> +		gsbase = rdgsbase();
>> >> +		native_swapgs();
>
> Does local_irq_save() even do anything useful here.
> You need to actually execute CLI, not just set a
> flag that indicates interrupts shouldn't happen.
> (Which is what I think local_irq_save() might do.)

  local_irq_save()
    raw_local_irq_save()
      arch_local_irq_save()
        arch_local_irq_disable()
          native_irq_disable()
            asm("CLI")

> You also (probably) need to disable NMIs.

The NMI entry can deal with that obviously.

Thanks,

        tglx
