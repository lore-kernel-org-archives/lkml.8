Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D28EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508D212CC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIH5C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:57:02 -0400
Received: from lixid.tarent.de ([193.107.123.118]:44812 "EHLO mail.lixid.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgDIH5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:57:02 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 03:57:01 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.lixid.net (MTA) with ESMTP id B721814094B;
        Thu,  9 Apr 2020 09:47:57 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
        by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
        id L4OhUbqpilQB; Thu,  9 Apr 2020 09:47:52 +0200 (CEST)
Received: from tglase-nb.lan.tarent.de (vpn-172-34-0-14.dynamic.tarent.de [172.34.0.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lixid.net (MTA) with ESMTPS id 4FB5D1406B0;
        Thu,  9 Apr 2020 09:47:52 +0200 (CEST)
Received: by tglase-nb.lan.tarent.de (Postfix, from userid 1000)
        id 0662B5203EC; Thu,  9 Apr 2020 09:47:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by tglase-nb.lan.tarent.de (Postfix) with ESMTP id 038A352034C;
        Thu,  9 Apr 2020 09:47:52 +0200 (CEST)
Date:   Thu, 9 Apr 2020 09:47:51 +0200 (CEST)
From:   Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase-nb.lan.tarent.de
To:     Andy Lutomirski <luto@kernel.org>
cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, 954294@bugs.debian.org
Subject: Re: __X32_SYSCALL_BIT being defined as UL constant breaks
 userspace
In-Reply-To: <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2004090945110.31491@tglase-nb.lan.tarent.de>
References: <alpine.DEB.2.22.394.2004081607050.27197@tglase.lan.tarent.de> <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020, Andy Lutomirski wrote:

> One might reasonably ask whether it makes sense for syscall nrs to be
> signed at all.

It doesn’t, but it’s probably this way for hysteric raisins.

> But regardless, this breaks userspace and we should fix it.  I can
> whip up a patch to split it into X32_SYSCALL_BIT (unsigned long) and
> __X32_SYSCALL_BIT (uapi, int).  Thomas, etc, does this seem

This would help with the issue, thanks.

> reasonable?  (For those not following all the machinations, this
> change caused some userspace build failures in libseccomp and/or
> systemd for reasons that are vaguely silly.)

Not very silly:

	printf("%d\n", __NR_mmap);

That with -Wformat and -Werror (or -Werror=format) rightfully warns,
as the compiler cannot, on x32 (where int=long), detect that, on
architectures where int≠long the constant is int.

Even worse, switching userspace to unsigned long globally would
completely hose this on LP64 architectures.

So this is, in my opinion, completely justified. (Disclaimer: I’m
not affiliated with systemd and not even running it except udev.)

bye,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
