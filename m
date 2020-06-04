Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE846C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC3B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAh/zEHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFDPQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgFDPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:16:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67BC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:16:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l6so6446193ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHhQRFD5dXLk3tEs66mKWpDieuiW+fGGAlwHvRQW7yM=;
        b=XAh/zEHbGqVyZrM2oX8y+oTOMy45mOF1/MZlf3g1SNEcYwSLiz31nwMYMImLTU7hHQ
         ArnxLj+f5CKk2sTOGxe8pE6IGwURQxx7curAh3RrVHQzE1TWJoYHifXv3rwQXMECnyoB
         CysC0s0Eu0EOYgd3Vi+N94qBkjR9+3tmM5MmfgYAS3jdyyVPLTKSPCPDqzLK4nPF0bHw
         /BN4WVQHL4IxVc9t4s+AuDg7TbyASMZIwZlOTRZSbghBIzbj1+NtC3xaXsf8XG33YcGY
         8KKKCrJMRdeofjD11fzx2DG+1DmXBsV2T3BTBDBNF45Uj9ccecJ7Xjad9AzY5WgJ+rEt
         oWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHhQRFD5dXLk3tEs66mKWpDieuiW+fGGAlwHvRQW7yM=;
        b=ehqCrFgwdSQGk1n/VCv65VEO3XDB6tI6cx4QGAWEjoCaXOuk9ZyJ6Q3dLE9xVCMtoo
         8sdsSTS2q9b2Gu6YO1SzWw0WK5tHqCFFCWQ9ASvEo9BIZgmQ+YQp+rDC7AM6Sld/OMya
         uotRWzIUTtghLu8oKjtLwVGeFzVrcowcZGm/tI7mrUbMJcrfM/govnjrj3yq+gSo20Kw
         znK0NMrAJD1V/Y9XSwanZE62aBpRIpKKQ6Kwv6R7ks1ZRZuAMZ0Vui3Wsrk52B78tBAe
         IPnOVveSEIIfW6STkffMwmO3K6IM7gSUouOe7WMpY3sZpo7T1l13Ed0VmR1c8Zz2yhq4
         uFjw==
X-Gm-Message-State: AOAM530WLThKQ4L8YL+i+W+r1XIo7534qPw2aHtYYeXUlTGVRNkMbww/
        Aj57vczrUsDaL8Z2QiEgoSPR7OblmIb5RaK7Pg0=
X-Google-Smtp-Source: ABdhPJzkVPqhXVmoY1skaPXsZIWDQ+EAQ6FvWbKKIu+LD3tCklbO+QT85Ay4tm7zgFdr+vudymZBkXSCuIvaqLUtsjs=
X-Received: by 2002:a92:af44:: with SMTP id n65mr4152893ili.61.1591283759746;
 Thu, 04 Jun 2020 08:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
In-Reply-To: <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 17:15:48 +0200
Message-ID: <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 4:36 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> Starting with kernel 5.6, loading nouveau without firmware (for GPUs
> where it is required, such as yours) got broken.
>
> You are loading nouveau without firmware, so it fails.
>
> The firmware needs to be available to the kernel at the time of nouveau loading.

Ok, I am now trying this:

/usr/src/linux> grep FIRMWARE /usr/src/linux/.config
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_EXTRA_FIRMWARE="nvidia/gp107/gr/sw_nonctx.bin"
# CONFIG_CYPRESS_FIRMWARE is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_TEST_FIRMWARE is not set

Best
Zeno
