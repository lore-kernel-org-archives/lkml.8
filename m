Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D7C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58A824671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fAd2viFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAODL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:11:29 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33799 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAODL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:11:28 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so9641685vsf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztj1hvO+WNVO+LNPV45474E/vfF/Pm9unbmeASb7NPA=;
        b=fAd2viFGmbBR8ZdFtpgvR+MYV5gshPH+9J4I8bVUF1JSXizaTydbFd3YzCEJG/Uhwm
         bt5fynuF1MlcRJYnjbuC+1/+Cz2lOaCcPOB05Z/Cm3DK+NnyCS7/OUT+geia3JjtPN8u
         xya4laWGuWdTzozjuIsMhQ3DFtjoqhCM1CM6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztj1hvO+WNVO+LNPV45474E/vfF/Pm9unbmeASb7NPA=;
        b=K+KXiic2bQJsKo8V/E3FsIdlumovp7k+ZUykBTyrItTG6BgUFKslDPqwSTFpfbest7
         l6oAyzOTjgR2eEcT5x/a+4xR5hvpXOnLaFFKkX9/cAQKGt6dnXoO8UgmGGnL7CxcAAJI
         ovX8Y8qFEj+QVU2XYAh5HqqnM+CTGs6svd2CgLsSL//yacAQiIXx1hgVZKjZUpAbxaCT
         JrqyAwlHGhXFE7LbmD4XzpbRVWc1I7w90ic+pqMIZP4IW03FkUJwZ9BCUVRhMNDTCi7r
         /Pn5h1X8W7Yx94b7xF+aziS9Tp7esMuZJkV9eWui1RcKd0WWIurV93AtICy+Bi9z1FgN
         wkRg==
X-Gm-Message-State: APjAAAVrM9AkzY+PZmcww4uJuuKanAPKt5r1MDZKTQ+SKRc6k/j5qbJs
        4fE3S7cZbWxje0lb6hvToVLa96OR5d0=
X-Google-Smtp-Source: APXvYqxBLAFKB0m1DdIRD5ces71zCy4nwpydo2ls51HtbVrZTuUfUcROssPE4tERWiHYqVNwalCUcA==
X-Received: by 2002:a05:6102:408:: with SMTP id d8mr3300921vsq.19.1579057887430;
        Tue, 14 Jan 2020 19:11:27 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id j26sm4435948ual.7.2020.01.14.19.11.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 19:11:26 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id w67so4304368vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:11:26 -0800 (PST)
X-Received: by 2002:a1f:c686:: with SMTP id w128mr13064603vkf.34.1579057885834;
 Tue, 14 Jan 2020 19:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20200115025314.3054-1-swboyd@chromium.org>
In-Reply-To: <20200115025314.3054-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jan 2020 19:11:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V=Ys+RLHd15+Y9c2Auiytbq821CAXLb-tMe__Rq48uDA@mail.gmail.com>
Message-ID: <CAD=FV=V=Ys+RLHd15+Y9c2Auiytbq821CAXLb-tMe__Rq48uDA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: pm6150: Add label to pwrkey node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 14, 2020 at 6:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some platforms don't want to use the pmic power key as the power key
> event. Add a label so platforms can easily reference and mark this node
> as status = "disabled".
>
> Cc: Kiran Gunda <kgunda@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
