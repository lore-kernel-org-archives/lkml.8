Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84955C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B1622CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596818519;
	bh=JIT48tVRZh5QtnoL/3kqeGILzTIHzJZvgKbBayuzwqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FEoea9Sp/1NV+fLpTa/GY/pcrSQrPC8TJr3ixakKLlZKqLOof3SCBNj1Lf1TrEg9Z
	 P1V2h+yhD2sWivdqET5x2LQuZIQCyMRiSen/0MILqdwl8d8cboiubcStaLHfMbnS7H
	 zwqH05c+eyhxlxL+opef3BUd2vhNP12c/V7qcMB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHGQl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHGQl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:41:57 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9110A22CF6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596818516;
        bh=JIT48tVRZh5QtnoL/3kqeGILzTIHzJZvgKbBayuzwqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPP690LZGh53qfbPoHyUj4HNywvQpaH0I2L9T7cN2sYIwZQ4y6AbA37GIcwX7zoge
         OSEn6hsUR1GnTYIcivIindYHmyYBiXDDmzbQ9cnZIKCDl35IPk46zYlyb+bKa85lCI
         iHcx3TvxeaL/TOl46JAj7eGTq8tlN2m1DD815vfY=
Received: by mail-oo1-f52.google.com with SMTP id a9so539897oof.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:41:56 -0700 (PDT)
X-Gm-Message-State: AOAM5310z3E9ln+m7U7Lsu6O4NfCqAA22PsvFE1UJi+dMU9pfb+qyg3G
        yDHuZIGZV7wmPPuxQVUFJIPjpBaGiHS4Xee42w==
X-Google-Smtp-Source: ABdhPJxXF7xlJBdJbBfvgJ7wVxDHE0mBYYElrK+mZmq/H0MW2EPUj3703ciHpT2JonAPVTvSMnecxOdH4pb5oGlg/eE=
X-Received: by 2002:a4a:a60a:: with SMTP id e10mr13335121oom.25.1596818515873;
 Fri, 07 Aug 2020 09:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200614063619.44944-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200614063619.44944-1-navid.emamdoost@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Aug 2020 10:41:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvrKU6RScJSsHFNn7GHx0N9XCdZmNupRGDqg4h0UKV9w@mail.gmail.com>
Message-ID: <CAL_JsqKvrKU6RScJSsHFNn7GHx0N9XCdZmNupRGDqg4h0UKV9w@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: perfcnt: fix ref count leak in panfrost_perfcnt_enable_locked
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        kjlu@umn.edu, mccamant@cs.umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 12:36 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> in panfrost_perfcnt_enable_locked, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied.

Rob
