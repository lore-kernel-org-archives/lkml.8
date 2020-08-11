Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B28C205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnJEPmUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHKVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:17:11 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:10 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k25so15864vsm.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BG7YFgc3xmLmgJtfXAfxYxZdUYNfvRF7uBrIdBJOZI=;
        b=MnJEPmUXAhyAuhSs5WSnq12nq2fZhQVfRdLJq41xeZ5tIkmBvs19n3/rrZy4dJeTq/
         Hr2BSIgCS1jVawdeO9VFLOdTRY/rbv4HfKugrQwlxLCf8MhTQf9E6ckjXbcJo5mgFAqt
         EkNQ+Mt42h3Qy4XjFEI98lnv+39Lw1FIELg10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BG7YFgc3xmLmgJtfXAfxYxZdUYNfvRF7uBrIdBJOZI=;
        b=GTUnrx8mDyUz17UeKEIMHpFR8eWh2DoPHrhOToirOuLyWFnVR3cU4EmItPIAgawSpY
         ayIBzo70mZqMVh9dGd4npzfQBY7BcS/k4DWuMnEscEhoqd67t5Fk2B8jHoYhwkvnmRUl
         tGU+knYQndGL+PTnOIVRJg7dgdQy+ZuX3MaltPEuJN+YrpJBXvp4wtBaoNIcuJBsIpBI
         5m0nr8oeKMs6gWtBPwiY7dT2VUW79DIujjP/A8YiBK8oIUaUVxQ+0pX+3zShPt2iSEUV
         Qx4MMKTDFqfDPa12IxoL7woxVcn6E95jX8tY+7CwEX/WHtfuLr8+BrFtYpIOvWffSomO
         MrKQ==
X-Gm-Message-State: AOAM5313qABQT0UtC580ciiPI3q+xqVXCJSaELGGvpWSWNjACZ68w6fq
        AW7a71EVKORfBqrjm4QxreoCieHTBrE=
X-Google-Smtp-Source: ABdhPJwkm4lIhXoCS+Hpq647W2voMn7cykQe6LqzlwCqEAq2bgKTiseH2jk/Ok7+8RrGcRMQ63DVMA==
X-Received: by 2002:a67:61c1:: with SMTP id v184mr26058034vsb.56.1597180629190;
        Tue, 11 Aug 2020 14:17:09 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id t191sm26238vkt.46.2020.08.11.14.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:17:08 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id r7so32526vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:08 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr26650661vsj.119.1597180627917;
 Tue, 11 Aug 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org> <20200811190252.10559-2-sibis@codeaurora.org>
In-Reply-To: <20200811190252.10559-2-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 14:16:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uo2LaMbT4nTbcFs2t0noCm_PzBi+TNPZ6HTBe8WraQBg@mail.gmail.com>
Message-ID: <CAD=FV=Uo2LaMbT4nTbcFs2t0noCm_PzBi+TNPZ6HTBe8WraQBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: aoss: Use GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Brown, Len" <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 12:03 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> All the power domains exposed as part of AOSS QMP driver require to stay
> powered on for suspend. They are powered on when the remote processors
> boots up and powered off on remote processor crash/shutdown. Mark the
> power domains with GENPD_FLAG_SUSPEND_ON to model this behavior.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index ed2c687c16b31..5a5b4bf928147 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -366,6 +366,7 @@ static int qmp_pd_add(struct qmp *qmp)
>                 res[i].pd.name = sdm845_resources[i];
>                 res[i].pd.power_on = qmp_pd_power_on;
>                 res[i].pd.power_off = qmp_pd_power_off;
> +               res[i].pd.flags = GENPD_FLAG_SUSPEND_ON;

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

This makes my patch [1] unnecessary.

[1] https://lore.kernel.org/r/20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid

-Doug
