Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEB208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OrKn1J/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFPVT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFPVTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:19:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D93C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:19:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so5015349lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRy69Tr1lrzT8zds2VU/VZdOzqvBMrrIUosFDbrbqYk=;
        b=OrKn1J/YXVkBXkTK+W7wBt2OgMnRjARIx1z+sp6X+NpilDwscgB74/2zyNQjoGO83C
         Po5xkD0NA1YHaJBLKqKNDl5MdzR7NqmJ053cNWBy6PAsFtOHCYhhczooB69oojOWOS65
         MVzltCXrkTJ/4Pl7Cw/hxBjsqOOBICjArU7WAHHo1ZKXI2XKwrWnonSKFcTSBRUUzZSZ
         cEp0tYl8/ipUspfMjYzBVSa1WxmxP5Ea5Lk8fm3zWvqwCiNFry2Q63p53UXd9m1+lMpm
         a0OhBph9IMUXnQmS/0ohaTPQSZ1759sI6/GhGFOjDhcq0XjSVU+R9De2V4Pbgsl1iOv0
         TYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRy69Tr1lrzT8zds2VU/VZdOzqvBMrrIUosFDbrbqYk=;
        b=h+sjMq8e0O/BsI0h/iFKNpoxPF78pVPVfK7hJp0RvRtTyEbYPYiepMzXQbTUbnE108
         FUwVYPbyt29C+bj6YF7txYe88W3nUjPQ6ropLwVySWdbhSRX9rmRVCRCRJOQpLCgpTi8
         EPvluTrl/efAtPz11fz3iKs6JrBAfWS3nevjBRppKEtixWBRag3pu/fXWeeWtInebcx/
         HH5lNThbc3fsdkeCd6CQFouYHjr3t9iN/c3dbUQqTjha/yylNyMvjinufrZeqtb6ynz+
         Fi4KimIhTUDdCl7KgcSUBe6XLdAI9VlYmAT2Yx3FrLK0JjaBaTgXnn+UbtdkpBCN2wU/
         wA7w==
X-Gm-Message-State: AOAM533fViDstFnYnjo8vuNTGBjy0kDItJYeUdqDw4jhdO1FNwc2zJVL
        CCqB60Qi+3SMAvF/UWCnzGZlK99fytDm+UbuS1/uBu4ZqQ==
X-Google-Smtp-Source: ABdhPJy5WUFWcij5N1NZJDUAAkVRefbSmpmU21wBc/qGQZzwGk/P0kbbAhMyjb3QNYYPemSqCxFqVgLETRYcl4ZXQNs=
X-Received: by 2002:ac2:43a5:: with SMTP id t5mr2582865lfl.197.1592342394044;
 Tue, 16 Jun 2020 14:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com> <20200616203741.GA13437@zn.tnic>
In-Reply-To: <20200616203741.GA13437@zn.tnic>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 16 Jun 2020 23:19:27 +0200
Message-ID: <CAEJqkghK8cjtsKUGn0bJ8nurzu2saNcVOAKJ43BtmgANWMY38Q@mail.gmail.com>
Subject: Re: Linux 5.8-rc1
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 16. Juni 2020 um 22:37 Uhr schrieb Borislav Petkov <bp@alien8.de>:
>
> On Tue, Jun 16, 2020 at 10:11:46PM +0200, Gabriel C wrote:
> > I didn't look closer at that but from the error, it seems to be,
> > some missing -fstack-protector* vs -fno-stack-protector* checks
> > somewhere.
>
> Can you give exact .config?
>
> Also, what compiler exactly?

Sure, config and compiler information uploaded to there:

http://crazy.dev.frugalware.org/kernel/


>
> I have
>
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> CONFIG_KEXEC_FILE=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
>
> here and gcc9 builds it fine.

I have gcc 9.2.1 20200215.
