Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE63EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0D32067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bhcwQHJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgGALu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgGALux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:50:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82270C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 04:50:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d4so21185521otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NVob0ht+U8pNgfjDQrHBX34FcQW437wfU3ZeV7D0RuA=;
        b=bhcwQHJMxAGtFPyBQ5eY/2DzNvMQZ0gxJz25nmeWyZhHFQeXbzw7I1tU9yMrBSwbhq
         GpXzmc2d77jan86WU3lnLC/f37XAhq7I3nj/Ud5MxR2NsU+8qqrrenSJ8QT3PS3Yd2HO
         WZDJOl5abIE63DpXZWrwLlb1GWcV+wM/Xxc7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVob0ht+U8pNgfjDQrHBX34FcQW437wfU3ZeV7D0RuA=;
        b=lMu69/3fC/07KdnIiv1RwybuHDzgaBhXiy5qv0mpxMX/tC6KlqoUewncSG1ZWdCVrD
         PvfSpP+hJIBLmEw4xlrnw8GPEJlc33c/e7I99TfFOObxe9nG1PXMD6sfptUEnQ6TZZdY
         zUS/YJeBLrZO4sIbAdHrEfK4+HQjG9uYWXCTFtxTL8RWbQzSGocjck1GR1ZiTlD/z5Qx
         NCj9goBDmu9RzcAvwiqrhFt2zdaaatQHOFgNnB4+t2Q/KchbBH84g+/PcLdJCC+Uls0Z
         G3W2H1KDJlaAhdqzt6WK2jCmJ89cW+Rd/kHMwA30q6fw8CAGUZyD1taFSYa0XEcYVhsF
         VNAQ==
X-Gm-Message-State: AOAM530FeGU+dbImSAkd2AAqWuTeJVDEurW1CVGjhsvBfjUme5Od065E
        1mAw1Zl2STVF62Ln6VAHYFd9FM2+X4wZS8yOW3kzTyBz
X-Google-Smtp-Source: ABdhPJzuhUYDGzoVqw7VfT6QA2g0y9nFhCw6PsVYMQvjENJx18Q3x1ONVY7LMMFKkczWIhYx3VaIrBiizht+fmKEFm8=
X-Received: by 2002:a9d:d55:: with SMTP id 79mr22087629oti.281.1593604252854;
 Wed, 01 Jul 2020 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200701112559.22669-1-christian.koenig@amd.com>
In-Reply-To: <20200701112559.22669-1-christian.koenig@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 1 Jul 2020 13:50:41 +0200
Message-ID: <CAKMK7uHqNaQPwATQf=Jfs6oQ=YEemHSHTEtC2=VqvNf+bMh_sQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as DMA-buf maintainer
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 1:26 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> As discussed on the list.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40474982a21d..5d7130f8d342 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5089,6 +5089,7 @@ F:        fs/dlm/
>
>  DMA BUFFER SHARING FRAMEWORK
>  M:     Sumit Semwal <sumit.semwal@linaro.org>
> +M:     Christian K=C3=B6nig <christian.koenig@amd.com>
>  L:     linux-media@vger.kernel.org
>  L:     dri-devel@lists.freedesktop.org
>  L:     linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
