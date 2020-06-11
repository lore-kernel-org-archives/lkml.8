Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA6E2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svm7yczh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFKD4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:56:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638FCC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:56:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q19so4967250eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vEkq8ztedt+qfPg8J7ZSmeiXnGr0VHQIJP0F6NBBlcg=;
        b=Svm7yczh4MLDGZXcAkI3ze0+uHZ8wJC+e9Xq5lwmoHGwNgLp35zut5dCXqOGMb7D+f
         ars6OeG4HfAEJLRoSeToSy30iVhqHszTHo/gdItawlKTu2yNCqZslZuoSZqCoEosXjo8
         pQgPZIUPTxv2AkVeBvWMIu/jbAVs0D/yrR7Hl051Zdjb8qCEgrUsAc/6ahy5wsvlp6jl
         dM+Bcbr99U5DvkMP2ZoxpgLwAqNg6rX4VwLqe+dV0JVJ1pcQ0cuCaJ0vxDSxp8cfRwba
         ZjMqfjdemif/x1NJ9v/WcPc0l4HhGWOpYacphBU2mXiSBIvDFt8NQI0JklOBrtGiSvJ8
         OCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vEkq8ztedt+qfPg8J7ZSmeiXnGr0VHQIJP0F6NBBlcg=;
        b=o6PDaj0wAfZZQgGgLZ+AAjeIpSCd8sRP5maro3AI6/ltrIlafQEcSp+sJV75ItkfX8
         9WMC5FrLyYvKTUdrCMmiGsQ1iLD8V0cxWg8mRqGlral4zqfFTea/S+5eaK6Siqj+pcNn
         hYjijws6akahSF/s3xRdRGzhvfqDVSUtt6IUP1G3uH/TK3wRYfRIA97rGvD2TZU9mN/1
         TGR0TC8/+CUC+l4tkHMUBs9PFj6ZttRi4Q/kmKhe2VlVUXIK2ZcBPIwuJDLkpdmSQi8c
         VTgvpgY2NB9vrttkGoyvRtReL5uoYfb4Y5e5hB1wUp8ISFg6M1ktWBxssVw6XlJ/YbQs
         09Rg==
X-Gm-Message-State: AOAM532B75rwLxC+1qbvqnVRRSRYqSsdj35ZFewS7GlXXUig+gxKEvKf
        lPQVCvdD922Wb4CMFXyHTIgHF9/c4uJSqEciiFQPw/2Q
X-Google-Smtp-Source: ABdhPJyjCBzpRLbkonfldqyBCvAO5JpRmv9SyXwSlFxVVI0GWmQiISf+9JR368yfch2UFL3aMJaqqO3Pv1WvXI1JT9M=
X-Received: by 2002:a17:906:1c8c:: with SMTP id g12mr6471204ejh.456.1591847794230;
 Wed, 10 Jun 2020 20:56:34 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 11 Jun 2020 13:56:23 +1000
Message-ID: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
Subject: [git pull] drm i915 fixes for rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

dhowells reported an oops, and the i915 team tracked it down to a
missing fix that didn't have correct tags, they've pulled it in along
with two other fixes.

I might have some more fixes for rc1, but I might not, taking the day
off tomorrow, so probably won't be in a hurry to process anything new
unless something urgent lands.

Thanks,
Dave.

drm-next-2020-06-11:
drm i915 fixes for 5.8-rc1

i915:
- Avoid use after free in cmdparser
- Avoid NULL dereference when probing all display encoders
- Fixup to module parameter type
The following changes since commit 8d286e2ff4400d313955b4203fc640ca6fd9228b:

  Merge tag 'drm-intel-next-fixes-2020-06-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-06-08
11:59:57 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-11

for you to fetch changes up to addb1e23bf72c47a3e2eb7cdad6dc8cdffa91384:

  Merge tag 'drm-intel-next-fixes-2020-06-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-06-11
11:49:04 +1000)

----------------------------------------------------------------
drm i915 fixes for 5.8-rc1

i915:
- Avoid use after free in cmdparser
- Avoid NULL dereference when probing all display encoders
- Fixup to module parameter type

----------------------------------------------------------------
Chris Wilson (2):
      drm/i915/gem: Mark the buffer pool as active for the cmdparser
      drm/i915/display: Only query DP state of a DDI encoder

Dave Airlie (1):
      Merge tag 'drm-intel-next-fixes-2020-06-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Jani Nikula (1):
      drm/i915/params: fix i915.reset module param type

 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 56 ++++++++++++++++++++++----
 drivers/gpu/drm/i915/i915_params.c             |  2 +-
 3 files changed, 52 insertions(+), 9 deletions(-)
