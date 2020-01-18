Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B104C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E424656
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5T13goF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgARA2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 19:28:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32907 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgARA2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:28:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so19704640lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGezdQEF2oN9RzY7rtgG+ABo1URCw4cTByw+RslsSBA=;
        b=I5T13goFYmuvhic8IOyx+Eb2v01MCLImHwdW7Ks0bHFKt9Di/V7VBYl6PqBlFnN+O3
         k/4bL+RYk7BLwDufMAmexCv3gtA1SBAk3GKfwKIAjTWjmTMjqT7c4vSIk+2kyduqUyEg
         Tw1t5BQMq15a81gICP43jCw4lSqrKTJsQPvr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGezdQEF2oN9RzY7rtgG+ABo1URCw4cTByw+RslsSBA=;
        b=dIzogXmvHNuZYviZUn5i8kNdIMwjYUEoCy0iW0CUL2LvBTSLfKNMfYOe+wlLPt8rb2
         CSC9WbCeBGL+YbFRrCyDr226kEzhI0ko2BY+3y+3bv3FkpXEB574NaPBZVpZzAS3pFZJ
         SBG1K5cMN1EJdnknPdpRPCI5tHzMZmfNFgwxW0ekcc8QLAEQKnspx+1fBRnP0R8OJ26U
         8Ps+FB/zuUaiKypF9dD56jJFwmXOS6q0myH1p8ZDrd2kxUR4a+qDL1prQfH+GPl7/p0w
         yye04ks1iiHGkAr/kR4TaQG3hi51dLln6MiacHdNiS0a64loWai/vNybDhpt+HFmAuQV
         vHfw==
X-Gm-Message-State: APjAAAVj6yMSq15iyo+1ZjJ4WZTs/sDAd3QTRtx+w2TT7yClhaPBLdM+
        zMyebbjYSnprXAq9ggkHUEAvkyxSzqU=
X-Google-Smtp-Source: APXvYqxgmhP9AeMuXYDQrQQwKTgJWdLRX4CGDRVH5K9cOFiZqmEY5q8ynL2KS0KD6ArBPPGQ/5DJUA==
X-Received: by 2002:a19:22cc:: with SMTP id i195mr6502191lfi.148.1579307295278;
        Fri, 17 Jan 2020 16:28:15 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p15sm12680105lfo.88.2020.01.17.16.28.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 16:28:15 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id m26so28157481ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 16:28:14 -0800 (PST)
X-Received: by 2002:a2e:b054:: with SMTP id d20mr6953708ljl.190.1579307293688;
 Fri, 17 Jan 2020 16:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
In-Reply-To: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 17 Jan 2020 16:27:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mM-YUmuL=opwgJYy_o4=bhb=iO7_SWQWahhbJ8z=95A@mail.gmail.com>
Message-ID: <CAE=gft7mM-YUmuL=opwgJYy_o4=bhb=iO7_SWQWahhbJ8z=95A@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 1:31 PM Evan Green <evgreen@chromium.org> wrote:
>
> __pci_write_msi_msg() updates three registers in the device: address
> high, address low, and data. On x86 systems, address low contains
> CPU targeting info, and data contains the vector. The order of writes
> is address, then data.
>
> This is problematic if an interrupt comes in after address has
> been written, but before data is updated, and the SMP affinity of
> the interrupt is changing. In this case, the interrupt targets the
> wrong vector on the new CPU.
>
> This case is pretty easy to stumble into using xhci and CPU hotplugging.
> Create a script that targets interrupts at a set of cores and then
> offlines those cores. Put some stress on USB, and then watch xhci lose
> an interrupt and die.
>
> Avoid this by disabling MSIs during the update.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Note to reviewers: I posted a v2 of this patch with some improvements here:
https://lore.kernel.org/lkml/20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid/T/#u
