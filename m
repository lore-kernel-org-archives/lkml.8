Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F43C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB38F2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585855993;
	bh=mYqoGLfUyvbdSbBXG282XzhrTLZ31L+XrX9dy+hzoEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tt0WK8accdWAdk93UKoXa9krCAOpgMfjMaEQHMr4sO/bTmKi23WSEbFMHUP3IT0eR
	 kq2OiAJPcaYK9HarxXP/GMEWOpRbBUvSWnlOPUcgITvLga3zhnlhUkh98T84rbqTGE
	 O0kaytE2eGjJovrKR2luDXspvSorrSUQZco3Xdi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbgDBTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:33:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46148 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:33:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id cf14so5827617edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNVfYQcU5r7QqnygVgwbeTwWR3NWKnCIk7XJifmEK+g=;
        b=WFRj2oMOOBQ9Ye/JZJICZujrvRy2hkbOR9uXKlMdFDvf9Q5Lq80wgWioeP0e0rs0oj
         n0Wk/vH8ieHoUcWgLtyDYX5P7nJxjuAYNdlNyNknULgO81UVaZJ0LqdKLLefqzuqrqZf
         RMdkwJXPuZPoAbZGgiU6xp+RQahaYFh5oXLKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNVfYQcU5r7QqnygVgwbeTwWR3NWKnCIk7XJifmEK+g=;
        b=hJUbA6WWPUpTFFAEP2Kd7TpSl6r3vL5oV0fTTRf7jkKLHnA+lsxHTr05lzfjaBzDqD
         midmDoGUVwyFK+15epjG0rmHLjRf5eg0ON7QVXvFTiElW1SCT1V7FuWBOL1wflod36J8
         bTNXUUjaTMzbdh4jxdbvVaxgJyTAHdfx6gkeJY92d151z600Ljn8njLx8UPJHRIq+EZ2
         QgZXrnn2sbtrODH04by/zfJwnj5j08W8qlMKdc8I5daXw455W0VsWFq9MCp8wXUNox+w
         eZGCWwFMiJPWMywk9nfCIojoGMinLFAvygqkh+BoimqQixf0C6NxamotWlX5vOOUZMGG
         0xpw==
X-Gm-Message-State: AGi0Pub0fya7nc2XwaMBXW5GPwiXa8MqT5ah6MWL39BmMmE2eK0Fghd2
        g0XFKZPF8DhJv45XbSdEGpL4XfnVhc0=
X-Google-Smtp-Source: APiQypLxS5pFtPUKQVZk4pYmw/PxBOSX42WwV0hlHJ+biivDhGUbq1JxJ76sSchl4xOOlBuJmQgPTQ==
X-Received: by 2002:a05:6402:17a7:: with SMTP id j7mr4646605edy.334.1585855988524;
        Thu, 02 Apr 2020 12:33:08 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d23sm1246832ejk.26.2020.04.02.12.33.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:33:08 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id c7so5639304wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:33:08 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr2938169lji.16.1585855628859;
 Thu, 02 Apr 2020 12:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk> <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
In-Reply-To: <202004021132.813F8E88@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 12:26:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Message-ID: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and user_write_access_begin/end
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.

Wel, at least the user_access_begin/end() sections can't nest. objtool
verifies and warns about that on x86.

> If we were looking at a design goal for all architectures, I'd like
> to be doing what the public PaX patchset

We already do better than PaX ever did. Seriously. Mainline has long
since passed their hacky garbage.

Plus PaX  and grsecurity should be actively shunned. Don't look at it,
don't use it, and tell everybody you know to not use that shit.

                Linus
