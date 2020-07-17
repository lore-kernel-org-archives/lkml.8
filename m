Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59068C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ADA20737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h50OyDj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGQRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgGQRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:39:21 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B300C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:39:21 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k7so5268649vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oOIi1T3qSHBH51MzlGC0XDR/RneCxeHWL3lEOGZbKJY=;
        b=h50OyDj1X58pC7yEJMwCHYam/5JpjacNj4lnzko/r7vN8UfLwGNHM+oCutt8YGlrWX
         sPZ3WG4CgGPiEsti7uJRLIjgLGclvu+gWYfbmNJlNQmexUpO+essviBd/mlHsE8bWYcQ
         XyzSByoFKpUZu/3vuZVc8VRbmooB91m5COMos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oOIi1T3qSHBH51MzlGC0XDR/RneCxeHWL3lEOGZbKJY=;
        b=UfCCPMq2u6aJsax+9jtcLykiL8fkxOb1edG9ZSrd5pRd+Es00ZhJOWsH1N6gzY7doh
         xqjPzlJ80itIKJBTfiSy5+7PUUAx9jxlzgCm+jvoeoajwCtP68e5kJf7wSWGI6PXOEQo
         PwhZI30Al1vlxQ2Vv+7ow4S33Wc4AJwQW+ZKkMWqfEOSxbOGKqzjZt0P2/hSs0c9pC5D
         GKuML9bJdOq99EdiSexyf+XDw8EkR1vKxk7NwGXA6PnyCLFCghw8KZOxzjrWIjprDX7d
         4vOK5SyNImlrpz0/No7imwD6B4u0CfTwxBThu1h4Ijm1stCrA6zY6kizerAoV6OUoQhW
         Xk/w==
X-Gm-Message-State: AOAM531kbYm7GiEHMY7XmjNg6xA7ThRL3U7Qs0BGrWBmaVLicR/Y5Pq/
        K3DmeQzAz2UVHB8URcjQ3rBZDKCFA9s=
X-Google-Smtp-Source: ABdhPJwsJcsa3osBRULamS32fKWxBeJcVf8ZKIy+JFHcdxoCGdKjBRRrYmSZV617ib6HdEE4thVxOA==
X-Received: by 2002:a67:db04:: with SMTP id z4mr8045279vsj.115.1595007560283;
        Fri, 17 Jul 2020 10:39:20 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id q11sm1376401vkn.47.2020.07.17.10.39.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 10:39:19 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id m6so5248954vsl.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:39:19 -0700 (PDT)
X-Received: by 2002:a67:69c1:: with SMTP id e184mr8687935vsc.119.1595007558792;
 Fri, 17 Jul 2020 10:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <1594996458-15529-1-git-send-email-akhilpo@codeaurora.org> <20200717144607.GA16703@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200717144607.GA16703@jcrouse1-lnx.qualcomm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 10:39:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vdg36wBJiYM9bxGy-8hjxEf85aYAGuqR=Xh_oM0pLt0g@mail.gmail.com>
Message-ID: <CAD=FV=Vdg36wBJiYM9bxGy-8hjxEf85aYAGuqR=Xh_oM0pLt0g@mail.gmail.com>
Subject: Re: [PATCH v2] drm: msm: a6xx: fix gpu failure after system resume
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 17, 2020 at 7:46 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, Jul 17, 2020 at 08:04:18PM +0530, Akhil P Oommen wrote:
> > On targets where GMU is available, GMU takes over the ownership of GX GDSC
> > during its initialization. So, move the refcount-get on GX PD before we
> > initialize the GMU. This ensures that nobody can collapse the GX GDSC
> > once GMU owns the GX GDSC. This patch fixes some GMU OOB errors seen
> > during GPU wake up during a system resume.
>
> > Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
>
> The Signed-off-by needs to be at the end but I think Rob can do that for you.

It does?  I've always been told that this is supposed to be roughly a
log of what happens.  In that sense you added your SoB before the
review/test happened so it should come before.  I know some
maintainers seem to do things differently but that seems to be the
most common.  In that sense, I think the order that Akhil has is
correct.  ...but, obviously, it's up to the maintainer.  ;-)
