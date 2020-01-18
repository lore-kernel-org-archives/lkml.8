Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B08CC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2404A2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFG8dNHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgARNlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:41:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46278 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgARNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:41:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so25191745wrl.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFe6n4FQHA1VOWCd6CGPk+kxacT5cKq8IuN+p1i7TQU=;
        b=nFG8dNHBdZVhq3lvwz+Ep/QRxaLzhWkpPsocSLSZtiWyPnHgy4DxZAO/r0wabt48hY
         m+c0Pk3kfEXm2iSHTYvTojcKPmm4P37by8jfTxv3lNUZWF8NnX+67zdHqd4YflzbSdoW
         n8Af3utWqYpeR/zY9UIDnxiQfKZffkduDaswsivVMbqUiwMcAdwo1qGaLeoA/tGLbhcQ
         WpR04wcFwqexpVNpBcaVmmd7agjQ1ldiELpyoFazZIm2KVzyOjXyHDvLg5ARcwweBo9t
         ed8v6jByNQhZWYR9xaof4u4stupgr1Uj0ySvV9MsNp5ukKo1dra3itOyaqMtH4hBFked
         uL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFe6n4FQHA1VOWCd6CGPk+kxacT5cKq8IuN+p1i7TQU=;
        b=Drs1q2WlGPX8H4V1DBVirRchBihBTi3LIsBx+UWCzH0obS3cO0XJef2ZBxs0HXwo9D
         Rp2tR8+4Cmekh+xD+5axWDRmDcCln0Uxlei1QSOCFy19CMf1V3p8b37oWfKbOiPISsot
         Dnnpjy0dz6ahNDlIVfonwqwiMxs5e97S9tTWruHMm0ipsoQnzOv4XkwgZtjMW5WZdNnm
         /3rpbMPb/FfxdMSV212xWSI07ZZnDJdXvVi5RgYitXMA/+5QuJoGpQs9/pfgTLgEkC38
         mn30LT1KRosgZf8d+eOpFNaFtgIoVB6ITrw33jK1SdR92owt6CjXxQufciVbOCJNs4dd
         9gbA==
X-Gm-Message-State: APjAAAUHiwjzCzrxFFH5quGjzdMikBmQo5ubd+3C1m52DTJ1G90n8yTh
        JdncxBQF7bzSu9jyW8bWL9uI9nZuRUQg6DpV9HpP7g==
X-Google-Smtp-Source: APXvYqxh1828BCmBT0NKPlZZ7fa0OWfuI0uRzSzAhQFvZ9LtyMpJok6v1/E18UYrR8Ik4eSL1Q8JSwyC6XAMbbsKA08=
X-Received: by 2002:adf:fe86:: with SMTP id l6mr8723881wrr.252.1579354880364;
 Sat, 18 Jan 2020 05:41:20 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
 <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw> <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
 <CACT4Y+bKhgRdCM1v8wTht=pEcX6u-J_Rq6=zA5yfMuBUcj169w@mail.gmail.com>
In-Reply-To: <CACT4Y+bKhgRdCM1v8wTht=pEcX6u-J_Rq6=zA5yfMuBUcj169w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 14:41:09 +0100
Message-ID: <CAKv+Gu8X1dPBk-_o66V81o_uXLReFYZhHgt7CfBGN_MhXXFTmg@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 at 14:37, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Jan 18, 2020 at 2:35 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > > > On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > Can't we just use READ_ONCE_NOCHECK() instead?
> > >
> > > My understanding is that KASAN actually want to make sure there is a no dereference of user memory because it has security implications. Does that make no sense here?
> >
> > Not really. This code runs extremely early in the boot, with a
> > temporary 1:1 memory mapping installed so that the EFI firmware can
> > transition into virtually remapped mode.
> >
> > Furthermore, the same issue exists for mixed mode, so we'll need to
> > fix that as well. I'll spin a patch and credit you as the reporter.
>
> If this code runs extremely early and uses even completely different
> mapping, it may make sense to disable KASAN instrumentation of this
> file in Makefile.

The routine in question runs extremely early, but the other code in
the file may be called at any time, so this is probably not the right
choice in this case.
