Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FA1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C162074B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="DZBEz0VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEaQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 12:21:29 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87425C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:21:28 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c8so4453120iob.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsvCGiYLLjaAspJB0Irl4XXJZpB4TLmB11Af7nODiZ4=;
        b=DZBEz0VQQYg8+MCuCPbFV+AxKIpnYpT7cQIziNyRP6k47qxPaYqEP/do+GxY9FzsWj
         OdHG9XF8XGaPSWIH3Y9TSoFK8UK9NcmP3M+138AII1HQtBcUUC80hOJgOjr/OQUle0zw
         7RCP57cmKOYzvFyRCGXNQIOXoIPpO9qqn/A6hyDuvuANk+h+PV/LiLhAkvWguduTZpYN
         uR+LSbgHzgv6cJOVUrafqAUB5pn09n6mUt+baeAvz/NqB4oa/YkCr37AkyW8EsRvTuVZ
         CVXRTfTNQ1cbZdJo1UjYA+vUaBzi/mkUAHlDQJXV+1alRxAZusjouPK+n1d27N7bKNEj
         +tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsvCGiYLLjaAspJB0Irl4XXJZpB4TLmB11Af7nODiZ4=;
        b=C0aIiEajIJAnN1qKFz0bOU0GbP2R+eTZB4DpCzN5qfPpPfRJuSrzb0C2F8KgudZ8XS
         ycOzfMJC1dWVWx9w0VSkkJDB9kBBGDW/EUksNWrOUY7XgP1wctRljfPOTw+/PUkKnrjC
         dQpopHlpeR+zyB3ZUMKeruQBCPbA1jVEqAejxztMOv6Gw50ZFow9T/yhFarb9wIPZNat
         ij25c2fLpQaWTyDs1UKCIYeWpZUOS7YJEJi9w+BVHIq7wRWqbSCRTPNIkluBtN0K0ppi
         JOn3Iyq0Q3D0HvyEO4USO9RyTwR9AME/NchFaN1agMxOJ0HojnM7ZM7mG8dztAobLmm3
         LPRg==
X-Gm-Message-State: AOAM531O2BiOC2YjEu5TqU+PYiRCB4b2NVOgDDqN7rGHkGuuSWNP2NVn
        S/gSwBncywUldsT22UEC8zClqwDBu8u10tTAIP2b3A==
X-Google-Smtp-Source: ABdhPJwlFVWf1KyILpr3E8+f5WbaYijh3ZVdvVTtmOMxgPjP10RHJPOwTwGYihQXRe5FlOki++Lno4KBjmQqnGh6fUY=
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr15517153iow.75.1590942087760;
 Sun, 31 May 2020 09:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck> <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck> <20200527101929.GT5031@arm.com>
In-Reply-To: <20200527101929.GT5031@arm.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 31 May 2020 12:20:51 -0400
Message-ID: <CABV8kRwhsPhhqUXS46Rwh-xDEDY2q=KSd-xz1W-pu4Gy4KVp8Q@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kyle Huey <khuey@pernos.co>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can't PTRACE_SYSEMU be emulated by using PTRACE_SYSCALL, cancelling the
> syscall at the syscall enter stop, then modifying the regs at the
> syscall exit stop?

Yes, it can. The idea behind SYSEMU is to be able to save half the
ptrace traps that would require, in theory making the ptracer
a decent amount faster. That said, the x7 issue is orthogonal to
SYSEMU, you'd have the same issues if you used PTRACE_SYSCALL.


Keno
