Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C99C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974A820772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGBSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:42:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:30064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgGBSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:42:17 -0400
IronPort-SDR: 3/o4F/Twn5gAV0kPeMC2uhMVi6Ni2WUWpPiOB8plk/FV1osQBd/24JMtkJhqxkm5KRjhM0SxaS
 Z39UBQp6kegA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231854511"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="231854511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 11:42:17 -0700
IronPort-SDR: kSdY8JjTauDyWVvUTV3AZpIJ5/e70QfsIjhUj4vpiG0SOD7OQE+ZhH/i2YOo5icWRknB0LAXny
 yq8dhSDF7PaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="295983459"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2020 11:42:16 -0700
Date:   Thu, 2 Jul 2020 11:42:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH RFC 0/7] CPU feature evaluation after microcode late
 loading
Message-ID: <20200702184216.GG3575@linux.intel.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 06:18:20PM +0300, Mihai Carabas wrote:
> This RFC patch set aims to provide the ability to re-evaluate all CPU
> features and take proper bug mitigation in place after a microcode
> late loading.
> 
> This was debated last year and this patch set implements a subset of
> point #2 from Thomas Gleixner's idea:
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
> 
> Point #1 was sent as an RFC some time ago
> (https://lkml.org/lkml/2020/4/27/214), but after a discussion with CPU
> vendors (Intel), the metadata file is not easily buildable at this
> moment so we could not advance with it more. Without #1, I know it is
> unlikely to embrace the feature re-evaluation.
> 
> Patches from 1 to 4 bring in changes for functions/variables in order to be
> able to use them at runtime.
> 
> Patch 5 re-evaluates CPU features, patch 6 is re-probing bugs and patch 7
> deals with speculation blacklist CPUs/microcode versions.

This misses critical functionality in KVM.  KVM snapshots boot_cpu_data at
module load time (and does further modifications) for ongoing reuse in
filtering what features are advertised to the userspace VMM.  See
kvm_set_cpu_caps() for details.

Even if you found a way to reference kvm_cpu_caps, that still leaves the
problem of existing guests having been created with stale data.  Oh, and
KVM also needs to properly handle MSR_IA32_TSX_CTRL.

Rather than forcefully tearing down guests, what about adding a way to block
updates, e.g. KVM would block updates on module load and unblock on module
exit. That puts the onus of coordinating updates on the orchestration layer
where it belongs.

KVM aside, it wouldn't surprise in the least if there is other code in the
kernel that captures bug state locally.  This series feels like it needs a
fair bit of infrastructure to either detect conflicting usage at build time
or actively prevent consuming stale state at runtime.

There's also the problem of the flags being exposed to userspace via
/proc/cpuinfo, though I suppose that's userspace's problem to not shoot
itself in the foot.
