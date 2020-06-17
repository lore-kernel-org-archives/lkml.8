Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBD820CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syLohjN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQLhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgFQLhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:37:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:37:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so6214wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXQ4CWx12JH+UTd6LPevcvMk/mJPjbOlgAlaoYSDFXI=;
        b=syLohjN+skjN+s5GcbPi3uS/tNaoXdOac+BV6dv+tEVB6APYNF/Nc10VRl6X/B7FLC
         0MgOMVW6eervusu6GxZmQlY3eNK+fOZv7xRc5qIby7J8qaNBuRNROs4ykF0zl66X+a/+
         hvAlweWemXcoxSF5iD+V4KMkrDXOhJaNCI0QyqKoHWNAWBc6KXzt8CKI4y/1XU1xu/7D
         Oh9YsBdwek8J0h/EmDi3WyXuZTvFnbjkfo+JkiBXvwuc19w+GI8POvWth4mCMh6tpuAs
         B1fEK6P+UBKh7Gfu0hbSWsz38FlToIkejLvQv0uagTWbNeAkVbaqciOUtYexW+dk5lW1
         lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXQ4CWx12JH+UTd6LPevcvMk/mJPjbOlgAlaoYSDFXI=;
        b=iTKspP53Cid3owLMgu6OREnlHQGhme65nhWzCmZVRuFrax2Zkn/EyduBNtAIMEiidV
         JBY94y9yn7t9GsaQ+csfeXX9nDrnJVml0IvjdYKnOPF+uYYl+U1+oPyJwIsTptP8/bD4
         VxRR2p9ejkH3dMj6oC8hKKXdK+iIpCW4MNoDo5u1/FOFg+QibQphaWvJ4CiDn3EoWGbt
         /XANgsyD0dgLMp8hfTlk0jai2jtCZ8IYhym6dlSABgKa0fozKnMaxHAKTsJmJg1cY5f/
         /BDLHjc17mI7C9ST6V+GJDu1oEt/4mPDezPbN/J9Fqz1SIxrfxlvTxjrk4jrFW9R2elO
         6Vzw==
X-Gm-Message-State: AOAM531pSZKCzoGBk9qk5QN2wzf3bVnRWHxMIDMX7aA9iZiYECXHxdyU
        qmxBHGqfkekt5TW89rAN5wgKxhXoyCOrhq5PcNYDVW0E2mbLbA==
X-Google-Smtp-Source: ABdhPJw1uKsZiDo5n9PMJ/YTn4jvzBLlGLMCe3Xyx4+6OYP++RENBpbA7rgMTL/oxhfwVBO+Mk1MMx7aAQvHcZfflRQ=
X-Received: by 2002:adf:93e3:: with SMTP id 90mr5114967wrp.298.1592393860953;
 Wed, 17 Jun 2020 04:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200617104756.6312-1-david@redhat.com>
In-Reply-To: <20200617104756.6312-1-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 17 Jun 2020 13:37:29 +0200
Message-ID: <CAM9Jb+iUb4Ksm2VD-jgUc14V+T9TnGL1a48JuV_FWJd0ZeT1_w@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: add URL for virtio-mem
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's add the status/info page, which is still under construction, however,
> already contains valuable documentation/information.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 301330e02bca7..3470c5bfbdc7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18234,6 +18234,7 @@ VIRTIO MEM DRIVER
>  M:     David Hildenbrand <david@redhat.com>
>  L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
> +W:     https://virtio-mem.gitlab.io/
>  F:     drivers/virtio/virtio_mem.c
>  F:     include/uapi/linux/virtio_mem.h

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
