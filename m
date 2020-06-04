Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35755C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E56A20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCFjxOTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgFDO0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgFDO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:26:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FDDC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:26:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so7569308ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBoURK9IvkbwBs1kPGIuS8onwD7joVufvI7DnXYuvi0=;
        b=eCFjxOTAU45BkEXkm9dz6n9yVUTYKjF0lfqsZeaFC/6ify5YGNdJzi4s/42EJQZhBX
         1nyzwSJOUmHwTC4erzNqLYt8oP3Z9mcusdfhj7KwKo7ODOGeIntpb/jlb6NeGSOKC7zs
         2vxUEqxohHamBIFMr3SHgxK2PndlbotB5rKYm+Nr69EgxtRXHQOW/J5C2HYX4E7orDmD
         CLpVwcKlAHqOChEXa+jjLzSQApNsSM0P2DZgA16woVD/aZcsvKBrVEkn2y6s2mids0Y8
         bvhEzQ6JPoIN2jCASEnd2HlER4AKNlCgfiSozQwnM4G8f8hoZpJVCgO+rFQneglybL6p
         l2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBoURK9IvkbwBs1kPGIuS8onwD7joVufvI7DnXYuvi0=;
        b=lAOPTEzKDtC9lVj7n2RuTpbs+jiVX3w85qkILw3ZP9xIucldSIjk+KfodrYjwbC1m5
         daDY+WX2Mw6zL5t3MO6PSHOAFfkyDL/MpB5IcNo0qdSsY9+cFZAWhRzAAuaWW2MsYml2
         A+uZYeXNDs6bgbSmIm4QE+m4twGTqKQM/eWM89WrM98F5g1FJOKcDNGsHQwXl+vwFmNK
         p8xx26QKFfnZwyUCoXW1GTkEkHCHydal6A2dsMT4RLGz+wluCRylf5u/wNCYbgyGZ0x0
         fg2O7ITnLGBKFI5c73GC0V78vuBaAhh3UznHRKM4v06AAkAjB2Ylj0Y2SmRhq63btWUL
         MQDw==
X-Gm-Message-State: AOAM532lxtsaBMEzxU6/I7AGckr6zhby0G4Xk0gQS3h7lbMRspYhz2Dg
        zYGZUspn2wSloBZHm0xfxNYBPEa7mfhGTg0P9G4+9Q==
X-Google-Smtp-Source: ABdhPJwh/YOClis/hIwcKj8vHzbw8wx9bOB6tTVkvL98ptRj6m7SsH1K4mSctfjnB9d0qvovuLDzYkm1/ruBzlolZfc=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr2270197ljh.415.1591280758179;
 Thu, 04 Jun 2020 07:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200604134957.505389-1-alex.popov@linux.com> <20200604134957.505389-6-alex.popov@linux.com>
 <20200604135806.GA3170@willie-the-truck> <CAG48ez0H_+EBd1wekk2oddSzLsgzincyZb_dB+s5atudB23YyA@mail.gmail.com>
 <ab7b6e17-69c5-dce9-a0ae-d12964319433@linux.com>
In-Reply-To: <ab7b6e17-69c5-dce9-a0ae-d12964319433@linux.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 4 Jun 2020 16:25:31 +0200
Message-ID: <CAG48ez3LZ1xzAYHm23JOXTFBZqaHkVVZXwSe+VmmCBTwxKOdUQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] gcc-plugins/stackleak: Don't instrument
 vgettimeofday.c in arm64 VDSO
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kbuild@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>, gcc@gcc.gnu.org,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 4:21 PM Alexander Popov <alex.popov@linux.com> wrote:
> On 04.06.2020 17:14, Jann Horn wrote:
> > Maybe at some point we should replace exclusions based on
> > GCC_PLUGINS_CFLAGS and KASAN_SANITIZE and UBSAN_SANITIZE and
> > OBJECT_FILES_NON_STANDARD and so on with something more generic...
> > something that says "this file will not be built into the normal
> > kernel, it contains code that runs in realmode / userspace / some
> > similarly weird context, and none of our instrumentation
> > infrastructure is available there"...
>
> Good idea. I would also add 'notrace' to that list.

Hm? notrace code should definitely still be subject to sanitizer
instrumentation.
