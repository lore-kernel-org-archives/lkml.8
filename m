Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5799FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC12080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtp1cONN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0R4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH0R4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:56:35 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E4C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:56:35 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i20so1455747vkk.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3B/Q02yvB9Yb/6f99Yh5bgWBIK4FmspfwcBGWYIhaQ=;
        b=gtp1cONNLRdqCbirQgaQZFoJMnU2+Pp93TVFD9+9a7EbozuUQabLEhaFWeodWKi/6A
         5yFTsxABrmxVdN5KKreOg0m5oB7Ffh7B4tvpdaZLlNPDvCQ2GiUUl3ne4fQ1a5jzMeZq
         gnsk8wIUwedu254Lobh9MlJxfV9jnafA5uwds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3B/Q02yvB9Yb/6f99Yh5bgWBIK4FmspfwcBGWYIhaQ=;
        b=YQsoosZg7HWq8wlAv+z59tnaeLVRulpQdA1rwfJfx/Tzp0MWvE61i4onaGKj5mz7lC
         jbx9UIuRBP6CynTGT3WLTuSsni2Q7dbYgEi1Sp0rl98p2lOCH5wnKqPEGxfc/fSs9S1q
         RJWMD+jzIWLU/YVErNFNT6sEo5G1TFexP9fouTEoHVr4yTVzlCuC/sTJgiO5PmCWlIX0
         PCiOvtv/osN6yUbrR42oNgdZ7TIEdpfYX/m1ErtVf0Pnlqlst/DMxXxEr6Yd7PNZMmC0
         Jud8/hdZ5FaxdMxEluOFTHA4hDubIpE3FEbTTgDYKEujSsf8KDdn4nombfk669o3BN7v
         qkig==
X-Gm-Message-State: AOAM531rD6HsXrJmocftWCnOvkLwufXN9Ot1Q3WxJ29qoyGkjGZjbdBE
        J4ExIM02U1ay+Pm3ozkRzNwSrTTa7Zb6YmMi
X-Google-Smtp-Source: ABdhPJyduakk4ayMp13Mr5lsFxcJGIcsi3ORY6tcITKgWKQWO66bd11uRpWoiyGeDdqowEr3XGDfBg==
X-Received: by 2002:a1f:734a:: with SMTP id o71mr13965821vkc.89.1598550993527;
        Thu, 27 Aug 2020 10:56:33 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id j20sm487984vsg.18.2020.08.27.10.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:56:32 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id a1so3286496vsp.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:56:32 -0700 (PDT)
X-Received: by 2002:a67:facb:: with SMTP id g11mr2701403vsq.56.1598550991774;
 Thu, 27 Aug 2020 10:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <1598492651-9072-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1598492651-9072-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 27 Aug 2020 10:56:20 -0700
X-Gmail-Original-Message-ID: <CA+jURctrQcKsGwxZriX8bD3AQr-yh_J_Z7kkP+6HtD72Gt5DUw@mail.gmail.com>
Message-ID: <CA+jURctrQcKsGwxZriX8bD3AQr-yh_J_Z7kkP+6HtD72Gt5DUw@mail.gmail.com>
Subject: Re: [PATCH v2] Input: elants_i2c - Report resolution of
 ABS_MT_TOUCH_MAJOR by FW information.
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 18:44, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> This patch adds a new behavior to report touch major resolution
> based on information provided by firmware.
>
> In initial process, driver acquires touch information from touch ic.
> This information contains of one flag about reporting resolution of
> ABS_MT_TOUCH_MAJOR is needed, or not.
> Touch driver will report touch major resolution after geting this flag.

I think this paragraph needs updating now that the firmware's
reporting the actual resolution instead of a flag.

>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>
> ---
> Changes in v2:
>   - register real resolution instead of true/false.
> ---
>  drivers/input/touchscreen/elants_i2c.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index b0bd5bb..dc7f4a5 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -151,6 +151,7 @@ struct elants_data {
>
>         bool wake_irq_enabled;
>         bool keep_power_in_suspend;
> +       u8 report_major_resolution;
>
>         /* Must be last to be used for DMA operations */
>         u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
> @@ -459,6 +460,9 @@ static int elants_i2c_query_ts_info(struct elants_data *ts)
>         rows = resp[2] + resp[6] + resp[10];
>         cols = resp[3] + resp[7] + resp[11];
>
> +       /* Decide if report resolution of ABS_MT_TOUCH_MAJOR */
> +       ts->report_major_resolution = resp[16];
> +
>         /* Process mm_to_pixel information */
>         error = elants_i2c_execute_command(client,
>                                            get_osr_cmd, sizeof(get_osr_cmd),
> @@ -1325,6 +1329,8 @@ static int elants_i2c_probe(struct i2c_client *client,
>                              0, MT_TOOL_PALM, 0, 0);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
> +       if (ts->report_major_resolution > 0)
> +               input_abs_set_res(ts->input, ABS_MT_TOUCH_MAJOR, ts->report_major_resolution);
>
>         touchscreen_parse_properties(ts->input, true, &ts->prop);
>
> --
> 2.7.4
>

Harry Cutts
Chrome OS Touch/Input team
