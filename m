Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F764C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C920739
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="a1jJ0h4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFQJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:36:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:36:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so4061598wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqV7b/dRGRsaYFJFTZmEAIxbxpemJlUlmyVmWunucJQ=;
        b=a1jJ0h4Gh9g26ELV/twHuTjWpRiKFHPp8TLQgzONwinJq+v0ldA8u5Eup6Ntp0eQBq
         nc1Lpg4kzTSI9EogHgUCu6Yr5o6TiGOdyYEUUCMjtBhKeBJkCdSzbL0uqikcMECQzOVp
         Zqchdh7yOtiUOSFYENISzhvCiIXwq0wbd6SI3ndto2+BES4dRC4hLCUprwa87V2AsrtG
         WqhBE2JM8omhJa4pmFycbSidghsV633Z49FM1+QGKfYNjHFDCxSOmXRnl7+h05r/tn6p
         /DmqFKKV9v2dwcM9yR1IGCSbxzmt71MWIxNdkkqw6pfqLArKDMB6tJBJm/imJNvsP/oA
         imzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqV7b/dRGRsaYFJFTZmEAIxbxpemJlUlmyVmWunucJQ=;
        b=m/LYA7YdqIRZCLDIeRIe9BuMsxkt+LM5uyPqeE6QbffEipxzSfLk86K7yf3Bx7g5Ak
         275+CYAqas3MP6PbodRkpioWA1VGv6DVpiQ5BKYgZZ9qBxTtcgYPwytptjIMte1O/x7C
         T8pWlJLapRFDlv3lBzFcYtsCqCrxeujBwqaMW3o7aMZ3pL4PJ23gYH7sk9e8/r6xt3km
         jxACyuBBUW/R9KcA1ZPsOuPXLLXASBvDIfONEyE0GjYfN0xwv1vHUIGEyxa0Dqsjq9F5
         vSDeYQbMUbla7TUiRrM+UeMrjbk8m8mYMs+U4RyiZRvcTvsNee0tV1SLyfBaCYrO7O5t
         /UHA==
X-Gm-Message-State: AOAM533rwtjqM72RXgooK+Oq/q69dd9zuaWS5yoZBBRvnbEe5cY2ZOJ2
        foc8HENqgZoFT9WYC4mgldZz/oClM3/zPJKgRnRJBw==
X-Google-Smtp-Source: ABdhPJyt/DSGWPMjUA/TqeAozgDqsIajAJ3rBCfT6Uxx5ItAbPuwx37kc6zO5bdEkyBLeZ+LenZ5E1u117tWg7+oIi0=
X-Received: by 2002:a1c:bbd6:: with SMTP id l205mr7896275wmf.147.1592386608011;
 Wed, 17 Jun 2020 02:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200614200121.14147-1-digetx@gmail.com> <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com> <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
 <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com> <CACvgo50BFH5qsPyWx9a1aZ4k5bzjSN-3KTU0BvnZ-nG-hfzKOQ@mail.gmail.com>
 <fe845434-cbf6-29d4-eeb6-8868d628fd04@gmail.com>
In-Reply-To: <fe845434-cbf6-29d4-eeb6-8868d628fd04@gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 17 Jun 2020 10:34:41 +0100
Message-ID: <CAPj87rPwwHWtYpuZfiTMyELvr3D+UAY8CVnH3v6+Lo1-UMRRVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jun 2020 at 22:16, Dmitry Osipenko <digetx@gmail.com> wrote:
> The panel's orientation could be parsed by any panel driver and then
> assigned as the connector's property in order to allow userspace/FB-core
> to decide what to do with the rotated display. Apparently upstream
> kernel supports only that one Samsung device which has display panel
> mounted upside-down and it already uses the custom DT properties for
> achieving the 180 rotation. So I don't quite see any panel drivers that
> instantly could benefit from using the rotation property. Perhaps I can
> add the orientation support to the panel-simple driver, but will it be
> useful to anyone?

Yes, exposing it to userspace is helpful, since Weston at least will
parse the property and then apply the correct transform:
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315

Cheers,
Daniel
