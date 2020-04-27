Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D178C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2511020661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588002563;
	bh=OyNRz7IsAlS0ADmWwL2MYfrE+apa1uCaMYPWIt9UIwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hoUi3aJb5ntrKzIipPdOQOkuUSVNPiouEW/WrBE0tODNOD42cFzRemwRVOXEOCTlj
	 bGo/OWiCzXziKtACL+9vPxNG/sqJJq8Zsdwbdy2G5wUNaTmB1jwP6998DrEJ3FLsfp
	 y8wbivI5c8lLLNqy5HP2jnvlkdpt7hguUQ9zp330=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgD0PtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgD0PtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:49:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14AA2064C;
        Mon, 27 Apr 2020 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002561;
        bh=OyNRz7IsAlS0ADmWwL2MYfrE+apa1uCaMYPWIt9UIwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zuPT42M9YmX7VY+ZqbSHQJlDBEhAbUdK/fU9+MY5pk67ORz/B6t/sh8QSXFh9EW7I
         VhPsjXizWfkuGmL4VqxU8NDRMneAvln8B5V7AQ+iVqoCrvkCAMyr4s3U6CyyRzc9Mf
         z64rzqlXvUVNJBcs3qLmLUwZWaXtC57e/anzudpQ=
Date:   Mon, 27 Apr 2020 18:49:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200427154917.GF134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
 <20200414062454.GA84326@gmail.com>
 <20200414070502.GR334007@unreal>
 <87v9llosax.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9llosax.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:35:18PM +0200, Thomas Gleixner wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> > But if we are talking about other weirdnesses, I have another splat in my
> > QEMU machine, which is different, but from the same code area.
>
> It's a completely different code area, really. This triggers in
> deactivate_slab().
>
> > [    1.383968] ACPI: Added _OSI(Module Device)
> > [    1.385684] ACPI: Added _OSI(Processor Device)
> > [    1.389345] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    1.389345] ACPI: Added _OSI(Processor Aggregator Device)
> > [    1.393454] ACPI: Added _OSI(Linux-Dell-Video)
> > [    1.394920] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> > [    1.396481] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> > [    1.793418] ACPI: 1 ACPI AML tables successfully acquired and loaded
> > [    1.845452]
> > [    1.846768] =============================
> > [    1.849293] [ BUG: Invalid wait context ]
>
> Do you have CONFIG_PROVE_RAW_LOCK_NESTING enabled? If yes, please
> disable it. The Kconfig option explains that this will trigger
> splats.

Yes, I have it enabled.

Thanks for the tip.

>
> If not, then this is mysterious but has absolutely nothing to do with
> the other thing. It's also completely unrelated to ACPI ...
>
> Thanks,
>
>         tglx
