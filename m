Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966DE20825
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gus+oTfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgERHtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgERHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:49:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:49:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d191so8198575oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Kg9Ix3G7gt7x5w/7wJrycMf+fayHlF4h5k5vb0LVNE=;
        b=gus+oTfRxh3dY9mcRGgv3VOc5RsBFCunI6dbDnm8adq9ral2CBEqTqlLwgGZxLm+vC
         ziYG7DBHGzpTHqRd83GWYvVnGeYWg9smIvSXqP5cyK/iu7h5UQBMjjhltZiDQWNeVx6a
         66AWjtaqp1SsfXdxM56EJ48c7p3hz8fW9o0sh9Dr7PmZiGAeXNCazO5b+ff1+o8dq9io
         k0pr0szNYEf8Cxe4cIYeIeKRbHNX66FHH2jcNZmosYXup3Kc8XpgnOakF4ujC281AOzU
         D2zf1hyCLD05cRgt/INkOKnbu97DFMfcRV9R1eZDR+TTmcDTvLCns9Poal2NPZ2pRGNS
         lgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Kg9Ix3G7gt7x5w/7wJrycMf+fayHlF4h5k5vb0LVNE=;
        b=gZCEQx5+qMiBRd0oEkIZnskGXQ8mnX5ljfBHvIuvoxKM/zjrUywCxymniO+sHCAq17
         QkNgKOPoLEI0ad70UqR49CVR3p2KrCiVEJjOAx9PKsQkqjOBgq3fGJBGZFVlDwxKFu3u
         uRkipiObf89qFBRX0IibE2v/V7Mt9Z3zh5GTrc6O2HT1jjAqx7jpF4qsSzV2fVys9b3b
         oESNbrzoyE0s2R8jg+5W8uJVOHATQoXXTgnqO60NSK3xKWHZbT7IRiq2ODkEbRqJ7b0I
         zYG+oq2U3l84h2ad7WE4POoF4jyaoo1KaGDyCz8fcLA2u/QAO6poU6D4iv8Bt1w0n6ac
         vB2g==
X-Gm-Message-State: AOAM530N/lxcPGV1+mx3pF2VGYTYroEIyMnNJc8/toEN48k/QA6+M0ea
        wpUPkqNeSs0xORydJWuq6uLr4J8lbBeZdSJvdUcAfg==
X-Google-Smtp-Source: ABdhPJzGlx8lai6LNz1Oy0wFUl8yeME9wOla1JSZsaTpsJyonIKVxhd06lQMams06G8wlnYAhhrBg89+S3pwR+SytsU=
X-Received: by 2002:aca:f1c2:: with SMTP id p185mr3962337oih.69.1589788158197;
 Mon, 18 May 2020 00:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200516080718.166676-1-saravanak@google.com>
In-Reply-To: <20200516080718.166676-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 May 2020 00:48:42 -0700
Message-ID: <CAGETcx8Ro_tsmYEQwzZKsm2xzimw=MBcChbSW5Nx9arUni53wQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix memory leak when adding
 SYNC_STATE_ONLY device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 1:07 AM Saravana Kannan <saravanak@google.com> wrote:
>
> When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> core: Add device link support for SYNC_STATE_ONLY flag"),
> device_link_add() incorrectly skipped adding the new SYNC_STATE_ONLY
> device link to the supplier's and consumer's "device link" list. So the
> "device link" is lost forever from driver core if the caller didn't keep
> track of it (typically isn't expected to).
>
> If the same SYNC_STATE_ONLY device link is created again using
> device_link_add(), instead of returning the pointer to the previously
> created device link, a new device link is created and returned. This can
> cause memory leaks in conjunction with fw_devlinks.
>
> Cc: stable@vger.kernel.org
> Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Greg/Rafael,

This patch causes a warning for SYNC_STATE_ONLY links because they
allow consumers to probe before suppliers but the device link
status/state change code wasn't written with that possibility in mind.
So I need to fix up that warning or state change code.

Depending on how urgent you think memory leak fixes are, you can take
it as is for now and I can send a separate patch to fix the
warning/state change code later. Or if we can sit on this memory leak
for a week, I might be able to fix the warning before then.

Thanks,
Saravana
