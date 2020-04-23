Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479AC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F6020776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoicCEDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgDWTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:42:49 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF2C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:42:48 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n188so3770148ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cR/DJnlT96QNm3NGBIkIs4BIyC/TKIWCroHu/+Ws5c=;
        b=OoicCEDfDDqDhNG5wGJM+kDmecFi3im0xcouX9srn6Kp5C0PeztSGi5HkNIkow+hKO
         WYnldPoZSiNZGGCVNTZtEt4FBKEN5anq17Imx39M0/0NiAoHa1GRQ8Flf/surhgHmaam
         9y7gt6Nq74CSVxUnl3Jo++uuGM/fBfEUcKDC5lBuP/8PFwc9CO7Fek6+Pr+8Djm6vUEL
         vQq/OQUhyF+MXgzgUHCffUsMnkJRp/60wyXV05VLcS2XCjai0sijvNUmkibVxPrl/rBG
         ZjUrG5GRrznerNSda13KNzWCnCobORsGdep6ROspa78jNyQnI3VMIZGneXNEpIDOk48m
         OG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cR/DJnlT96QNm3NGBIkIs4BIyC/TKIWCroHu/+Ws5c=;
        b=XNp9wKSMvQ/p0asQKiqjAuERoCAy3EVQyY5Gq+u+7anhSRjfg9Jw3MejqZm+oJFy4h
         IiLn5f0Fn97d+imYSEX1CCLNVLsNq8xHj0Bkhb7neRztGQ53F49Glc5dDyH9qKz9vimV
         N+D4EWjjeHGq8eW2lJGSuAd3Q21FV0IvR1amrnjQ/oHG/01aUwmjNH1lL8iOZXjiyJ4p
         Ci5nsqC76nIygouSm0eIzXoZIk/mxEr0vzwqwQ8y3n+rYd2X3zzbcN/+lLAwWntBA3Z9
         2Rs8O5LubP35s+qMLJQzxa/3k7SZhlkypihfB4JunwvBpk2V7GjtIZsfiv54OvjZiA+d
         V4sQ==
X-Gm-Message-State: AGi0PubeUWWXhw6ggoJanKQ/0ysmRcUFiA/2IMVNWMijCSZXxvT7VNyV
        r/n85tcKc16qNKSHC0WodPiifN5O1tENo1lxV3ggng==
X-Google-Smtp-Source: APiQypKD0rCF/2YRoTVDdPGpyeEFdCdu8VnBSdmH5/h/9CScA3Ot3BZNq1J2eKOvrnGaJL7WJNjZRn89NRT6vHnGQcw=
X-Received: by 2002:a25:60d6:: with SMTP id u205mr9755331ybb.440.1587670967194;
 Thu, 23 Apr 2020 12:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200423191504.149922-1-rcy@google.com>
In-Reply-To: <20200423191504.149922-1-rcy@google.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Thu, 23 Apr 2020 12:42:36 -0700
Message-ID: <CAAW3YpY0dc-dzW0a6XOWhX-D0JS4xCTNXLobmwvkj35z=q+L5A@mail.gmail.com>
Subject: Re: [PATCH] Add rcy@google.com as maintainer for drivers/staging/gasket
To:     Richard Yeh <rcy@google.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jesse Barnes <jsbarnes@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:15 PM Richard Yeh <rcy@google.com> wrote:
>
> From: Richard C Yeh <rcy@google.com>
>
> After consultation with Todd Poynor and Jesse Barnes, I am
> adding myself as a maintainer for drivers/staging/gasket
>
> Signed-off-by: Richard C Yeh <rcy@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1175fc0aadb..3a61de752219 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7036,6 +7036,7 @@ GASKET DRIVER FRAMEWORK
>  M:     Rob Springer <rspringer@google.com>
>  M:     Todd Poynor <toddpoynor@google.com>
>  M:     Ben Chan <benchan@chromium.org>
> +M:     Richard Yeh <rcy@google.com>
>  S:     Maintained
>  F:     drivers/staging/gasket/
>
> --
> 2.26.1.301.g55bc3eb7cb9-goog

Acked-by: Todd Poynor <toddpoynor@google.com>
