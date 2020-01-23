Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E6C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70C822522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579804730;
	bh=uS1j4xUyCTKyoCCN5jmxQEAMZpACEpOnPizd/Neez5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z21eNIjA2CJh5kAYBGYtZdN2i6pi9SZ4Dw8T6FnKEQ7b/t4hjP0vBJ5F+DHhYXBX7
	 DOMBlVFaAQ2sONAzdkR3xj135Gx7k/0Puq3Lum2cjZjEe1mdbfTRRbX4aGmmhmmepT
	 SydDQSvLT84yhyYSBprv2f2F60A2geKeHk7E+rxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAWSiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:38:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40477 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:38:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so4720300ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ25OTOBjFwniHXaIhyRIPei9koK1Vea3aQMS9ddWaY=;
        b=CO5Rx/d/+juGBR+FFLJo0Qdw3RYFgTLIf+Mnl29p0mNIytugs2NcVQlE2/w2WUc19a
         r7ybFhTMI9YigwXFyviyqQt0NfnDBfayvOxgRYe2KBPKF1sYRQ5QUo2wzCyUmR6GFB8N
         XlNGtwTb4WQwbGi39oResI6dOVY+bDpk8CA2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ25OTOBjFwniHXaIhyRIPei9koK1Vea3aQMS9ddWaY=;
        b=tb2FtbHICy1RZ1CLpBYEKhCww41uGqvcfVqoZ2E0E4MilNHMYGFde9V0bN63wQsvUp
         HvYL6XmLuX2/zwDdEHp8Bjg5N0I3UyRmTywvssya+3HEoS2iBFI1iIc398mrbt3DPY0N
         30+gr7R9P41vRAiQ2QK0jFjKaRir+5IfbDQjleVAyV4dV+5OVpSZqVIcTpVMgxASWqnE
         E2G/xgf0Jwkx3UFhWr1scdqW9SsJNT8verKzoX+iFTSD1bTYO9KUSpeDYvi/yTtta+Zu
         m5iuDQPhHmD6yVurA67+JD3MnMu2bNgFvIQeJ1+klN2GZionuDKoDww8GkikKuKUHOpI
         76AA==
X-Gm-Message-State: APjAAAXFdmN1nOKNODw84lmxoT7wpObR1uKAVDnd/Ncwlc9+YJ+i0Fng
        Px+sfdwC7pVF54OD13VfEMvB5RyzZgk=
X-Google-Smtp-Source: APXvYqzi+WckUnZYoGfw1BhrcXd/luEDH3932G47MJ14m/auKqK6izVbuSRTe1r7qIq0kWoBkwd5WQ==
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr23902146ljc.84.1579804727262;
        Thu, 23 Jan 2020 10:38:47 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q17sm1741654ljg.23.2020.01.23.10.38.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:38:46 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id z22so4773809ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:38:46 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr22668549lji.23.1579804725767;
 Thu, 23 Jan 2020 10:38:45 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <87muaeidyc.fsf@mpe.ellerman.id.au> <87k15iidrq.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k15iidrq.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:38:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
Message-ID: <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 4:00 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> So I guess I'll wait and see what happens with patch 1.

I've committed my fixes to filldir[64]() directly - they really were
fixing me being lazy about the range, and the name length checking
really is a theoretical "access wrong user space pointer" issue with
corrupted filesystems regardless (even though I suspect it's entirely
theoretical - even a corrupt filesystem hopefully won't be passing in
negative directory entry lengths or something like that).

The "pass in read/write" part I'm not entirely convinced about.
Honestly, if this is just for ppc32 and nobody else really needs it,
make the ppc32s thing always just enable both user space reads and
writes. That's the semantics for x86 and arm as is, I'm not convinced
that we should complicate this for a legacy platform.

                Linus
