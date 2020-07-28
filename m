Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1CD2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8+Svu+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgG1LZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgG1LZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:25:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A4FC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:25:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so11705948pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUmUMz6UgsCt+CXB7icgRI+l8Tvn7Jgl/4MrS/vbZRg=;
        b=M8+Svu+YOx7/2gsUroIjDqeqHz0fv6v2+W+hVAiWJjBagMP32QT2IblXw9nSm9xTfn
         P9JhY1yHNLyhLyPjMbyUZp5HXoSgVK3X7j3rZT7az+bSha5/bNtlA3jF4dvV5m1Cv5V0
         223oOfoaOSyr31V1z6413MMc2ZmpAIMNyHdDbkbUQO6ZycyI7WawnVNd1mZqI9qJ9e/X
         MV+nUvUTere0RZopRHkbYmVT2ARjTc3crPxm1ZWlZyq8MKceZjlC2bzX2971Djx1l4Xu
         RMC4Q/F0wfGJpEViHq5cmHpC/LadlhUnU9KqS/TM/SVFN88SGDS0PJAwWXyhu3pDJxm7
         sfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUmUMz6UgsCt+CXB7icgRI+l8Tvn7Jgl/4MrS/vbZRg=;
        b=Pm+jBp8suUGls1LHfSBKaawQpjaph6L0qn9gA58znW1z89bXubaGOh8V4IVFIZZT6U
         uWDEQmwOls+WkLyWtDxeXisYUAOJjcHpx1qVF5VuH661nbRyXTXIxM2U2k1738/a86mf
         mqHfXTRyYkbb/QlwsRTaNRZEcxZ8JIhLg9cKQdQy3z2cxNn6jSgmSPj4uFMlZtirDiFd
         0/bNT3u+q7+DUHqZQuOW9BFkpBQIEQM7cuKUKaJ8xtxo24e7AGmsLvrS/dpxUaF4GyxW
         K6deuzJtMrUj3YAHPhmJSdxLJgWCI/V2v1xFfFBIWqJk419QrC+VXKg4amQUFSJMAAAT
         TICg==
X-Gm-Message-State: AOAM533e3Y+o0g1u8BxXeUORQiM5u7aKe3GHfKcjuejFZTX1/6mnSqmP
        p3NDJedBhAgy2Zrm8AaLiF70kw==
X-Google-Smtp-Source: ABdhPJzHsWs+C2CAir0w1/n4qx2AAi7Eo9fWCt8dVNRFp68sei/9QQuAuxDTPc580wHpTPxR+0lNQA==
X-Received: by 2002:a63:cb03:: with SMTP id p3mr23750881pgg.444.1595935504307;
        Tue, 28 Jul 2020 04:25:04 -0700 (PDT)
Received: from localhost ([122.180.34.198])
        by smtp.gmail.com with ESMTPSA id j26sm17746105pfe.200.2020.07.28.04.25.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 04:25:03 -0700 (PDT)
Date:   Tue, 28 Jul 2020 16:55:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Anson Huang <anson.huang@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Peng Fan <peng.fan@nxp.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/4] gpio: mxc: Support module build
Message-ID: <20200728112500.a43jow25yueltyuw@vireshk-mac-ubuntu>
References: <1595382353-17486-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a13gcF_+dkfxZW0u_YuJ92hY1JukWfzM+e30iM=YUhraQ@mail.gmail.com>
 <DB3PR0402MB3916F080E4912B27B18BEADEF5720@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a2CBYV2xEkedQYmzL4XgHPeu02=vmLffq+RWwvEvuUGKQ@mail.gmail.com>
 <CACRpkdb0=9K4-F2xFWN6OvnOi5-jwLXihdphTgMCA1vTejB_Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb0=9K4-F2xFWN6OvnOi5-jwLXihdphTgMCA1vTejB_Qw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-20, 09:59, Linus Walleij wrote:
> On Mon, Jul 27, 2020 at 12:44 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jul 27, 2020 at 10:18 AM Anson Huang <anson.huang@nxp.com> wrote:
> > drivers/pinctrl/spear/pinctrl-plgpio.c:static
> > SIMPLE_DEV_PM_OPS(plgpio_dev_pm_ops, plgpio_suspend, plgpio_resume);
> 
> This one is affected by the same problem, I don't know if anyone
> really has this hardware anymore, but there are some
> SPEAr products deployed so the users should be notified
> that they may need to move this to syscore ops.
> 
> Viresh?

Yeah, I can't test the patches but Ack them if someone can send them to me or if
someone can tell me exactly what to do here.

-- 
viresh
