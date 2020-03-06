Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93316C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B180206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jnIT+soc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:46:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCFJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:46:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id n15so1508553wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGNU/jf35HfUN1T3ElSIUZGcBSwx9/JHjFsWgRm1Y2E=;
        b=jnIT+socjgr9cPbT4XrpWv7ubWcUkBphwCf0eqfxw27pV7C0pajc7+MCzNveg3MqOT
         Bo+ZH57LY87Po2xLVlHTwqmpGKqM725ZWDPXaCGlHIvOil+KMj/rmE1X/OZT7zxcua4i
         icq267LAuWY8SCfFSaOg1HSQ1z1VyAJGNKPDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yGNU/jf35HfUN1T3ElSIUZGcBSwx9/JHjFsWgRm1Y2E=;
        b=aQl0NELGGwjETtTDT5kT2INwHEEGiMtYy5nLVu29Fl7DHClz9MQ0csTuIFH3+VgB0q
         itrq7GA55A33F9Dg4DXyRNW0aCEsZOaBfILK51suKpOU8P9ZlZ05JG/UN+M1xfGsq0c/
         hF57e2WWxQa6WMsJG3EVgiSMfItnSC02HnOK6TpKLm6meMsJTO0p11VOhZAAZPUkQgSo
         wj3wNoXn18aKBp29arFNKwhcsXpXPW6QG6pcowTrLzLiWYAdBpKIJtgwWq7Oh8mnQFm7
         UedxV2E2kXlU6s4CFdUojaNeJREOoDUl8ppJ4e9J3GhgMWEhZQX5h3x7NbFoY6QhQ5tG
         +ldg==
X-Gm-Message-State: ANhLgQ31d3AVvgevY0HKw2IvooBSfEtVC87bGABYxRMIwdx/gdthAdQB
        gVzge5uKEjbdYU1AFCpw3ifvvhcx0mY=
X-Google-Smtp-Source: ADFU+vuIEN9MLH6slybeE1LymTIs37lzdw0hWqe3qk3qZpxFmaQBX2lUCJZ/2uWCAzAVsjS2Tm6HOA==
X-Received: by 2002:adf:f611:: with SMTP id t17mr3374329wrp.38.1583487968475;
        Fri, 06 Mar 2020 01:46:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y3sm13758055wmi.14.2020.03.06.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 01:46:07 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:46:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: drm: context: Clean up documentation
Message-ID: <20200306094605.GQ2363188@phenom.ffwll.local>
Mail-Followup-To: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20200131092147.32063-1-benjamin.gaignard@st.com>
 <CACvgo50=Wt9LFWDjkJa99T8r8A64JWgfqApmir8kX=kSXd1yog@mail.gmail.com>
 <f8af37a1-ff6b-9a09-7b24-a7e3f9a981c2@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8af37a1-ff6b-9a09-7b24-a7e3f9a981c2@st.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:42:09PM +0000, Benjamin GAIGNARD wrote:
> 
> 
> On 3/4/20 5:07 PM, Emil Velikov wrote:
> > On Mon, 3 Feb 2020 at 08:11, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> >> Fix kernel doc comments to avoid warnings when compiling with W=1.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   drivers/gpu/drm/drm_context.c | 145 ++++++++++++++++++------------------------
> >>   1 file changed, 61 insertions(+), 84 deletions(-)
> >>
> > Since we're talking about legacy, aka user mode-setting code, I think
> > a wiser solution is to simply remove the documentation. It is _not_
> > something we should encourage people to read, let alone use.
> >
> > Nit: prefix should be "drm:"
> Should I assume it is the same for drm_vm.c and drm_bufs.c ?

Yeah. In other legacy files all I've done is replace the /** with /* and
that's it. That shuts up kerneldoc validation for good with minimal
effort. Just not worth it to spend any time and polish on these :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
