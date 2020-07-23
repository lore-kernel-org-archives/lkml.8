Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE832080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+cxs13m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbgGWAnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGWAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:43:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB7C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:43:21 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so1891399qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjJ2f6Qn24zyVoutya2+PlbgSuUbJceLpmUp9TpO5dk=;
        b=R+cxs13maEWIhcBKfoNOhIoFtm5sFSWI1/PSMH0bpzJAhOsSxz/9fIZmlyN/YWaTTi
         ok/0JxjDa0tpriCFoFXLS5cwKHvHsoGtBvU0s4+0Rl3LTOXQl764+x3bgx8YyHQgZ2Vq
         3PyKVFt23VU7BYm2zPE3UXbPAPXr9itJZPl+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjJ2f6Qn24zyVoutya2+PlbgSuUbJceLpmUp9TpO5dk=;
        b=QK3qX0x8Socz3jytO3vxsJEk5/Sk30K9mbr+Rim4BVLk22gFbd/T/hKTZB+QYL2QqL
         PokMMro9WLEToGsVadkeJATCbuIRfigAEZvEhpEzboidFv8AylEfytyG/37ApIW++35l
         2gqAMdiC0uQt56/WV4EYGYwKdSPnYxUeP3B0bGJviiUB6cYEMZFQzFJFXjqO15ffuXmq
         ciUZP6G+Y+RqDn5DHholrLJqFPiS0h9sPXxMg4ZqxIT6tMSZrjwuHGg6p5Mm969i/pUz
         orbrVXmqX/DgujWP5RdjyUBG++U5TJXarlPJktkw+oOVt+GUaVDDriQoBWEfiiWnT/KH
         AZ4A==
X-Gm-Message-State: AOAM532sL5TSbaOd+mGLmAfFOkAlqug4inLey5c1Mm0fbZ9akE6BgKoW
        rxdKVTuJK4DvhN9p8nXHYQrGYNoVa/c=
X-Google-Smtp-Source: ABdhPJzUAMHFRJ/4Bvz1mw47GXIcZWr3vfh5H8vpCgJr81JaqG06s0YEkBd0MsPuzdKgDH2GElHLMA==
X-Received: by 2002:a0c:f887:: with SMTP id u7mr2516886qvn.132.1595465000210;
        Wed, 22 Jul 2020 17:43:20 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id e23sm1217511qkl.55.2020.07.22.17.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 17:43:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id h7so3878926qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:43:18 -0700 (PDT)
X-Received: by 2002:a05:620a:15ab:: with SMTP id f11mr2660524qkk.199.1595464997468;
 Wed, 22 Jul 2020 17:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com> <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com>
In-Reply-To: <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 22 Jul 2020 17:43:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
Message-ID: <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:13 PM Guenter Roeck <groeck@google.com> wrote:
> On Wed, Jul 22, 2020 at 1:50 PM Brian Norris <briannorris@chromium.org> wrote:
> > Other than perhaps taking a lesson not to propagate -ENOTSUPP, I don't
> > think this series should block on that, as this is a bugfix IMO.
>
> My patch will return -EOPNOTSUPP for EC_RES_INVALID_COMMAND, so maybe
> you could do the same. In my latest version (not yet submitted) I
> extracted the conversion into a separate function, so if your patch is
> accepted now I can just add another patch on top of it to start using
> that function.

Sure, I can use EOPNOTSUPP in v2.

BTW, the error code is completely internal to cros_ec_proto.c in my
patch, so it seems even less-related to your series, unless I got
refactor cros_ec_get_host_event_wake_mask() to use
cros_ec_cmd_xfer_status() instead of send_command(). I'm actually not
sure why we don't do that, now that I think about it...

So WDYT? Should I rebase on your eventual v3 and refactor to
cros_ec_cmd_xfer_status()? Or (re)submit this first, and add one more
cros_ec_cmd_xfer_status() usage for you to tweak in your series?

I don't mind a lot either way, except that I would like to port this
to older kernels soon.

Brian
