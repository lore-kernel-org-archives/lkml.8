Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039DF20756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7RbKLwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgEVRyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgEVRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:54:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:54:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so11018796wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pf8ZbrNYhqExC9KlQDsW36HsSdXFIIPGxctjlqUhPhU=;
        b=u7RbKLwjVjVzyigBMehTZA8DZ8q5mbPJhVRZm6b5dfW8TZB/BDoYYQtn+kJTQVQooR
         tutjnmSCKhbXhltjZ47l7fpwMjaGwDOJ8PxvMMbkw5bjHWd+Rw+01hsi0MEJf6vDmYLf
         IkUETqM3VjFJIdTQ4W4vgTPcpjo4PcMPaAd4AeHfpuWlI8WwZneTofDEE8uaaaYUU2Zj
         qn0JHeEZ0RBiTCBmRCkPXS0A1XDwDgstTkU1rsnlzkm/y8QJPb250SCSKULGpmx9msW+
         9N1r7SruAt/HdxBXAsVX+FunUtJHSGLh91Y6nvUi9Kk1FPUHl1xB9tpsKXjKOyTrq95y
         zCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pf8ZbrNYhqExC9KlQDsW36HsSdXFIIPGxctjlqUhPhU=;
        b=FniquTGLSbK53x+assK5r5m95sRHnocVEX2MrMjq3eLyC6qDdGOBVGiK8hRqeNJVd3
         sgZltg5NgfgKwW0RPHZVxEIUeqXwZTgho1EYP5iF5Djo1LTwitZ5V1RGGZITh5eeD3Ye
         BS34iWyb0x7+aOQYgBW8w3c0F0UxyAnCk+LhpAIorLzLIBuJ92XnjmkkWkI6dYjpx/nt
         ydSjXAjxZVR3qGqLcA6H2O2zanFOHOaH9y65RKDtTcqPKjhe9Q4KlxpyeUlwt6bXShbs
         nOPRqiE+fBmemQDrK8KDiFS/oLAw+eloLF4yJQZYiuiuhJUqWbVyvl7vtIJQGCkr/tgw
         fBQA==
X-Gm-Message-State: AOAM533gexrlQik24QGOonnrRHhX1BQ3sK8IeyGzHOK9d4cFkh0AZAlf
        SJlYSiFxxVv1298hEw8J4PO4zy/fJYi76FV9NJQ=
X-Google-Smtp-Source: ABdhPJzvWdhRPfLMzR36gDh2x1ZCpNeC2MEquHBzD0O8Idsmsrs64y9LjzBbuf3andQmXrkZnIRYjU6VUv3tzxnzNtM=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4535314wrp.419.1590170052313;
 Fri, 22 May 2020 10:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519225545.GA2066@embeddedor> <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
 <20200522175142.GF29907@embeddedor>
In-Reply-To: <20200522175142.GF29907@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 May 2020 13:54:01 -0400
Message-ID: <CADnq5_NQRYkeHY-9733rqh1ykRbVXKyBa5+r8qzbavo240jjug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 1:46 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 09:42:27AM +0200, Christian K=C3=B6nig wrote:
> > >
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > May I suggest that we add a section how to correctly do this to
> > Documentation/process/coding-style.rst or similar document?
> >
>
> That's already on my list. :)
>
> > I've seen a bunch of different approaches and some even doesn't work wi=
th
> > some gcc versions and result in a broken binary.
> >
>
> Do you have an example of that one that doesn't work with some GCC
> versions? It'd be interesting to take a look...

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/gpu/drm/radeon/radeon_atombios.c?id=3Da7ee824a6255e347ea76e2f00827e8=
1bbe01004e

Alex

>
> Thanks
> --
> Gustavo
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
