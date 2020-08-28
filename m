Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431AFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E632086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ikL2sQF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH1WF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1WFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:05:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4507C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 15:05:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f75so1955045ilh.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8l9Y1rOZPRRyAHQsWY7UgIU81ZXJcSOGq+jCPt+emY=;
        b=ikL2sQF+QPKjUnU5mcXYoX1u2vGuquw37/tzon4q21JsdRJuiWTpaypdxcuQL6N51G
         1b1bPBoNRDsSQjgB+BPEworPKuZIc5rltnkePFIlEs2a9GcAZ3S4dpdo2iHNBo714blU
         Mot7iHJtFqEi7SK8exJApRmrModrTmM8jtPP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8l9Y1rOZPRRyAHQsWY7UgIU81ZXJcSOGq+jCPt+emY=;
        b=KGjy0rwsswNMnOuaajzcYXg+x0SCdPn0z76uVk86xrS86NcUnXNR/KcAcea3Vt+SqC
         2IkyDVkOmAK5bcAJ8BYYTllfiL5MXhBbPEwaQnrFE6zbE3OA59X4lLGbzSuZno8oGZZR
         YFxxfsc5Pr7utF1dey1Zcl+D9hNpg371leA0X7lbhbziGyaTRK0rrAc/y94voeQ1baP2
         8QWpfATc1U9tlh9RFElsoyztPmraHTIQ+DQaqfkyilp31vB2Nn0XMqtEvSOrwn9o2yJ/
         NxbketYSe4cCj88XrdXIsD8QypgaMaU/1ygA5TZhvAQ+cA1IwNt/sb9LlRNjWciRjraQ
         rCUQ==
X-Gm-Message-State: AOAM531gKDye/UugnM835e7Dqg7qJLUR/+bxSLbe9aJSz6zTLU1WZrOD
        ESj+XNz1MYqDN6oNDSUVfCDZqq+u92R8NBq9y257xQ==
X-Google-Smtp-Source: ABdhPJyqO2B0cTDYb5Y6AcsSkgrs4g0bfaagWVyDTTg3S8RCBrLRVDXnKwUyG73cZs0q+HbbUEROVhrRitCQLhh0Zy8=
X-Received: by 2002:a92:b74c:: with SMTP id c12mr281422ilm.237.1598652352532;
 Fri, 28 Aug 2020 15:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200826002945.394562-1-gwendal@chromium.org>
In-Reply-To: <20200826002945.394562-1-gwendal@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 28 Aug 2020 15:05:41 -0700
Message-ID: <CAPUE2usdNt-AcgdqmBX78ujehGzZN-xfSG4P1rxJcQiK_5UKsQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform: cros_ec: Reduce ligthbar get version command
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-iio list][+kernel list]


On Tue, Aug 25, 2020 at 5:29 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> By default, the lightbar commands are set to the
> biggest lightbar command and response. That length is greater than 128
> bytes and may not work on all machines.
> But all EC are probed for lightbar by sending a get version request.
> Set that request size precisely.
>
> Before the command would be:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
> Afer:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v1:
> - Remove BUG and TEST fields.
>
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index b59180bff5a3e..ef61298c30bdd 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
>
>         param = (struct ec_params_lightbar *)msg->data;
>         param->cmd = LIGHTBAR_CMD_VERSION;
> +       msg->outsize = sizeof(param->cmd);
> +       msg->result = sizeof(resp->version);
>         ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>         if (ret < 0) {
>                 ret = 0;
> --
> 2.28.0.297.g1956fa8f8d-goog
>
