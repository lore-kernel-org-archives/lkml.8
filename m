Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE3720673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/SpiVFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgAJBGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:06:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbgAJBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:06:11 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so227503iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 17:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AaGdesSrwy9CQvlbcsq69wkQKgx9ks9Un7URg79eFs=;
        b=Q/SpiVFs4/CEUFt4OJSbX9xPIsfLj3jSr20AiDtXP9XvZICvdGeSQk0lhVHg5Qd5ZS
         8VjrJNEgPxcXYOwEWkcs4vOmFRVOLcc8qYl7fD090QaaMrmq5H+H5eVVXXZjUIO6RwaS
         coZEj5xntuTb9jKxuehVxmW5QEaU9gi9tM0Sd9ENZdBR1/dXMyjy6yw0raRCe/i0RLxy
         SBed63A6k1u1GI0RmSCoxlYb8u+D7oW+/5KqjBw+xq6Dwx2vL77j0U9iaIkH5NOoYrsS
         tQzyxjlVTJE1fnAPu9bhvkp1lCm49fC8vZlK8HTeqq84e6+FresN1q5780lOqNG8NjId
         wgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AaGdesSrwy9CQvlbcsq69wkQKgx9ks9Un7URg79eFs=;
        b=f8cRrM4txXZ8zDwrsCfHfbQRztcmRy3YXi3FlYxTDU87MfVbIVCXVXo4w4Ng/8ybtE
         wHIiNQBsUAMhoo4SsLsNlzcYluXkvEI8pgCrFeWem2dh+CHv0G1GdkwWx72678CM+2X9
         bN9p33UHGmusQ4YTgb0J2GhgSLOX/CxKoX1pNjLc9kLxwZMPLPsWZQJHbqF7w8/GXoIZ
         ugVmRpYxdGgJoP1o45XkUvsGUq9hH6MiHKIT+VR5CfWP3P57wkrsqHgZOZANbv91HaUK
         LrlG/sjc1gaHkyDOofiui6WfBMHYWbwDQTDnoOvWWPMxIp/0NbEP14R7jwyluk2zj+5s
         Y76A==
X-Gm-Message-State: APjAAAWPScTUwWjDF8TKG1kjI8V6hEVZuQS1csJe0c0ebRWa0Aiz3b+D
        p/juDnKTSf+3xvh3El9tZuh9dVlEN0upPHAiQrmf/w==
X-Google-Smtp-Source: APXvYqy7FKLikZyPAOHw9u0R+JZtbYnesh6NErB95a1HKW/PFprxIo+ALAFJPqjDzEla5n9WWRiJb0HU6Pa+sn+1gKQ=
X-Received: by 2002:a6b:8f41:: with SMTP id r62mr300820iod.140.1578618370473;
 Thu, 09 Jan 2020 17:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200108115027eucas1p1d3645ba53703780679c662921efbca78@eucas1p1.samsung.com>
 <20200108115007.31095-1-m.szyprowski@samsung.com> <20200108115007.31095-2-m.szyprowski@samsung.com>
 <CA+Px+wXkFE5b_8bLz7-c95TvEdqHGD5s-XKRYMVr40xQkqTWxQ@mail.gmail.com> <83169752-ac05-d1b1-ece9-fbe1109287cf@samsung.com>
In-Reply-To: <83169752-ac05-d1b1-ece9-fbe1109287cf@samsung.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 10 Jan 2020 09:05:59 +0800
Message-ID: <CA+Px+wWiZ9MWwi-moXo9rJrbgLFVEbOqjQMhOZmm5mRL7EeMbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98090: fix lockdep warning
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:09 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 09.01.2020 06:36, Tzung-Bi Shih wrote:
> > On Wed, Jan 8, 2020 at 7:50 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> Fix this by introducing a separate mutex only for serializing the SHDN
> >> hardware register related operations.
> > This fix makes less sense to me.  We used dapm_mutex intentionally
> > because: both DAPM and userspace mixer control would change SHDN bit
> > at the same time.

We should not use a separate lock.  Either mixer control or DAPM would
change the SHDN bit.  The patch overlooks the calling path from DAPM.
As a result, DAPM can change the bit in the middle of mixer control.

> Nope. This is just a lockdep warning about possible hypothetical
> situation on the test system during the normal boot. It doesn't mean
> that the circular dependency actually happens (if so, it would end in
> deadlock). It also doesn't mean that such circular dependency can be
> really triggered, because some other dependencies that not known to
> lockdep engine might protect against it. However the easiest way to fix
> it is to use fine-grained locking instead of reusing some framework
> locks for other purposes. Such approach is also usually a good practice.

If the possible circular locking is a hypothetical situation, shall we
ignore it since we are very sure userspace cannot see the control
devices when building the sound card?
