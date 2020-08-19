Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399A320738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4OABwUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHSGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSGTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:19:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6FC061389;
        Tue, 18 Aug 2020 23:19:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so16991912qtt.13;
        Tue, 18 Aug 2020 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTOKvcFNffgh/XzBfPa7Smu/OsUcNaV4MrEtw+PeKw8=;
        b=U4OABwUfl5r0xz0P3olTASnqrUy1QbOG4JPZtgzSWmplzqvHjUUHzAvuJHaPlXgKFW
         uDW4xSarAGEbm9ep3R0GxXfTBGWdF9awWNrnhkpLPVSHSunFJcAnYCOQJu+u+QzJXu1v
         e/BKCu80yrGIQUxXLwjt+cL2dZcuNSUbyY82e0Wn668miC51pZg4OYGpwBsMViXaRFAW
         GYZuvOcbW5kD8flgBne5MhA7BFivUqrjP1SgLYP+Gu2BAqYyAJOujIDhPNc4dtjfxpNP
         VD8Yqvsg0HgYNcjZGtnS4+RKJXHSAkWaaUPJ7AXR4WvZ0iV2gesZY5WOPi0j+W44FfZM
         KgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTOKvcFNffgh/XzBfPa7Smu/OsUcNaV4MrEtw+PeKw8=;
        b=MZ8h9UOeERcuqi1YvlG8c23Tef1LiE2tQLYe69NlLbyIiwcrxd74c4jXelXblxEDlX
         8C4yuKEAgw22Acv9ADdik+LloJWvF6wpodx5X/15LcYsTOY+rJGSYudUxsj6wGbXm8kb
         p9B3YTiZo3oN7cJyV4rSf8Xh6l3BYxub+TgYbpZpGUCjD9s+rWV3eVckQy1IFF6J7XIu
         Qi4MS4OFRn5ABnAWPHmv+ybkxcahaNI18BT/GLKJcEE3D0zZzfSn/emuPMdojqrtYMKn
         8sRFvhXL/A1NAjKXojr9C/DyGPWPnX4sQQrPb8PcjV7K3EZ+uOTHN+ihE98X8DQQgQ2/
         Q+AQ==
X-Gm-Message-State: AOAM533ih4RtjW3jxqKBGP50lA5LHu8DijYzkCYP7aOMlOmNDmzr3FQi
        5mwfztFBM1QMkFaHKpRgc56oXLEAq6kc02cgfM0=
X-Google-Smtp-Source: ABdhPJxqpOhvykIzgNwcc1NKVNmWwbtm0b1WkwrbYXj+e9AS1W+FFMjjvPTr6GC4iA8bcJfzkRJbQH7RVCJjBsh+Qhs=
X-Received: by 2002:ac8:6c55:: with SMTP id z21mr20944550qtu.68.1597817958514;
 Tue, 18 Aug 2020 23:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200817070009.4631-1-krzk@kernel.org>
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
From:   vijai kumar <vijaikumar.kanagarajan@gmail.com>
Date:   Wed, 19 Aug 2020 11:49:07 +0530
Message-ID: <CALLGG_JH1Stak6-V3bFQMOqeg6oKWqqDNy8ZKEF5ARKdac+jzQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer have the setup for testing. The changes look good to me.

Reviewed-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>

Thanks,
Vijai Kumar K

On Mon, Aug 17, 2020 at 12:30 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> Changes since v1:
> 1. Mutex unlock fix in patch 8/13.
>
> Best regards,
> Krzysztof
