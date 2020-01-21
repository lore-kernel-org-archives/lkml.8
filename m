Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A878C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1682253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUHsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:48:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:47384 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgAUHsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:48:15 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00L7lP0w003538;
        Tue, 21 Jan 2020 01:47:25 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00L7lN5d003537;
        Tue, 21 Jan 2020 01:47:23 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 21 Jan 2020 01:47:23 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
        allison@lohutok.net
Subject: Re: [PATCH -next] powerpc/maple: fix comparing pointer to 0
Message-ID: <20200121074723.GF3191@gate.crashing.org>
References: <20200121013153.9937-1-chenzhou10@huawei.com> <618f58cd46f0e4fd619cb2ee3c76665a28e30f4e.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618f58cd46f0e4fd619cb2ee3c76665a28e30f4e.camel@perches.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:52:15PM -0800, Joe Perches wrote:
> On Tue, 2020-01-21 at 09:31 +0800, Chen Zhou wrote:
> > Fixes coccicheck warning:
> > ./arch/powerpc/platforms/maple/setup.c:232:15-16:
> > 	WARNING comparing pointer to 0
> 
> Does anyone have or use these powerpc maple boards anymore?
> 
> Maybe the whole codebase should just be deleted instead.

This is used for *all* non-Apple 970 systems (not running virtualized),
not just actual Maple.


Segher
