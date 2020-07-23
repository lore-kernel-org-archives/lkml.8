Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCEDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C750320657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OEO3pmmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbgGWAum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:50:41 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89357C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:50:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a32so3290224qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfIoTfjDp/a91mgOibnM3a9UrKcF4+o+S2eOslmkg8E=;
        b=OEO3pmmEfq4/SKd0FWCE7+iZPd4LVACjD478+0w6qx1vQLHw2eJbiBlUl1ku0MMAZ/
         2s6MiITA/m/lSINCALdyo8abHhuZMtqKZMo6WUh2QeHECmTo25xIHamXmOICzzkZuASA
         WoyzSzQwI7wr7nmBONpQ0D51bYrLaI69bhAlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfIoTfjDp/a91mgOibnM3a9UrKcF4+o+S2eOslmkg8E=;
        b=IoI5tv4zOg20ctYirNiPtwmYT7pftRqRlv87Z1De8l6jabTtlgaYhXpR58CODOVaO9
         3ASkpaS/71zSTlTga/bONOBqyV7oZYYIFT1KYzOm3zOhFuKl910FDGW36vf+3FYMtFs0
         Eg0isXOf9KaLp/Ab7Fa1pajn2Jl2wfYlY8omTIV8TapY4pAiDWO88tYiqvm9w9bMAdaa
         cSMX4C+r27hzcRt1lgi+AftRtoHnODXadqLMZ91inBSViMFPZs3UI2/pKgZeQfWZ8TRJ
         B/8Ho8cIcUpBkoajIJdjyLQMu1Vm3A04ZtaiEnt7wsyk8GDRr8RyubhxtBxBYDkBRvVp
         PWrg==
X-Gm-Message-State: AOAM533Vf6ZeA5LVoUAFA8beey3CQnybhWt2c3j+NhmALbQ/buzT/MeN
        JV71i225UeTiAUMmj8VAmbs/rDNvq2Q=
X-Google-Smtp-Source: ABdhPJzWL9YJz4tHBixBdOPcXS1bb3abMUAwf0DrN2nG5obLvFozcAyZYx43Y+CyddlyEZob1PMkig==
X-Received: by 2002:ac8:51d3:: with SMTP id d19mr2004001qtn.151.1595465440338;
        Wed, 22 Jul 2020 17:50:40 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id c133sm1405319qkb.111.2020.07.22.17.50.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 17:50:39 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id x69so3931850qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:50:39 -0700 (PDT)
X-Received: by 2002:a37:68c1:: with SMTP id d184mr2806642qkc.62.1595465438712;
 Wed, 22 Jul 2020 17:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
 <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com> <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
In-Reply-To: <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 22 Jul 2020 17:50:26 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPbnqRbw9EpTQ5uWt1ALh6h9dqggrEusXXaAOp46dp+Ag@mail.gmail.com>
Message-ID: <CA+ASDXPbnqRbw9EpTQ5uWt1ALh6h9dqggrEusXXaAOp46dp+Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 5:43 PM Brian Norris <briannorris@chromium.org> wrote:
> unless I got
> refactor cros_ec_get_host_event_wake_mask() to use
> cros_ec_cmd_xfer_status() instead of send_command(). I'm actually not
> sure why we don't do that, now that I think about it...

Ah, that would appear to be recursion (cros_ec_query_all() ->
cros_ec_get_host_event_wake_mask() -> cros_ec_cmd_xfer_status() -> ...
cros_ec_query_all()), although that could only happen if the first
cros_ec_query_all() doesn't initialize 'proto_version' to something
besides EC_PROTO_VERSION_UNKNOWN. That is only possible if the EC
reports '0' back to us.

I might skip out on that particular refactor for the moment.

Brian
