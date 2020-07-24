Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B698206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRj2aH9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGXTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:39:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB997C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:39:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so7710836qtm.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TazZGQrAsCLiIWrPwT1UZAvuWoCuwXngNJMrqeGcsEg=;
        b=aRj2aH9eTJKXki7tXIQj2wajIeBCsKvgdAqOvF30BEMCCePzME/VixPBw/RZQLWKui
         fpt3XR70XHRkqXuGoIj2qnAuO3UgH9R2b9vssreaoVpVUeCNuYDn1nPdj5U3MSZ5+RZz
         tTxcpl6dpsVlCf467MqZowiVnO2dLpurd1OOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TazZGQrAsCLiIWrPwT1UZAvuWoCuwXngNJMrqeGcsEg=;
        b=X5DtEy4zXxprDEETGPJWxKCgZiq5YK40UMq05nS21Gvim1CVMNlBNcYXYp4JVKxmEG
         iTL1TXs8u66drDllDyhOZNIjpATL6r2MXFfBVQOhmgo1TRdeDNjxACUfmYR1iJPUwc+0
         Rl/OG3UwajeGYWzl+Dp4Mq94sFr2US6VPR9qcarSMCbD3rCuo7OeORG+h9N0lkc8ITwP
         V0x5FqXQQ6/5MHIwKAX9AWtdjaSQyILLgiGD+7dOu3Or0S8KhnSciMKBYJMu+HdBAHJB
         Btw3fiznwTmjBu+Hj+ECMZ8b3NAR2R0WyNdgqnAwv86NOb6GuI51FWdJyyZRFUbvTCvD
         LI+g==
X-Gm-Message-State: AOAM532wdMNsBsW1OTigSS4M6e/CeWBF/2EnAuZsnOad8ADynPs3aUZB
        hobzhpdSyRcMo8gy6sh2Ag4SlId/Lko=
X-Google-Smtp-Source: ABdhPJzKBPsJa+i5eNf1O2SX93/OuMqR1OwaxbrvnyAitbk+CvuPKPuyHPD9UGPfPxRSOphrw1CUWQ==
X-Received: by 2002:ac8:4f4c:: with SMTP id i12mr11180801qtw.17.1595619570722;
        Fri, 24 Jul 2020 12:39:30 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id f189sm7259019qke.15.2020.07.24.12.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:39:29 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id v22so1819291qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:39:29 -0700 (PDT)
X-Received: by 2002:ac8:4247:: with SMTP id r7mr10177571qtm.213.1595619569159;
 Fri, 24 Jul 2020 12:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com> <59657973-cdef-eaf2-47f2-368205015750@collabora.com>
In-Reply-To: <59657973-cdef-eaf2-47f2-368205015750@collabora.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 24 Jul 2020 12:39:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOWYkhrQJvQDfg89t1X20Q63MXt9c+MJQcfdrsV1VirwQ@mail.gmail.com>
Message-ID: <CA+ASDXOWYkhrQJvQDfg89t1X20Q63MXt9c+MJQcfdrsV1VirwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:04 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Another thing that we can do (although this is specific for you and doesn't
> solve the problem with people like you that are interested on this), is add you
> as a reviewer in the MAINTAINERS file. The CrOS EC has a lot of subtleties, and
> having more ChromeOS people involved in the reviewing upstream is more than welcome.

I'll think about that. If my lore.kernel.org searches over the last 4
months are correct, there's been about 50 patches a month, which is a
bit much as a side project. (I don't regularly work on EC stuff these
days.) It still might be better to subscribe and filter on my own
("opt in"), rather than pretend that I'm going to pay any attention to
50 patches a month.

Brian
