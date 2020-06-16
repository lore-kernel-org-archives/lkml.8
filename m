Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8269C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F3A206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="E0Zi/jXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgFPNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgFPNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:34:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:34:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x93so14267108ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAci7iu9x7AuACkwyPspvtLfgfrwKch4Y/GzStjmjeY=;
        b=E0Zi/jXUzZyzGLyIcWdXRQd84MOhCKAGFfN7znAr5/rt4+3/R66Metwl4buEQfC7aN
         AdZgo1V+eDHH815vjjsqU/VBwowGuCUQFyvrZfvDxSZ/0K80giQV+IgwgJKSFQzaCCbD
         RKUnSfuw9eYiaqh7vgWsoF0WhVkGS2GLl26xHNrCRp6zfLb1qDrTMPunUkH5rrwIl1Nf
         qervC5pVTYGCpyAoU36WuoTM/tgdjZjECgxrZjN20FY4CeIJVUvaLNi0A/qazC3x1jy/
         WjYw/sSFNJGMIkmKxeXQCQu2J654FEaZN7Q3g+rrxkyLYl+Cql3n4+v3tha6nbo1965u
         iH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAci7iu9x7AuACkwyPspvtLfgfrwKch4Y/GzStjmjeY=;
        b=Lpr2edhyiwjSXKV9h2UU1i5s1aOwSo0HBSZ4soAMYHnxtAkOmvfZ/PEZ3TOkX7Ysel
         JToDyqKncqeN+Fe7yyETt0bLqmNmdpEzyjWzeu/KUo//IE7iX4SvP8nevUSDNilM9GjP
         yAbba109+8Z+Yz1TclC6IDvze4Px5JrTfZvCxiZ/lpHYg64t7VaQCehK0D8SReoAZdgW
         O4gRvSYGPZyehyhMdRONgD9r9hZaKIdb+6/i5sMgMbjXqdFHQIw8Srpa1CPdoaU3+l/r
         KTuatqCyBBMP/TFBwhC0gk9dCNtP8qRGVn+fADi5sfKZcMEo3UPNI3Nnbg3ps+MoarcJ
         /8kw==
X-Gm-Message-State: AOAM531piGr2sWlsnfvr9df/lXQBCMEG7Rn8vb6rfrx2OUQwkJhobizu
        oWzzwcJCTdE/BTKRz/vIA1XsQUGG23dDcBLA1tQYzQ==
X-Google-Smtp-Source: ABdhPJxKr3cIPVxwUoBrHPpip3Va7+OcCXoSiS2elgmhtiC0qEoNsFfb+CW1j+Ni3sAnWwDzyHc+AFWj5tQ6aGTp/Qg=
X-Received: by 2002:a05:6402:a42:: with SMTP id bt2mr2544456edb.42.1592314466851;
 Tue, 16 Jun 2020 06:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEmgLbd8mjEE4xM-U7MGCsWsdHEHCqs2erMdJ7+CUCFaCA@mail.gmail.com>
 <20200616131555.GU2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200616131555.GU2531@hirez.programming.kicks-ass.net>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 16 Jun 2020 15:34:15 +0200
Message-ID: <CAMGffEnevUWFQAaB9cvpCY0i0bnfiCSCBc8pWJaqMH3p-NC4xg@mail.gmail.com>
Subject: Re: [BUG] divide error select_idle_sibling+0x36b
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Jun 16, 2020 at 3:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 16, 2020 at 03:07:00PM +0200, Jinpu Wang wrote:
>
> > [7623813.970839] CPU: 10 PID: 46544 Comm: qemu-2.7 Tainted: G
> >  O    4.14.154-1-pserver #4.14.154-1.1~deb9
>
> Please try on a kernel from this century.
Thanks for quick reply, we are upgrading to 4.19.105 (release on Wed
Feb 19 19:51:59 2020), do you maybe know if it is fixed in 4.19?

Regards!
