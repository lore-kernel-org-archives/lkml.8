Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5CC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49C20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580581778;
	bh=jKMJDbpHEhAKlTdIT/UPPi0qx9us1KYw98GOzNZaGn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A/RDpwjY+h0cXtxu6nVBghgXv82jvLtHlygo5UslxPNIjCyqSe2GOlmHO22OLq03Q
	 IIr8lqC81OmHhaEPf10X0o9uaLmxW88hjfhHhtDCL+BAKN/rSkburpatAnbRe0A/av
	 UR0GPOhj2loVYkoDvgifVvGDRKGc2lDTq5NaFOIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBAS3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:29:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44394 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBAS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:29:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so10467999ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSI0TK8DtQcgu7WAq2+0dqsq5n6ujNavCAHjt896Jhg=;
        b=A5Ie0buo7SpllcOPGmNpyxOG7YA6j+kdIqsnzFtc1W8MKL4VnNs71wro8qKmqbCCNO
         jnMq/AjHCV4Ub2WdHib6Xp5vXi7cyE7o55BhCqAOvz18NMJybm8Jby8Z4vYrkHB5j76B
         SVGzrUeALZlF/zC8ExpgB54jGYy4T2P1Ol/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSI0TK8DtQcgu7WAq2+0dqsq5n6ujNavCAHjt896Jhg=;
        b=C3eKCLvEFbtJodY5bBn+rosTCbHrG/R9iALiMpBFc9OUvwkqBBDNAMP7ZdqnGAyHdU
         3FqRb3ZQ8eFakC7i9AGxD8GiImkNRWDBptsWBOo8kzoQKlhI/ukskfTT1O+3vdyKzHct
         URSWzDJPfMKOHFOJkxe0qr1UnQ0cGr3ZCOo90S90DHsZRg2R5T4YPaLcNikDksaryV+f
         Z3YntGB185mUGiSXZrmesYortPjquPUxp67Ymv+E6fFEImKOzU69sNKq28yafph+rl9O
         p6NJHr5tX71NjtKeNQNXX1ZJWTGwoJ7ySn/9pz2751EblnmchplL8yrzN1DiPXhS6rEp
         wIPQ==
X-Gm-Message-State: APjAAAVPIe5EFf6bf1whxDDkGBk3khYCXma9oCBck0OcVFa2ylC+3Ap1
        FmVRUDUGmTPDiv1OX2CWpk4N02dcf9A=
X-Google-Smtp-Source: APXvYqzgmuzmUENWySR2j7iVSIRTnmp004n68dZOibLw5lHb8B+D3w0kV4O6LhegsaZ1Ly2aZrQvQw==
X-Received: by 2002:a2e:865a:: with SMTP id i26mr9499055ljj.236.1580581774764;
        Sat, 01 Feb 2020 10:29:34 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 23sm7017239ljw.31.2020.02.01.10.29.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:29:34 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f24so7037012lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:29:33 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr8157515lfm.152.1580581773681;
 Sat, 01 Feb 2020 10:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20200201162645.GJ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201162645.GJ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:29:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Message-ID: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Subject: Re: [PATCH] fix do_last() regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 8:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Brown paperbag time: fetching ->i_uid/->i_mode really should've been
> done from nd->inode.

I'm assuming you want me to apply this directly as a patch, or was it
meant as a heads-up with a future pull request?

                 Linus
