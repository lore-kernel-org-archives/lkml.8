Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD37C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32BA20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XYKOiU4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgFRUm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgFRUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:39:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dcf00ed288847e9b97b82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:cf00:ed28:8847:e9b9:7b82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB92D1EC0422;
        Thu, 18 Jun 2020 22:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592512755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qaDaPVDxHbDWv9+oI2zUb1akLXpcihmbLjFQrzPj0K8=;
        b=XYKOiU4H4SlbzHHBUXpUZ6YpP4J6LTxnIut7y2vtqiqxUuq9vm22Z1RT9w/OOylJz7WqWx
        bYcP29reJYY7dLlvIfXCB87pT/9tW8Wl4XF/fMvrk7s0gbcBQGcTcdZXFpIP3Jg8Vbev0A
        2fHs8D4bkhd3QJbIWWEUjwdylcFIsRA=
Date:   Thu, 18 Jun 2020 22:39:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [Nouveau] 2dd4d163cd9c ("drm/nouveau: remove open-coded version
 of remove_conflicting_pci_framebuffers()")
Message-ID: <20200618203907.GG27951@zn.tnic>
References: <20200618200106.GF27951@zn.tnic>
 <CAKb7UviibvRfqJgtLkePEuXFa6mQfi4h=7eeW+YQxB-StVjjrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKb7UviibvRfqJgtLkePEuXFa6mQfi4h=7eeW+YQxB-StVjjrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 04:19:02PM -0400, Ilia Mirkin wrote:
> Hi Boris,
> 
> There was a fixup to that patch that you'll also have to revert first
> -- 7dbbdd37f2ae7dd4175ba3f86f4335c463b18403. I guess there's some
> subtle difference between the old open-coded logic and the helper,
> they were supposed to be identical.

Thanks, that's a good point. I reverted both but it still hangs. So
either my bisection is wrong or reverting those two is not enough due to
other changes.

I'll redo the bisection tomorrow, on a fresh head, to check.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
