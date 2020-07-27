Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49443C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3127D20809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgG0W2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:28:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:58004 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0W2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:28:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7DCC12E7;
        Mon, 27 Jul 2020 22:28:06 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:28:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] scripts/kernel-doc: optionally treat warnings as errors
Message-ID: <20200727162805.3ef9bacf@lwn.net>
In-Reply-To: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
References: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 18:01:38 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> The kbuild bot recently added the W=1 option, which triggered
> documentation cleanups to squelch hundreds of kernel-doc warnings.
> 
> To make sure new kernel contributions don't add regressions to
> kernel-doc descriptors, this patch suggests an option to treat
> warnings as errors in CI/automated tests. A command-line option is
> provided to the kernel-doc script, as well as a check on environment
> variables to turn this optional behavior on.
> 
> Examples for the two subsystems I contribute to:
> 
> KCFLAGS="-Wall -Werror" make W=1 sound/
> KCFLAGS="-Wall -Werror" make W=1 drivers/soundwire/
> 
> Randy Dunlap also suggested adding a log for when generating
> documentation. The documentation build is however not stopped for now.
> 
> KDOC_WERROR=1 make htmldocs

So I'm not opposed to this, but I'm missing a couple of things in the
changelog:

 - A statement that you are adding a -Werror option that invokes this
   behavior.

 - Mention of the fact that you also cause it to look at a couple of
   environment variables and change its behavior based on that.

Could I get a version with that clarified a bit?

Thanks,

jon
