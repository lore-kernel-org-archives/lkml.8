Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1857D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H4wRIpkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLJra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:47:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgBLJra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:47:30 -0500
Received: from zn.tnic (p200300EC2F09E80011DF4A8A67D9D17B.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:e800:11df:4a8a:67d9:d17b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D187F1EC0CE4;
        Wed, 12 Feb 2020 10:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581500848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A+UxdxRfhb2KxZ5sW3vuVAuCDanzPsN8zts9XRHkNTA=;
        b=H4wRIpkKfQOSd93tLrrVNgqNNdrbHHkjFWCmVHmTbEKhLJcSVbWj2nvtHtVCsC2LgAhyHj
        oG36/dDcP6WZoXCIEKYe/baFZv/TOp6Y33MZHRWP0ZcYkLEZy1KNy+HPe8vV1tZ7K8gre8
        0rFkquLVMlKS3piZC/BMj+j4srUnAi8=
Date:   Wed, 12 Feb 2020 10:47:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH v2] x86/boot: Use 32-bit (zero-extended) move for
 z_output_len
Message-ID: <20200212094721.GB30793@zn.tnic>
References: <20200211161739.GE32279@zn.tnic>
 <20200211173333.1722739-1-nivedita@alum.mit.edu>
 <20200211181559.GI32279@zn.tnic>
 <20200211192739.GA1761914@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211192739.GA1761914@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:27:39PM -0500, Arvind Sankar wrote:
> Yes, this is just a "neatening" patch to use a more appropriate
> instruction. There would have to be a lot of work to allow kernels to be
> bigger than 2Gb,

And yet we're bloating up, right into that limit... ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
