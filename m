Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBAD20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="LKZL0Qou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgFALPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgFALPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:15:17 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 04:15:15 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c9so2684570uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXZ/1DYRo+pu94KlRLN7nt0/Jhb4JRPyNAe/TLutDXA=;
        b=LKZL0Qour/P3znlT11X6MSTa6a99kxJDMSO5oEuzh1urufoBk/cF8qaCaAXe2QzSU7
         o+TAkmNpjAqy8QBkVVDWyY2MQf7jZV3Sh5yfmmn8AxRZqeXovzJiNaHsAVzkJkJbp0c4
         xOcWqsh+4ND9g/cdr4emUuxzL7VBStoQv47qrX7kbAJczbJJH+M9ntwRVDPf9UWnQy0J
         JpeO55wc7hgIA6KQ5zR6fbuP5EPaptgIWLcCl9L8ym6u8sXM5Tj6e1wCaPtGGbKTRxn2
         G3uT95sz/KJ3K0xAc8pFwhdZqDe3jkNHXZUrB5Se/v2+2CNH8Gpz/c3+6EBiz8z1pHYT
         gpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXZ/1DYRo+pu94KlRLN7nt0/Jhb4JRPyNAe/TLutDXA=;
        b=GDi3CcqQxjaDFw6keOaoxvFoQZOtnymH86wI+46kiCUdtP47DHTGE2igA7+99KFS4L
         6pyxMFx0DHRZpQQGE8QA06elRYzFEgGw3812KkBABsia+e9TiomPuEVFAMOltGorRTjZ
         QocEuwBBUJNCveUwCoufk35jK730nMLzeeeOVhZlMC36N9h4spSnrb+jfhtBxjtdTVDO
         n+cxAvgI9khjgvUwrdDYxRSZnJmnx2B/gFOu7qx14iCC/iLa1MKYqJ2Fl2L+onunzBUq
         1i263skOzPh0l8fMKfTZ4zMRb1I2+TstjCoVO6TEeapNLRyxJ+DRkF1pU51PzyPz2Yfs
         QI2A==
X-Gm-Message-State: AOAM533QU891hBnCObwLVYIdpgLe1T4QPw2yvlEpKG0m45rkJuFtV2gp
        vfg2dRqgdfOpNZYexwyAah3UjC+178Eym5i+lvF7Og==
X-Google-Smtp-Source: ABdhPJyLmXk9IokgmeXuSJkA51TK2eGFwPQT+GFIvU7RA+yCOCZNRcNTXzdIV1T6tjLuIq55IW6dCOPqa3CLlRE70JQ=
X-Received: by 2002:ab0:548a:: with SMTP id p10mr13945454uaa.35.1591010115132;
 Mon, 01 Jun 2020 04:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224802.27850-1-colin.king@canonical.com>
In-Reply-To: <20200524224802.27850-1-colin.king@canonical.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 1 Jun 2020 07:15:04 -0400
Message-ID: <CAOg9mSQWuE06DJtfSn-d2cBK+RMZ0ndnw6m29pWEdw3jQq3erQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin... thanks for the patch, I have applied it
to the orangefs for-next tree...

-Mike

On Sun, May 24, 2020 at 6:48 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/orangefs/orangefs-mod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
> index c010c1fddafc..289b648ae196 100644
> --- a/fs/orangefs/orangefs-mod.c
> +++ b/fs/orangefs/orangefs-mod.c
> @@ -79,7 +79,7 @@ DECLARE_WAIT_QUEUE_HEAD(orangefs_request_list_waitq);
>
>  static int __init orangefs_init(void)
>  {
> -       int ret = -1;
> +       int ret;
>         __u32 i = 0;
>
>         if (op_timeout_secs < 0)
> --
> 2.25.1
>
