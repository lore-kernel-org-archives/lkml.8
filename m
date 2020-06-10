Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497DF2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLtjgtJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFJIsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgFJIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:48:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05717C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:48:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so985087lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tv9cLm6NrVEw+od9yE+yuCdvd9rQx1UMp3tOwcdNQ6A=;
        b=xLtjgtJ8Kq7VuUa8BbXEMYn+JDvsxigXSI5oo/wg1liD77Uvva30qb+Ue4DnxHtjam
         Elme55spXBwYx5CgDUeaml/cfsQ6LUZao9b16LKSlvxj+G3XM/yuoK3udquOLtevy+Er
         X3e38FLE+ZpA/4fIR+5OQTAwQDmiPRijmpAsDwGyCr0J2LItdBJDDaL9eH4cO7INk82q
         u6yPzASpg7nLl0pPg/QrXZEHd2naQGjDOEtaT7FGM09+z5sv5CgiZyW/HS6BA2EFJCjC
         1pPLZYV1z1UzaBQ6SXSQSAssU+Xs5qrn40m2JbMhlQUjEky8+UyVJs07RaE5BULZHY1c
         Swrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tv9cLm6NrVEw+od9yE+yuCdvd9rQx1UMp3tOwcdNQ6A=;
        b=eds42c7DXqTi8wSOS/R7hMYoKfIfXEB/3ox++Cm9AZOa/kkoOMrYETTmGkOWh6b4da
         U5OXmXHz5Hl5NlpU0SiMGAXnPxUx2I9s0CV2e7ZPBbdKEd93xi/FdZ/BRqErAc7DGBEo
         A41EbWQ63o+v//okO7MsSxSxlWoeo2QtcvH0jweT703ctZy8CO9OFeYQIW5jxnK5ZKOc
         cDD+GqnuCzagyiSIBjp27PBmcQTGVy8I0zhgGR7NFwNpJjGb1dmuoj9SpmYJOsKZ9fut
         eDzpiVo6Ok3cdQNzfqAGF3ZPAvVPxi8cs3vf71YR82Gw1Y40zORvMLBBm5VqGYtgcD6f
         i/iA==
X-Gm-Message-State: AOAM531ukh/2GeK0L5QW1LUFs67VJkZxr8CHSCT1OdYGhOf9Rfp3naCj
        kEQXW6zopmdVnUd7Y2DoGChFKPXem/PQb/Yc9I/EeQ==
X-Google-Smtp-Source: ABdhPJwB1YdVqyxgQzEn1jME2RfkT9tqX2deD1Fxk7xDGiza8EgLMKE2iE1rVqr0cl5GGteUcAmL6g68Mcu61Hc88ho=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr1123126lfn.77.1591778882313;
 Wed, 10 Jun 2020 01:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200604174935.26560-1-vidyas@nvidia.com>
In-Reply-To: <20200604174935.26560-1-vidyas@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 10:47:51 +0200
Message-ID: <CACRpkdYnwYFr2NEfGmCRYCEr7J0fdT1L5jkuPrkPQGJmudMgJw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: tegra: Use noirq suspend/resume callbacks
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 7:49 PM Vidya Sagar <vidyas@nvidia.com> wrote:

> Use noirq suspend/resume callbacks as other drivers which implement
> noirq suspend/resume callbacks (Ex:- PCIe) depend on pinctrl driver to
> configure the signals used by their respective devices in the noirq phase.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Patch applied for fixes.

Yours,
Linus Walleij
