Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1718D20786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmgvobhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHYQC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgHYQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:02:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5145C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:02:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t2so3002855wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tTxeNahv5q1FXtG4qVWxMsRTv7XdCLwkd20q56V8+2I=;
        b=OmgvobhW1+4wUwztCxo9jyR+SPzYBjWffxCQjTAXmY7Mj0rcbvtXLh0GIJ2zAFgTR4
         424w8VwynEJM9uR+bqi5cYA1ACQ2ToMXh+b9qRPrEzhINMIQcnZKvNoEAss8S52OPNGr
         Pa9o3yVGOSOy5wKaRSbGxkA0c0wrQPQv+T+iuIwdv5umPngXd5hGdpAG+Q7FI6xH35gg
         EuHgSLDjEGOJanVZf9591vSeH7uQTzsp+I7mxxBUleeb7NnZIZ1edyWm/b71BB3eguMB
         tOcsgkWAuc36az2J9dgSwe/kn3mE8jZMmseO98jEgzUYqCcljKBTgLIeQHFQnPuDJRi0
         QU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTxeNahv5q1FXtG4qVWxMsRTv7XdCLwkd20q56V8+2I=;
        b=oPvkmzGm6ppozrN88oS8Noawzg7yHjZ+MEdR+XTj0oc820x2T+3KCWoalWJqeLgtk7
         yVhkGXpJOoBDMrFAhlKryFat0I6I8FSEsYiQrJ+JT0fc5aVQzV8N5k2ODZPhsYm3Cnbb
         H0DigSpj+Jn91iUgfbt2gMeyzuZUxP2HS5qxwtRh+ZllFtf/yQQ5PQ/4BG/kn61pw68x
         ShO5NDb7FxTT4RQ9uCd6Q7ZA0nttRosegyNSzyOdwN9GnuyXwXbj40pq769XdG2lSCdU
         TELPZ8roY72knus8elYqLmMIGNMLnSY9SN11l0gOQUQv1QYspmu/eak57BF3zHCInVfx
         4yAQ==
X-Gm-Message-State: AOAM532sh4GyzoxlCz9l74jB5tDGZ3Z4Vt4CHCwIucaFc5WgRc0Oy6nu
        ILC7odwqVluDYHJVMXbzIrM=
X-Google-Smtp-Source: ABdhPJxATi2/nACkk9huMF7nAKfQT11rcTxjVkx+7ijD2XDfrF49ww0RbwnuIie3KoZRrhmScvMytw==
X-Received: by 2002:a1c:7902:: with SMTP id l2mr2695006wme.101.1598371333323;
        Tue, 25 Aug 2020 09:02:13 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id g18sm32633985wru.27.2020.08.25.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:02:12 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:02:06 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v5 0/3] drm/vkms: Introduces writeback support
Message-ID: <20200825160206.jpdxrdbswaogayzu@smtp.gmail.com>
References: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

Nice work!

I tested this on the kms_writeback set of subtests and works fine.

I have also checked it on the other IGT tests that I usually uses:
- kms_cursor_crc/cursor-alpha-transparent was affected by a small
  problem in the bitmap_clear of the get_pixel_from_buffer function,
  that I pointed out inline. Please, check it.
- kms_flip and kms_pipe_crc_basic works as expected (was not affected).

Best regards,

Melissa Wen

On 08/24, Rodrigo Siqueira wrote:
> This is the V5 version of a series that introduces the writeback support
> to VKMS. The first two patches of this series are a pre-work for the
> latest patch that adds the writeback connector, this patchset can be seen
> in two parts: 
> 
> * A pre-work that aims to make vkms composer operations a little bit more
>   generic; these patches try to centralize the vkms framebuffer operations.
> * The final patch enables the support for writeback in vkms.
> 
> In the previous review, Emil suggested multiple changes in the series. I
> tried to apply most of the recommendations except for some suggestions
> which I was not able to incorporate due to compilation issues, or other
> suggestions that may complicate this series review. I left some changes
> for future patches for keeping this patchset simple with the hope of
> landing this feature soon in order to support VKMS user's requirements.
> Emil, let me know if you want me to change any other thing.
> 
> It is important to highlight that from the previous series to the
> current version of this patchset we had some changes in the VKMS that
> made it unstable.  In particular, our previous writeback series stopped
> working properly due to changes in our commit tail.  Thanks to Melissa
> working in the instability issue and her latest fixes to VKMS, I finally
> could update writeback and make it work again. The main update in the
> latest patch is the use of vkms_set_composer when the writeback work
> starts (enable composer) and after the writeback end (disable composer).
> 
> Best Regard
> 
> Rodrigo Siqueira (3):
>   drm/vkms: Decouple crc operations from composer
>   drm/vkms: Compute CRC without change input data
>   drm/vkms: Add support for writeback
> 
>  drivers/gpu/drm/vkms/Makefile         |   9 +-
>  drivers/gpu/drm/vkms/vkms_composer.c  | 102 +++++++++++-------
>  drivers/gpu/drm/vkms/vkms_drv.h       |  11 +-
>  drivers/gpu/drm/vkms/vkms_output.c    |   4 +
>  drivers/gpu/drm/vkms/vkms_writeback.c | 143 ++++++++++++++++++++++++++
>  5 files changed, 231 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> 
> -- 
> 2.28.0
> 
