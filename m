Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1DE20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSWR8LYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgFXA6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbgFXA6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:58:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:58:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x18so675681lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o88U5URmW+6MR16b/R2K54jEVRKDmah+bTz23qZzCpo=;
        b=YSWR8LYzFvhf2n/qT9TXv0lN04IqFa7XM33Kmq+zcSJZpkxVTFOae49vPDGv5XgRQm
         ryQV8ktF4kbc+OL/zCkZg0nTjjRkGYLzWFH5COLREo7ohT2QpZEUb2qnWB21BBnRYZaO
         ELK0+vYIVGlsUxbkX30VjP8HRrCu/tajmVvlPsLaRA5hCeocPijloszm/Z0IVkGFNG3o
         fhi37G2ZVHytq2WvvMFvazplwfY8E2/Jcm3OxzOe3XdJig2fYbc+p19ERebTP1LSRe6E
         ISPdRcu5oZYjD1pam0bHr898wCAOam6VU+y3Q1dlMPYazsk7FbbuyAPGDqz0f6tE6xya
         LC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o88U5URmW+6MR16b/R2K54jEVRKDmah+bTz23qZzCpo=;
        b=erwBRK+DHAOQE27COz4rtIcgZIRor3gXOf8TwopX8lUfbDkiKaGNiuKwwyCqA6wSVH
         93MXWPAYJdiJOE31L3tZWlbPUALrdoSXn1Bd4yDPdvi04Fakx2ION/aDIPo5xSUsZf7u
         pCjflANLhwU0cd1qiRuCOCfEEa8Polbd0iF9BFXeOdhF4gtdipzbMvDBx+IM2Bz2L47V
         udqNBWDq+tBAajzIV4PAexUwiWaoOf3RA/AbKY3PF/yEK/gfguaSv1A21iqg8mz/LN1G
         sgi3qp80aGYhuwd+A7F448qwbKiOOvjCYDVY/WZEM703LbERp6AtGRsUxujuNWvgkBsB
         4qxQ==
X-Gm-Message-State: AOAM533/EMEK37XwO9ubysDJoLdoC5XeSTouTEl4PvIKYK9Ej6y3PMSe
        +WnqB4qXQo4WDNSf7xN9VZj3FaCw0l8H/+CCwLEAOg==
X-Google-Smtp-Source: ABdhPJx4+TMVe9obxlPY9iCN34JLkOOJSMwnHLPa4bnnL91ftwmD9hWrTH6Dt8WgYEMjeU/1ohzNfaLWd0QUCEJt68s=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr13126966ljg.332.1592960323561;
 Tue, 23 Jun 2020 17:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200623184515.4132564-1-guro@fb.com> <20200623184515.4132564-2-guro@fb.com>
In-Reply-To: <20200623184515.4132564-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Jun 2020 17:58:32 -0700
Message-ID: <CALvZod6_itLtuVwo3FK5GhcUUQQjp1u93xHUtgKJkA=28spavA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] percpu: return number of released bytes from pcpu_free_area()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:47 AM Roman Gushchin <guro@fb.com> wrote:
>
> To implement accounting of percpu memory we need the information about the
> size of freed object.  Return it from pcpu_free_area().
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
