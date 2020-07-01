Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A00E20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+MWlv5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgGAJdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGAJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:33:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E6C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:33:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f8so13842292ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXVNWOucI6EFBlae54Jt5ATW+9aYYLThSen8wW5XL98=;
        b=N+MWlv5d/FXup8ILTXoea15sJMo76qgGssVMC0+yvlLxtz7pDBS5PLLHzyAj3OG/qd
         cnmy9y+V66jkAnPsSAYNwjs31IaaDYtbX4jAiQXT0YrAiWigSY2NxRnY+3L0tQ02cIey
         7FlHiDGkQ96aaZ/s6KiERKxjurCUzmVnoQ2z73cMGvr3dsvJipEAlRzYRaK3phM+xTfM
         M4HXFPPBjmOFZAxxRJfooqx7q8Lt6BNXCEi3zazHg8iTSZQc4QaBl5pst/U/p3p8xbiJ
         m7qUo8sa+9ExT4OOLIHAhvaIgWZv+WgOUf3kqvWL6BwxS/Sd5KypFOc3tHSCKlHlvLbN
         hEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXVNWOucI6EFBlae54Jt5ATW+9aYYLThSen8wW5XL98=;
        b=UpJ9hGcatOX6YA4zEcm1Teshg/Rs2XSB39xIaQjWtsNO+36U73SJI5lNce8jxTCTnM
         IaX+8VrlXMzBExWPpzDxHRPr7ryhy7N7Jpi3oHhbxtPkFs2/cwvErATjNBt8H9OIrzm5
         QKWr9ygoOoTb4mQxxN+GiwvRB/T6ZL8mDbbqaExNFQQhMG5FTk4Rg2fF+M+dFetpzPe6
         dBx8ro2QFw8KjPnMUg0j7QsAyMX6e67qCOh4wKIAcPgz/lQygRnfRUuk4Vmj6Q8l5bi+
         tHG4OCHE30cU9dBU/Mr9JQEhJ7N/nmfV2uNlXMAL15YQ7k/CNZ3fxOXxUfV5POdxHBIu
         XyAA==
X-Gm-Message-State: AOAM533XL0hCXEkDJkPdSUmSIRl9JF91nQ2OGujYLiOOuNdHtIMDLpJi
        9jXmD0JGwnvLwo3oRsGHcO+LjhtAi2c040pO0dQt2Q==
X-Google-Smtp-Source: ABdhPJzWLRNJD27Z7gbJanMdExaMCHQCltjsFuFwRAFU8qXv/ZmPe2JLRAGFSFeyuTZDcu0xZDwmNUF3OBw1bqThA5w=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr13337944lja.152.1593596029145;
 Wed, 01 Jul 2020 02:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-3-daniel.lezcano@linaro.org> <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
 <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org>
In-Reply-To: <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 1 Jul 2020 15:03:38 +0530
Message-ID: <CAP245DUG-OsSD-_CucMMQ26HpzjJhn0emfq_go923NsDq6RqOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 2:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 30/06/2020 13:47, Amit Kucheria wrote:
> > On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> In order to set the scene for the new generic netlink thermal
> >> management and notifications, let remove the old dead code remaining
> >
> > s/management/management api/
> >
> > s/let/let's/
> >
> >> in the uapi headers.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  include/linux/thermal.h      |  5 -----
> >>  include/uapi/linux/thermal.h | 12 +-----------
> >>  2 files changed, 1 insertion(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >> index faf7ad031e42..fc93a6348082 100644
> >> --- a/include/linux/thermal.h
> >> +++ b/include/linux/thermal.h
> >> @@ -302,11 +302,6 @@ struct thermal_zone_params {
> >>         int offset;
> >>  };
> >>
> >> -struct thermal_genl_event {
> >> -       u32 orig;
> >> -       enum events event;
> >> -};
> >> -
> >>  /**
> >>   * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
> >>   *
> >> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> >> index 96218378dda8..22df67ed9e9c 100644
> >> --- a/include/uapi/linux/thermal.h
> >> +++ b/include/uapi/linux/thermal.h
> >> @@ -6,21 +6,12 @@
> >>
> >>  /* Adding event notification support elements */
> >>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
> >> -#define THERMAL_GENL_VERSION                    0x01
> >> +#define THERMAL_GENL_VERSION                    0x02
> >
> > This hunk should be removed since you set version back to 1 in the
> > next patch and we don't actually intend to bump the version yet.
>
> Well, I've been very strict here for git-bisecting.
>
> I move to V2 because of the removal, but when adding the new genetlink
> code, the family name changed, so we returned back to the V1 as it is a
> new genetlink thermal brand.

I don't understand the move to v2 for an empty skeleton UAPI. For the
purposes of bisection, couldn't you just remove all the v1 UAPI (w/o
bumping to v2) and then add a new UAPI in the next patch?

> The name is change because it is no longer event based but also sampling
> and commands.

In this case, just to avoid any confusion, the new UAPI could be v2
making the transition clear in case of bisection.

I'm afraid the v1->v2->v1 is a bit more confusing.

/Amit
