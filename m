Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CA321775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Bm2nns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgCDQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:08:32 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35524 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:08:32 -0500
Received: by mail-vk1-f193.google.com with SMTP id r5so715011vkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1TPPQdcdHvad52oa9e1eaBSfICW/64mgOwAr43XQg4=;
        b=b0Bm2nnsjkT2KC7lNWy0bvOY7WZB9B5kjiGTGYB/UftpLH0F+BrFQhzmGsQ6ZFX4Cr
         fHVZdc71lS2P8koutRJRnvZ9U9wvn/+IH/Osw4Ic7VRZfiNb12rmKZFRUhvq27VVHvZm
         HCqvxHWu2Q5dsvdfVb1rsHrHOd9ILczUbDPCbKFvlr3xkc+xkM/5J3rEPi3sqfr0VFK6
         OUQBVRooKCC4ieXUuaEz8ssSa+zhx7qSdj9rvqhrie7AMwO5gpRB7UPYPXGQhLafgBwk
         NieAFPB3KtCnxthjnEqdEIXzx2YOa9U/gCQ2fDDiR795wCf3QDeC4Y2E5yetJOhl+9wq
         fjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1TPPQdcdHvad52oa9e1eaBSfICW/64mgOwAr43XQg4=;
        b=lHDTfhWxvxMmJYkwpFZ0eIwdk0Yc+dgHRvdpWNaakDgIKR+2DgSOZroLBRj0klnun1
         LKl4zDtDnCxpymeFrpMvJD3/OJgwbK/LxRm9BbgfC0Vm3WaN7Z1ssWINNUmZK53/gaAu
         t2OVv/IMkKzYCsskVqPS2RbjuGEVvwang+qwQb6TZgjtb477IDmojaVAyRqz1zlSfL+v
         J6sNRIyBv1o2OW+qKFGe7H8Xylx1K0eV+boRi9DN5F7FO3urED3M5+SmFi4ofGWQNPNj
         bKWemcyG2sKFU23VQg1xVFeJ2em/O/coQ+l0Xow+npn7YLSzit1LdTUZnFOiVhfKJ89s
         qK2g==
X-Gm-Message-State: ANhLgQ2Sh7QTHs599Zkvfr0k/i/OF+475GWw/+xb2PkOBso04xFgUKZc
        qrH5r69tnGX79BGLtzUBk3i+8zPSqIJm0NYqx0o=
X-Google-Smtp-Source: ADFU+vs31W/WEVIn76Ztw3WyoimEONBAG53uXXKde/SleGt+DABaUMoEsr1PNpI6SJ5LdUBweh4yjPYk2mmpKKbfPv4=
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr1793743vke.22.1583338111113;
 Wed, 04 Mar 2020 08:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20200131092147.32063-1-benjamin.gaignard@st.com>
In-Reply-To: <20200131092147.32063-1-benjamin.gaignard@st.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 4 Mar 2020 16:07:55 +0000
Message-ID: <CACvgo50=Wt9LFWDjkJa99T8r8A64JWgfqApmir8kX=kSXd1yog@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: context: Clean up documentation
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 at 08:11, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
>
> Fix kernel doc comments to avoid warnings when compiling with W=1.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_context.c | 145 ++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 84 deletions(-)
>
Since we're talking about legacy, aka user mode-setting code, I think
a wiser solution is to simply remove the documentation. It is _not_
something we should encourage people to read, let alone use.

Nit: prefix should be "drm:"

-Emil
