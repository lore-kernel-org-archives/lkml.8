Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527BAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D88424676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1anK7vJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgANLu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:50:26 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39742 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:50:25 -0500
Received: by mail-wr1-f54.google.com with SMTP id y11so11859272wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ivr736knYIorCYXBCEfFvx8JIEKWP58L9vJcEe5yyJ4=;
        b=u1anK7vJl/+VgQZ2Mvc2T7RuBOEQstVyUDuOG3J8jiJTjSGyNQIeYf1zbiUi7/XKqj
         KCgN5hd1Z29+O5y7xkcsuJ/ujONJoQhfqENzL1MxEl0HLZEGjVRECmlUpoymIbr/qQUf
         uL6X/gMjms1ICNa5weT7MfILw6Uymwh0vT1b+4L7NJb6+SNtrGdbztJXYAK3NfARE4JY
         s0eDIigsQYQqVjZDVTet8KfzA2VyuIVD+qVTxpRVX6LN5QXQk+SAEF5IYruCHZYcQUjE
         p7qmyCVSYHmkhjCRL3TRRM4hUbF0KrhBhQlH1PMhcyzAK1dZQ2tcDS0yLqv6zlXVvu2q
         x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ivr736knYIorCYXBCEfFvx8JIEKWP58L9vJcEe5yyJ4=;
        b=iW95K01uKSsmPAmsQZTDedXYzYZkcRBSsoz7iqnxZdxWS9PaBqYq65wwkcLrrFgDhu
         hCjrnW0a7lchFhZKUfonuwfUCnszCzRpR12uVlDlTEMwPsOs2BIm0NIlpd6fI2cBdGfR
         2IFuIKzpz78uMRA6wDXqbra50NEqtDlDlvCsuNdLGAIHrK322qIp763dfB8AZKgnLybc
         Om8ciRr5fJ+Lx7TtKta2E4iVya+I+S0+hXpxH7immL13yIZd7PyeBTsd29rikW0DaRlJ
         xoMu5eQdw6nKhAShLUS2dh8DNMAE1Qg7fobLCBB8bwZqnuzcD1l1P59/UTtuIxOnoHN9
         95NQ==
X-Gm-Message-State: APjAAAVvZ8F4gmP4FWZZ7ka5mBRpjO8yYx3BbpfkZLuoLkoGXebS0Uxd
        X1M1IDG5hL+HVRNHzMoNl4aXSpuSBAU1z7cDha8=
X-Google-Smtp-Source: APXvYqzKDeyTtNAAtwd2SPDtOnLmzhCbpnQujK7AIp1vSLBiKBiVDt3GPkim6qYUs53Sg6psb/cDt2IxB9ke2Gj+p8s=
X-Received: by 2002:a5d:5491:: with SMTP id h17mr25206380wrv.374.1579002623832;
 Tue, 14 Jan 2020 03:50:23 -0800 (PST)
MIME-Version: 1.0
References: <CAJKSTDwPX3D956yMaNakgjbHSd7hyyU7YbGN-nM=LmR3qXMtxQ@mail.gmail.com>
 <22e494d8f2c7448dbf75a70a949d1280@AcuMS.aculab.com>
In-Reply-To: <22e494d8f2c7448dbf75a70a949d1280@AcuMS.aculab.com>
From:   xuesong Chen <xuesong1977@gmail.com>
Date:   Tue, 14 Jan 2020 19:50:13 +0800
Message-ID: <CAJKSTDxsSH=ToKhhBizydi6KiJkSxhAcKAHOo1593p3L3At0Zg@mail.gmail.com>
Subject: Re: Question about output of kmalloc()
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 6:36 PM David Laight <David.Laight@aculab.com> wrote:
>
> From:  xuesong Chen
> > Sent: 14 January 2020 07:21
> > Below code snippet in the .ko:
> >
> > unsigned long *p = (unsigned long *)kmalloc(sizeof(*p), GFP_KERNEL);
> > printk("Addr of p = 0x%p\n", p);
> >
> > The output is:
> > Addr of p = 0x0000000018606ce7
> >
> > In my mind, during the early day, the p should be 0xfffff...., can
> > anybody give some tips why the output looks like it's a physical
> > address?
>
> The printed value is hashed to avoid leaking info.
>
But '%px' can print the correct value, so seems the infoleak is still
there... BTW, kindly point me to the hashed address code part?
>
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
