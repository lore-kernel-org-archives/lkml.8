Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B320848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B1ETMjUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgBKQRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:17:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgBKQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:17:49 -0500
Received: from zn.tnic (p200300EC2F095500A0BCD2BD7DE0BB10.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:a0bc:d2bd:7de0:bb10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0043D1EC0CE0;
        Tue, 11 Feb 2020 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581437868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jNk9ru2Mlqvgd7oMyU9lkOHZ6oDMW/fu9MopoXicqJA=;
        b=B1ETMjUfOxNsmpk3jWvkrrohvcvBf/aYVTwOMDnRPCPxnVzf3LrgtO9mXlqXwFq/i4SBbZ
        FZmBNFxMp4G7sbovMlUZL0KGBUjpnPjr7Gxm9J1nLF/IxuPccFIMbGAeh4KpCi/eTS5Ef4
        6c3S6vP9kwboJcZjYvPNJ3Z0IZUau04=
Date:   Tue, 11 Feb 2020 17:17:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH 3/3] x86/boot/compressed/64: Use 32-bit move for
 z_output_len
Message-ID: <20200211161739.GE32279@zn.tnic>
References: <20200107194436.2166846-1-nivedita@alum.mit.edu>
 <20200107194436.2166846-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107194436.2166846-3-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:44:36PM -0500, Arvind Sankar wrote:
> z_output_len is a 32-bit quantity,

It took me a while to figure out why that is, with Michael's help.
Please write in the commit message why it is a 32-bit quantity so that
it is clear to readers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
