Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94F20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ACyT1dui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgDAQtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:49:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44865 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbgDAQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:41:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so645497edy.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHntT7rz/8kXjZW+chO0kzb7YsyM5bEPqAG2duuo+dY=;
        b=ACyT1duiYos03DooLNAqRqKdl9uYfMkBhAjMLzLUDyqTzqG0o5wbU245Y1BVSFDZ+U
         SkhJVSNuTisEqh60Y4jSkj9bT6NAylbj0ahmFFBUH/aQtjBV7OdqQHh12FSdE31N+NFc
         +CVM/nVEA/OMUdd6uqmOO1rd/muhSlIklPt82IEeRVW18Fmz0hHB7AwgnUPew0W9RM0D
         WxMky9mYO94zrKnER/yTYvcGUa2QEwd2j7eeFysVgvhYVIWqUMFaNY+JptZG/1u3VXR/
         CPXoJJNF8otuaWjQ0WRdvI2upXO2S2ptQ0aewluNXHuBu+M8aYpLj0IwNCMnLDBvOBGq
         lpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHntT7rz/8kXjZW+chO0kzb7YsyM5bEPqAG2duuo+dY=;
        b=Lo0oVFOqc70kBwZCfbGUortMpQZtnHN9fuHQ9S4vPjalHWPZ0oP59HBfjWX0qH1Tuw
         LHQlTUdsCGLibyMS2e5H0F6qbV1PiifXiaTCsN5RqlGnDIROlVUwEgJylAGmCgHZMJ5d
         ceWP6bBRFVDrHiAaICENgUU2hCxIMs1AXn8nXVLyx0k4Ip58zOQrvnUSToxd7I4sEahW
         L5Nr1hYrokdvk+uqZZV+oSnLsjVrsKpjjO1pchby4jtBAV1dZfUrC6dc230rnbULJ5j7
         LX8nTDCmzgQ9SMvf2SOaZrY2R6lcJS6tr/lkhi92CPvP+k5fiq8L+36PrgG+d0LnwfYi
         Csrw==
X-Gm-Message-State: ANhLgQ07/wFGJYpf7o48wfLTOwDtHOiLvLz9OI2/4/ew3UKq8kMTA4IP
        YcF7doyinhocZGRrqi4qa1M7U504xGJrv0c35EmDEg==
X-Google-Smtp-Source: ADFU+vvTZbm8ftaAU5J7iRDbCPa6FF1UrbAiMBHRRnxV2F3v8EyUAjzgd/S/I4DpsnMw43O6gUfFaVygJsk6TIxUjsI=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr22183019edb.142.1585759286419;
 Wed, 01 Apr 2020 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz> <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz> <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz> <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
 <20200401162655.GX22681@dhcp22.suse.cz>
In-Reply-To: <20200401162655.GX22681@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 12:41:13 -0400
Message-ID: <CA+CK2bCGpG6kBjkGd-QP06kNtwezj8mW13Jdvbxs6ExzRaJSpQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 12:26 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 01-04-20 12:18:10, Daniel Jordan wrote:
> > On Wed, Apr 01, 2020 at 06:12:43PM +0200, Michal Hocko wrote:
> > > On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
> > > > On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> > > > > On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > > > > > On 01.04.20 17:42, Michal Hocko wrote:
> > > > > > > This needs a double checking but I strongly believe that the lock can be
> > > > > > > simply dropped in this path.
> > > >
> > > > This is what my fix does, it limits the time the resize lock is held.
> > >
> > > Just remove it from the deferred intialization and add a comment that we
> > > deliberately not taking the lock here because abc
> >
> > I think it has to be a little more involved because of the window where
> > interrupts might allocate during deferred init, as Vlastimil pointed out a few
> > years ago when the change was made.
>
> I do not remember any details but do we have any actual real allocation
> failure or was this mostly a theoretical concern. Vlastimil? For your
> context we are talking about 3a2d7fa8a3d5 ("mm: disable interrupts while
> initializing deferred pages")

I do not remember seeing any real failures, this was a theoretical
window. So, we could potentially simply remove these locks until we
see a real boot failure in some interrupt thread. The allocation has
to be rather large as well.

Pasha
