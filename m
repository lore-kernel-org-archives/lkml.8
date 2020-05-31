Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B556C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3438B206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="0NrOYjs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEaQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 12:13:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5EDC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:13:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c8so4441185iob.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDcDX99D7ZANOd7Hfxd9CsLkN0llgnSPxO8kSVRHg5A=;
        b=0NrOYjs83qN/UOFMEjcddPRGfiWhC3QNA2KlKhk/2EaDJh0asjZoU9RUUIk3nnnkMj
         cGP/zgRQqDj1o9N406w+mZf7XGZ3fb7k4nGhEYMVXldcj3TfVrMyp/thU5snJvHeLQpF
         BZcDGDzxkJR71o+bx+Jzclz63EJ0NGpzAIDGIxuJ0xRxVKBzeHzVh8RpRlXzUMoGanP7
         OkAGs5UdPMsdp3yn1Km90QMWr/fKkLsnZa61FGazDrthn17N3Jbs1eTkH8YYxC18iSyC
         a2a9yL6yjSP7TQZY101dPf7st1N0wr+AzkyVL8Cb13yiQZvGbZuPQdHv5y8bfn8Ubs/R
         40Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDcDX99D7ZANOd7Hfxd9CsLkN0llgnSPxO8kSVRHg5A=;
        b=LtLsoNX60nKgZB35XxDUmr5vV1d+DUkRp/0RMXbvUkiJCQlwRB+keP/M3F8aq8MVBX
         mlTZiAyPDsOV7YMXjwcBwDDMdZmwQuGqll/yv+AHRoecFBtNnfvfvsvDcxeburdLg7uX
         G9M4/pAzDiO5rAWWDuY+PdoSj4MLBK+HQhDWuLMjecarBvn1n4CQY+R4f6ZAj8wmvKfW
         Z4bFN/+GEV1eyh5kmZ2GUrW2DwSkvZsI0yKqUnxJUtBE1hq9TyTzta9QgTVTPBCMFo/V
         BX+EohFfdQHXB6xlNJ8lVxmfVcwsqLxz1hrFYMtLpaMJCGCTLWH+52mxowWI/duk5nzm
         J2Bw==
X-Gm-Message-State: AOAM533SpbOdvLuHkbsF4eFlR/BTN5obAor1rtsfqFt1HPLXY9XFA+jG
        rKzgV4tG0yYAjMIo5lzPsAMiEdmSjj/FzRtNZN/0DWA7
X-Google-Smtp-Source: ABdhPJyE5v1llWMoFwhdQL/ba2iAnwmju7I539rDRBzkQsXwXkHb6dGdI+r21DnNhF4FonkVmHnG2iPG5GXcAjc6t+c=
X-Received: by 2002:a05:6602:80b:: with SMTP id z11mr15367394iow.109.1590941633982;
 Sun, 31 May 2020 09:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck> <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck> <20200527101929.GT5031@arm.com> <20200531093320.GA30204@willie-the-truck>
In-Reply-To: <20200531093320.GA30204@willie-the-truck>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 31 May 2020 12:13:18 -0400
Message-ID: <CABV8kRyHo+EAWaMUzGA220z=HJRBCpH6UWiYGb84uSL3h8HQHw@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Will Deacon <will@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kyle Huey <khuey@pernos.co>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Keno -- are you planning to send out a patch? You previously spoke about
> implementing this using PTRACE_SETOPTIONS.

Yes, I'll have a patch for you. Though I've come to the conclusion
that introducing a new regset is probably a better way to solve it.
We can then also expose orig_x0 at the same time and give it sane semantics
(there's some problems with the way it works currently - I'll write it up
together with the patch).


Keno
