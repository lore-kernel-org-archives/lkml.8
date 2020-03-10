Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC15C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926C620873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q05xIIQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgCJIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:54:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37923 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:54:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so6002710qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSPxA9X500mgbh9IFPNCBvtp5v+qregrP1EhmFh9wNQ=;
        b=Q05xIIQLHRc1MoiGKDvABRgahTMFDzDQ4Ck1T7qE3LuZVcY7SjB9im3hZXh1MBO8BD
         tQCQ5/nKjtYM51FVdSbLdKJNHTOr07CgOD7VspKmPJLSI2nKDNMYnGh+sgs9eEgdTaTz
         UAtWopKNqaTtn6NQW1GbkupcEFOUnnuOY8xmbv1jNSClQP43hozMkqz7dq3Sywj5LGzc
         NCBDP9dcWc9zXnyQ+e1bkqZJRb9S61qNJVSKpRfNYWkUurvYLqKtbQUUF+Ptg/TB8S2n
         V1Z27CFKbaqbF2MARL6t8YH4yvnrl2r4smaHIfyzrRnX47CCFxgEcqGa2BT07/kWYY2N
         bNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSPxA9X500mgbh9IFPNCBvtp5v+qregrP1EhmFh9wNQ=;
        b=YBWXUciaGBVA5j5pOJeLdP5mPnDlssQ1LmMALqnxWWl0BNTrCtxKm6iS3EcmYGrKI6
         aQ9lDWErD/ZYo0hJBHgdLhrB4limw2pI/8li+zFIIDJUe9hxms5C24jxZhZ/QfaFQoWm
         J4QAdjdYRuegw/3ZDqvlYdhxJCXysZa5gEKBctJcYkhdTdlRgt4LzAvBu+fW6nwqvho0
         M92CU7aOmu+IzjoBbEWmQlCLFf2pfTzn5oMBgMawyzpugG1TeY28n0IXKGqGqUJPh//c
         apTwf3rpwi5oLJH8mavHiyYQ9xlGql3N8hhBC/jo0VLdGDbsoLAj+DcLepSkyLGkv1ez
         uZxA==
X-Gm-Message-State: ANhLgQ3ZYcuv+kbhOqHJx1F5H177aHuAT8tdkQQPzAl+ALgKsYywfKU0
        J1GmyXdO6ME9b3X0zITgNo3ETRVFGmbHOl14EDZR5Q==
X-Google-Smtp-Source: ADFU+vtMECKg0iE77xyeveafTTIJe1NctM9ZS1gbqJZXUfdRwOkJDNRqliHHiYwApvHERLRaNfSDyKeu+F6P0l3jIE0=
X-Received: by 2002:a37:a8d8:: with SMTP id r207mr18024852qke.123.1583830471137;
 Tue, 10 Mar 2020 01:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200308094954.13258-1-guoren@kernel.org> <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
 <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
In-Reply-To: <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 10 Mar 2020 16:54:19 +0800
Message-ID: <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 6:27 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> On 2020/3/9 11:41, Greentime Hu wrote:
> > On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> >> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
> >>
> >> The patch implement basic context switch, sigcontext save/restore and
> >> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> >> is implemented. We need to discuss about vlen-size for libc sigcontext and
> >> ptrace (the maximum size of vlen is unlimited in spec).
> >>
> >> Puzzle:
> >> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> >> before, and riscv also met vlen size problem. Let's discuss the common issue
> >> for all architectures and we need a better solution for unlimited vlen.
> >>
> >> Any help are welcomed :)
> >>
> >>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> > Hi Guo,
> >
> > Thanks for your patch.
> > It seems the qemu repo doesn't have this branch?
> Hi Greentime,
>
> It's a promise from me. Now it's ready.  You can turn on vector by
> "qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".
>
> Zhiwei
>
>

Hi Zhiwei,

Thank you, I see the branch in the repo now. I will give it a try and
let you know if I have any problem. :)
