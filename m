Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F35C20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFKAAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:00:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:14660 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgFKAAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:00:33 -0400
IronPort-SDR: SE10CC9A2LBsv546AGLOiHuc7GowI8HTvDN60gL5uQ52fVdI1or8DrfCURFOdK/z//bsSm4352
 Rc5dF1hdLjTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 17:00:33 -0700
IronPort-SDR: NfMrcfm4ZnQtCNeqiWz2f8LzNdPP5sEYFf+z0qJHcPzA1Lu9xULjvDHTDroLNGpGfphpgx34Y0
 lqAh+XDgkz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="380228276"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 17:00:32 -0700
Date:   Wed, 10 Jun 2020 17:00:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200611000032.GI18790@linux.intel.com>
References: <20200610181254.2142-1-dpreed@deepplum.com>
 <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:59:19PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 10, 2020, at 11:21 AM, David P. Reed <dpreed@deepplum.com> wrote:
> > 
> > ﻿If a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF is
> > done on all CPUS, to allow the INIT IPI to function, since
> > INIT is suppressed when CPUs are in VMX root operation.
> > However, VMXOFF causes an undefined operation fault if the CPU is not
> > in VMX operation, that is, VMXON has not been executed, or VMXOFF
> > has been executed, but VMX is enabled.
> 
> I’m surprised. Wouldn’t this mean that emergency reboots always fail it a VM
> is running?  I would think someone would have noticed before.

The call to cpu_vmxoff() is conditioned on CR4.VMXE==1, which KVM toggles in
tandem with VMXON and VMXOFF.  Out of tree hypervisors presumably do the
same.  That's obviously not atomic though, e.g. VMXOFF will #UD if the
vmxoff_nmi() NMI arrives between CR4.VMXE=1 and VMXON, or between VMXOFF
and CR4.VMXE=0.
