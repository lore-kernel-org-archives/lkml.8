Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8DC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23E206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583504003;
	bh=8HMSv45RmcowcvUV+/JVwCs/5SkwykqDSsq0zxlngI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zvqkgyicel7BUodjcEw0R5/etxqyYWcdRh2UJQBs9JkRG5tn1Jotbp3GGCR8KRjvH
	 UIW7eil9JCMhEzAtO/QMed7JX5vQqwVsYQg8qh7HCrQJCiKPAiO/cwkArF2Hiz53kA
	 OS4gldXiSThNXUsOCgL85w5X0GZcsbnAasd5QnxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCFONX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCFONW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:13:22 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7646206CC;
        Fri,  6 Mar 2020 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583504001;
        bh=8HMSv45RmcowcvUV+/JVwCs/5SkwykqDSsq0zxlngI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kwDxgZlOXDyDbl3r6rSK08+Sd8k5f1bwGh0lcEG94uqfILJBo3jo/PxP9wbPgyaCP
         NLB9f8j7t4VXm6EFEEZ/lxmd9wKxWoqUFcJjYga6NBEsm38Ive2pM8k+5BfuWtqO+e
         maiHZptvwMIIrk8aVL4xXnB5i4SADPrfQ3o5caMs=
Received: by mail-qt1-f179.google.com with SMTP id e20so1786453qto.5;
        Fri, 06 Mar 2020 06:13:21 -0800 (PST)
X-Gm-Message-State: ANhLgQ1+c3GpTrdLjKiDk1xk+B/fl/rs0CjXaPTk8HHGDVriOPPLvILP
        n1zR7mYpqHUbEGc+CJ3EcsQmoYGe0wQHkauqcA==
X-Google-Smtp-Source: ADFU+vtV93a6Fp58Tncd6cIdfe2+CpsQ5PI8x6hov3jHYzgAVFu8JmXylmr7k0+5bR+Gvm/UG+tSzfOnnksdk3kV1RI=
X-Received: by 2002:aed:3461:: with SMTP id w88mr3133057qtd.143.1583504000926;
 Fri, 06 Mar 2020 06:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-2-drinkcat@chromium.org> <20200225171613.GA7063@bogus>
 <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com> <1583462055.4947.6.camel@mtksdaap41>
In-Reply-To: <1583462055.4947.6.camel@mtksdaap41>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Mar 2020 08:13:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLoUnxfrJh0WCs0jgro1KHAjWaYMsaKkKfAKA2KJ252_g@mail.gmail.com>
Message-ID: <CAL_JsqLoUnxfrJh0WCs0jgro1KHAjWaYMsaKkKfAKA2KJ252_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Nick Fan <nick.fan@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Sj Huang <sj.huang@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 8:34 PM Nick Fan <nick.fan@mediatek.com> wrote:
>
> Sorry for my late reply.
> I have checked internally.
> The MT8183_POWER_DOMAIN_MFG_2D is just a legacy name, not really 2D
> domain.
>
> If the naming too confusing, we can change this name to
> MT8183_POWER_DOMAIN_MFG_CORE2 for consistency.

Can you clarify what's in each domain? Are there actually 3 shader
cores (IIRC, that should be discoverable)?

Rob
