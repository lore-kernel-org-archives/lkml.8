Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B815FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961D620702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JjYvUZBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGGFuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGGFuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:50:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E448C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 22:50:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so32498781wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 22:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWwPNUXAhZkGALSmCM6I62dir2ac7KtA6PfPQYUz4tM=;
        b=JjYvUZBaLJxTV/BcuvHN0yhsBodhFnLNMtn6S42f4eG11n/5e/oCblJoIIBUpfysyf
         Vgw3xlD1GHvhj9g1ql1pmPUfwN4tqKoAj4Pvpq1pZ2urqQ5fkXpiqvs54MSWagyQKwiA
         n6No1KSVjXYrja6mPtGqEkYkUS2sD4sKfSn3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=tWwPNUXAhZkGALSmCM6I62dir2ac7KtA6PfPQYUz4tM=;
        b=rtYoeuy1sdFjYNMeVqv0ufJOsGhDkjKKx20ouvgqgAicSivh5kDHhLHk/SPhjsGjqa
         iY6IEyCKLHbV8Rkhfnjaq6RscJTmCkVu6EHjPgmoSARyAHXuLcEBBECCc3mlTjysUL9E
         +YTq23J3Vze9iGR73tfrFhlJR9aHRJpJ/6hDbixT6XeWeH0rP398ZjE2rIe0kI4Flk7y
         /Q7x5lHaLVaGrR7irOvQZt6NbU9N7QeKYJA6yaN7HpBNQ4xqmi6Og3x4FqwGTEbfn7yJ
         xDiGS7kvd2CaFX877j/8hzwxRSzjjl37TozYQtfutpWju+qXNP1oJuckqwXCPWyRnJ+j
         03wA==
X-Gm-Message-State: AOAM530LuOuKcCHzOXjnvR6oPLcPHZQS4R3S67YWDzLoUsBSsXoEHWS5
        L4NJHQTYx9ZNNvB3TdaXhO0New==
X-Google-Smtp-Source: ABdhPJxzb1aGKqJ4jxtL9PIFyXbRUO2dBkb0GWe1iZ9+xLYdWRBle+zVIIjxFlCnANQHnCq+1iMaNw==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr51255032wrq.319.1594101016305;
        Mon, 06 Jul 2020 22:50:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k185sm1883352wmk.47.2020.07.06.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:50:15 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:50:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [Proposal] drm: amd: Convert logging to drm_* functions with
 drm_device parameter
Message-ID: <20200707055013.GG3278063@phenom.ffwll.local>
Mail-Followup-To: Suraj Upadhyay <usuraj35@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20200706105138.GA10722@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706105138.GA10722@blackclown>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:21:38PM +0530, Suraj Upadhyay wrote:
> Hii Maintainers,
> 	I recently came across this list of janatorial tasks
> for starters on DRM subsystem [1]. One of the tasks is replacing
> conventional dmesg macros (like dev_info(), dev_warn() and dev_err())
> with DRM dmesg macros [2]. And I need your input whether the
> conversions to DRM dmesg macros are worth it or not.
> I would like to start working on this task if this needs the change.

For any core code I'm happy to merge such patches. If you're changing a
specific driver (all the subdirectories under drivers/gpu/drm/*) then
please ping the specific driver maintainer first. They should be all
listed in the MAINTAINERS file.

Cheers, Daniel

> 
> Thank you,
> Suraj Upadhyay.
> 
> [1] https://dri.freedesktop.org/docs/drm/gpu/todo.html.
> [2] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater
> 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
