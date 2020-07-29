Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8D420809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596047342;
	bh=AF30tY4fyaKB4QjFsTMCgyviAjqFWEZhXxelvVN41R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2sDUlTqH/1+kVH2q3xm3ZAWo+KRvCi645aziRqwDLd5B1I34KTC33AWYu9a8yZCOK
	 JEkBkHP2ZkqHeXUr4admuqPucuZaArwsEPuyTFZKZBsDtyAqH8F3M++tDoft1RdFaW
	 XYNQn4gqFRMpfudQRfOUzYiwDdndapD6Kpq9Ko1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2S3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2S3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:29:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F047E2075F;
        Wed, 29 Jul 2020 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596047340;
        bh=AF30tY4fyaKB4QjFsTMCgyviAjqFWEZhXxelvVN41R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5HPG2SYY1xpBDi+EAgeCcRhT5QjOkc7iKMYXhV+S/kwItWYQRHQGoPldX8+SP3Gx
         Iul5fF5HQ3ud80uN+6+WtdvdC1AhE4J/QijsfqErEf23Le3DFBEUsjOkgtt2McejJ5
         MpBvMJxQHcacFmcU9toHvZeTjpHsT47moJC9i3+I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D7FC40E57; Wed, 29 Jul 2020 15:28:57 -0300 (-03)
Date:   Wed, 29 Jul 2020 15:28:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Should perf version match kernel version?
Message-ID: <20200729182857.GA433799@kernel.org>
References: <20200729155647.xte33krus3mak3wu@altlinux.org>
 <20200729160220.GB2655@hirez.programming.kicks-ass.net>
 <7CEC30D2-0C1E-4E88-A1D2-35C121EB1013@gmail.com>
 <20200729175704.gsbh4gkbqxas5j2t@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729175704.gsbh4gkbqxas5j2t@altlinux.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 29, 2020 at 08:57:04PM +0300, Vitaly Chikunov escreveu:
> On Wed, Jul 29, 2020 at 01:27:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On July 29, 2020 1:02:20 PM GMT-03:00, peterz@infradead.org wrote:
> > >On Wed, Jul 29, 2020 at 06:56:47PM +0300, Vitaly Chikunov wrote:
> > >> It seems that most distros try to have perf version to match with
> > >> running kernel version. Is is requirement? Would it be better to have
> > >> single perf from kernel mainline to work with any (older) kernel
> > >> version?

> > >> We have different kernel versions in ALT Linux (stable for 4.19, 5.4,
> > >> and 5.7) and I want to understand if we should have three perfs or
> > >> single package will be enough.

> > >We strive to have it all compatible, older perf should work on newer
> > >kernel and newer perf should work on older kernel.

> > >How well it's all tested is another.

> > >Personally I often use a very old perf.

> > Yeah, never was a requirement, if you find some problem using a new perf on an old kernel or the other way around, please report.
> 
> That's great to know. Thanks for the answers!

Having said that, from time to time there are new features such as, say
LBR callgraph stitching, there are kernel and tooling components, so its
important to try and have the latest perf, but yeah, as you said, one
perf package is enough, just keep it uptodate :-)

For other features such as the metric work with 'perf stat', its purely
userspace, and sometimes its purely kernel space, no lockstep.

- Arnaldo
