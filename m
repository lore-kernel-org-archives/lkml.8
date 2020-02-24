Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6620836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBXSCW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:02:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:28381 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBXSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:02:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 10:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="435986381"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2020 10:02:20 -0800
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 10:02:20 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.237]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.249]) with mapi id 14.03.0439.000;
 Mon, 24 Feb 2020 12:02:18 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Topic: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Index: AQHVet/uukAR+D18mEydsD8sMzHMMqeNNAKAgAAL8ACAFbkggIAAIFiAgAQpEQCAA+z5AICAuHaA
Date:   Mon, 24 Feb 2020 18:02:17 +0000
Message-ID: <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
In-Reply-To: <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.157.154]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEE4D93671EB89419D0C9F8BCF7B0528@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 4, 2019, at 12:20, Andy Lutomirski <luto@kernel.org> wrote:
> 
> I think it could make sense to add a whole new ptrace() command to
> tell the tracee to, in effect, MOV a specified value to a segment
> register.  This call would have the actual correct semantics in which
> it would return an error code if the specified value is invalid and
> would return 0 on success.  And then a second ptrace() call could be
> issued to read out FSBASE or GSBASE if needed.  Would this be useful?
> What gdb commands would invoke it?

We consider new commands to access GDT/LDT that hpa posted before [1] may be
helpful. If the kernel provides the interfaces to ptracer, we expect GDB for
both 32-/64-bits can make such changes for inferior calls:
(1) When FS/GS selector only updated,
	GDB used to write the selector value via SETREGS. Now it can read the
	base value from the new APIs and write the base also. This change does
	not harm today's kernel, and it retains the legacy behavior on
	FSGSBASE-enabled kernels in the future.
(2) When FS/GS base only updated,
(3) When both FS/GS selector and base updated,
	GDB has no change from what it used to do. The new FSGSBASE-enabled
	kernel improves the behavior by keeping the base regardless of a
	selector.

The proposed change in GDB would do an additional GETREGS for every SETREGS
to obtain the old value. Other ptrace-users may need a similar patch if
sensitive to the outcome from writing FS/GS selector, but last time when we
surveyed for other tools [2, 3], we didn't find the issue. We also didn't
find actual users who rely on legacy behavior in practice.

We'd like to hear a clear opinion of whether the GDB changes along with the
new ptrace APIs are necessary and sufficient as preparing the FSGSBASE
support in the kernel.

[1] https://lore.kernel.org/patchwork/cover/954471/
[2] https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
[3] https://lists.openvz.org/pipermail/criu/2018-March/040654.html

Thanks,
Chang
