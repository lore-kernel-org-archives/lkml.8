Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4C92074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWTl8zHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFATou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFATot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:44:49 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBACC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:44:47 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n188so297006vkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yu4/Kz+VWCHFdlS6gSMcAHaPvU2AgSWIMu33wwnK+Q=;
        b=YWTl8zHh8xkC7BFwjRUS3d4PZic0BMx5Sx00riFMgrxsoNayBqXBi7zrEgHqg56fra
         ZUh3XXpBxStiDWOgunQ+xafSY9dmH0gZ6XEQCrxfQpRlKxWRy+cr+g89qqFrrLOTTTTN
         8DrlF47Raz+f3ANAuzR902I//Q0J7KW9uJtzGfxdf0+xxCSIjAjrnQlGogsFMO8zlbxK
         dL+OQM9p2AL9dQLRYwIODl4qR5dRXDtu/9/RFWLq3iqGwuKs0cC+QRA6NMHojdlopwEI
         ZCNMXiBJt/gjCrajZEARkRk2UxA2Kd68B42rciKS+cdT0FITcDqEUSr+ONYF/V0tp4Xf
         WqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yu4/Kz+VWCHFdlS6gSMcAHaPvU2AgSWIMu33wwnK+Q=;
        b=lph9zx8+Hc/vA2m+KDK+6hvtl0/62TC42BzSWVg+2hDpR1jGPx/MjiFh42ZwVN0uqU
         m55NSt967e9vToxOvDdDSXPi0586y6t31wZBh69i7tuhrJUPoBbOf3QWvXPRsO4V606C
         5AhZ+ixt8po6Yf7L6dhSsFuwIBHHMS/xQmZkYxRTa/ov/1I+76ZIMm7Vnn5cRcE2TNRP
         brzstgWw33t2ltDjW2VD/XaH1g2T2d3akV613YSMX6LkT9tYnsSwg1J/pJmFsV/38YS2
         MWt7n9SD58NlBeMJ01GNiM25ojxQ4++fBEC+rWSSojxfk89PhZcYLyEm2+y29RDZ/xpd
         c1GQ==
X-Gm-Message-State: AOAM532WzwUaeMvJ/XYpBRt6Dvhe+G2Y6GoVQ8U3VsNYA9HSj+b5GRZK
        jNVB5ZmwVaEnpWTsw2nnSc3yRusbZrpeucEX7RP/1A==
X-Google-Smtp-Source: ABdhPJyJqOfiJzcGD7YsynUmIsIEsdUuxGrclBiOXmHoOeT24XZZX5IkKzO2HAq9GdEPkEnFefhuWMWBAomrAV+zvio=
X-Received: by 2002:a1f:ac8e:: with SMTP id v136mr14817675vke.40.1591040686773;
 Mon, 01 Jun 2020 12:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200528201614.250182-1-eranian@google.com> <384ca5bd-4f20-b81b-4260-8ab76c364c5f@amd.com>
In-Reply-To: <384ca5bd-4f20-b81b-4260-8ab76c364c5f@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 1 Jun 2020 12:44:35 -0700
Message-ID: <CABPqkBQ5S4h+cawcFPvY9X6caRhdqtuq=HFkp-05r6gNPh70XA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/rapl: fix rapl config variable bug
To:     mingo@elte.hu
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 2:30 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 5/28/20 3:16 PM, Stephane Eranian wrote:
> > This patch fixes a bug introduced by:
> >
> > commit fd3ae1e1587d6 ("perf/x86/rapl: Move RAPL support to common x86 code")
> >
> > The Kconfig variable name was wrong. It was missing the CONFIG_ prefix.
> >
> > Signed-off-by: Stephane Eranian <eraniangoogle.com>
> >
> > ---
>
> Tested-by: Kim Phillips <kim.phillips@amd.com>
>
Without this patch, the rapl.c module does not get compiled.
Please apply.
Thanks.

> Thanks,
>
> Kim
