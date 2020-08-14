Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FFEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3C920768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597439665;
	bh=QYjU/vHFCS41bzi+vPXXQqe7RJtvplWROO45G4OWvcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jWXo47+5NIoyaCo1Gs+kv4Y7upu50qQ+mLv/y5vM8kalBIqRVd0snd/o2gtc1VMXk
	 /5IDt78Q148mtg00FFK1v2GlgpOcyWFtICF4MknT6jsqfItzIJlHfvQbprVxUnWorb
	 Y32y2d99LCFccl5wmLcPywDKltZk32tEGlbm5VeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHNVOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHNVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:14:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B802C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:14:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so5509417lfm.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgZPud1OIYmjyYOBhbQEPVHjGt1NvY50k3PH2MTBtqk=;
        b=FGa0IGjC4TVqgiFWylWQmY8BmKxOmj299ALM3yNzYBOUo9Qm+T3JLEWp37temhIOmX
         7o4lGyY5vOmKC1s7j1N3lL37qW+vElX617XBb1kjarrJMkPVyjjjzMar/SPE2fqlZhCB
         oWnAhWqpFOYT3k3fYk8Nz2dcriDiVqZO8V8rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgZPud1OIYmjyYOBhbQEPVHjGt1NvY50k3PH2MTBtqk=;
        b=G0wnnvLxVdz7Jua25xBgUgQNuCsZ1d2i+HXXL4HNQ+watThmDzmkAkCYZ+4T3QTXMV
         58zsYdy6tp/k2D9zjJ92IhPLsj8UGe1A0HOC49GMtZrFcg4cbnFlsCOUd39te6JvsCAd
         vRClyJS+tY6VG8ABG8zhCxMbcXyt4SY705ScDH6O9H7pyuPwae0EuhdABXd37cdZB5aE
         Ixsc0+G+UPcZRLf6LYn9NCIB2NFNcWjXS/PbCVp4IZo223PW14weaOF/PTI73WWn6DAm
         T7asZi2oEQxSm1d3q3u/69InNYxv7q9WXbnMOrrai5Hv12IP7blwuJpXU3WH63SG4U9M
         wgAA==
X-Gm-Message-State: AOAM532DmZKTu7N30TsnDNJedpwVMtCYVWO9AZGP20PcZ2wSD9JK0BmL
        BZJCjfSW3qr5Vy4KEcUWSgwcHF2ABsKjwA==
X-Google-Smtp-Source: ABdhPJypGzLkx4v8Qz9R86gRIlq7WL6XbSmRfjqPWLVibzliImTi2mH5t25qzRDEnLPdYa5POziiIg==
X-Received: by 2002:ac2:5991:: with SMTP id w17mr2062912lfn.153.1597439660522;
        Fri, 14 Aug 2020 14:14:20 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v10sm2121658lfo.11.2020.08.14.14.14.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 14:14:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y2so2338043ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:14:19 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1861612ljk.421.1597439659164;
 Fri, 14 Aug 2020 14:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <159742071192.30851.2328227964586183297.tglx@nanos>
In-Reply-To: <159742071192.30851.2328227964586183297.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 14:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUx-DOx8kL91PmPwCbA6K7-9LXZ_+bkoa4SuQ6_zbaPA@mail.gmail.com>
Message-ID: <CAHk-=wjUx-DOx8kL91PmPwCbA6K7-9LXZ_+bkoa4SuQ6_zbaPA@mail.gmail.com>
Subject: Re: [GIT pull] irq/urgent for v5.9-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Two fixes in the core interrupt code which ensure that all error exits
> unlock the descriptor lock.

No diffstat?

I've pulled it, but please check what went wrong..

                Linus
