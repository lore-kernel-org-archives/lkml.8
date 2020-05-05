Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F3EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45712206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgEEPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbgEEPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:48:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:48:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F04C737;
        Tue,  5 May 2020 15:48:36 +0000 (UTC)
Date:   Tue, 5 May 2020 09:48:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: fix binderfs sample
Message-ID: <20200505094835.47cc2d53@lwn.net>
In-Reply-To: <20200429080113.wetsjwkfxfrarfvf@wittgenstein>
References: <20200428212555.2806258-1-arnd@arndb.de>
        <20200429080113.wetsjwkfxfrarfvf@wittgenstein>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 10:01:13 +0200
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> On Tue, Apr 28, 2020 at 11:25:33PM +0200, Arnd Bergmann wrote:
> > A routine check for misspelled Kconfig symbols showed on instance
> > from last year, the correct symbol name is CONFIG_ANDROID_BINDERFS,
> > not CONFIG_CONFIG_ANDROID_BINDERFS, so the extra prefix must
> > be removed in the Kconfig file to allow enabling the sample.
> > 
> > As the actual sample fails to build as a kernel module, change the
> > Makefile enough to get to build as a hostprog instead.
> > 
> > Fixes: 9762dc1432e1 ("samples: add binderfs sample program")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Thanks for fixing this Arnd!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
I've applied this, thanks.

jon
