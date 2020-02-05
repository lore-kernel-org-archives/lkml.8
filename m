Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27198C3524D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05922464
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VT9hTnG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBEAgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:36:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgBEAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:36:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so541455ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjWXCXEdOOwOMkJJTNAHcUDq4zVsPSajy/GXrZmEiag=;
        b=VT9hTnG+dCpN1oUkTy15tykgYxQNI3vmF23pTk/136wicIDfFXnU1lBcH6cchRsKpj
         bSE7kppl3FvhhKU2qOSlNuQ01A213YcbbvQtFqQMtuUoH8Pc7or8v4KxolAK6vp21o8N
         AQKDmeLLPLIAIT3qI/FHSsJCREix1XNwkRx2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjWXCXEdOOwOMkJJTNAHcUDq4zVsPSajy/GXrZmEiag=;
        b=Pj6fN02I6tqlZYoGb4K1Xfyi3HpicFALLnRr//W7XKko3fNzfhDQOQDJXjRj1qVIfR
         p0SnySY3OPLylPovLO1wNJYgtWlT2wNrwa/14916e8CPudI4QrpITH1/lvi5hkyj86+l
         7ERazLXc8m8Es1ccJT/bhYHwHwJ4Uw+AGUD46ycYGtG/y93zTS2AgCTV3Hood+g5tVnn
         m+Pg9I4YfEfvb/XYWgR+T84rT9cHCF71OYByy73zEMtIoI5jBQqRaU5z/YmTleKRh4GS
         r7oQ1BO676n9xCUvSH+IwJi9I3/PrcrhqPcnuvkjyRTW3tl4euCl28T5jktVH8JR+Mwx
         h6eA==
X-Gm-Message-State: APjAAAUFwjD7NzRZPtXJFd2QYU0/7VJC51muPZgzueM66szbAbxgWVP+
        Snfu7YfFdGPDBzVtfVMORMFGJbDkBh0=
X-Google-Smtp-Source: APXvYqwJw5hJDHqDnfRpbBRNb8GcEWu71ppz7NOv6d5md4IkRXyPcfNI9pE+whVaksEnyz73A0VqvA==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr18013940ljg.154.1580862991840;
        Tue, 04 Feb 2020 16:36:31 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 135sm11336337lfb.28.2020.02.04.16.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 16:36:31 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id q8so552441ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 16:36:30 -0800 (PST)
X-Received: by 2002:a2e:3e10:: with SMTP id l16mr18417534lja.286.1580862990119;
 Tue, 04 Feb 2020 16:36:30 -0800 (PST)
MIME-Version: 1.0
References: <1580796831-18996-1-git-send-email-mkshah@codeaurora.org> <1580796831-18996-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1580796831-18996-2-git-send-email-mkshah@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 Feb 2020 16:35:53 -0800
X-Gmail-Original-Message-ID: <CAE=gft6DCqmX8=cHWXNeOjSTuRHL23t7+b_GZOrvUJAPfhVD8A@mail.gmail.com>
Message-ID: <CAE=gft6DCqmX8=cHWXNeOjSTuRHL23t7+b_GZOrvUJAPfhVD8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Currently rpmh ctrlr dirty flag is set for all cases regardless
> of data is really changed or not.
>
> Add changes to update it when data is updated to new values.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 035091f..c3d6f00 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -139,20 +139,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>  existing:
>         switch (state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> -               if (req->sleep_val != UINT_MAX)
> +               if (req->sleep_val != UINT_MAX) {
>                         req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }

Don't you need to set dirty = true for ACTIVE_ONLY state always? The
conditional is just saying "if nobody set a sleep vote, then maintain
this vote when we wake back up".
