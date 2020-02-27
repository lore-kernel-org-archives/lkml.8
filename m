Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85110C3F2C1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9DD246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582837882;
	bh=a0k3dQtn0xIAtZFfz5o9NyeAnbxdMiSKnb2eX/p6TCU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=w1OM02LqJK9yYvYBsVrPzrOSYs2tR0EBE0oJLm7RHOykGhu5dqpswg+PmwBc34G4E
	 LQNQegdFbIn3UnxsPk1786MfWiePXgxZii5l2auV0tFw2cfusqs8vYlTdl37XsReEe
	 75s0Jw/PEbrqCr1CcJw9bfPP1ag7AHB5HO9Hehws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgB0VLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgB0VLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:11:20 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BDAA2469F;
        Thu, 27 Feb 2020 21:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582837880;
        bh=a0k3dQtn0xIAtZFfz5o9NyeAnbxdMiSKnb2eX/p6TCU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UqAMnfOdc8LJ4TdDA3g3AkalEFSQapnQpW4Jl2sbZRrx+2bAG5ZwYh8bU4gCHK3Z1
         niS8jpSFG8gY1Bv2xb25CptSVrU0mTzQEN5Aa48QrE3fYZSbsN4MiwL3CSlwgaAcq5
         o4IRib8EWEP0Nmc8b1y5o5gUonoPY+gpljRDtXjk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9563535226F3; Thu, 27 Feb 2020 13:11:19 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:11:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>, davidgoldblatt@fb.com
Subject: Re: Rseq registration: Google tcmalloc vs glibc
Message-ID: <20200227211119.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for top-posting, and adding David Goldblatt of the jemalloc()
group on CC.  I have bounced the rest of the email chain to him.

							Thanx, Paul

On Thu, Feb 20, 2020 at 04:33:30PM -0500, Mathieu Desnoyers wrote:
> Hi Chris,
> 
> As one of the maintainers of the Rseq system call in the Linux kernel, I would
> like to thank the Google team for open sourcing a tcmalloc implementation based
> on Rseq!
> 
> I've looked into some critical integration aspects of the tcmalloc implementation,
> and would like to bring up a topic which involves both tcmalloc developers and the
> glibc community.
> 
> I have been discussing aspects of co-existence between early Rseq adopter libraries
> and glibc for the past year with the glibc community, and tcmalloc happens to be the
> first project to publicly use Rseq outside of prototype branches or selftests code.
> Considering that there can only be one Rseq registration per thread (as imposed by
> the rseq ABI), there needs to be some kind of protocol between libraries to ensure we
> don't introduce regressions when we eventually combine a newer glibc which takes care
> of registration of the __rseq_abi TLS along with tcmalloc which also try to perform
> that registration within the same thread.
> 
> Throughout the various rounds of review of the glibc Rseq integration patch set,
> there were a few solutions envisioned. Here is a brief history:
> 
> 1) Introduce a __rseq_refcount TLS variable.
> 
> - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
> - Currently used by Google tcmalloc,
> - Emitted by glibc as well my the original patchset (but was later removed),
> 
> A user incrementing the refcount from 0 -> 1 performs rseq registration.
> The last user decrementing from 1 -> 0 performs rseq unregistration.
> 
> Works for co-existence of dlopen'd/dlclose'd libraries, for dynamically
> linked libraries, and for the main executable.
> 
> The refcounting was deemed too complex for glibc's needs (it always
> exists for the entire executable's lifetime), so we moved to
> __rseq_handled instead.
> 
> 
> 2) Introduce a __rseq_handled global variable.
> 
> - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
> - At some point emitted by glibc as well in my patch set (but was later
>   removed),
> 
> A library may take rseq ownership if it is still 0 when executing the
> library constructor. Set to 1 by library constructor when handling rseq.
> Set to 0 in destructor if handling rseq.
> 
> Not meant to be set by dlopen'd/dlclose'd libraries, only by libraries
> existing for the whole lifetime of the executable and/or the main executable.
> 
> This __rseq_handled symbol has been identified as being somewhat redundant
> with the information provided in the __rseq_abi.cpu_id field (uninitialized
> state), which motivated removing this symbol from the glibc integration
> entirely. The only reason for having __rseq_handled separate from
> __rseq_abi.cpu_id was because it was then impossible to touch TLS data
> early in the glibc initialization. This issue was later resolved within
> glibc.
> 
> 
> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
> registered.
> 
> - Current protocol in the most recent glibc integration patch set.
> - Not supported yet by Linux kernel rseq selftests,
> - Not supported yet by tcmalloc,
> 
> Use the per-thread state to figure out whether each thread need to register
> Rseq individually.
> 
> Works for integration between a library which exists for the entire lifetime
> of the executable (e.g. glibc) and other libraries. However, it does not
> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
> having a library like glibc handling the registration present.
> 
> So overall, I suspect the protocol we want for early adopters is that they
> only register Rseq if __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED, which
> ensure they do not get -1, errno = EBUSY when linked against a newer glibc
> which handles Rseq registration. In order to handle multiple early adopters
> dlopen'd/dlclose'd in the same executable, those should synchronize with a
> __rseq_refcount TLS reference count, but it does not have to be taken into
> account by the main executable or libraries present for the entire executable
> lifetime (like glibc).
> 
> Based on this, what I think would be missing from the current Google tcmalloc
> implementation is a check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED
> in InitThreadPerCpu().
> 
> Is tcmalloc ever meant to be dlopen'd/dlclose'd (either directly or indirectly),
> or is it required to exist for the entire executable lifetime ? The check and
> increment of __rseq_refcount is only useful to co-exist with dlopen'd/dlclose'd
> libraries, but it would not allow discovering the presence of a glibc which
> takes care of the rseq registration with the planned protocol. A dlopen'd
> library should then only perform rseq unregistration if if brings the
> __rseq_refcount back to 0 (e.g. in a pthread_key destructor).
> 
> Adding this check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED is something
> I need to do in the Linux rseq selftests, but I refrained from submitting any
> further change to those tests until the glibc rseq integration gets finally
> merged.
> 
> Is it something that could be easily changed at this stage in Google tcmalloc,
> or should we reconsider adding back __rseq_refcount within the glibc integration
> patch set, even though it is not strictly useful to glibc ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
