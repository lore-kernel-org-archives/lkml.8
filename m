Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA85C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3D620768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TLCIhGXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgCRHej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:34:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43266 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRHei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:34:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so24720366oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImnCZJDFg1rQOtfa/ceoUHZbJvEiQdm+R8XInF6JTFI=;
        b=TLCIhGXDURuqIMeQG6s0U7WdW04eLC+XM2claAJPvoBsBajRsO4T5BSxY1ENJ2pHdb
         5o/YLhQRdAgmNylO3lrZWRO9ItNtfg6L5fzgPjUdlET3pNOzgJqD4aqeEWqjy4VHDVZv
         ZTl+0L6bKEMib/QdaRuLhuE+ZohrXXIYaExtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImnCZJDFg1rQOtfa/ceoUHZbJvEiQdm+R8XInF6JTFI=;
        b=tdDcUZo+vQE3t9H4ZdkVljeKkhVhKpGiJ15tPsdCs0zCG295/YWOcr6yyq/MdSjTmZ
         W0c9EzpB4yxQ8l7U8wg4TsOCXzbcNonaWSrjMlkxpVtJ9pSF0oAUTRUCawjyov7vJgTz
         w88vAS0pLWcDZjI/9DEJzhi943a53UWMMd7HKCz7cyFSswuX/5pJG7NPYBU2yfconnNH
         KDbFXtly++/Sp2nLA+OuXpVnG7DO0QIbBOTdE/T4L+W2h5QMYIkQcby+Zm1YzCPp9LPy
         2NfrKvixOeTjCkuYzzCmTgWdEQesubgb5hCHQMkCrwxRqNSnIy3UCITmT4/mbjoEJZqT
         gDYg==
X-Gm-Message-State: ANhLgQ2S98ZEuLKZOuYr2aRmTF/ujMvJ53PfFQ1ylm3NKbQaNSLm5tGj
        SMhICyMxeSKlIkyPcATPJ6GKF7pKjyIN4bO+auj+pw==
X-Google-Smtp-Source: ADFU+vtAn6lL50NwcHPgytvRZmg50l63XV0Syeur/1ju+uROCi3D9Op+vVl0likHxo8FG98msXAnnrAs8iSPt64+Xd8=
X-Received: by 2002:aca:5345:: with SMTP id h66mr2229552oib.110.1584516876432;
 Wed, 18 Mar 2020 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
 <20200317170243.GR2363188@phenom.ffwll.local> <CAJRQjofSWYR--4V_4zmp6K9WVtqShdzpGuH1VFBPvHpViGYH5g@mail.gmail.com>
In-Reply-To: <CAJRQjofSWYR--4V_4zmp6K9WVtqShdzpGuH1VFBPvHpViGYH5g@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Mar 2020 08:34:24 +0100
Message-ID: <CAKMK7uG8v7cYUwqTJTgYGfC8LEZtczTZ5a+Z4NcRnbFVBcG4Fw@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
To:     Qiujun Huang <hqjagain@gmail.com>, Marco Elver <elver@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:33 PM Qiujun Huang <hqjagain@gmail.com> wrote:
>
> On Wed, Mar 18, 2020 at 1:02 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Mar 16, 2020 at 03:18:23PM +0800, Qiujun Huang wrote:
> > > We should hold idr_mutex for idr_alloc.
> > >
> > > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> >
> > I've not seen the first version of this anywhere in my inbox, not sure
> > where that got lost.
> >
> > Anyway, this seems like a false positive - I'm assuming this was caught
> > with KCSAN. The commit message really should mention that.
> >
> > fill_object_idr creates the idr, which yes is only access later on under
> > the idr_mutex. But here it's not yet visible to any other thread, and
> > hence lockless access is safe and correct.
>
> Agree that.

Do you know what the recommended annotation for kcsan false positives
like this should be? Adding kcsan author Marco.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
