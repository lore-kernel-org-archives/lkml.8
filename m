Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BC4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE1C207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTXFKyn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgFDQEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:04:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48572C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:04:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c8so6924366iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJFlc3Gy04cdlG64ny6cPW6U6TQmqhNoO4dpS7PXknE=;
        b=mTXFKyn4oqGoG+g3Bk47F5MLJHUMSNBsAauKM5ecuDkU7B+iueqgNX19QrxBZF1xdc
         1jAb1wzPtsjLj562LpXyuIrK2dSd+9lXJo+VStIYcvWHRLdlgexGwuJ5v3ZM4IaIM1sw
         JQ16pGfjlhO7byFHQMW95D3FGYwZ6lAr8OUnezIW84s+GABmE7koMXsCZN1fcjIaNKM4
         lmbBUOqZkvbjwkWV9tTkBNJJrMF4jkeuZrSN1hj5/OvT9yPzqbd8EpSIlEpUEPQ107Fd
         Dy5L/xdGR7NtXRX7Gk0LgoptBmgYiEJBnNiV+dN0iSfuXLfO5fCMpPwi9J0GVods6QMg
         1xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJFlc3Gy04cdlG64ny6cPW6U6TQmqhNoO4dpS7PXknE=;
        b=sc2RvF/wwghIBDG2eoEOQR8q97E7q1nsbr3lLAYd2ioFr9jN0HnpdIAKSb+UVFkq1N
         bbBHwyojFcLN7qV7nYx+v71hZYyCU362GOWHIKQbdvs6ruA3SqL8n3F5/Ja6qTWfDPCY
         wGLPh/0l4X99p6BLACRBxf84N3PO+4VMkg9bO24CHHmdF8iquHhNzsYTskdxOoaCDrt6
         mG/+FO33RXL+bpJ5CPAwJq2jHuDeFY7UT8v9frpsdW+1MHMCqKM29UCQLVqIOf+ruLBM
         e+WLckbwDE2E05ChWvJpRiy+flagT822Cq6CS4mAuJJPRpWMJPMQm5M/ulokxiL9OXJx
         BW6A==
X-Gm-Message-State: AOAM531yJ+TXm0FXZaAh7eEem/p5dqFCNsZ0EULGHPDojiwmh7J3XTAL
        XzAkvWhcNcODtAAua5cB1of65q51ybG4C+xofjo=
X-Google-Smtp-Source: ABdhPJzsd93CWEsJZg8aBgXCPYiR1gAdYYsTgHX8mCO8aV9bTUGmnU9TgkL53rRGtlJz1GDKtDXa5xpLQtoDNnolXmk=
X-Received: by 2002:a6b:b489:: with SMTP id d131mr4695033iof.73.1591286691576;
 Thu, 04 Jun 2020 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com> <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
In-Reply-To: <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 18:04:40 +0200
Message-ID: <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Ilia

On Thu, Jun 4, 2020 at 5:25 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> There's a lot more firmware files than that ... everything in the
> gp107 directory. Also this would only be necessary if nouveau is built
> into the kernel. The files just have to be available whenever nouveau
> is loaded -- if it's built in, that means the firmware has to be baked
> into the kernel too. If it's loaded from initrd, that means the
> firmware has to be in initrd. If it's loaded after boot, then the
> firmware has to be available after boot.

For the time being I got it working by removing all nouveau selections
in "make menuconfig" and by emerging "x11-drivers/nvidia-drivers"
Version 440.82.

Back on the latest Linux Kernel. Feels great ;).

Linux zenogentoo 5.7.0 #84 SMP Thu Jun 4 17:47:15 CEST 2020 x86_64
Intel(R) Core(TM) i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux

Best
Zeno
