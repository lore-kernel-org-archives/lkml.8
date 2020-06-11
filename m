Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A377C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB6C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5t8Bz4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFKIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFKIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:12:24 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E337C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:12:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id w18so5335025iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDfa4+jXZ9ulsLY5WKCYieKo7asoV0jE5raIUBCwu3E=;
        b=m5t8Bz4MRofIIRs+WrQSDZwHw0H8/wYC4xq3slGdkV36tKpMJRV8d4jBMWxYlu0xam
         Ew9Q/3I8xsNpANdA98LfZi8rRQT1T21dZHmNMrbMBq7w/1Jd6hRdkxZoFrREF58OZJWN
         mY6aaa+mGIOOAUaYvPu6RLE0blvu0gyvwBFcSMc4K1fAMgflbpTgSech0O7FrJTOwaLh
         InL3AZDhHRqH4a9xfaQbOffx4L+rG6/U7BHt24X7JyhfcJhCzlEj/QV1ei016lhUvhHb
         yC5DqTaAhmr1r+TKRVwsJErZDYG4FLItUX1dY9+vLcv3Bm/qsbB/N+Zul0tgE/yqQ/AI
         wI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDfa4+jXZ9ulsLY5WKCYieKo7asoV0jE5raIUBCwu3E=;
        b=A7PjgfdvVu16jgkC6Bwr90g0xBfoB6myb8Rg2fsskgcSsNe/hpGlY2HOIhR5Y4lNNq
         ZyvwP7Gef04KJ3gconXaukX+m8IKzoJWvCJOCMco7NeGUQJVH3ytV9VI+HBD8HwCbyB9
         y4cLvKWRgAHw/fZafJGHiz2f6r3EYUaVV+38o/jYs/Sw8xu/ZexmNFjSKP4a7A8Gcs/b
         UtCaIRlOX1jL8uXMNHPr0fpz654mg3rqMj83EqnuHAhqeh7SodwndS8hus+qiohcuUpQ
         jzhh6zpHN8w4HeauFHtyBex52dD8VjxmRBZblU4ejgZ7jNvm5quOx2q2hcwluwwzkH2A
         8K9w==
X-Gm-Message-State: AOAM533BepQGL6ifoYVu8mjytwuXHf4QKM4XyFC+VDxe96EQhkQ/PywT
        V/bwj9XkzFweXs1gCL1yjel/TIhPqVgr1o0X5FE=
X-Google-Smtp-Source: ABdhPJzAm3bBTmpi7aZrgpXDcEocIqrcqoYVsUlHQV9H2bX+oYHTvbEmauteQggXeMYqpnl5AOcXAfJyXfILIAFIuDQ=
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr7249309iow.183.1591863143330;
 Thu, 11 Jun 2020 01:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
 <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
 <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com>
 <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com> <CAOkhzLUQXAB1-=2VasSeJC9-LDgsd0Sk-pJY2LBbHaLqpcBeLg@mail.gmail.com>
In-Reply-To: <CAOkhzLUQXAB1-=2VasSeJC9-LDgsd0Sk-pJY2LBbHaLqpcBeLg@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 11 Jun 2020 10:12:12 +0200
Message-ID: <CAOkhzLUrm6bS1ejmBdCOmU4G7O=t0XU_0PqYPx4AssGm5z1uCw@mail.gmail.com>
Subject: Kernel 5.7.0, nouveau 1.0.15-r1, sudo lshw -C display, *-display UNCLAIMED
To:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With Kernel 5.7.0, nouveau drivers 1.0.15-r1

sudo `lshw -C display`

will show me:

 *-display UNCLAIMED

Also `xrandr -q` will not work:

xrandr: Failed to get size of gamma for output default
Screen 0: minimum 1680 x 1050, current 1680 x 1050, maximum 1680 x 1050
default connected primary 1680x1050+0+0 0mm x 0mm
   1680x1050      0.00*

So I can not start up my second monitor with this command:

xrandr --output DVI-D-1 --auto --output DP-1 --auto --left-of DVI-D-1

This used to work with Kernel 5.5.

It was "completely broken" in 5.6 and with 5.7 my first display is
back, but not my second.

I am on Gentoo Linux. Please CC for replies.

Best
Zeno
