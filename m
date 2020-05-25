Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EAAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5BA20812
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbTArHGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbgEYIsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbgEYIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:48:28 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD499C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:48:28 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 36so5854386uaf.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bQhRpovnI1HzxA3RnCUyYp1wNF/naeL/4Ai5nPC8gQ=;
        b=DbTArHGBvYzYTec6ziZjmrTFpe6aYhI+pcxRwpmCO6Or3WkyytcJTCORpEY6eEIrc1
         h70QUccD228mfZzZ9OnjeQ2HNHcEuVbiFNsKiUSlzfKjDlVmJyBp0ki4+rUaJwHalIhS
         SKxlEpmfGQqcpXvsA1+4RfbqWQvWfdVAnt5Wei23TyCZZpxCt2QODn5eXb8fp3KroBXD
         1Q4bJINZ2BQo/uJOdAnd59RoDWN8kH6XJomKUDJPUL/1tKy2RhkO05SrgwOYGbP6T7q5
         dvy2dL1+89m6+GRKLn7o+9G/Eb4MaRQ9gxmgu/WcbhcjBWohOIk+0HFZpyBih29UtqeR
         vP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bQhRpovnI1HzxA3RnCUyYp1wNF/naeL/4Ai5nPC8gQ=;
        b=t75vdeQXdmmzkB7xKWaNTVctfTnP9JbrweTmZXraeyxWz8foys0QexVr2egJzaU237
         gCki/ES1AWDNb0EAytfqGzp+Tv9HCarOARQ+xy6CskqhjF78pJ2oFq7y8cPwcKNPPb5b
         4PUld6uIjeOToy95zKFGG0X0sYV/vj4pc8+FWfoM//46PsucLAQTBAvNvKYZxO3GIqYx
         toQ2+7EQTa7nHhPWag5jBrT1Q9tmqia8QbO0mJjtc62NjEVa5Nt99u1RlUb/kwzTNVVd
         N46hdrlTZwi02xJtkTkTEJearpiFiOmVgv6ulfeTxlo2gPCjcW6KbAupkj9ac+oMoAWo
         PuIw==
X-Gm-Message-State: AOAM530+q/uKoVWN2uc1IBdf/ltLkWvgxZnOc8ktSanuVaKC8MmZi4Wk
        SvKoYSrtOVaeapYKofrqIUWNAkOZ49J2V674+pXQmsnoqXE=
X-Google-Smtp-Source: ABdhPJzaBYQscuG49zQyyECCXDLU5ZXD2rJlN26+ZR+WzP067eVMWQEhmuDuBjc6B9HyjIvj4ta+JfMi5w0vDffFbGU=
X-Received: by 2002:a9f:3701:: with SMTP id z1mr8215995uad.100.1590396507967;
 Mon, 25 May 2020 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org> <1590139950-7288-1-git-send-email-sartgarg@codeaurora.org>
In-Reply-To: <1590139950-7288-1-git-send-email-sartgarg@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:47:51 +0200
Message-ID: <CAPDyKFqKZbmzpcFJxvD5R4qOc4cKghU7f2pffjFw86bnCN+vaA@mail.gmail.com>
Subject: Re: [PATCH V2 0/8] Board specific DLL configuration for qcom SDHC
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 11:33, Sarthak Garg <sartgarg@codeaurora.org> wrote:
>
> Changes since V1:
>         -Splitting documentation change into two patches to
>                 avoid confusion
>         -For the rest of patches retaining Andrians Ack.
>
> Sarthak Garg (7):
>   dt-bindings: mmc: Add new compatible string for sm8250 target
>   dt-bindings: mmc: Add information for DLL register properties
>   mmc: sdhci-msm: Update dll_config_3 as per HSR
>   mmc: sdhci-msm: Update DDR_CONFIG as per device tree file
>   mmc: sdhci-msm: Read and use DLL Config property from device tree file
>   mmc: sdhci-msm: Introduce new ops to dump vendor specific registers
>   mmc: sdhci-msm: dump vendor specific registers during error
>
> Veerabhadrarao Badiganti (1):
>   mmc: host: sdhci-msm: Configure dll-user-control in dll init sequence
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  14 +++
>  drivers/mmc/host/sdhci-msm.c                       | 103 ++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c                           |   3 +
>  drivers/mmc/host/sdhci.h                           |   1 +
>  4 files changed, 118 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
