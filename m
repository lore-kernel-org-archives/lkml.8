Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D18C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D59207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOek734h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgGAPOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgGAPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:14:10 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B1C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:14:10 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id z47so7838238uad.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPwKKf6uw9cQn3+zWKTcclwYDlrMRJsDVGhFtE0vfHQ=;
        b=GOek734hoxnUFdKwQZYks2y/teGU/5sM8hSU9kIAbXx+QXbNbn5TVbjpM6ZtvSQ4DH
         +8KPuA2Iy1rIASApRFHRSBsRDw7yq7+wflLU1wzlakISVX0ZrNiZlrYmk7Acb7X1WHzD
         VpP7A1Oq1bgTnZTQ3qcvk1+jl2XcUN+t4WHLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPwKKf6uw9cQn3+zWKTcclwYDlrMRJsDVGhFtE0vfHQ=;
        b=NnJekHG2418BWd1EM9bY+LZEg74hGAnpEdf3bnKQ/+VfjqQyZEZcuSEVGbBqURx59b
         TF8Rj1P9EGu+Cy/9iFOCQ65hPxpK8lRTDTdQWxtVwROwbbbgMxjMSl4Y4I0ZQQ4zCZKu
         eLEWhyO7+gkZk2y+0vgznHlnXH3k3ghjrIRj82ZpUImNuDpMJyIujx3KOTSn1456mRrJ
         MoTreiNGwOj2Tj0cqqGn9R+n0K5fiwkpiMu8Ss/Z15irU4d4PX8M5E0s0q46w2whHtr6
         UT/yI1weheyFPJF6LVpAGdRcZVU7RawcWxZLZpaRzQYPTf+xVKHeTYAXBIOBf2MbNwvk
         RyrQ==
X-Gm-Message-State: AOAM533/OTRmB9+VPMsE1xX0BW+fW6i5VvzPiwhqJPO/MyU8Hrqa0YGT
        7707Ue4fV3qWrExejaLDIgGitW/bHgs=
X-Google-Smtp-Source: ABdhPJzPlZ4hLsTuabpr6kMEbzso2npKOiecghhNSg3X5+j+06vE71lNQoCxgnuKi4qkJktS+zsCOQ==
X-Received: by 2002:a9f:2104:: with SMTP id 4mr18442169uab.43.1593616449402;
        Wed, 01 Jul 2020 08:14:09 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id q187sm771725vsq.12.2020.07.01.08.14.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:14:08 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id 64so7240940vsl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:14:07 -0700 (PDT)
X-Received: by 2002:a05:6102:407:: with SMTP id d7mr19071366vsq.73.1593616447314;
 Wed, 01 Jul 2020 08:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200622144929.230498-1-dianders@chromium.org>
 <20200622074845.v4.3.I68222d0b5966f652f29dd3a73ab33551a6e3b7e0@changeid> <850240a0-a8c2-9bca-b17e-5452ce2f9c10@codeaurora.org>
In-Reply-To: <850240a0-a8c2-9bca-b17e-5452ce2f9c10@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Jul 2020 08:13:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UcqYzrb_H3YJ=UGpRYMkNiRgG8_EaJazK-8+WCfK4msQ@mail.gmail.com>
Message-ID: <CAD=FV=UcqYzrb_H3YJ=UGpRYMkNiRgG8_EaJazK-8+WCfK4msQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] nvmem: qfprom: Add fuse blowing support
To:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, mturney@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, dhavalp@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        mkurumel@codeaurora.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 1, 2020 at 8:09 AM Ravi Kumar Bokka (Temp)
<rbokka@codeaurora.org> wrote:
>
> Hi Doug,
> I have tested v4 changes internally on target, if i am giving input as
> unaligned address, it's not throwing any error message.

You mean if you _read_ from an unaligned address, right?  Yes, this is
on purpose and by design.

1. It appears to work fine.

2. If we didn't allow this then we would break compatibility with
existing dts files and existing users of sysfs that want to read here.

-Doug
