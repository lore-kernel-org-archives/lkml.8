Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC88206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589441191;
	bh=syiyWkIggjH/CryQFESzDaHB1LaDM9sAiDSV8Zk+Uqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bv8sIKBAPySX06SBhIEF346aFwO2zvqvrkUNcZxhG4oj1YCcnOgf51/KG+gsWrhgl
	 9hlMxPlmxy+tN7v0L5Bm7NOqu11RajyJztRyNUOIvt4cn36Paxl13Wvx8HVWk1QQk1
	 DUzl4wti7oY/PXErFx8d34h2fjs6GU1GmOJMPhN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgENH0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgENH0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:26:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662B8205CB;
        Thu, 14 May 2020 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589441189;
        bh=syiyWkIggjH/CryQFESzDaHB1LaDM9sAiDSV8Zk+Uqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek40gIMInC2Mr/QZBAdoHMpZmRPcD90RoXY/yN1eeMabVl/de9AUapECYzCBaDwCa
         2tcgtqRDr7GFJ7vw6eDr2kvJM1XTlZiy2DlqxTt5sRbLvsP8hsEOpDENzgn2HwlhyM
         EwplRkZwQiEsntqr1RjZclYz+G/OzV+9rZdladIQ=
Date:   Thu, 14 May 2020 08:26:24 +0100
From:   Will Deacon <will@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, matt@codeblueprint.co.uk,
        sparclinux@vger.kernel.org, kernel-team@android.com,
        tglx@linutronix.de
Subject: Re: [RESEND PATCH 0/4] Rework sparc32 page-table layout
Message-ID: <20200514072624.GA4280@willie-the-truck>
References: <20200414214011.2699-1-will@kernel.org>
 <20200513.153226.1639916880914538869.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513.153226.1639916880914538869.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, May 13, 2020 at 03:32:26PM -0700, David Miller wrote:
> From: Will Deacon <will@kernel.org>
> Date: Tue, 14 Apr 2020 22:40:07 +0100
> 
> > This is a reposting of the patch series I sent previously to rework the
> > sparc32 page-table layout so that 'pmd_t' can be used safely with
> > READ_ONCE():
> > 
> > https://lore.kernel.org/lkml/20200324104005.11279-1-will@kernel.org
> > 
> > This is blocking the READ_ONCE() rework, which in turn allows us to
> > bump the minimum GCC version for building the kernel up to 4.8.
> 
> Series applied to sparc-next, thanks Will.

Thanks, although this was picked up by -tip a couple of days ago [1] since
the READ_ONCE() rework relies on it to avoid breaking the sparc32 build.

It's obviously harmless to go in both trees, but if you don't need it for
anything then you may want to drop these to avoid duplicate commits in
mainline.

Cheers,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=locking/kcsan
