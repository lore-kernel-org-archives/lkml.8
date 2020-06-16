Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43C42071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVXqvcoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFPMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPMAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:00:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903BC08C5C2;
        Tue, 16 Jun 2020 05:00:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so23202403lji.2;
        Tue, 16 Jun 2020 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSDz1CcTlXHevMdT17dfagrIIYP8BvIZ7bez+W8TR/I=;
        b=oVXqvcoYIkCXNR7wL6n3vOVqa4vsvz555GXgN3SvQbk++DqCfyY3ihS6C44FTj/1l6
         oxmN6rQSl/0N9Rs3GD1cLcFTRNOKZVrFi+4MTLxT4A2/TIruex3OouFYhG8DGyT0KOei
         Egd1CQ9keFWRBVCIckvgZJkqKf+CloQ3UDJ82KcY8QsjVL5gnReCpUBL/e/CbpjQs1IB
         8i7oNBfAdR0pwujcU3YFsnbfNvsFqW8GB4um9FicmqKBkBg+cjmgG00mhPHH06pjiOMn
         Yh7v9I+PaSONtPPasNP/XArF6pxddi6OvJDr7wTny6RMQ7M6/XNYqeMBP+Vd+B4k5NLy
         MlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSDz1CcTlXHevMdT17dfagrIIYP8BvIZ7bez+W8TR/I=;
        b=Ec6xqW6fCdV5BRUROYAof+dWucvox0XxNn1JOZokn7nFsqD+r1lDqyEBRFMZ/G+Srj
         QL2m6+fXLxak2r6TERz0a1SVWrvQQQLSEJ7/OI41B53gthOgJDWTtZQB7tNETMUPc7j1
         eV+T4dZ5hB12gacpr5ypIZToU2+P96MggM4Yu/vFx2aIPtOT2nEr880ESKYNZNiTfdcF
         HISCWlhCF9421z6gLifIgWexHZxMJUmn85rzUx6JZOYtCRxHIzN7ZaqOqE+rLggOl0uI
         r1I/3OPn01PPEbDnX4fuRVVx8D5AMNaJKDT9ExkeW60FiYJh31v1Ms9I070qjAFt6ld/
         duYw==
X-Gm-Message-State: AOAM530S/pBbXTp82v2wm/Mp15GSDNxGvfKEFc9znFJ3DSHuUE96Remb
        VNQfZj3uQgxFT48zaPTk6gM=
X-Google-Smtp-Source: ABdhPJwuQbHaMDqXb3iB07dLDs9sxQLsnHPublzf3ks7pGsQG6s9Bp48XpLM+JQKBc+w1SQqlJh7Iw==
X-Received: by 2002:a2e:98d4:: with SMTP id s20mr1343979ljj.83.1592308850862;
        Tue, 16 Jun 2020 05:00:50 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id i22sm4343234ljb.21.2020.06.16.05.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:00:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20200614200121.14147-1-digetx@gmail.com>
 <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e6b50ec8-08f9-a15e-6aa5-2ca306613e97@gmail.com>
Date:   Tue, 16 Jun 2020 15:00:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 01:26, Emil Velikov пишет:
...
> Although I see that this series, alike Derek's, has a couple of issues:
>  - only a single panel driver is updated

I'll separate this series into two patchsets.

One will add orientation support to the panel drivers and I'll include
the Derek's tv101wum-nl6 patch, so it will be two panel drivers \o/ :)

The other will add reflection-x support to the Tegra driver.
