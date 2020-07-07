Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDDE20758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGF32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:29:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:22341 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgGGF31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:29:27 -0400
IronPort-SDR: 67V/OQnSdtD32UNnsIt22621zg3Zapj9fCVKhW3NnKZwRsKimbSACkoh5UKVOlNVYjFhQsceaq
 1TPxrUUH2nAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135785976"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="135785976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 22:29:27 -0700
IronPort-SDR: E8dPLPovLMaIiTDJOHL6peua9uwEipDuJ2Qu5vMbQI4zedr50NzQL3WSpJLWdCZBp5VHZGENAC
 dPS8SK73R01w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="268090616"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2020 22:29:26 -0700
Date:   Mon, 6 Jul 2020 22:29:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Force all cpus to exit VMX root operation on
 crash/panic reliably
Message-ID: <20200707052926.GG5208@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
 <20200704203809.76391-4-dpreed@deepplum.com>
 <CALCETrWzh03fefGuSTM9hr9QY9_=xqbHg3hQ-_vo2PLUXuZ4wg@mail.gmail.com>
 <1593979233.22877148@apps.rackspace.com>
 <CALCETrWnef+Q=Pyrf1h5tcPSrp7tW6eSVozjfONC+OsqbGcj-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWnef+Q=Pyrf1h5tcPSrp7tW6eSVozjfONC+OsqbGcj-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 01:53:39PM -0700, Andy Lutomirski wrote:
> On Sun, Jul 5, 2020 at 1:00 PM David P. Reed <dpreed@deepplum.com> wrote:
> >
> > On Sunday, July 5, 2020 2:26pm, "Andy Lutomirski" <luto@kernel.org> said:
> > > As a minor caveat, doing cr4_clear_bits() in NMI context is not really
> > > okay, but we're about to reboot, so nothing too awful should happen.
> > > And this has very little to do with your patch.
> >
> > I had wondered why the bit is cleared, too. (I assumed it was OK or
> > desirable, because it was being cleared in NMI context before). Happy to
> > submit a separate patch to eliminate that issue as well, since the point of
> > emergency vmxoff is only to get out of VMX root mode - CR4.VMXE's state is
> > irrelevant. Of course, clearing it prevents any future emergency vmxoff
> > attempts. (there seemed to be some confusion about "enabling" VMX vs. "in
> > VMX operation" in the comments)  Should I?
> 
> I have a vague recollection of some firmwares that got upset if rebooted with
> CR4.VMXE set.  Sean?

Hmm, rebooting with CR4.VMXE=1 shouldn't be a problem.  VMXON does all the
special stuff that causes problems with reboot, e.g. blocks INIT, prevents
disabling paging, etc...

That being said, I think it makes sense to keep the clearing of CR4.VMXE out
of paranoia as BIOS will be BIOS, and there is no real downside.  Not only
is the system about to reboot, but the CPUs that call cr4_clear_bits() from
NMI context are also being put into an infinite loop by crash_nmi_callback(),
i.e. they never leave NMI context.  And we rely on that behavior, otherwise
KVM could set CR4.VMXE and do VMXON after the NMI and the whole thing would
be for naught.
 
> The real issue here is that the percpu CR4 machinery uses IRQ-offness as a
> lock, and NMI breaks this.
