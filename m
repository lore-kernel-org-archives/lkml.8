Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ECC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8820578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYbcj/yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBUQ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:29:39 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35996 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:29:38 -0500
Received: by mail-oi1-f174.google.com with SMTP id c16so2150922oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=golNOeZAecO+rCg5yrouOo8wVf/DNFKrYOLfKQXIQS0=;
        b=gYbcj/yt0Hm6cLBecIaEfulYo0/Yv93dcj3J4BZyQbXeNKNpcJGTBtBMXqikJcpxKE
         Gr+T6StsCW72VU0oxylWrT6R+RPM2F2705+HKoDp9bIjuEn1quZSf7thiQvqOymAXrXq
         m+bWoo9pwWwb93y/Rb1+uKsC9lNEt2Qm/etGv6rvhZMswhpg96LkQAUZRsvyVUj1O6ld
         n2VKn8txKA4zK5xbmVhQNUaXFrTC8MA2+A2DeQmTnOrcw86VcmizD6nqZPtRgTzRZF1p
         SSJRocq/Ih5WRPupqAtXje6JZ7yapp+kjxcba4r+d5+Ic/GofDD8HO22v07fe3R+BpzJ
         1Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=golNOeZAecO+rCg5yrouOo8wVf/DNFKrYOLfKQXIQS0=;
        b=DnW4Xjim97Rxr20SwQhs2ruZDl7wr3dkqpPUUftV1qCfQb4/tw8W8PuxsXHDiJUqTS
         suXGJFZuL43a+YSp8pDeHGsupLu56b45i8jsQjPJPKa38DgbPS4BXULYD8Laiwq/q3gI
         +ATuHdgUyCPO1QyJX6LLDoGCH8O4JCDWxOqgCj3lupVq/mns/3Q+R17Vsnu33ckV05hu
         c18YdKqzMWNch6G02uD1ONaQGy1s8W1i/kgEoe5ZaAn2BTUwcxXdbQwYVQcNyS7Kuig9
         WpbbGXYaedOH3gouCN4I8Iu9sLxtTmtxW2JkWMlvi02YcJzS3fy4WcbskSVZqKxHjE+Y
         5UWw==
X-Gm-Message-State: APjAAAWVY0lmAPnUWmZXPjt7m/qCsecAiaGPDZoaQ0ZnPnV364ygoW3B
        UVXvztdSrxB44vzey3DRKJETq2kKTnmlLMyUyKfdKDydSiMDeA==
X-Google-Smtp-Source: APXvYqx1gwwtDidYhuxbqXFyMpFEb/Zov1Sge+PoC0LN7vUYZG/K5IUCIuidGlee8r6HPRuNrNAA/fgiiEfW0Dc6BVc=
X-Received: by 2002:aca:b187:: with SMTP id a129mr2667928oif.175.1582302577146;
 Fri, 21 Feb 2020 08:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20200221115542.GL14493@shao2-debian>
In-Reply-To: <20200221115542.GL14493@shao2-debian>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 17:29:10 +0100
Message-ID: <CAG48ez0iUi6Qag4M2Y7=SfgJy5nET61NDB=aJ1yDS=GFJ--LZA@mail.gmail.com>
Subject: Re: [kernel] 247f5d7caa: will-it-scale.per_process_ops 9.6% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:56 PM kernel test robot
<rong.a.chen@intel.com> wrote:
[...]
>                             will-it-scale.per_process_ops
>
>   83000 +-------------------------------------------------------------------+
>   82000 |-+                                        O O      O O             |
>         |    O O O    O     O  O O      O O O                      O        |
>   81000 |-O        O    O O        O O         O O      O O      O   O    O |
>   80000 |-+                                                            O    |
>         |                                                                   |
>   79000 |-+                                                                 |
>   78000 |-+                                                                 |
>   77000 |-+                                                                 |
>         |                                                                   |
>   76000 |-+                                                                 |
>   75000 |-+                                                                 |
>         |.      .+.             .+.      .+.+..     .+..                    |
>   74000 |-+..+.+   +..+.+.+.+..+   +.+..+      +.+.+    +.+.+.+..+.+        |
>   73000 +-------------------------------------------------------------------+
>
>
>                                 will-it-scale.workload
>
>   1.32e+06 +----------------------------------------------------------------+
>            |   O  O O   O      O   O        O O                             |
>    1.3e+06 |-O        O   O O    O   O O O        O        O     O O      O |
>   1.28e+06 |-+                                  O        O            O O   |
>            |                                                                |
>   1.26e+06 |-+                                                              |
>            |                                                                |
>   1.24e+06 |-+                                                              |
>            |                                                                |
>   1.22e+06 |-+                                                              |
>    1.2e+06 |-+                                                              |
>            |                                                                |
>   1.18e+06 |.+.+..+.+.+. .+.+..+.+.+.+.+.+..+.+.+.+.+.+..+.+. .+. .+        |
>            |            +                                    +   +          |
>   1.16e+06 +----------------------------------------------------------------+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample

Some comments on the report format:

"O" appears in the graphs, but not "*". Is "+" supposed to be the
"bisect-good sample"? Also, what do "per_process_ops" and "workload"
mean - are higher numbers better or worse? And what does "bisect-good"
and "bisect-bad" even mean in the context of a performance
*improvement* - is the "good" commit the newer one and the "bad" one
the older one?
