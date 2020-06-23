Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2C92076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592931459;
	bh=VFpMHGMOkfxQ8AB6qe3YYkBZw3f0fAv4eRBSgiMhi+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mkei0sFsVnAEqRNIyRE7tTsDeJn6t2JqsA+h7JpCCSRHgS70v+uEPOWU9kdNR/RcS
	 TQTq9Q0Q0y3Je5pmMEi+IaDtxdAN9EjYLqNUvjYiQ0tmmN8oMF6Msr5qqgXt3NYmWa
	 HbdEWuXD9TVzyxy3Bt7Tm/GWWBhKBwMIcn/Ce4Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbgFWQ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733100AbgFWQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:57:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6252E2076E;
        Tue, 23 Jun 2020 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592931449;
        bh=VFpMHGMOkfxQ8AB6qe3YYkBZw3f0fAv4eRBSgiMhi+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcaSWYzIOvwNnttS8B9JpebXlTD9Ew6G68XXs7JIVqQRq2/0lingC0RbdOsnwTSHh
         NmaMeM+bOQhxqaXCo7xjaoRPwFB5vKXGaFtkBiIUMTA3+JNGTFOwOHJb22GL8mCfcp
         kHho4p9bQhCIGTk/N4YDlmwrICxaG0WEzbSEYuWM=
Date:   Tue, 23 Jun 2020 17:57:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Chiawei Wang <chiaweiwang@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2]: arch: arm64: vdso: export the symbols for time()
Message-ID: <20200623165723.GB4819@willie-the-truck>
References: <20200615143838.143137-1-salyzyn@android.com>
 <20200623144459.GB4336@willie-the-truck>
 <CAJ-C09j3ZZOZDPLiS+8-9Ypd1hYtfJY5LUym8z79xAUKS11VUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-C09j3ZZOZDPLiS+8-9Ypd1hYtfJY5LUym8z79xAUKS11VUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:47:57AM -0700, Mark Salyzyn wrote:
>    time() in bionic libc will go an use vDSO interface to pick up this
>    low-resolution timer.

But my point is it should _already_ be using the vDSO implementation of
clock_gettime(), which should be plenty fast enough.

Will
