Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70384206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="cLgpUZDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFAJlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFAJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:41:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11555C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:41:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 18so8716170iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nO7elIn75rXMDTmbGX5CwrU6GxaesMXHLlCbJsq5rEQ=;
        b=cLgpUZDiWZDwAN2vx/sytkpCsMzPnswW25yhXlVOp7mvVpeRlJOUcL6ONESsHq4N5X
         HH2yxwDti5i1GdDd4YCHAfPTiWSoyXWJxirYGBbpZDuEGo9JLmODxeuxOXEeKzLCB9+C
         l7vGuRn6j6t3VTQiJVZq5T2MzB9ClqZ6VP+bNNVn8ZUM4GYX9hNpIDTbFVB/Jjh/UT/l
         /7o7vY5W2BcCYbuGhcjIItQQeq6n7o6igNnkuw3WivgXrRHJoIRI8dDzPGEKi9pDWVXi
         9om6exEDZE16d0x4y+jjS1v1SxPgLbzLu1EyvD2GvI+iRK8xDBnMidpRDhiCnt2pEJX/
         RUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nO7elIn75rXMDTmbGX5CwrU6GxaesMXHLlCbJsq5rEQ=;
        b=AoVJfSxYctb6zncYtL+p8hCqDwszGgttOuyozluMWkiA085Ica/Pkh/Uzc/3WJX/u2
         HwJNr/sUQufbfS74glTH63ZjucE87mx0apE9XdhtIqj2TWzKRYDCRtwvUH7H/rC7zOeJ
         ZG5F3nzB2pllSDk0hSDWjZsEdQOosWFpIo0OeLtCtFHpKXN8kitdxD+Vpn5igV7GxBEq
         ahKkAjbg+DgjmfTPWoIra761lMSxc1aasfxIuEY1EK3pBbyaJMGM0tKOOlHWvjhUMPpl
         8LGyZrw/nrpSSnNfmyVwhDsp0bOub0GmQUuZDxacKrzvMyuKC87dYKk4wsSdLirCHySr
         Dpbw==
X-Gm-Message-State: AOAM530Z7zhC2EAxzrBm1ODOZ0/fc141H64LxcKxLz8tUOyTaZ4WwNzN
        AujGbmYFbGeb3CuUr+PpihaqN6GMUDfBsGZMCxrFBg==
X-Google-Smtp-Source: ABdhPJzVdyKeWuJzEbxe7Sc+FKz1NHQru8HQk5OZpdLtuY1JD367wXLiZfSvV0eqC82O90IqonbPfcZ/GoTr0iSLTy4=
X-Received: by 2002:a92:c04d:: with SMTP id o13mr7724607ilf.201.1591004464341;
 Mon, 01 Jun 2020 02:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck> <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck> <20200527101929.GT5031@arm.com>
 <CABV8kRwhsPhhqUXS46Rwh-xDEDY2q=KSd-xz1W-pu4Gy4KVp8Q@mail.gmail.com> <20200601092329.GX5031@arm.com>
In-Reply-To: <20200601092329.GX5031@arm.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 1 Jun 2020 05:40:28 -0400
Message-ID: <CABV8kRzkLiVuqxT3+8c1o8m_OuROtXgfowQcrMVnrxu=CiGB=w@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Kyle Huey <khuey@pernos.co>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 5:23 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > > Can't PTRACE_SYSEMU be emulated by using PTRACE_SYSCALL, cancelling the
> > > syscall at the syscall enter stop, then modifying the regs at the
> > > syscall exit stop?
> >
> > Yes, it can. The idea behind SYSEMU is to be able to save half the
> > ptrace traps that would require, in theory making the ptracer
> > a decent amount faster. That said, the x7 issue is orthogonal to
> > SYSEMU, you'd have the same issues if you used PTRACE_SYSCALL.
>
> Right, I just wondered whether there was some deeper difference between
> the two approaches.

You're asking about a new regset vs trying to do it via ptrace option?
I don't think there's anything a ptrace option can do that a new regset
that replicates the same registers (I'm gonna propose adding orig_x0,
while we're at it and changing the x0 semantics a bit, will have
those details with the patch) wouldn't be able to do . The reason I
originally thought it might have to be a ptrace option is because
the register modification currently gets applied in the syscall entry
code to the actual regs struct, so I thought you might have to know
to preserve those registers. However, then I realized that you could
just change the regset accessors to emulate the old behavior, since
we do already store all the required information (what kind of stop
we're currently at) in order to be able to answer the ptrace
informational queries. So doing that it probably just all around
easier. I guess NT_PRSTATUS might also rot, but I guess strace
doesn't really have to stop using it, since it doesn't care about
the x7 value nor does it need to modify it.

Keno
