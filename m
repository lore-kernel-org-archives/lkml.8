Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A55320835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=notmuch.email header.i=@notmuch.email header.b="kACaUp8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgETBI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:08:56 -0400
Received: from mx.h4ck.space ([159.69.146.50]:58828 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETBIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:08:55 -0400
Date:   Wed, 20 May 2020 03:08:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1589936933;
        bh=eD1JwKxV0IM6VPh2p6kr6Xs6kEAiC5RCKFBXJxQjb4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kACaUp8rFsWqT+WvaE/embZRx2TrgrMj05jZLSFPC2E6wqVW+NSUYDl6D5UsSdxl5
         D9BYIyjLWIFczonYdLbGwxFAz6M4m0NJc3MBxwjqmy7WXxSzQDlQoP0hchZd/nGrHn
         fYbyQeUFkONBUHaHqwVLOMNs070TXS3WD5O02VV0=
From:   andi@notmuch.email
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200520010853.635wep2ewq4zpn2y@wrt>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:56 19.05.20, Brendan Shanks wrote:
> The problem is that the kernel does not emulate/spoof the SLDT instruction, only SGDT, SIDT, and SMSW.
> SLDT and STR weren't thought to be commonly used, so emulation/spoofing wasn’t added.
> In the last few months I have seen reports of one or two (32-bit) Windows games that use SLDT though.
> Can you share more information about the application you’re running?

I'll try to create a very simple reproducer for this case in the next
days. Unfortunately I don't have the source of the original application.
I can mail you instructions about it directly, if required.

> Maybe the best path is to add kernel emulation/spoofing for SLDT and
> STR on 32 and 64-bit, just to cover all the cases. It should be a
> pretty simple patch, I’ll start working on it.

Check the other mail from Ricardo, you can probably safe that effort :-)

> Alternately, I did work on a Wine patch to emulate the UMIP
> instructions in user-space, but it adds a lot of code and I don’t
> think there’s much appetite for it in upstream Wine (especially since
> the kernel emulation is sufficient for almost all cases).
> https://www.winehq.org/pipermail/wine-devel/2020-February/160027.html

Yeah that seems like the less favorable effort. My best guess is that
this might not be limited to Wine thus handling in the kernel might be
best.

> In the meantime, an easy way to disable UMIP without rebuilding the
> kernel is to pass 'clearcpuid=514’ on the kernel command line.

Nice, I'll use that next time :-)
