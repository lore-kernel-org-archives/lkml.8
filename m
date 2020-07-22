Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EF7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15420771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGVGKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:10:47 -0400
Received: from verein.lst.de ([213.95.11.211]:54915 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVGKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:10:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D151E68AFE; Wed, 22 Jul 2020 08:10:44 +0200 (CEST)
Date:   Wed, 22 Jul 2020 08:10:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: add a kernel_wait helper
Message-ID: <20200722061044.GA24678@lst.de>
References: <20200721130449.5008-1-hch@lst.de> <20200721141838.12d19fce025c842138140324@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721141838.12d19fce025c842138140324@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:18:38PM -0700, Andrew Morton wrote:
> On Tue, 21 Jul 2020 15:04:49 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Add a helper that waits for a pid and stores the status in the passed
> > in kernel pointer.  Use it to fix the usage of kernel_wait4 in
> > call_usermodehelper_exec_sync that only happens to work due to the
> > implicit set_fs(KERNEL_DS) for kernel threads.
> 
> I guess it's cleaner, although it's a bit sad to be adding code to
> address a non-problem.
> 
> Did you consider a simpler kernel_wait() which just wraps a
> set_fs(KERNEL_DS) around a call to kernel_wait4()?

I'm about to kill set_fs and this one of the last users in linux-next..
