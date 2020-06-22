Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8984E25378
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oGS+oYKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgFVCjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgFVCjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:39:00 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4263C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 19:39:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49qtrw5t3Gz9sSF;
        Mon, 22 Jun 2020 12:38:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592793537;
        bh=C+XPnt8YT4ROg3t+m1g63N4ADdJ53SFqw06cw583kO8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oGS+oYKRBQpfRPq8Pk2Nuugdgj4qSTDHQFL+bSORNItWK4d+g9XF1d9lK6QA/QgLp
         Wjmvxq63Onw2H055haWSv/Tlr8mQXOOJRk2lKW3C5KkSZDgaHZXkOEy1xynUstSQYr
         TspojzVthwbd3qboeJqFsmdrIgmfQQbi8UbskEfIpGRl65gKe0A8LzGGghZaRyZoMY
         7lQhM/tMS+unTpdwir35+rLdUlYOGmAE37RfiZZDAQEtdRR5eShL0JHIUSrtcRrj2I
         U08VMmXOS6kZvV94eJmAKqcexqTVk+Sa9RnK/ROhs3slwykOspcArduEFyn0R73T23
         9Yg9+9a6CgmMA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [GIT PULL] libnvdimm for v5.8-rc2
In-Reply-To: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
References: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
Date:   Mon, 22 Jun 2020 12:39:24 +1000
Message-ID: <87zh8vbz8j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> tags/libnvdimm-for-5.8-rc2
>
> ...to receive a feature (papr_scm health retrieval) and a fix (sysfs
> attribute visibility) for v5.8.
>
> Vaibhav explains in the merge commit below why missing v5.8 would be
> painful and I agreed to try a -rc2 pull because only cosmetics kept
> this out of -rc1 and his initial versions were posted in more than
> enough time for v5.8 consideration.
>
> ===
>     These patches are tied to specific features that were committed to
>     customers in upcoming distros releases (RHEL and SLES) whose time-lines
>     are tied to 5.8 kernel release.
>
>     Being able to track the health of an nvdimm is critical for our
>     customers that are running workloads leveraging papr-scm nvdimms.
>     Missing the 5.8 kernel would mean missing the distro timelines and
>     shifting forward the availability of this feature in distro kernels by
>     at least 6 months.
> ===
>
> I notice that these do not have an ack from Michael, but I had been
> assuming that he was deferring this to a libnvdimm subsystem decision
> ever since v7 back at the end of May where he said "I don't have
> strong opinions about the user API, it's really up to the nvdimm
> folks." [1]

Yeah, sorry for not providing an actual ack, I didn't realise you were
planning to send it for 5.8.

The arch parts of that series are pretty boring plumbing of hypervisor
calls, so the important details were all the libnvdimm related issues
IMO.

So please consider this a belated ack and thanks for getting it merged.

cheers
