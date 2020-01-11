Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA16C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71382064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7alot6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAKARd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:17:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgAKARc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:17:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so3414429wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOhHMjy7jdpfI1DMYloTLgZVUnGgeKv/Vqgziyk6eXM=;
        b=d7alot6oEoRhlxOjMLBtLjjjYjrqNTDRYLUbcpREvaRnqXf+FREesB72vDqa5U/nJf
         MRHzajAz9C4Bmd6J0+NlRHeYsqRDDz3VPfsLH7WxelGR7Hk+CkZlACaWeLCaD4LXuTAj
         3Jwp9dwTiNqj3b+Jltdu2wCznan+Qfk+xxeg8qD8dpB9IRg5nXdK/r4V8cxIpPoQaxkv
         X0miuWjfHUi29kAKpPayo1J/mx/ltWPVjr8pdLBouwFeLHkPY32hayi7r0DKEuS0OGvg
         NYuW7c4a5CaYEeKM+N5cIuBKSDC35xHWQmY0ZOyJJHfysXO+FQ54O0FlbKySV6UCcCAz
         qDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOhHMjy7jdpfI1DMYloTLgZVUnGgeKv/Vqgziyk6eXM=;
        b=SNIcwSuuGBmb53tqakJP9qLrmgiTxHM7UBJy9mwpfEnJmzE976xwELhGJsmEeht/QH
         eTJT+JQRfFGFcGuFqPAtIS1ngUcBsPZaukl3JMtIjGgzK+XF4yseMbo3b5vaqDHrFPat
         vrivlZJkAq2Vm8NYDiroMaqp7W2WpD0YbSoGmyBuwwgs+mvLABXECSwOkbygo/sYLiLK
         1o998r5w0lgCWcNh8w0tizFZBJF5w0FpUAmuzJ7H2kcWnN1Gy5p2ye2MEAFI3jyp5RqZ
         P+5209fDqkp8YS8Sj2YzIK/QXwAkDx9yTlez07g+071F96QWxkLPAC+p2yVNXslaRqnT
         j3IQ==
X-Gm-Message-State: APjAAAWxErcSXbY0fn+8PjbdWQFdW3qTD1tG/I++UZRaldTg/GJ7bmXs
        MQiK/s7GWcyqZeRepW0bH+hLMqFxkkL8UEroxOXWtA==
X-Google-Smtp-Source: APXvYqw+qKybwrfVajfQDahIQSXrj+ZLJMSfvl8jxphCdSH2XtSjuAr8/dm/HDmXOdEKzHEFntFAa6/pJPj2HQ91x8k=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr5891985wru.154.1578701850516;
 Fri, 10 Jan 2020 16:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20200110071616.84891-1-chenzhou10@huawei.com> <b86d050a-634e-c99d-1302-29fd6257df1c@amd.com>
In-Reply-To: <b86d050a-634e-c99d-1302-29fd6257df1c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Jan 2020 19:17:16 -0500
Message-ID: <CADnq5_OXHwj=acC7SWg9_gBpennTU7Rqa5VKrafJAJYYFnaWzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conversion to bool
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

On Fri, Jan 10, 2020 at 4:41 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2020-01-10 2:16 a.m., Chen Zhou wrote:
> > The conversion to bool is not needed, remove it.
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 504055f..a004e8e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -2792,7 +2792,7 @@ static bool retrieve_link_cap(struct dc_link *link)
> >                       dpcd_data[DP_TRAINING_AUX_RD_INTERVAL];
> >
> >               link->dpcd_caps.ext_receiver_cap_field_present =
> > -                             aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1 ? true:false;
> > +                             aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1;
> >
> >               if (aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1) {
> >                       uint8_t ext_cap_data[16];
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
