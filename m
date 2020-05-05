Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A41A206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgEEXOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727089AbgEEXOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:14:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:14:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jW6ls-0006ls-MP; Wed, 06 May 2020 01:14:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 329981001F5; Wed,  6 May 2020 01:14:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dimitri Sivanich <sivanich@hpe.com>, Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: x86/uv cleanups
In-Reply-To: <20200505153944.GD2297@hpe.com>
References: <20200504171527.2845224-1-hch@lst.de> <20200505153944.GD2297@hpe.com>
Date:   Wed, 06 May 2020 01:14:40 +0200
Message-ID: <87sggenfdr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@hpe.com> writes:
> Yes, we do see a need to clean up old code where it exists, but we would like
> to assume this responsibility ourselves in order to ensure functional continuity
> with externally available open-sourced modules that our customers rely on.  This
> code supports current Superdome Flex systems, as well as forthcoming platforms
> based on Intel Cooper Lake and Sapphire Rapids processors.  Some cleanup is
> already being included as part of a forthcoming patchset in support of the
> upcoming Sapphire Rapids platform.

That's a completely bogus argument.

 1) You could have cleaned up that code long ago

 2) The rule for code which is unused in the mainline kernel is that it
    can be removed during spring cleaning unless there is a compelling
    reason. I can't see one here.

 3) Out of tree modules are not supported independent of the license.
    It's not our problem that you have code out of tree which you could
    have upstreamed long ago.

Look at the history of platform/uv code. All we see from you guys is:

 - Drops of adding support for new platforms

 - Occasional fixes when we managed to break UV or you found some bug in
   your precious code.

> Nacked-by: Dimitri Sivanich <sivanich@hpe.com>

I'm happy to add that tag when merging this cleanup.

Thanks,

        tglx
