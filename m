Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2629AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D952620885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qN6Z+7A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHTBxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:53:20 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:53:20 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b22so702827oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95vglf64Vq/O/1I3tuau6vIlhCDn5C32IVrNU3ul3Rs=;
        b=qN6Z+7A+Lbqvnw/Y3D/+sTqCsXSHZNFofii9Sv7TAGxZTT4nzYugE0dv9WTjhy2Ach
         +bhLMdQLy50q5omf+RBQ7ttymA4E2wnLpegiXS6qkD0jOwznXKg6Uhanq75UdpRrSZ66
         OM5P1bIQaiyp+S+D5AsSGvF1RLWV0iyMOLjSPXcJJ5W4N8NQvko9tn0H8YwE5EYRDUYh
         5bltJlJRMt+4kkGWuQZZd1tFeESB9OagrslJBjw8flAHuV7E+cA49b+f4QZ+Ys+qKJzf
         yt9Du/YLUFEDZvS0GWAkjnup+G5NgTLBJdMf5qwxqk3iQE1wPRWq6d8GTvx0sLSy1P6D
         aTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95vglf64Vq/O/1I3tuau6vIlhCDn5C32IVrNU3ul3Rs=;
        b=GoqCUJunZQMUOWgp6fVizbAUg3HTDF2XwhwFi5rd1f5UG3+RZXOyccudBAnFiQvzdk
         QUOrOkyh/qeBsvWHW71aWcvNn7F1t4m0n7wkFiDh8YKeos0gwFqwPfLKxEag5Stw4FXU
         OUqckCbxzyptWB5Y5CcDJPlPSA/VR/YJeSoHNgUI5JESvmTT1gzJR9ouLE4Q31mqIhmh
         FoRBuTpnQMzz96c05+mOFbt24CexIEjHYIZ01xYOcG0oxylxgKUFpUWBbloXCTdZgU2W
         E1lmxpYjZmUVCGggeDgN+czU9Z43B0hvC2vM0TlfI92WYJfgpAe8twdBHS7uYBfQw3bk
         Jthg==
X-Gm-Message-State: AOAM530b3kXGtU7RaIPTZ6P0Wa+kpQS7TYsMCgBAcvo0dfPrKYQNFTjw
        DrscGGRJA0rem3RFgc2Eb0ee7uzRjlkjat4pp0+25g==
X-Google-Smtp-Source: ABdhPJySRF2+7apSZAyGDFV0x5mhrt3OKJXKRRGDgyzVeBsX16AotO12+Vzd0RVSZAnZmVjb8g7Vq+nZj9NHf4LQsIU=
X-Received: by 2002:aca:1014:: with SMTP id 20mr557719oiq.169.1597888399467;
 Wed, 19 Aug 2020 18:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org> <9fa944021373ec5b82c2c1e118c15d9effe7f964.1597833138.git.mchehab+huawei@kernel.org>
In-Reply-To: <9fa944021373ec5b82c2c1e118c15d9effe7f964.1597833138.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 18:53:06 -0700
Message-ID: <CALAqxLV-LaMPKD-ddRM1EehFh+JZfh1eUsKobXgVG9R+q0EF2w@mail.gmail.com>
Subject: Re: [PATCH 25/49] staging: hikey9xx/gpu: do some code cleanups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> @@ -376,7 +355,7 @@ static int kirin_drm_platform_resume(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id kirin_drm_dt_ids[] = {
> -       { .compatible = "hisilicon,hi3660-dpe",
> +       { .compatible = "hisilicon,kirin960-dpe",


One issue, elsewhere in your patch stack you still refer to the
hisilicon,hi3660-dpe compatible string. This should probably be
consistent one way or the other.

thanks
-john
