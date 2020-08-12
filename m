Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38625C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132E020829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Aof0WnwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHLNth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLNtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:49:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A943C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:49:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r21so1937311ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6p588ldpfa1PVpJ16iQTZFtp7YHBAN7hgleJ+hPyMLw=;
        b=Aof0WnwL4Zpy/TzlXE9WxgzQzSIBn9eQBLvK3uaFdobVRSFA6hoRM5PP9kBt33r8D2
         lUkSV5tiTUP0ENvEe+exQdP2uazJOa6dDn/xLZES9iVUFHXzn1wKBT8sSRou9DXjSvgN
         rCHCsdVGAFiBdxpYbmuqYBeZCtvokMeYDr+lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6p588ldpfa1PVpJ16iQTZFtp7YHBAN7hgleJ+hPyMLw=;
        b=SVDLaxyzM2Aftio1vLNdJf5gv36CFxqv+VlTP6xKlgV53ILfdjNIgHxuW2HTHb/4df
         KRyJlbE2dMdGSWB5HmVPmm+pfc2UchEIEtaW+fXH7gBrvA/ko4s7zpeIknMIO804kJFm
         FSDs2sFefXqgEyoLFVmBTFJ9J6xrb5fOrwJUCPfWmxaRQHuecxmvjReUp4wYmzZI3epS
         CV7Zt67hKURuKaWNRb7C8lUeL/egWC9CYuCfL8bPojnfB0NOa5RT6nIw7SP0f/nmnele
         H1IfAPInPFO8sKGonwM0cxtbcg7f6tzfgaM8K3AFzZu36Cqo2weID0yMTZG0slkg09DW
         +jrg==
X-Gm-Message-State: AOAM533xwJqIo8e6SaL7DU4B0uldxTb0j+dIgpyV0cNlPGgeMnBTn3d0
        EZ9rbeLdUa+zzc7jmps6Xwyq4gqc2cTJxqNZcsNOHQ==
X-Google-Smtp-Source: ABdhPJxEe0H3WGYtNYF7iiy0/vriF3AdeNpxSoMQy6gs/xutnGtPjqYzCu6cznAdYnnxukUfyTao/pCs1WdiecXZaJk=
X-Received: by 2002:a9d:7283:: with SMTP id t3mr8920536otj.303.1597240174269;
 Wed, 12 Aug 2020 06:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200807133658.1866-1-christian.koenig@amd.com> <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
In-Reply-To: <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 12 Aug 2020 15:49:23 +0200
Message-ID: <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
Subject: Re: RFC: How to adjust the trace pid?
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>, Shashank.Sharma@amd.com,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:42 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Ping? Daniel, Dave any opinion on this?

Type patch, cc: tracing people, see what they say? tbh I have no idea,
but they have been making unhappy noises about some of the tricks
we've played in the past in i915 tracepoints. So not everything is
cool in there.

Otherwise I guess just add another tracepoint parameter to dump the
correct userspace mm.

3rd option could be to dump the current mm (since I'm assuming those
threads do kthread_use/unuse_mm to impersonate the right userspace
process correctly) in the tracepoint infrastructure too?

Cheers, Daniel

> Christian.
>
> Am 07.08.20 um 15:36 schrieb Christian K=C3=B6nig:
> > Hi everybody,
> >
> > in amdgpu we got the following issue which I'm seeking advise how to cl=
eanly handle it.
> >
> > We have a bunch of trace points which are related to the VM subsystem a=
nd executed in either a work item, kthread or foreign process context.
> >
> > Now tracing the pid of the context which we are executing in is not rea=
lly that useful, so I'm wondering if we could just overwrite the pid record=
ed in the trace entry?
> >
> > The following patch does exactly that for the vm_grab_id() trace point,=
 but I'm not 100% sure if that is legal or not.
> >
> > Any ideas? Comments?
> >
> > Thanks,
> > Christian.
> >
> >
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
