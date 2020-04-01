Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847FC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EE320678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwAHBtNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgDASTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:19:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39686 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbgDASTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:19:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so1212563wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OU74YOGHQ6ePRK+7shGUKVyt5Ht+V+76PPs499ObSJM=;
        b=rwAHBtNNyCB5iSJhLJ07g9Fr605TncEhdAYMDOk6W5ufpzoYn7GRHelRffmifTGQma
         1EpdwZApqeXI5lokgCmLM0vormbBT4jpiO49DayybE7G4KOp8IY0RJQasF4OX9mK/xKj
         zp8FoOo6TuYO50W3mTuty0aDfs89yvwHjdmbQ1Tr6gBjiqguifnO4Cbsutb9Ya24FyHe
         pSXxhxJwpeAHGG3GN/DJ6FiHaSWQzuaca0En3DiW0AfYcSLnoRrg+GiXvbclGTb6s3XA
         MWgKtWbhYYvWAHc3cAfpEOqrJQWZ4WiDSBHR12nyAdu9Oxd9yv5msuIqZtse2hOY/LgW
         BY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OU74YOGHQ6ePRK+7shGUKVyt5Ht+V+76PPs499ObSJM=;
        b=AdWekGmsqgsUVVFIujbuUtC8Qe1IP8mKEsuTAfnCMLE+B7BEyEvKp5dDRzl/wV8zCr
         LAPKJAHKNWbUS0qI7pajOZXL5n6IF9VA1cioQtLF34E48U3TZA0IT9wGb1mayZlRUer1
         4Q2/tLtW8aeV4NV6AxuhAUqhS8Y+AT54N713qHjPP16rFUeX4W23eitRwhgQ9jmXbK+x
         xtEH6LThb0Dy1GaGoUtkYj4Bo3IwDpZVFHOUq9A7ctrxnpaqQXGhXhH7a8Ykb7phjNgq
         OeZTvzIcFbe3FEu404tk920rC+4Uk+eC1qd5PO2Jq67m+QiNyk8JxHzv7mqPekDVgrAS
         +mDA==
X-Gm-Message-State: ANhLgQ3kAOcMAm4phSz7Nc8SEbNAmsKVD16NNTh6k1bZc/tLABqzH3RD
        SQDSpKqJXaXm4yXskvZh/2OS20BrQsJXwKVdvUJ/0A==
X-Google-Smtp-Source: ADFU+vtxzOFKz9YR0+J01r9kWIIlBM+Dy/RQq6SXU0xM1AAoM+6OT/HNf/VZj2/xK/RYU19ZCs2fiRGjks/KQYfYegQ=
X-Received: by 2002:a5d:6187:: with SMTP id j7mr28401577wru.419.1585765145756;
 Wed, 01 Apr 2020 11:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200331212228.139219-1-lyude@redhat.com> <20200331212228.139219-3-lyude@redhat.com>
 <48f2037b-1939-2ad3-750e-4ad4601d88be@amd.com>
In-Reply-To: <48f2037b-1939-2ad3-750e-4ad4601d88be@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Apr 2020 14:18:54 -0400
Message-ID: <CADnq5_O0DHnqRVnrEB1uRgHO9JtHqbikevmdOmrN3qmX48svCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/dc: Kill dc_conn_log_hex_linux()
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Wyatt Wood <wyatt.wood@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:00 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-03-31 5:22 p.m., Lyude Paul wrote:
> > DRM already supports tracing DPCD transactions, there's no reason for
> > the existence of this function. Also, it prints one byte per-line which
> > is way too loud. So, just remove it.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Thanks for helping clean this up!
>
> Series is:
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>


Applied the series.  Thanks!

Alex

>
> Regards,
> Nicholas Kazlauskas
>
> > ---
> >   .../gpu/drm/amd/display/dc/basics/Makefile    |  3 +-
> >   .../drm/amd/display/dc/basics/log_helpers.c   | 39 -------------------
> >   .../amd/display/include/logger_interface.h    |  4 --
> >   3 files changed, 1 insertion(+), 45 deletions(-)
> >   delete mode 100644 drivers/gpu/drm/amd/display/dc/basics/log_helpers.c
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/drm/amd/display/dc/basics/Makefile
> > index 7ad0cad0f4ef..01b99e0d788e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
> > @@ -24,8 +24,7 @@
> >   # It provides the general basic services required by other DAL
> >   # subcomponents.
> >
> > -BASICS = conversion.o fixpt31_32.o \
> > -     log_helpers.o vector.o dc_common.o
> > +BASICS = conversion.o fixpt31_32.o vector.o dc_common.o
> >
> >   AMD_DAL_BASICS = $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c b/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c
> > deleted file mode 100644
> > index 26583f346c39..000000000000
> > --- a/drivers/gpu/drm/amd/display/dc/basics/log_helpers.c
> > +++ /dev/null
> > @@ -1,39 +0,0 @@
> > -/*
> > - * Copyright 2012-16 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaining a
> > - * copy of this software and associated documentation files (the "Software"),
> > - * to deal in the Software without restriction, including without limitation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - * Authors: AMD
> > - *
> > - */
> > -
> > -#include "core_types.h"
> > -#include "logger.h"
> > -#include "include/logger_interface.h"
> > -#include "dm_helpers.h"
> > -
> > -void dc_conn_log_hex_linux(const uint8_t *hex_data, int hex_data_count)
> > -{
> > -     int i;
> > -
> > -     if (hex_data)
> > -             for (i = 0; i < hex_data_count; i++)
> > -                     DC_LOG_DEBUG("%2.2X ", hex_data[i]);
> > -}
> > -
> > diff --git a/drivers/gpu/drm/amd/display/include/logger_interface.h b/drivers/gpu/drm/amd/display/include/logger_interface.h
> > index 6e008de25629..02c23b04d34b 100644
> > --- a/drivers/gpu/drm/amd/display/include/logger_interface.h
> > +++ b/drivers/gpu/drm/amd/display/include/logger_interface.h
> > @@ -40,8 +40,6 @@ struct dc_state;
> >    *
> >    */
> >
> > -void dc_conn_log_hex_linux(const uint8_t *hex_data, int hex_data_count);
> > -
> >   void pre_surface_trace(
> >               struct dc *dc,
> >               const struct dc_plane_state *const *plane_states,
> > @@ -102,14 +100,12 @@ void context_clock_trace(
> >   #define CONN_DATA_DETECT(link, hex_data, hex_len, ...) \
> >               do { \
> >                       (void)(link); \
> > -                     dc_conn_log_hex_linux(hex_data, hex_len); \
> >                       DC_LOG_EVENT_DETECTION(__VA_ARGS__); \
> >               } while (0)
> >
> >   #define CONN_DATA_LINK_LOSS(link, hex_data, hex_len, ...) \
> >               do { \
> >                       (void)(link); \
> > -                     dc_conn_log_hex_linux(hex_data, hex_len); \
> >                       DC_LOG_EVENT_LINK_LOSS(__VA_ARGS__); \
> >               } while (0)
> >
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
