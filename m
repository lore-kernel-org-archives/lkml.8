Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FAEC83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35A92078C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588080493;
	bh=e2h+YGX8UNd7RGu9S/wztUu2W9Zxes42cCR7ChuzclQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iBWihsA2WfzK2seKp6p/XU6a5KLJViPl96xX/2gjJtPRhhAoCF+6sjXxtLFDCm8Tm
	 XxEDYo1GnuEhjKP57FzMzf938KK3ljZviTPlFHRubWNwlceUMSIHL5DS9aRtjiOF0m
	 Z7MxpY4LcJfb3vcf7/ts6xA9FMWPjs8jMVLFhG14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD1N2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgD1N2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:28:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439F5206F0;
        Tue, 28 Apr 2020 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588080492;
        bh=e2h+YGX8UNd7RGu9S/wztUu2W9Zxes42cCR7ChuzclQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaFvCu6krhFeoqDRhlxn4Rt0HIxMcHkb8PJJjF/01l9E9bBbYc0uSUxxo5MRegT8S
         rcMlMNwdwADZCmdFUqk1E3PWHt/iQ+TBzEOqu6W95E2Gppu3nhQV4pELCaIVMxuAMr
         VdBgg/Q/DMYyELaZHTFaB9/B+wUhZEkt8jkDc01A=
Date:   Tue, 28 Apr 2020 14:28:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200428132804.GF6791@willie-the-truck>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422162954.GF3585@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:29:54PM +0100, Catalin Marinas wrote:
> On Wed, Apr 22, 2020 at 04:44:36PM +0100, Mark Brown wrote:
> > On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> > > This patch series implements support for ARMv8.5-A Branch Target
> > > Identification (BTI), which is a control flow integrity protection
> > > feature introduced as part of the ARMv8.5-A extensions.
> > 
> > I've not resent this since the branch is still sitting in the arm64 tree
> > but it's also not in -next at the minute - is there anything you're
> > waiting for from my end here?
> 
> It's up to Will whether he wants a new series posted. The for-next/bti
> branch is complete AFAICT, only that normally we start queueing stuff
> (and push to -next) around -rc3.

I'm happy either way, but it would be nice to base other BTI patches on
top of this branch. Mark -- is it easier for you to refresh the series
against v5.7-rc3, or leave it like it is? Please just let me know either
way.

Thanks,

Will
