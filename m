Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E31C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908520714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCXO3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:29:47 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:45506 "EHLO
        14.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgCXO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:29:47 -0400
X-Greylist: delayed 7804 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 10:29:46 EDT
Received: from player697.ha.ovh.net (unknown [10.108.57.16])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 61C3A159B51
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:01:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id 1D7B110BE91A8;
        Tue, 24 Mar 2020 12:00:53 +0000 (UTC)
Date:   Tue, 24 Mar 2020 13:00:52 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: check caller of H_SVM_* Hcalls
Message-ID: <20200324130052.373fdf89@bahia.lan>
In-Reply-To: <20200323234323.GA5604@blackberry>
References: <20200320102643.15516-1-ldufour@linux.ibm.com>
        <20200320102643.15516-2-ldufour@linux.ibm.com>
        <20200320132248.44b81b3b@bahia.lan>
        <20200323234323.GA5604@blackberry>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17764167258308712891
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 10:43:23 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Fri, Mar 20, 2020 at 01:22:48PM +0100, Greg Kurz wrote:
> > On Fri, 20 Mar 2020 11:26:42 +0100
> > Laurent Dufour <ldufour@linux.ibm.com> wrote:
> > 
> > > The Hcall named H_SVM_* are reserved to the Ultravisor. However, nothing
> > > prevent a malicious VM or SVM to call them. This could lead to weird result
> > > and should be filtered out.
> > > 
> > > Checking the Secure bit of the calling MSR ensure that the call is coming
> > > from either the Ultravisor or a SVM. But any system call made from a SVM
> > > are going through the Ultravisor, and the Ultravisor should filter out
> > > these malicious call. This way, only the Ultravisor is able to make such a
> > > Hcall.
> > 
> > "Ultravisor should filter" ? And what if it doesn't (eg. because of a bug) ?
> > 
> > Shouldn't we also check the HV bit of the calling MSR as well to
> > disambiguate SVM and UV ?
> 
> The trouble with doing that (checking the HV bit) is that KVM does not
> expect to see the HV bit set on an interrupt that occurred while we
> were in the guest, and if it is set, it indicates a serious problem,
> i.e. that an interrupt occurred while we were in the code that
> transitions from host context to guest context, or from guest context
> to host context.  In those cases we don't know how much of the
> transition has been completed and therefore whether we have guest
> values or host values in the CPU registers (GPRs, FPRs/VSRs, SPRs).
> If we do see HV set then KVM reports a severe error to userspace which
> should cause userspace to terminate the guest.
> 
> Therefore the UV should *always* have the HV bit clear in HSRR1/SRR1
> when transitioning to KVM.
> 

Indeed... thanks for the clarification. So I guess we'll just assume
that the UV doesn't reflect these SVM specific hcalls if they happened
to be issued by the guest then.

Cheers,

--
Greg

> Paul.

