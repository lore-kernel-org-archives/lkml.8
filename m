Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5642C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E220776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgDQT4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:56:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:42224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgDQT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:56:05 -0400
IronPort-SDR: bY+Nv4DwfffzSmk0QNIxEVXMojkanhI8Y1yehpOvtA9FBVafRPqvDQq2WOON/FdRnvI4uEw0QR
 nG9QjhbjMQcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 12:56:04 -0700
IronPort-SDR: DSdNJnSTF08K8+2knzazgSJw4aK89y2I/PYIfXOevJJrdxvcH2YIgzuticvjcnp2CyXYPO616J
 7iX3UmwWbGFA==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="428339779"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 12:56:03 -0700
Date:   Fri, 17 Apr 2020 12:56:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Message-ID: <20200417195601.GA22640@agluck-desk2.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
 <20200416205754.21177-3-tony.luck@intel.com>
 <878siumnrf.fsf@nanos.tec.linutronix.de>
 <20200417170607.GA18267@agluck-desk2.amr.corp.intel.com>
 <87ftd1zzau.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftd1zzau.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:29:13PM +0200, Thomas Gleixner wrote:
> "Luck, Tony" <tony.luck@intel.com> writes:
> > On Fri, Apr 17, 2020 at 12:04:36PM +0200, Thomas Gleixner wrote:
> > +	if (!m->driver_data)
> > +		goto setup;
> > +	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> > +		return;
> > +	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> > +	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
> > +		return;
> > +setup:
> > +	split_lock_setup();
> 
> Which looks nicer w/o the goto:
> 
> 	if (m->driver_data) {
> 		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> 			return;
> 		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> 		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
> 			return;
> 	}
> 
> Hmm?

Swings and roundabouts ... getting rid of the goto makes for
deeper indentation. But if you really want to get rid of the
goto, then your version is fine with me.

Do you want me to spin it into v3?

-Tony
