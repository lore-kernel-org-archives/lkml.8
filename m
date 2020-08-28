Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12906C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEF12074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bm8otg2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgH1Rmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1Rms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:42:48 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE6C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:42:47 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g20so629539uap.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfWev2M1Xpd0SkwFXAvENjqVJ7dg27p9sAOXozAjUnw=;
        b=Bm8otg2nmuFqBhhhUn490kKbDsqitiYKl22uNuIdNmP7rqNhp3wZmUHyYEoGfEO2XJ
         O90xFEF2C+JZlCBxVKlV3r9nmpJCJNiW/CORFc1SvQlEvtLKfuCyJjIbQbN9yKpAP+4l
         Ay15kCNf6bdwa8b7i2b7XEfPxwTzqIuvLHHyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfWev2M1Xpd0SkwFXAvENjqVJ7dg27p9sAOXozAjUnw=;
        b=gbny8P/KMJsMjAhiDYN0M8GoV6yk5MWSIJZPC0+7gmMx4SfrxvkmQjAQv6Rj8mx7xu
         9vxVrF9/mdJMD1Y3ku3Gq7tb7GAQ9XBYbRfeLmno0XZJX8beLoljr5fm/KMjhkAVgLvW
         /FA1Lq3zYEbERegcnNGrFNLq7UigIKgWeXgRIbWQeQ5bHTwFsNe6T8GjzgqwAcsv+1nB
         66ruCZk3ZpaCfPpcwzuWiBs4DRcoQKLdjhIsI0i1e0xnTcuS6bX/igInLBCVGrhepX5F
         T/KU1SG+3Y07haSW5bpX2beKHj0S1s+zIHgKZ/26/Dq/UtyzE2EHB6z1n0timGaBUGhr
         RjwQ==
X-Gm-Message-State: AOAM530eAOKuEPwoS4ig5AbYYJ1asNRxuZJCyxNTyVXYcYTgdT1BbgNx
        XD5+Amo3VntpYcdL/rv3rNeLUHRRjG5YM2Wx
X-Google-Smtp-Source: ABdhPJyJsme/zWMPIUVPuBDBaryAmB90ZYm7cR4tPm2kHvOPgPClc2oFMxrNw9THqoJFuCbfpadz+Q==
X-Received: by 2002:ab0:5e65:: with SMTP id a37mr2137911uah.13.1598636565945;
        Fri, 28 Aug 2020 10:42:45 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 67sm260768vsl.13.2020.08.28.10.42.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 10:42:45 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id v138so44319vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:42:44 -0700 (PDT)
X-Received: by 2002:a67:1603:: with SMTP id 3mr7443vsw.81.1598636564112; Fri,
 28 Aug 2020 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <1598581195-9874-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1598581195-9874-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 28 Aug 2020 10:42:33 -0700
X-Gmail-Original-Message-ID: <CA+jURcs2tLsVihoiXLsvLzdJZ4LKv0sQTu7FAqqT6r+pCi0wsA@mail.gmail.com>
Message-ID: <CA+jURcs2tLsVihoiXLsvLzdJZ4LKv0sQTu7FAqqT6r+pCi0wsA@mail.gmail.com>
Subject: Re: [PATCH v3] Input: elants_i2c - Report resolution of
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

On Thu, 27 Aug 2020 at 19:20, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> This patch adds a new behavior to report touch major resolution
> based on information provided by firmware.
>
> In initial process, driver acquires touch information from touch ic.
> It contains one byte about the resolution value of ABS_MT_TOUCH_MAJOR.
> Touch driver will report touch major resolution by this information.
>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>

Thanks Johnny!

Reviewed-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team

> ---
> Changes in v2:
>   - register a real resolution value from firmware,
>         instead of hardcoding resolution value as 1 by flag.
> Changes in v3:
>   - modify git log message from flag to real value.
>   - modify driver comment from flag to real value.
> ---
>  drivers/input/touchscreen/elants_i2c.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index b0bd5bb..661a3ee 100644
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
> +       /* get report resolution value of ABS_MT_TOUCH_MAJOR */
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
