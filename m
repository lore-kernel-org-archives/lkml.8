Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B96C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D0520656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiC/8+X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFKIyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgFKIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:54:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA6C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:54:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q13so3376803edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bw+V3wLHTM7iJAt18YSs25Q73LjKcxMJcBBocazrA4=;
        b=DiC/8+X93yYnhHRJtAvQfxbw2XSIf5yNO6ElLZQGmw+ASMt3WHFdOgvdSAY2VN1RdC
         vcjLGNCIAKNZ6aGOO1DpH6Q2SG0Ob6CQVOgobudNqacRfc3AafpN9aKQXNNRDDdDdTsa
         xE8DimKjdyNx5rixUKIhQqGV/QrHYQvWuRV3DXtxMNnAJTBo+oMxJjgonwCY6gL7/uWv
         m55DRMA4goNC29LIW03LkavMCFdUKiSO3HCqJDDdy0g7W8Bbg5Btg1qK5vMfZIK85s0U
         OESWF7AbzrsAwdKk/kfNyFkiL7da1297cO94SiiT0lz3P+LUpkO9s/Uc2rvgY+cTAYDh
         zx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bw+V3wLHTM7iJAt18YSs25Q73LjKcxMJcBBocazrA4=;
        b=XXS9durXTzZ6b5Nomg0YPBK/gtGaSa2goml6/FIjST0+OWijDHCEfA8OXss69z3Q9c
         UgEX+d5Nple+UtcBnmy7dQmpxulsJNMjAZkuj4s7NzpJjZgdZKArAFeKRegKCJOEeAl3
         grN5MX0Jiq/K9YmVu6Oy7S9Ie+iQTOwYlQ+mjNgBxZFhaunmbDQqAmbogDTgIoTNjdH2
         U6hccx+Y6KRgwOvnS8CHxG26c1n1o2YSYU7hOjjNeXorblhxH25w9K0v+EeNOblM2qF/
         oNVgV5QKO/XbxhvM9XWlgUdPyOhG2UX4mXNGF8yFXpG75BWkI8NKBnfGjONMd/mR+Yq6
         pRLQ==
X-Gm-Message-State: AOAM531mA0RIYGy+h9Cr0X572Ij4NRUpHl0mVennuZfBUluwNcbUJCnm
        BKsQE8f5GEFjg5OkGAU9vonu8pU1VITXK1OJOxE=
X-Google-Smtp-Source: ABdhPJxyerA60LPR4dRD2QK1TZ5tc9Pqs9AUoEwTTRAumEOjf8tBER/H4EVa++W9q3TACWCmreAnsI0J5Vi1+4jREpI=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr5890903edw.127.1591865653991;
 Thu, 11 Jun 2020 01:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
In-Reply-To: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 11 Jun 2020 18:54:02 +1000
Message-ID: <CAPM=9twpkGsm0z7HkU9PWEKiua37zU4yrHKoKYoe30UPXQ8Lzg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.8-rc1 (updated pull)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(now with a subject you might see).

On Thu, 11 Jun 2020 at 18:38, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This is the update of the pull I sent earlier today, it's got a couple
> of more fixes along with the i915 fixes. One sun4i fix and a connector
> hotplug race The ast fix is for a regression in 5.6, and as mentioned
> previously one of the i915 ones fixes an oops reported by dhowells.
>
> definitely taking tomorrow off now :-)
>
> Regards,
> Dave.
>
> drm-next-2020-06-11-1:
> drm fixes for 5.7-rc1
>
> core:
> - fix race in connectors sending hotplug
>
> i915:
> - Avoid use after free in cmdparser
> - Avoid NULL dereference when probing all display encoders
> - Fixup to module parameter type
>
> sun4i:
> - clock divider fix
>
> ast:
> - 24/32 bpp mode setting fix
> The following changes since commit 8d286e2ff4400d313955b4203fc640ca6fd9228b:
>
>   Merge tag 'drm-intel-next-fixes-2020-06-04' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-06-08
> 11:59:57 +1000)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-11-1
>
> for you to fetch changes up to 66057dd1d1cf2149e0f5fdaee58d6ea69bc98048:
>
>   Merge tag 'drm-misc-next-fixes-2020-06-11' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-next (2020-06-11
> 17:51:15 +1000)
>
> ----------------------------------------------------------------
> drm fixes for 5.7-rc1
>
> core:
> - fix race in connectors sending hotplug
>
> i915:
> - Avoid use after free in cmdparser
> - Avoid NULL dereference when probing all display encoders
> - Fixup to module parameter type
>
> sun4i:
> - clock divider fix
>
> ast:
> - 24/32 bpp mode setting fix
>
> ----------------------------------------------------------------
> Chris Wilson (2):
>       drm/i915/gem: Mark the buffer pool as active for the cmdparser
>       drm/i915/display: Only query DP state of a DDI encoder
>
> Colin Ian King (1):
>       drm/ast: fix missing break in switch statement for format->cpp[0] case 4
>
> Dave Airlie (2):
>       Merge tag 'drm-intel-next-fixes-2020-06-10' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next
>       Merge tag 'drm-misc-next-fixes-2020-06-11' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-next
>
> Jani Nikula (1):
>       drm/i915/params: fix i915.reset module param type
>
> Jernej Skrabec (1):
>       drm/sun4i: hdmi ddc clk: Fix size of m divider
>
> Jeykumar Sankaran (1):
>       drm/connector: notify userspace on hotplug after register complete
>
>  drivers/gpu/drm/ast/ast_mode.c                 |  1 +
>  drivers/gpu/drm/drm_connector.c                |  5 +++
>  drivers/gpu/drm/drm_sysfs.c                    |  3 --
>  drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 56 ++++++++++++++++++++++----
>  drivers/gpu/drm/i915/i915_params.c             |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi.h             |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c     |  2 +-
>  8 files changed, 60 insertions(+), 14 deletions(-)
