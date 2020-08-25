Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CA22076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UFYOs0nS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHYQUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:20:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgHYQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:20:04 -0400
Received: from zn.tnic (p200300ec2f0c5a009557515e5e730b1a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5a00:9557:515e:5e73:b1a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AEA81EC02F2;
        Tue, 25 Aug 2020 18:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598372402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5IBziXPpKvbhhwgqPns5G/U34kVP+yhkOY8NKitEfqY=;
        b=UFYOs0nSLheWet86YKFgFmeHP+EMoJimZ0vnWmXbT1qWa8UsoTHbee/zvk/w0UlO9/ceSw
        BfUOS4IJxsClx3SFCN8Gf/TvVSyB9KRmuqIkj967x8OTtgTPd62rRRNr4hCqJxLECSPXnr
        s4TsdOj8jF4pcoCnx7YaLlUqeRfplAE=
Date:   Tue, 25 Aug 2020 18:19:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mchehab@kernel.org,
        tony.luck@intel.com, aou@eecs.berkeley.edu, james.morse@arm.com,
        rrichter@marvell.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH 0/3] SiFive DDR controller and EDAC support
Message-ID: <20200825161958.GE12107@zn.tnic>
References: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
 <mhng-eeb15e05-0af6-42bd-8c35-0b7e9bbedba7@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-eeb15e05-0af6-42bd-8c35-0b7e9bbedba7@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:02:54AM -0700, Palmer Dabbelt wrote:
> Thanks.  These look good to me and I'm happy to take them through the RISC-V
> tree, but I'm going to wait for a bit to see if there are any comments from the
> maintainers of the various subsystems before doing so.

I'll have a look at the EDAC bits these days and give you an ACK if
they're ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
