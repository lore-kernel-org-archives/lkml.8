Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB885C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92639205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbgE1NAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:00:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:48839 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389954AbgE1NAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:00:36 -0400
IronPort-SDR: 02pW02f1rdmgCM4gslr5i2a5pW+uhdEIb7y7Zanxo1gl24nhvl8jqsrl46d4lvmiszretFyPRf
 Y27gMsoMZwqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:00:35 -0700
IronPort-SDR: hxb+UYqB8FrmnMs1FjY/zGUfF1Iq94qe4NxTXvK1A15ltbAqsRewE0lAHkW6dIHf+U80+vHSfa
 OiVHQzeOz13A==
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="442939274"
Received: from cmccarth-mobl.ger.corp.intel.com ([10.252.7.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:00:32 -0700
Message-ID: <b674e0b3900c4ac6b9a67cf9e041c642c0639679.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 28 May 2020 14:00:29 +0100
In-Reply-To: <20200528112231.GA22054@duo.ucw.cz>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
         <20200501081002.GA1055721@kroah.com>
         <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
         <20200524212851.GG1192@bug>
         <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
         <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
         <20200528112231.GA22054@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-28 at 13:22 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Agreed, this sounds like an incompatible extension of the boot
> > > protocol
> > > that we should otherwise not merge.
> > > 
> > > However, there is also a lot of missing information here, and it
> > > is
> > > always
> > > possible they are trying to something for a good reason. As long
> > > as
> > > the
> > > problem that the bootloader is trying to solve is explained well
> > > enough
> > > in the changelog, we can discuss it to see how it should be done
> > > properly.
> > 
> > Apologies, I should have provided more information. Here it is :)
> > 
> > Basically, at boot time U-Boot code and core memory (.text, .data,
> > .bss, etc.) is protected by this Isolated Memory Region (IMR) which
> > prevents any device or processing units other than the ARM CPU to
> > access/modify the memory.
> > 
> > This is done for security reasons, to reduce the risks that a
> > potential
> > attacker can use "hijacked" HW devices to interfere with the boot
> > process (and break the secure boot flow in place).
> 
> Dunno. You disable that after boot anyway. Whether it is disabled
> just before starting kernel or just after it makes very little
> difference.

Not sure I get your point. Disabling it while U-Boot is still running
poses a security risk (even if arguably tiny), while doing it once the
the Kernel is running is  totally safe. So, I'd prefer to do it in the
Kernel, unless practical reasons prevent it.

> 
> Plus, I'm not sure if this has much security value at all. If I can
> corrupt data u-boot works _with_ (such as kernel, dtb), I'll take
> over the system anyway.

True, U-Boot data needs to be protected too and, in fact, we're trying
to do that as well. Other IMRs are used to protect the kernel, dtb, and
other critical memory sections.

> 
> IOW I believe the best/simplest way is to simply disable this in
> u-boot before jumping to kernel entrypoint.

Yes, that's definitely the simplest solution, but, IMO, not the safest
one. So, I'd prefer to build on your initial suggestion and Arnd's
advice and create a new device driver to disable the IMR once Linux is
running. But, yes, if that eventually proves unfeasible, I might just
have the bootloader disable the protection right before booting the OS.

> 
> Best regards,
> 									
> Pavel
> 

