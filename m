Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806BC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE144218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOu8k7co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBFTMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:12:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36056 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:12:39 -0500
Received: by mail-io1-f66.google.com with SMTP id d15so7494124iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ru+inu1PmEIJ9vDnJLv1Qr4gQtvZqrjXnMpeSc0T07w=;
        b=dOu8k7co1W3I1l1ud/O4tNq6yrR8hg9NmPtIwy/s1Z6lQY342ZljFEmid3M8nHnKoE
         o6EgzYmkeJe2Zuz2J3Vz99vNyFGmG5pEZQddN+ZtJBEGBSrIGW1REL64YKWw0eC4HOF2
         8IkPafFKv5Gs9Dp6vgisxTnweTLTpT+i5SCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ru+inu1PmEIJ9vDnJLv1Qr4gQtvZqrjXnMpeSc0T07w=;
        b=rPy84glkvfZw2KTx/bWqzgWLiRfRjgI/iEcfMeFd4a3UTpTnv7MHs5CZgfKClAVKWQ
         3Qx/eKJ534e8xwPeFalWyMzZUuTZ/rS1QbZx4ZvXfIP/9RaLEH/jqToLPTYiQx0CL8JG
         T73T0mEjZyWCkio9kaNZycThpzi8KNRo5q67m2/mldP3WtdtFWcPtP2baLw3dMmMuTno
         eT07cxhSoD8xh641+NBQX6QPQYM0f7PIjBk+XTAUfiZfIi+53QsXGH3UrtNHAIgpQkgp
         0kxqqpdwLbjbWAkE6cWvXdZNncu8KlAID4X3DfTFMhgcpaGSOMigneY5uTEBnJhfXJrN
         Ey9g==
X-Gm-Message-State: APjAAAX7XYgxlSML+4SG8kvxVPcLwaNxy19TNAU2yWzIQreE14YytKjl
        9cXzo6WhWamPNc/zxhiP08TMTkifM94=
X-Google-Smtp-Source: APXvYqzB5OJfXwjOERixFMcSTzpDzPpU2kKcF2i8xzUSk5mITghZkw+K+HNGEh0ybLCGt4IPgcWMKQ==
X-Received: by 2002:a6b:f214:: with SMTP id q20mr35993664ioh.137.1581016358087;
        Thu, 06 Feb 2020 11:12:38 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id g4sm218581iln.81.2020.02.06.11.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 11:12:36 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id o13so6143767ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:12:35 -0800 (PST)
X-Received: by 2002:a92:508:: with SMTP id q8mr5345001ile.187.1581016355450;
 Thu, 06 Feb 2020 11:12:35 -0800 (PST)
MIME-Version: 1.0
References: <1580935697-28195-1-git-send-email-jcrouse@codeaurora.org> <CAF6AEGv9jVEO=QDY3DWts3w9aPxQ6fSBt2nydoqWdf5JenK=jA@mail.gmail.com>
In-Reply-To: <CAF6AEGv9jVEO=QDY3DWts3w9aPxQ6fSBt2nydoqWdf5JenK=jA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Feb 2020 11:12:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U7iWY1z5mwS0FyHyAA5EoFkAYzL-HKRaFMbRkMu6ffkg@mail.gmail.com>
Message-ID: <CAD=FV=U7iWY1z5mwS0FyHyAA5EoFkAYzL-HKRaFMbRkMu6ffkg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Fix a6xx GMU shutdown sequence
To:     Rob Clark <robdclark@gmail.com>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 5, 2020 at 1:00 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Feb 5, 2020 at 12:48 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Commit e812744c5f95 ("drm: msm: a6xx: Add support for A618") missed
> > updating the VBIF flush in a6xx_gmu_shutdown and instead
> > inserted the new sequence into a6xx_pm_suspend along with a redundant
> > GMU idle.
> >
> > Move a6xx_bus_clear_pending_transactions to a6xx_gmu.c and use it in
> > the appropriate place in the shutdown routine and remove the redundant
> > idle call.
> >
> > v2: Remove newly unused variable that was triggering a warning
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>
> Reviewed-by: Rob Clark <robdclark@gmail.com>

Without this patch I'm seeing some really bad behavior where the whole
system will pause for a bit, especially if it has been idle.  After
this patch things are much better.  Thus:

Fixes: e812744c5f95 ("drm: msm: a6xx: Add support for A618")
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
