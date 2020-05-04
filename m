Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42708C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B91520705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CV2JK5Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgEDOJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:09:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4797C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 07:09:47 -0700 (PDT)
Received: from zn.tnic (p200300EC2F08AF0065867C3890225131.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:af00:6586:7c38:9022:5131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11AC31EC02D7;
        Mon,  4 May 2020 16:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588601385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lZ4aqziNyvYw3GSKD0XU2YhwX5XuP4rjgq7LEC+3Iqg=;
        b=CV2JK5XtORlHCkNTYou9kVw9zJqbNvImcy+Ef0Lg9WYr+0d/WUYKm7Q+v8dQkTqVWm5tOr
        jQLH0vU2yAhM8X+zNEiv85x88vP3kdT5T4p9oMaPu4Z5uuYILNoSMCZlIjeUu68p93DlJs
        ke4Z5HXJpAcd1VM5kSGynvIClmH/dpk=
Date:   Mon, 4 May 2020 16:09:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] Documentation: x86: microcode: add description
 for metadata file
Message-ID: <20200504140940.GF15046@zn.tnic>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
 <1587972479-10971-4-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1587972479-10971-4-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:27:59AM +0300, Mihai Carabas wrote:
> +Here is an example of content for the metadata file::
> +   m + 0x00000122
> +   m - 0x00000120

That's not enough. Imagine a blob adds the MSR and a subsequent blob
adds *another* bit in that MSR. You need to be able express that.

IOW, I think it would be easier if each line describes exactly *one*
software-visible change brought by the microcode.

Also, what is the use case to say that you're adding a new MSR?

This would require to patch all the code that *potentially* might use
that MSR, to be able to handle a *change* in that MSR or it appearing
all of a sudden. Yuck.

I mean, an easy way to handle it is to say, "Hmm, nope, won't load that
ucode."

> +   c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
> +   c - 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000

I don't think this'll work with the vendors as depending on the
configuration, CPUID on the different platforms could be different.

And then you might gonna have to specify CPUID for this particular
{family,model,stepping, ... } tuple which identifies the platform
uniquely so the c-line is insufficient.

IOW, I think it would be easier to be able to specify one CPUID bit per
line of being added/removed so that the post-load callback can handle
this properly. And this specification needs to be complete: i.e.

"I'm adding this CPUID bit for this family,model,stepping configurations
under this and that conditions".

And that needs to be describable by the "language" of the metadata.

So think of actual examples and then try to represent them with this
format.

But all of this is moot if you don't get a vendor buy-in into this. IOW,
microcode vendors need to agree to this format and adhere to the format
when allowing microcode to late-load.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
