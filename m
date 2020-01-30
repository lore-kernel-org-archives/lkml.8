Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647682082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580407681;
	bh=zPwsK0cZ+gg0sAze5HIH8cLcQbsg3RaEOgTG39y7In8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w2Owhw4RPy1igc/cCjHqYSEtWLQF68hw2z/DWtmvO77AU7o/hKEbRUvhdqhn3RC4G
	 SCyaQs/Sndczw3W8gxMhHMroU+UPUSgWse7HuNyGxH6PBM9DTsb/fKsLWlJWNAiNJx
	 6jvVR/h0YXM0u/7p9XJs81ufPf5GiwyqZUt/WgfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgA3SIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:08:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33578 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgA3SIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:08:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so2957555lfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL4rjiP0e48Y4A4F+RCnrqnSbJmlceS+HGmd0tES8pc=;
        b=C14FZFb+G7nVOgqeueIR9P8NCe2Pq3rf8p0yZcDJX9bKw01xzAWVqWSSiLVGdF1691
         13mDU9QQpLjxx7aLKLnKUdyECKhjONzeJTNLCR99kWiPJ9dxOvLXFADfiMGaKf73PVO3
         OpKqsMhNXJLnC5txzl7UPnzLbAdh4SfjFGPHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL4rjiP0e48Y4A4F+RCnrqnSbJmlceS+HGmd0tES8pc=;
        b=QI6nWwgzgRpkZ7APdBq3B6qrQrWnvlhEl+G4YKgJbcX2a8jw1pZc9zv12dMq98X7jm
         LZxn9utkftrOYIKAikl+NlBEsKWafM5rIgbk/+Y9Yz0lbU2gO02txTNvB0O4p95jXHFv
         YISV5Q+pqtNOE8EAhr1u9/kupO0EkBGRALHJPR3hDjPCi6TWLDroQiQqi2sF0wr81AVm
         aN5bctx60YWIeRrM2EejZHdTCDCMw+g4TrFm2o/LdklHYOagNtbgYKnNp9g3/lSCWYaY
         VtqFqfS9Twdz1NORnLtqPOF3vt9phDbor5UAViDBDWTH9GRs+FMnp44H8XI3nfV9e02I
         gGcw==
X-Gm-Message-State: APjAAAVDQJAl5Ckg8Du3eZAgxtPEt46SVAW1Nr4e/3DLCLKi7UF1eg4E
        ZFeWpCdi1djjKvy6ZxXuposin7jIXJ0=
X-Google-Smtp-Source: APXvYqyfzLn9pwfrwMDBfkXBZe//hdJcP1x6AC6+fhIh5N+e1EoDiV/vFFaUe5YWLcE6THh9keBdwA==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr3169189lfl.185.1580407677832;
        Thu, 30 Jan 2020 10:07:57 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n3sm3327421ljc.100.2020.01.30.10.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:07:57 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id q8so4401564ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:07:56 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr3661876ljb.150.1580407676549;
 Thu, 30 Jan 2020 10:07:56 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
In-Reply-To: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jan 2020 10:07:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
Message-ID: <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
Subject: Re: 5.6-### doesn't boot
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 9:32 AM J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> my notebook doesn't boot with current kernel. Booting stops right after
> displaying "loading initial ramdisk..". No further displays.
> Also nothing is wriiten to the logs.
>
> last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d

It would be lovely if you can bisect a bit. But my merges in that
range are all from Ingo:

Ingo Molnar (7):
    header cleanup
    objtool updates
    RCU updates
    EFI updates
    locking updates
    perf updates
    scheduler updates

but not having any messages at all makes it hard to guess where it would be=
.

A few bisect runs would narrow it down a fair amount. Bisecting all
the way would be even better, of course,

            Linus
