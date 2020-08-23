Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD179C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943AD22C9F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598206626;
	bh=3lul98rbUGtH34AYFa7Aqj5OcRlHkKocjnlMIpYR2yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DyIKAf/p2OoO82CvnHeqPwr5lfKp/VeUE0Q5Fm5nGSoMzEFNHWCDzvZWEciuLfd+g
	 tqq+IDBgfzy9vGGFHQDajgsHyq/K/2GSC1s9p/TAwHopsAA4mw7x30Q8pFcgGQersR
	 o/5M6hkPASwFiv+Zs7I6frFafopXyAz41lqsFWiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHWSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHWSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:17:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:17:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y26so3005167lfe.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnKpyRAWRyhJsnfjEuUO679mdOG8RFrNfw0DNC4pOc0=;
        b=X1nycomtytoGAhD6s6RaibTAcGAxZPZRkVo3vot8/b9LYGnffAdF1OY82DnLGqqhEp
         HOcbMRaSoHu2hQM8Lv9Y6GefQd6q42MhnMvkFCiA4HRF42frubpc7nNCHZNQ4R4agaza
         FIxpxuqLvauWvIMVnuP6EFyh9PcojPTjAPi3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnKpyRAWRyhJsnfjEuUO679mdOG8RFrNfw0DNC4pOc0=;
        b=R9FMW8sAX749aR1AABN21gVdft8FS340IruHh//fgEAAvtdXco2SrQEsDpmU2VMa+h
         Vqr7LLM1sHzxqeBIbwDesJrNZMYutzvjNL76k7yfssQ7MPVIgduRdx3CZortXBnyxgwa
         PzE9QI6a/QiyspBANZLkpm+3bgfQSOuxi2rJDTPL0EDHLC4ThTZVO3cWKiJPpKq6Bn8f
         5hcp8xbM6YuuBL9P9+E0a5hhUUsvkcsO6vUN9hi8IEPNlJIWg54y1UcXBB02hVus7Skh
         +cJPIW4hqV8+6EK9/ANWojiQf584aoMYz6tHZLdIgD62VKpte0YupgYFX4o/Ym8iw5+v
         NCVg==
X-Gm-Message-State: AOAM531tgAUxBytLx73kBlgMT4udfQ63nEtZdlJmUCl4JvEp3yxw8IqW
        EDW2sRtVfB+FNwxa/xSODoEbJ9vcE/sEVQ==
X-Google-Smtp-Source: ABdhPJxW2B1PMHtsQimpIjoXZkpEP5oMgnJUAOMYv4LynD17ca82Bs7Sv71wJp0Spgc3ArVDVYGTlQ==
X-Received: by 2002:ac2:44d4:: with SMTP id d20mr928937lfm.137.1598206618071;
        Sun, 23 Aug 2020 11:16:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r11sm1723772ljk.46.2020.08.23.11.16.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 11:16:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c8so3279054lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:16:56 -0700 (PDT)
X-Received: by 2002:ac2:5469:: with SMTP id e9mr954739lfn.125.1598206616565;
 Sun, 23 Aug 2020 11:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113641.5783.13356693197176111647.tglx@nanos>
In-Reply-To: <159817113641.5783.13356693197176111647.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Aug 2020 11:16:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
Message-ID: <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single update for perf on x86 which ass support for the
> broken down bandwith counters.

Spot the freudian slip..

                   Linus
