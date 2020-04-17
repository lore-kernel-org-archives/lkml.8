Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7CC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636AE2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O655oVXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgDQOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDQOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:30:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237DC061A41
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:30:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so1708863eji.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4kmCow4WbTQt7XbF+AHk2oxINCbHnDLYHrlyOhKeBk=;
        b=O655oVXD26/Duqzplq5CoYORER7kylQOADLYA8rTjyrsRtR+cZoU1U4nPoMhz2fkz8
         hapAuxqoExCMkSrWtwrMaz1fh4B5HjHb6jhmbHULPqqw+j6tfZjmofNvMNaDq/pdhDdf
         jQbdidXViJE77LOAHkJ6/vpAL2zd7EOztZHXN4ZS1D3gfE7tNnUtkMK4IFtHz2tQNL9H
         9YJcx+coYjh+IcshnyOrzzCjR23xQUP76YvhuMi8qg81ltnrMvYhhWBemdUw1mkr/JMd
         x9WcSSshr6riUwK78zVOB0ReS93JWQIfKnx4W90kVjq5grkY1sAVC6hFgbMwY6FePuIM
         t+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4kmCow4WbTQt7XbF+AHk2oxINCbHnDLYHrlyOhKeBk=;
        b=uchihcG8jYhcRs9+Zme7KMp+HRETTl9RcRuDDca8SPnX8dtoeU+7OnwYYrd2JM0DEG
         LNL0endVhVrfFik7phLT0rwsf4uJHyYksMVBM6DUU2Lh6mdIcgS6/LFOXiczSXiP+bkI
         T6IpjLxI345Vm0jbsIjjfw+cYxu20jPrHnhQK7MvKKnz7DJ71v0HGrOGH+ZBsvZZ8JWB
         mSUUTf3x31D6zOnlcQgj03TInGFoY0N0teePhJ/WGixTw0ylHkimE4Y/BdwRZIjyI7nM
         aBQnwn8YlGzEfJZPzebFv0YaR9IybPRAdA88GMoLC95uqUibpEubkP7YjsQWEtQqhLx0
         uNow==
X-Gm-Message-State: AGi0PuYKZ1YxcClToWOI2utUd/n04849f3DJRY67q2pB7Nrb2RHNCsj7
        y9z4UJvynd9iM5C9+o0btV8fWxQ8RzgCf8l6plbTGw==
X-Google-Smtp-Source: APiQypKPdKUYjS3rat3E9WJ8o9VJMKiO8ypcMyMQxjiSuPo/IX7IsxV3bqp0yPJ5iuSP5EY8uP4deMWceCiTHe4iuBY=
X-Received: by 2002:a17:906:11c9:: with SMTP id o9mr3448550eja.64.1587133812954;
 Fri, 17 Apr 2020 07:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <ilia.lin@kernel.org> <20200313175213.8654-1-ansuelsmth@gmail.com>
In-Reply-To: <20200313175213.8654-1-ansuelsmth@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 17 Apr 2020 16:34:03 +0200
Message-ID: <CAMZdPi8XnoCiD2OL8dEEG6qtcicz9BM5CrziX4p9_s-UNKk9HQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom: Add support for krait based socs
To:     Ansuel Smith <ansuelsmth@gmail.com>, viresh.kumar@linaro.org
Cc:     ilia.lin@kernel.org, Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh, Ansuel,



On Fri, 13 Mar 2020 at 18:52, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
>
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -19,7 +19,8 @@ In 'cpu' nodes:
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -       - 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
> +                                            apq8064, ipq8064, msm8960 and ipq8074.

> @@ -153,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         if (!np)
>                 return -ENOENT;
>
> -       ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> +       ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");

This breaks backward compatibility and is not aligned with the
qcom-nvmem-cpufreq compatible binding.

Regards,
Loic
