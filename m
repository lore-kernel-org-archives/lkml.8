Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514BFC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C722080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQUtNh5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAJO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:27:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41713 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgAJO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:27:13 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so1956246oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TcuAQkmRiwoqdLSJS6JTYiOGLP/QjfJC3ke5FsTXG8=;
        b=QQUtNh5zpMO+es8jtL5Huhx44/oUYSq9UkPHgRekDBCIAX7bDk5S/8XnrlzK2uM9Ja
         zvCYnT4jYammyV3cplBHFo/zfdpxeA4ZK+j/1ngUc0tqalMlT/uJUjpLBUlvH4QivqoA
         gb7QL/liN+RAqLtw5w+A9ExIx15LEGwOwL9GoSz5jTwu1WH6liTDrsei8gdVVFrNA2/x
         hRA/ArvUdOm6LrjbLX2Or9AvwdO1E/QThIgvvBAYA5DY8ywiTLCb96NpkUBDRhJfcxsw
         PUo5TJhmJqRnuhxuiVAji1AtkaA+fL+OUafBwZkrtknMIQ+2WsRjNdY87uMepWTTKbAL
         sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TcuAQkmRiwoqdLSJS6JTYiOGLP/QjfJC3ke5FsTXG8=;
        b=a9c/DV6F5FAT5yNBl3cOqcB4A+veaBfUPyt+1/d1xkfPlft6tMAnLZTZ4reCPM+RwI
         X02ELOQBGZLb3UZ8uzlwBoD6/69dbSy+d1jvOXA8jEs1p4To1oTHGCPcOSVrpY95TDNQ
         spfHgHzkhPx1JmHEsMwmaU+HDZyX/hTIL9+DDw9wqTEo76sv8VqmfZJEgLT7pK5aF4jN
         NomnbDOmgbZz9KVl3z5+iFtKzAZUImxDoiRE5j+r0yWZtAy8nBG8T3d/GGbhwZ0QWAnp
         2BE8oRsClG+/2+xHC7C+ZQul3A3SsIz1KMxNVmq+Yx+jS0s0pG7i+IRqkBQqmYnwVucK
         tchg==
X-Gm-Message-State: APjAAAWkV8dvndmp/nyicT4ezYE0Y0fNtelX/X3z7tjzb4jZrV9AgMNn
        mhPyLKgAFHeOXlRGZQFrxOrD/MdRLmtYGDSnmw5J5g==
X-Google-Smtp-Source: APXvYqzJICcxFN3gQb2rNRQ6JHRvBjVW+UtXYivPPLM9eyQgilX8UtH1y4dVV3TYuMn+dM3geKzplvKp5yscEzr13zY=
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr2459757oif.157.1578666433070;
 Fri, 10 Jan 2020 06:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20200110094535.23472-1-kraxel@redhat.com>
In-Reply-To: <20200110094535.23472-1-kraxel@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Jan 2020 15:26:46 +0100
Message-ID: <CAG48ez0wfLkTqdBtDBV4b1uUQMGeeAr09GPPi9WT++Fn8ph4rA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: add missing virtio_gpu_array_lock_resv call
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org,
        Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:45 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> When submitting a fenced command we must lock the object reservations
> because virtio_gpu_queue_fenced_ctrl_buffer() unlocks after adding the
> fence.

Thanks a lot! With this patch applied, my VM doesn't throw lockdep
warnings anymore. If you want, you can add:

Tested-by: Jann Horn <jannh@google.com>

> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>  1 file changed, 1 insertion(+)
