Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5EC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D18C222D9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581127364;
	bh=Ep9DWWQ3IAk/c/WU1LcSyOTQsUi867TZ20j0xnKOrws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wp268BDXttO6Kf5f3lwh9yDyDrmlHJJiC9EK7cxZbYyOccgoN9y8LVt78KQFnQVyK
	 GTHYCq7adYztLW3imApjSHma6+dJbayfSwKzhWrnie10QRv5clEED+htBVPo54tJsW
	 dmkshy6a4kwFwuNXGhBjpEztYUS26AOVdOuXfWIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBHCCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 21:02:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36080 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgBHCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:02:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so611933lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSdbqNdPUtUOvCueS/kVTLhf/ggnA3z2ZykHjuNmsTs=;
        b=VjcqDW8gFUGTKHEOyfrP8+Sz/MKzSyHKR1RBD8+MxKlM4JHzWLHEDfAaKf8H1gM88v
         vuL5c8C6Gt9Mc6Z39qUSOcCQ5o5ZfPL+RKcd2AbIHEEly13PPff2bSDVm0ZAuX6jzQgc
         wqSt3wapwl+Nw1u3e+WOKGpDc3wRmryDrCoAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSdbqNdPUtUOvCueS/kVTLhf/ggnA3z2ZykHjuNmsTs=;
        b=Aib1unQh2DtMa9eeH/cEWksl2HPufUD6AbIsYZT9CMNzeW9OrcC4dz6CRIm2l+Zajx
         BFM8jxqKA/8NO9ccOG5ifS3XkMw4V9D3LVbQfFcg85WRxJOF65fSTS+/Sc/sV/5YXVbl
         U2wJysb47W+uzkVUeotreGv7LZZ81l0ZZ71c4oDiZjBFYglInVh97R2AFTvDh7Gm819c
         FUeBhyrW1+MG3Vc8BDAFwcEDW6B9j8T+VCkcNr1UwXfPB9yL+vmGjj/mwEdxPey3YNJN
         pNJLT4wlpKBNXHWfYOdphPRUE2/XI/YjywXKInzyq3fngduuwiE9H3wuTPVn86PUCuiL
         V4nA==
X-Gm-Message-State: APjAAAXrZMiOdI+/vzT9h4FXXhW/JVnOQCI2Et7yn48WIzFcQffc1ivq
        yRHSMMFhmt37t3B8vBzd1228FcG7wnY=
X-Google-Smtp-Source: APXvYqzTlft0mZSbuJxtwff2JjoLDv2UqUhA1oDWbicSHPcRCqp6MVTM6EBIApEze/kb82KMzVq3Cg==
X-Received: by 2002:a19:4208:: with SMTP id p8mr843019lfa.160.1581127357211;
        Fri, 07 Feb 2020 18:02:37 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h19sm2089082ljl.57.2020.02.07.18.02.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 18:02:36 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id r19so1311731ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 18:02:35 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1220068lja.204.1581127355277;
 Fri, 07 Feb 2020 18:02:35 -0800 (PST)
MIME-Version: 1.0
References: <297144.1580786668@turing-police> <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com>
 <20200204060654.GB31675@lst.de> <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
 <252365.1580963202@turing-police> <20200206065423.GZ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200206065423.GZ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 18:02:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
Message-ID: <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
Subject: Re: [PATCH] exfat: update file system parameter handling
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 10:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The situation with #work.fs_parse is simple: I'm waiting for NFS series
> to get in (git://git.linux-nfs.org/projects/anna/linux-nfs.git, that is).
>  As soon as it happens, I'm sending #work.fs_parse + merge with nfs stuff +
> fixups for said nfs stuff to Linus.

I've got the nfs pull request and it's merged now.

               Linus
