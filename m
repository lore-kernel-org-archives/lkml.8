Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E116C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EED2071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT9U55m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAZTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:03:47 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36424 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:03:46 -0500
Received: by mail-yw1-f68.google.com with SMTP id n184so3734633ywc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRTKFC8tkNpVzZjh1xTaFB0CylTteHOERXk+IQjSUU4=;
        b=tT9U55m2toAaypKCHa3uaKkjYNiBEQ6MSN043rjhb/jbWOGwPMLokOoScfHEKlmHic
         +MplA1sARTVuRlhld2lE0IrIiNIV7z2ydBaTgqnmhQbKTUy/9qMF4cjRREKJMscGMafV
         nlkWQ/w9Bg4ZL/ucG/O7EaN5PBfSmUwZA6RkjuwzSYgbt58fxsghvNM+wfZTGGSmLE+w
         oPqUIW6N72BRLAtXZ6QQWW1coEbAuf4OGeDTgHiNZ02U3tveyV3IQ/MrrWGETKNbCcWN
         YjzwN1PL4K3AdEoAShD9cmYrV4V5qtsMxWJzTX+Li5EtqiucpjJ+5VAUNIBA8ijY/z5Z
         WDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRTKFC8tkNpVzZjh1xTaFB0CylTteHOERXk+IQjSUU4=;
        b=CxurJVwFgYDFZBzAMC90rG5+gg6DFNw+RUhZisuIUST2q9sN3WydL1OHqRAXXIqTOr
         3spx2lkD+wGNvus7ILhxmGgU1Z5jAdj6lRTt8Q361K2bQhpkKIXl2yQQKSvzg18fOkQ1
         2M+JB4AyknyszD6Qfn9yGHrAOs0qDSzaVhe12xNqTz3fvqMF+izyABPChjcTMDGedmtZ
         sJN9FQVwtvs4PkjHyt95zzn5iUTbi5dYIG90LmA65xCFwaTNeeK6Nm/yDagF/broF7G7
         pVoqL2fXmPaUaw+n7t2k/kZvW9IN8oP8PqvD1SUaAmRm4j1HwispaWloSZoXcEWztjMQ
         3XyA==
X-Gm-Message-State: APjAAAXcNz+IzfTkzv2qd+ufPLEEZSo0NMPnDni0TI2PFEV1KBIjb3Tm
        mHj5z/T7mB3rLVTw75Cc+ETZisI2h1ArBJS4dCMSVQ==
X-Google-Smtp-Source: APXvYqzG6ESP151wQdhyAf8/g4tYA71B5x5G8VytepUfspekee2MwQgF71vP/HUjuNjJK+KmtsqqDrX4Nv30tAzNiRM=
X-Received: by 2002:a81:b38a:: with SMTP id r132mr10556836ywh.114.1580065425509;
 Sun, 26 Jan 2020 11:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20200124093047.008739095@linuxfoundation.org> <20200124093204.391643194@linuxfoundation.org>
 <20200126171505.GD19082@duo.ucw.cz>
In-Reply-To: <20200126171505.GD19082@duo.ucw.cz>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 26 Jan 2020 11:03:34 -0800
Message-ID: <CANn89iJLuoQ=R3k_Fz7ZFdhrcsvhH5WxDKbLLhEN-jkzpzz6+w@mail.gmail.com>
Subject: Re: [PATCH 4.19 599/639] net: avoid possible false sharing in sk_leave_memory_pressure()
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 9:15 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Fri 2020-01-24 10:32:49, Greg Kroah-Hartman wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > [ Upstream commit 503978aca46124cd714703e180b9c8292ba50ba7 ]
> >
> > As mentioned in https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
> > a C compiler can legally transform :
> >
> > if (memory_pressure && *memory_pressure)
> >         *memory_pressure = 0;
> >
> > to :
> >
> > if (memory_pressure)
> >         *memory_pressure = 0;
>
> Well, C compiler can do a lot of stuff, and we rely on C compiler
> being "sane" -- that is gcc.
>
> Even if compiler did the transformation, that will only result in
> slightly slower performance, right?
>
> Is there any evidence this is problem in practice? Should this be in
> stable?

There is evidence of this problem in practice yes.

Should it be in stable I do not know.
Should stable kernels only be compiled by old compilers, I do not know.
