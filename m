Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E479C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027BC2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+Yk5UsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgCDQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:00:31 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34374 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgCDQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:00:30 -0500
Received: by mail-vk1-f194.google.com with SMTP id w67so706222vkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqEs55y4dEw5uRAexZmSkf/N7GxDvacFCfzXLumfPhk=;
        b=T+Yk5UsXq7hnVU0JjnMyTsBDjOuUJFVmT8YM7D0B51N0UZCTVLldZ0uTHWY2NX0wmP
         K8/nKQdhdrrW173wgG+t8GgRNOcM1LrjK22agARS/gkJaRhmZAE4xUtS3xP37JDWTITE
         OUGGD5uVCJJXMUhB+NUPrmsyBnhPeGPpopfTODebAUmbnkR2XWQAdTnTuSDQ7K9WMS8v
         I7BqvtLfMPtFfg+qcZ2gHB2RRjNmV6zG6HVqlDxQMTO61Z6oPyBJLtC08tLSUgBhzrs3
         l4iJUufZ8exJmMweJO6TKMhvJhpSvQKu/eX32eU9iXl3TDfax6nMDGSHOTdTsi3yPCMp
         Xd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqEs55y4dEw5uRAexZmSkf/N7GxDvacFCfzXLumfPhk=;
        b=H2OehfhEZGt9aUABrbze1oZHIQyjMFUX0B7SB4JcOhgf92JflesIg19085yLSUgMBm
         siKr0ds//nL+upoDUJL0LTSbjteW6tLpMY2XLqzXYuCmSrTUs5qB5n/nnuJeUgjRsLed
         LFx7xkWrmhSsxT9RCIpGe6+3JsEOIPAPVKJHTX7UzrbzwkEwRXJFC+lV2dDwfq7Au279
         c9sxH45FPgr5HWA9RAd56d4Mcs4HrR+/06eBL/l/3XUbIxTeeS6cP37A0zV12jhNQxf2
         dIvkVCBq7ExjRbftGps1dO31+sQj9+CJrWK12cwVfWBY5pRclDvTbnJQ+f1YSmxey4+M
         epqw==
X-Gm-Message-State: ANhLgQ0w40EeOF3K44extl/esBUz1g0WJVmdT7SAI+IuBtrTbKYWUjMi
        a6cvh3S998vEMrwjRVkEY65IJomBu6Bi+C3VV0SOOQ==
X-Google-Smtp-Source: ADFU+vvDe6AUVq7FvlD0Zl/y/Oj3Ne1SZTjBontrgT4tGULO92r4fXatr48O/ebUZw7D/ayIYX1ZG9T/mmjQx4yXLIY=
X-Received: by 2002:ac5:cdcd:: with SMTP id u13mr1841139vkn.0.1583337629345;
 Wed, 04 Mar 2020 08:00:29 -0800 (PST)
MIME-Version: 1.0
References: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org> <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 4 Mar 2020 08:00:19 -0800
Message-ID: <CAD=FV=XKFa3vs5Fv0DUwYLF8o4s8cCAsSudYGMn3XZ73wVoOdw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: cqhci: Update cqhci memory ioresource name
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 4, 2020 at 5:25 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Update cqhci memory ioresource name from cqhci_mem to cqhci since
> suffix _mem is redundant.
>
> Only sdhci-msm driver is making use of this resource as of now.
> No other vendor's driver is using it. So this update shouldn't affect
> any other vendor's cqhci functionality.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
> Corresponding binding change:
> https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
>
> Changes sicne V1:
>         - Updated commit text expalining this change affects *only*
>           qcom cqhci functionality.
>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

...now I guess the last thing is the dts change...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
