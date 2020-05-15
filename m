Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BBF204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkBlAm2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEOC35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgEOC34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:29:56 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67EC05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:29:56 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a7so237771uak.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JifzVBQeOFFZWECIooC1r1MBLb2LpZu3OhDsGzyQwI=;
        b=ZkBlAm2iPlEcr/Yn4qDW9Yq6BXZNd/Rv6CWBamTR7L/fNW4uy8Bxdam5xyBgH6mbo1
         T9Ggd5HVo4MANHIcEtjG+/EYbItWYAcFGy6VOaG4l12Ns/5lLWeKwxJvDB7zq3rfA+q8
         W+9nwtTERzKqQY51VK5fKIGpSe5CpsH5S4Cxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JifzVBQeOFFZWECIooC1r1MBLb2LpZu3OhDsGzyQwI=;
        b=QhCj8DqGL4VxKX9mkBtBPsJOtY1ilz8NQzRbuRY5IvSmNBTKvULh6XO8aTfhMxIxXn
         o7QpXCF5aacruUIwp+U1ONperr6019iDgAvyGonUkUPrfFV3ejn5zPd/30LLZEe82fui
         qZ8j3uq9H3wp0BnO0RDrx0/phnYwhhrgArTiyvalL2tgg3UsVpzv4Aa7OzeukTk/2bhB
         rkQJol/C8SWzdf2qgnhRx0X5AQo58gqK1TtgPovHu6Y3BYHW4sLfEv6DmMsocTzhUdKS
         lrVGrdEx497l1dI3OUSmcgloezFfIpKtfETOkjFEOXvnX4+X5tOMiMqb0U7Q5EYBu11X
         Qlfg==
X-Gm-Message-State: AOAM532lhtuDhb5pHplxslofW5vzn7kdVzd6i4oQr2TxVXsf1cMVzxnE
        +ympZMxDw9xpNZLIK7gIICINm/4vtZI=
X-Google-Smtp-Source: ABdhPJxpqNU8VzLKmgUn899ubOvABUTke8L/7uAgReFw830n2vF0SkuQm4XHN5QNKz3+1AleLr2Itg==
X-Received: by 2002:ab0:2045:: with SMTP id g5mr1197061ual.35.1589509794927;
        Thu, 14 May 2020 19:29:54 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id y1sm191471vsn.23.2020.05.14.19.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 19:29:53 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id o8so178983vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:29:52 -0700 (PDT)
X-Received: by 2002:a1f:2c41:: with SMTP id s62mr1100387vks.40.1589509792456;
 Thu, 14 May 2020 19:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
In-Reply-To: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 May 2020 19:29:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbcUersNDYK9LQiGb55PUN-HSwxjCZdxo6QqUV=N=UTQ@mail.gmail.com>
Message-ID: <CAD=FV=UbcUersNDYK9LQiGb55PUN-HSwxjCZdxo6QqUV=N=UTQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] soc: qcom: rpmh-rsc: Correctly ignore
 CPU_CLUSTER_PM notifications
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 4, 2020 at 10:50 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Our switch statement doesn't have entries for CPU_CLUSTER_PM_ENTER,
> CPU_CLUSTER_PM_ENTER_FAILED, and CPU_CLUSTER_PM_EXIT and doesn't have
> a default.  This means that we'll try to do a flush in those cases but
> we won't necessarily be the last CPU down.  That's not so ideal since
> our (lack of) locking assumes we're on the last CPU.
>
> Luckily this isn't as big a problem as you'd think since (at least on
> the SoC I tested) we don't get these notifications except on full
> system suspend.  ...and on full system suspend we get them on the last
> CPU down.  That means that the worst problem we hit is flushing twice.
> Still, it's good to make it correct.
>
> Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v6:
> - Release the lock on cluster notifications.
>
> Changes in v5:
> - Corrently => Correctly
>
> Changes in v4:
> - ("...Corrently ignore CPU_CLUSTER_PM notifications") split out for v4.
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/soc/qcom/rpmh-rsc.c | 3 +++
>  1 file changed, 3 insertions(+)

The bugfixes in this series seem somewhat important to land.  Is there
something delaying them?  Are we waiting for some tags from Maulik?

-Doug
