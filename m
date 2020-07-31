Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACA021883
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4dxRilW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbgGaJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgGaJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:18:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:18:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so22099584iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBYKW+6zfDB2a54T6hWqLG1CXD8Xv9gEE8YRBupknoc=;
        b=Q4dxRilWRBgR7d7mMciRIspoaJm1fKMtrrxqGop4MRWMLfDc2D9yEkmq7lanCl9IDe
         r7Ipz4IWXCJMfmE8gERtTCXqU0PCd2yaU25HbqQAmtQQfmbt9kxpDNN2AVYcf2lFK1pC
         cwqvXq69UceGzBHTSrTnvMYRIvHZl+qJ4u17vqcges3uTIgsNJpdkSZKEYBAdS6e1jjj
         qwjFZv61E1DWla4RqmgLOTPcf169N+7qeHI86xyeTQ+kuv1LDlJTZGttIqTSER1GnIn6
         R01XGra1AUEkoKQGTvP1e29NBtDPetvcV9hgYInxlth9Nfx8/iX5yND0vqQLmGYSWbhj
         /bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBYKW+6zfDB2a54T6hWqLG1CXD8Xv9gEE8YRBupknoc=;
        b=Gwmx21b0IQByWfQ0RDXcn6vhN6Ywbt5GXx+TbpX0uydJFnS+Ggj22GmNjiO2xvrVQq
         AzG7yvvi6BOHhYEC3BbiA+RAkj3++jYKlHgKnVnDEtu7OS4+ECTVK+iBGWMYgfTSc1Wx
         QRDyS3z/y1gqrGDR6M/2mbsgUojPhB7PuwrJUnLh+ECvFQ6FJQNPJeVq9krA2Ql5M/Ij
         4K43X1rJYrzqLcATCFtyJCWSNnVPwQGvb239S7IS70Mv0HZdhX35ejzuyhEoemGS1iZX
         6xwrpwEhJmnCA9+QidUM+NMNZATXpPAzwpl577wmF1qXfC3hEkVGBPMnucor7IV30wGv
         50MQ==
X-Gm-Message-State: AOAM532ZTbVvY2E1HGnERWDqbfRsVe+xpk0iLpCHVOjUL91fHZKvSZqS
        SGg4F7sQkEzRVV0XPKWIMwdu2hiPZj4620ltAPVLbw==
X-Google-Smtp-Source: ABdhPJx+ufc4R00ufDto7B+hLq2EDngnNSkTrnF9favAezBqDM2gxaTBrSA3LHvhe9NZwN3t9yBnkD6e7zjqycRcULE=
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr2682909ion.59.1596187081282;
 Fri, 31 Jul 2020 02:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200731084023.2678931-1-cychiang@chromium.org> <20200731084023.2678931-3-cychiang@chromium.org>
In-Reply-To: <20200731084023.2678931-3-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 31 Jul 2020 17:17:50 +0800
Message-ID: <CA+Px+wXL6-zM6vBZj9_6MhxQz7Dy_Z4J7+RUYEViVkWYv2zX=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        Ajit Pandey <ajitp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:41 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> Add new driver to register sound card on sc7180 trogdor board and
> do the required configuration for lpass cpu dai and external codecs
> connected over MI2S interfaces.
>
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM.
