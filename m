Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B479C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758702089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIfUhviW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbgE1SES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391258AbgE1SEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:04:14 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86EC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:04:13 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c17so9976668uaq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ5JUbesFirtJBWiXrChM94Gcp29UpeOFm8d91owft4=;
        b=UIfUhviWUXDEoXbz7ZQDKkdfO/J2eQ9XSxx/Qyz0FLsHjcpXdf/Elpazpv43+tXhzo
         K7JCq6APujFDLwjcLlBmcszhY/ZAabhEoiY8upljd9o2rs1Lc3o2XafHBBKB1AtJ+Cb7
         8Injbxv6+vYbHWy9Wgd/8oDsXrJ83yySnlYQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ5JUbesFirtJBWiXrChM94Gcp29UpeOFm8d91owft4=;
        b=EOhP6/snchPCK1THPuGNGKHwjn3r82VqXGv7Xp1v9TeirUroKUC6N+4WoNlIxax3xM
         LpizqkLAJlJz1gvALqAAnyjNhLmYXfIsSOWa9+IuPCXxmB6PN7ojX1gWXaCr+VM21BrZ
         fAPYvEcUZ4HmNB/0rrnjRFG5mwQ5+e4Z2HVUymphB2D0Ttk3J/450CaHX1iYIUhobh38
         FIQ2GRYAGeqxsFVMTdzvMH6KRY/Danp1RMMWw8CIfLIq2WKVXP7FDzsgBXajA5NVHqLq
         WfrtBnkoN245tFfVC+N8lw6smrPChaZ5/4JWeDkXQVbsVw0FmfyxMAJi+LBFEX9kzYyn
         teKQ==
X-Gm-Message-State: AOAM531LIh3gXSgvKfYDNIp70KRLMU9VfVFJNewFREXN4WsbEmS6j4em
        GI69abJqs1psColbztNmWst7bWTSyo0=
X-Google-Smtp-Source: ABdhPJypxmbNGwClF1CJhVwkVnhEFEn75Y0y9ADEEXvR6yTHIH2JbUWre0TEGcW97RSbx/2+DZZeRQ==
X-Received: by 2002:a9f:23e7:: with SMTP id 94mr2955540uao.84.1590689052408;
        Thu, 28 May 2020 11:04:12 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id j24sm606600vsn.13.2020.05.28.11.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:04:11 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 21so6971164vkq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:04:11 -0700 (PDT)
X-Received: by 2002:a1f:a24e:: with SMTP id l75mr3226940vke.92.1590689051355;
 Thu, 28 May 2020 11:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200521060425.24285-1-swboyd@chromium.org> <20200521060425.24285-2-swboyd@chromium.org>
In-Reply-To: <20200521060425.24285-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 May 2020 11:04:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyT+opi5hgtmfKQ9gSs0FWK0W=+uHdPv-mJF2MTHQS5g@mail.gmail.com>
Message-ID: <CAD=FV=UyT+opi5hgtmfKQ9gSs0FWK0W=+uHdPv-mJF2MTHQS5g@mail.gmail.com>
Subject: Re: [PATCHv3/RESEND 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 20, 2020 at 11:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This API does very little. Let's replace all the callsites with the
> normal operations that would be done on top of the bitmap that
> tcs_in_use is. This simplifies and reduces the code size.
>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 59 +++++++++++++------------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)

Sorry for the delay in getting to this review.  Looks great.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
