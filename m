Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EDAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D8E206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbgF2VuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:50:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:23956 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404115AbgF2Vt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:49:56 -0400
IronPort-SDR: V6lqV12aAH74JgUsFf4SpQB0zciaXKzj+WXZIa648OUc9LJ72UI9ocTuQPYJH/HmtQ6noFeMu6
 UI+yoYe7A49Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="125718592"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="125718592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 14:49:56 -0700
IronPort-SDR: 78RHerYZoP3QP/al+zc+OsHhaZkObvuUJwM7sUcT8D9eygdH4F+OKnTEPJZ2uKtcbx3HMh+BZE
 jkLEswkdwuNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="264946140"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2020 14:49:56 -0700
Date:   Mon, 29 Jun 2020 14:49:56 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
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
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200629214956.GA12962@linux.intel.com>
References: <1593464072.34968499@apps.rackspace.com>
 <0AFABBBA-18B7-4E2F-BCE7-D69889CC0F79@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0AFABBBA-18B7-4E2F-BCE7-D69889CC0F79@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:22:45PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 29, 2020, at 1:54 PM, David P. Reed <dpreed@deepplum.com> wrote:
> > 
> > ﻿Simple question for those on the To: and CC: list here. Should I
> > abandon any hope of this patch being accepted? It's been a long time.
> > 
> > The non-response after I acknowledged that this was discovered by when
> > working on a personal, non-commercial research project - which is
> > "out-of-tree" (apparently dirty words on LKML) has me thinking my
> > contribution is unwanted. That's fine, I suppose. I can maintain this patch
> > out-of-tree as well.  I did incorporate all the helpful suggestions I
> > received in this second patch, and given some encouragement, will happily
> > submit a revised v3 if there is any likelihood of acceptance. I'm wary of
> > doing more radical changes (like combining emergency and normal paths).
> > 
> 
> Sorry about being slow and less actively encouraging than we should be. We
> absolutely welcome personal contributions. The actual problem is that
> everyone is worked and we’re all slow. Also, you may be hitting a corner case
> in the process: is this a KVM patch or an x86 patch?

It's an x86 patch as it's not KVM specific, e.g. this code also helps play
nice with out of tree hypervisors.

The code change is mostly good, but it needs to be split up as there are
three separate fixes:

  1. Handle #UD on VMXON due to a race.
  2. Mark memory and flags as clobbered by VMXON.
  3. Change emergency_vmx_disable_all() to not manually check cpu_vmx_enabled().

Yes, the changes are tiny, but if for example #3 introduces a bug then we
don't have to revert #1 and #2.  Or perhaps older kernels are only subject
to the #1 and #2 and thus dumping all three changes into a single patch makes
it all harder to backport.  In other words, all the usual "one change per
patch" reasons.
