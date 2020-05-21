Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ED0207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8x6M/zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgEUPUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEUPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:20:39 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:20:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so3232906qva.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PyltkYq399/JnsXHqh2D/haZU5ohhj4XlFCKZOShGc4=;
        b=N8x6M/zN5oXi53W+aZtSeZNvck40A/pd4XKv5kB1pFWvNSGbazExCxFxEx0fjxH0Fi
         kV1IgKGW0GF+hmtrw5uGnaxk8h0/E4MECFg9aasbvC9+9HpC137JoQVs02xm1W9duv1K
         WKdXLvPXFW2DTSrD+XP+/x2lQWv4PJnAAjZ8IAZAHPO3P2FF3DgQTKiwrsQJlhLZVlN9
         pkyTo58bx6uIBSgpnF+CNUVcX9l1wyknoAVCYKhFjdw0OAH0vbnIPt3O2EOrdplOIoFO
         5IMe9xuapdDWN4Y1eeDV5aPMfE9/+B8WVR6vBIpHOpa8B07sKq5iDVotvujJv46qgKDL
         xW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PyltkYq399/JnsXHqh2D/haZU5ohhj4XlFCKZOShGc4=;
        b=soyP5s3ev3S6IV1tMMx+3Cg+bCDBHZKISUDDhfcWIRujnB4v4aZaHmXGoJRTld2/V6
         NsPNV3PHoIvxmNq+/Zc66/t5CK6kQq66Q/SUmCFYuXoNe7casw67x9KMaGt5kJ+dvT9m
         jnNK3R8DWA4dNaUQz3rFQbvEr0ePdCN2zvb8z4r9Bi2TV9jCopVw5z/wo3YQKy6sWI2B
         7N6HiHWlb9PY92Sjt/xmJ4KYLjlJTQD4OWxav5Pe09JMWXIGi+UON0GYzxe7zhgNn+VF
         GUoCaUkHn4DXgjJSyxUWs1laSU526ulgr3y1PD3WEo5SdyvwwmVuxrAi2pHxJpqW+imU
         sfLA==
X-Gm-Message-State: AOAM533csOsJGsgvqOToTp5KzgIY/U8zY64Jvus0ivD0dtXw+vcyCsrW
        /W8KnKViP63yfXW/GA2BeLWBmnQN
X-Google-Smtp-Source: ABdhPJysyBTLsuoLoi3TrI8qn796huK6BCJEy7tJl4iIe9dlIWinKQCZRtxKaCTpO+JKBZjFDm/eTg==
X-Received: by 2002:ad4:466f:: with SMTP id z15mr10845318qvv.101.1590074438779;
        Thu, 21 May 2020 08:20:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l5sm5304896qtu.42.2020.05.21.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:20:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 21 May 2020 11:20:36 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86/boot: lld fix
Message-ID: <20200521152036.GB502432@rani.riverdale.lan>
References: <20200520225654.4144534-1-nivedita@alum.mit.edu>
 <20200520233357.GA4160490@rani.riverdale.lan>
 <20200521021217.yqsulqwfrhqorp7p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200521021217.yqsulqwfrhqorp7p@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:12:17PM -0700, Fangrui Song wrote:
> On 2020-05-20, Arvind Sankar wrote:
> >On Wed, May 20, 2020 at 06:56:53PM -0400, Arvind Sankar wrote:
> >> arch/x86/boot/setup.elf currently has an orphan section .text.startup,
> >> and lld git as of ebf14d9b6d8b is breaking on 64-bit due to what seems
> >> to be a change in behavior on orphan section placement (details in patch
> >> commit message).
> >>
> >> I'm not sure if this was an intentional change in lld, but it seems like
> >> a good idea to explicitly include .text.startup anyway.
> >>
> >> Arvind Sankar (1):
> >>   x86/boot: Add .text.startup to setup.ld
> >>
> >>  arch/x86/boot/setup.ld | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --
> >> 2.26.2
> >>
> 
> I found your PATCH 1/1 on https://lkml.org/lkml/2020/5/20/1491 
> 
> -	.text		: { *(.text) }
> +	.text		: { *(.text.startup) *(.text) }
> 
> The LLD behavior change was introduced in
> https://reviews.llvm.org/D75225 (will be included in 11.0.0)
> It was intended to match GNU ld.
> 
> But yes, orphan section placement is still different in the two linkers.
> 
> Placing .text.startup before .text seems good.
> In GNU ld's internal linker script (ld --verbose),
> .text.startup is placed before .text
> 
> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks. I'll reword the commit message to include a reference to that
change. It's also not just 64-bit, on 32-bit it currently fails before
it gets around to linking setup.elf due to the text relocs issues,
that's why this one doesn't show up, but they are in fact at least
consistent.
