Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B7920674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130621;
	bh=zzDlU6HYBgONtHjrkZD2Q2njEIQITW5k5gtJU1DpjIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WX8XjcIocs1cMVOomC8HeCWp49T+a2rFi0zW5QdzUGK/l1ngF45M8KwMIobU4SA2p
	 wrN7XpQoT5/nIEyJI99zv1WwoBJo1LPHrfWI/NasYM7JdQ36Eaplk4VBQ9+G78J7vT
	 jxuqkCDik3aXdbKYAc4gaBDhnSFSDFffjcKBQtNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgFBUnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFBUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:43:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B935C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:43:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so3625006ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Azl+Ad2Snhfc0xP2HW9Ep94V4yuBccpc/CvQD+kNGgE=;
        b=bUurhMFsGKldaV/fuSmBFvEu0dq7tRd7XTk2lYRSi7CMt/C6LTxrmwSmxTUVSAUw+R
         hFe8+ZbhpvMW8p8gN7hIFf7JuzG0jpuk+SD5IcjAuz+qyt7SbCCoAckx1gBtY7EuHg70
         ph2LYj1CMupe+0MuVxpfesphrjpJYdYSsavyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Azl+Ad2Snhfc0xP2HW9Ep94V4yuBccpc/CvQD+kNGgE=;
        b=lr9/YbHa8377h3fc7hsAKqk7ozgUIpW6fSqivT5hBDEyPR+TqGSeQ+WhMVphy3uskS
         BtuMOACg1v4b4FmHhHACYc4jrreINIOWK9chN3ugiQN6q6nzm0sAs9uOUER1k5nVHVcr
         zsWaFuv7hYS+H0ww32W3Kog9eC1J2xjybZIUK/VYCFLCJFFtxA+l50FQvpPBnaauYdnJ
         3VEIbiwZSTN3S5EKgt6R9PTKS4O/XSy2qYKw2pCYLyY4O+MhU9BegJeszxa9OD93p1uL
         XJh7moxPMq+Pzn5wpnLLzqR3rjebv5KKkbZE3TtTuhhpQun4oVfzL2arsj2ATAwe9gGd
         vVUw==
X-Gm-Message-State: AOAM531S5Nwq3qojvgIzmUkBdxwMn/PPdvuXi3fnRNLqOGZS+AqDl3W8
        upD72mDLGaru3LaUgZe9IGLoeZYdbrk=
X-Google-Smtp-Source: ABdhPJz0HICOcSq9G2Z6W277iDXe9tpZyAq3fSkGnReUmPKQ+ljfeAwPX24PZ2OGkNMnI6bs6qbHBw==
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr389254ljl.427.1591130617523;
        Tue, 02 Jun 2020 13:43:37 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n8sm37178lfb.20.2020.06.02.13.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 13:43:36 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d7so6988868lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:43:36 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr590629lfn.125.1591130616197;
 Tue, 02 Jun 2020 13:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200602084257.134555-1-mst@redhat.com> <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk> <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
 <20200602162931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200602162931-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 13:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYu+qk15_NpUZXwbetEU5eiWppJ=Z_A6dCSCWKxCfDfw@mail.gmail.com>
Message-ID: <CAHk-=wgYu+qk15_NpUZXwbetEU5eiWppJ=Z_A6dCSCWKxCfDfw@mail.gmail.com>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Hmm are you sure we can drop it? access_ok is done in the context
> of the process. Access itself in the context of a kernel thread
> that borrows the same mm. IIUC if the process can be 32 bit
> while the kernel is 64 bit, access_ok in the context of the
> kernel thread will not DTRT.

You're historically expected to just "set_fs()" when you do use_mm().

Then we fixed it in commit...

Oh, when I look for it, I notice that it still hasn't gotten merged.
It's still pending, see

  https://lore.kernel.org/lkml/20200416053158.586887-4-hch@lst.de/

for the current thing.

              Linus
