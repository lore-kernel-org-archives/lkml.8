Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31EB20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFDGpwpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEEMMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbgEEMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:12:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744FCC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:12:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f11so1356745ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCkYjBhiVEvy0x3Ue8g2r+hn+6C7TksnCaeziOTVJG0=;
        b=QFDGpwpdAjG4puvpxt7yXioyDCQRWv8af8uv28j3ibtUVzeEm40eoEpbjJfCOBHeEN
         nYh+gwUf7GpXOphCOJSSRq5/SrvcRTe/hb6RS+XpqYi8jYaSpk43m3by/tDB162gSyXD
         8F+k7QECoZNvysKdCFSOIHoOxJvt1CFlLt7aClN/mMwdPQkIQ/G65Od+yFoyfBOIsqui
         sLED4V37/OhtshXrK3QiN6QZ09KLvSRmeQguVgo9UXSVEeu5zO73lTc2Os0FeQuxHXFV
         uazREV7iVchOwG9fB7cIX+ZnpSmWkDac/RVVhYef39tZ8IyT4PCR3qJGit3oWLN9iXiW
         PFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCkYjBhiVEvy0x3Ue8g2r+hn+6C7TksnCaeziOTVJG0=;
        b=a27sm1c0p98R8fPNnfkNSoYBCAjW/4cZ4Rburjwbpgi8XohPkjhneb7wSaafDCpkdA
         Z07rAbOUqRT/eL3U6jD6geGDsz1vmq1ihJkmZnGaefwVkVnHn7MGm4p91rzQuzADOFHx
         k8xReC9bPwQCvxT6WPAyt0dlQH0D+rHQuWBatc3kCnocHZMuHgnZ4A7Rm/6NXOCDgkwa
         tQyvOuPNSTL+5NbYKUsF/FnGqcr4n7UTxozENJ+Vw41S0mmJE6zBk9ozw6n1slmEUWrC
         iR+1UYYnCaDcmWov3aP1HT88khjHmH8XtOF4/5DnH1PyVRqfEgBLiXs7LXZWU8iep0KR
         m8wA==
X-Gm-Message-State: AGi0PuYVbSWARnRy3nKrg3/wAKu9ZVxB3I3hvf9FkzIqrTw2klERZZiR
        zg7nZECgq7NnqO+58uQZSwvsZSTyoDdxHkr0iqiiqg==
X-Google-Smtp-Source: APiQypI4n3wOwtw+5CxzN9WhaiI9i9oWcjIepnnD18HMaud1N/zwYMkYxFtOWeBMr+wDtyiHi2Cq8Q8HPpRcwwyTcmk=
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr1605622ljq.125.1588680761762;
 Tue, 05 May 2020 05:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200505111204.963-1-manafm@codeaurora.org>
In-Reply-To: <20200505111204.963-1-manafm@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 5 May 2020 17:42:09 +0530
Message-ID: <CAP245DWxDVBAXU_1uqfA0iuajVCZvZOL4HG4VOOwZ1qMSuuMSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add 0C (zeorC) interrupt support to tsens driver
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manaf,

Thanks for sending this.

Typo: zeorc in subject line.


On Tue, May 5, 2020 at 4:42 PM Manaf Meethalavalappu Pallikunhi
<manafm@codeaurora.org> wrote:
>
> Changes:
> * Add zeroc interrupt support to tsens driver
> * Update zeroc interrupt support in yaml
>
> Manaf Meethalavalappu Pallikunhi (2):
>   drivers: thermal: tsens: Add 0C (zeorC) interrupt support
>   dt-bindings: thermal: tsens: Add zeroc interrupt support in yaml
>
>  .../bindings/thermal/qcom-tsens.yaml          |  7 +-
>  drivers/thermal/qcom/tsens-common.c           | 72 ++++++++++++++++++-
>  drivers/thermal/qcom/tsens-v2.c               |  7 ++
>  drivers/thermal/qcom/tsens.c                  | 51 +++++++++++--
>  drivers/thermal/qcom/tsens.h                  | 11 +++
>  5 files changed, 140 insertions(+), 8 deletions(-)
>
> --
> 2.26.2
