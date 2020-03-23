Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1427A20637
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="WkLFZ009"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCXAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:55:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54251 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgCXAzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:55:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 48mXqP2FhXz9sSJ; Tue, 24 Mar 2020 11:55:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1585011345; bh=LoDPTy8hotXOVNxAbYYkoDWHTyQTtTLTM+W7YwaCFqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkLFZ009uhYM/bD3ncmLk6wAuvUncEP6zj7yGZc+Ly5tPhpxlI/q8n0HkjPxIiLRl
         r8tvEKgm0zkkntTWtzip2lvRCduiVnXS/EInxK0Ab20OJPU+NMFOREJkOGHBmqnpZA
         710DKCqOZcYqE/o+zbYvF8sNhXd8wOXjqr7by/CX2r4SLQk4fwL07Uktw8QIe6tRKd
         aYitSdz9++x2M7fEArmKUIu8X+bLqzCdRp4q9m3f0O40bDQpaIMsEGis9oOo4hZ/y1
         QJo4PWmvAQFEqor4dl9ubPzD8FbYW/hJMEDVF4iu74c9NEt7dESqCGUiZyyv9wxYaL
         zyOaiUWTJhncg==
Date:   Tue, 24 Mar 2020 10:43:23 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: check caller of H_SVM_* Hcalls
Message-ID: <20200323234323.GA5604@blackberry>
References: <20200320102643.15516-1-ldufour@linux.ibm.com>
 <20200320102643.15516-2-ldufour@linux.ibm.com>
 <20200320132248.44b81b3b@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320132248.44b81b3b@bahia.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 01:22:48PM +0100, Greg Kurz wrote:
> On Fri, 20 Mar 2020 11:26:42 +0100
> Laurent Dufour <ldufour@linux.ibm.com> wrote:
> 
> > The Hcall named H_SVM_* are reserved to the Ultravisor. However, nothing
> > prevent a malicious VM or SVM to call them. This could lead to weird result
> > and should be filtered out.
> > 
> > Checking the Secure bit of the calling MSR ensure that the call is coming
> > from either the Ultravisor or a SVM. But any system call made from a SVM
> > are going through the Ultravisor, and the Ultravisor should filter out
> > these malicious call. This way, only the Ultravisor is able to make such a
> > Hcall.
> 
> "Ultravisor should filter" ? And what if it doesn't (eg. because of a bug) ?
> 
> Shouldn't we also check the HV bit of the calling MSR as well to
> disambiguate SVM and UV ?

The trouble with doing that (checking the HV bit) is that KVM does not
expect to see the HV bit set on an interrupt that occurred while we
were in the guest, and if it is set, it indicates a serious problem,
i.e. that an interrupt occurred while we were in the code that
transitions from host context to guest context, or from guest context
to host context.  In those cases we don't know how much of the
transition has been completed and therefore whether we have guest
values or host values in the CPU registers (GPRs, FPRs/VSRs, SPRs).
If we do see HV set then KVM reports a severe error to userspace which
should cause userspace to terminate the guest.

Therefore the UV should *always* have the HV bit clear in HSRR1/SRR1
when transitioning to KVM.

Paul.
