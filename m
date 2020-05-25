Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0168206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcspBIgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbgEYWtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYWtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:49:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:49:13 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h10so20028524iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgfzii3w4zBhvnSFy6hm9tLH31EQbAkoo9v7Tojqwbc=;
        b=dcspBIgNn/n4OLoNx3KKRZ66ueSb6eWqZolM0FVquT/3iWMhiEe+yBJPMqZi5AhbDf
         sqm7xOSB3IypKAsszu4WTRG+CRTLKC87w/ZpisO7ci8c3VsRRIySgLkJKQ3d5+Cr9KqN
         +EOQbiNJ0sDJ377mplG30dbr8n/HPo+Nt02nnVAN48OUP/GmM9UPvHMIkqD67mNhM8/K
         LZRYNE1HVKo9wFaQJe0sQPLWaqSR7dL+Ta2upQFAErghBhlLApnRWWJHoVRLJkIjeUrU
         ftObvDVuEdnJxmTpltYfe8s8RBkb06JpEevRPoQCaHPlTv1bhS8Vsznn/ZOKghz8kJhB
         bsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgfzii3w4zBhvnSFy6hm9tLH31EQbAkoo9v7Tojqwbc=;
        b=auC5VIyENHBilH14CzPzyXk5iFRljuXXXWmgKM1sV4ZR3YFIz0wFs1wBH+SwVrGJoM
         19y0HG7XwNBWWhI+vojsxsnvroLOve0o/EQr1aoDlwM9SFviY7wlg1qiqcBR0dzmyfFR
         sClIoTTAsuXD77AKRR8r8biIJlkl+xvPVC6SRyy0N/ObRQuWYNPk8Y6s8ep4q5Ju/ktH
         YIkCqmYPBf5jfRjrZ6RUxJrDQ+1T8i4kAijCY/GC1b/slhvJOAz1x7x1Ma6G/klvZ8of
         Vel5CP6zFiykAmwirABJTHYvfDhv/lxHl/g3fedIL6RwPBaVUSEanD1b46u50UTIQ+63
         wa0A==
X-Gm-Message-State: AOAM530B6Yva+rMKCW2WGEOi+l6Jtzs1l7BH5DO4pYwJDiUWfROoZoeC
        b/0XJXQDc3TxB4yGlfRRgmw6X2mhYZnP0sqlT7M=
X-Google-Smtp-Source: ABdhPJztsYgUbkCWngAwxh/Lx7y5ACZYOEPYTEbCI+HYpVGCWOA2qdhLgOE4jnZOw43NOPUBDlvxGYOjg9XfN1Xgz2U=
X-Received: by 2002:a02:4d:: with SMTP id 74mr21385989jaa.141.1590446952614;
 Mon, 25 May 2020 15:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org> <20200524153041.2361-2-gregkh@linuxfoundation.org>
In-Reply-To: <20200524153041.2361-2-gregkh@linuxfoundation.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 25 May 2020 15:49:01 -0700
Message-ID: <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> after the files are actually gone from sysfs, due to how reference
> counting for kobjects work.  This should not be a problem, but it would
> be good to properly send the information when things are going away, not
> at some later point in time in the future.
>
> Before this move, if a kobject's parent was torn down before the child,

^^^^ And this is the root of the problem and what has to be fixed.

> when the call to kobject_uevent() happened, the parent walk to try to
> reconstruct the full path of the kobject could be a total mess and cause
> crashes.  It's not good to try to tear down a kobject tree from top
> down, but let's at least try to not to crash if a user does so.

One can try, but if we keep proper reference counting then kobject
core should take care of actually releasing objects in the right
order. I do not think you should keep this patch, and instead see if
we can push call to kobject_put(kobj->parent) into kobject_cleanup().

Thanks.

-- 
Dmitry
