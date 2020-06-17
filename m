Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98841C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B65021789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592422663;
	bh=MmQpNycHMc+CvYJVky1PDDcVkBa9imkx5orsNbgASoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AOjlw5ONdPJK4FjDRw0M5pMpfiyfRj4YQ0AJ5orAo5ex5GCmhdwRuWjp1L7ljT4sa
	 MYcN/XpYsBbtzO6wq4TKKmWvWBviWXiWZTKJyrZDn3UjPNw+Sh0x3Y8D/QTA1uxkcl
	 Azm3FnkMhmcWSuYgzxa7XQW0WOBJyF/FyXswENmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgFQThc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:37:32 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4C82073E;
        Wed, 17 Jun 2020 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592422651;
        bh=MmQpNycHMc+CvYJVky1PDDcVkBa9imkx5orsNbgASoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3Th9T2SGaIyOvzLlpMjuoNQNJ0zBrBNSlo3mWaDNKJWd+iDi7X5yEfqXKi7xGfFc
         3BdLKznyEOdOe/MHQcBu42lX0p271ow9uSkR6pRuC4Cri6Vnu2LZi0Vqeq4sTR5Lmy
         Z4/uNda7jlXD4LRp6IV5JV5R3s4v8pLokrYfRYjc=
Date:   Wed, 17 Jun 2020 12:37:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jbohac@suse.cz, jmorris@namei.org,
        mjg59@google.com, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
Message-Id: <20200617123731.0dbb039a053a2ef610af59fb@linux-foundation.org>
In-Reply-To: <20200602045952.27487-1-lijiang@redhat.com>
References: <20200602045952.27487-1-lijiang@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jun 2020 12:59:52 +0800 Lianbo Jiang <lijiang@redhat.com> wrote:

> Signature verification is an important security feature, to protect
> system from being attacked with a kernel of unknown origin. Kexec
> rebooting is a way to replace the running kernel, hence need be
> secured carefully.

I'm finding this changelog quite hard to understand,

> In the current code of handling signature verification of kexec kernel,
> the logic is very twisted. It mixes signature verification, IMA signature
> appraising and kexec lockdown.
> 
> If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
> signature, the supported crypto, and key, we don't think this is wrong,

I think this is saying that in the absence of KEXEC_SIG_FORCE and if
the signature/crypto/key are all incorrect, the kexec still succeeds,
but it should not.

> Unless kexec lockdown is executed. IMA is considered as another kind of
> signature appraising method.
> 
> If kexec kernel image has signature/crypto/key, it has to go through the
> signature verification and pass. Otherwise it's seen as verification
> failure, and won't be loaded.

I don't know if this is describing the current situation or the
post-patch situation.

> Seems kexec kernel image with an unqualified signature is even worse than
> those w/o signature at all, this sounds very unreasonable. E.g. If people
> get a unsigned kernel to load, or a kernel signed with expired key, which
> one is more dangerous?
> 
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.

I think the whole thing needs a rewrite.  Start out by fully describing
the current situation.  THen describe what is wrong with it, and why. 
Then describe the proposed change.  Or something along these lines.

The changelog should also make clear the end-user impact of the patch. 
In sufficient detail for others to decide which kernel version(s)
should be patched.  Your recommendations will also be valuable - which
kernel version(s) do you think should be patched, and why?
