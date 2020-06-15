Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D163520656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGtDqsqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbgFORNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:13:24 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7216C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:13:23 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id u15so4109045vkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rf7CL3fcSu5+k2Trl+OBC0MyNMMzie2yNiD78p0muS8=;
        b=bGtDqsqdSjPjpiGYMLfCNmu3n84+4VDe7k+/FPtwYOiUSt1/qRT8ZL44Orm74WQs5m
         1ILGRUY54Rim/0iEJvmoYw2qEddkH8nBtTEQkAAbh4B1VzuiQGwGUiPiGQQ+sZC8sy5P
         Ifi11tJe8Kw71dYh64pCdIoQdlI2kojL0DhWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rf7CL3fcSu5+k2Trl+OBC0MyNMMzie2yNiD78p0muS8=;
        b=Li/0b9yHNz3T3HfdhVFdoGZiLe5OKcMMKzGa84TP+B1DGCkrbHdaY7pApuOXmRVQc+
         VWt66i2gK6rf7kw59CXqoi0bw8OF3vAHhx2/1/pKsch1HuK7Ssvmwhl7GJO2RdU78E9S
         +9uENTnfy03cdD3bURJ59CE6OjW2erTzIRDMCYZxRKHNcNHlOPFsyAQQVBt3YaV+NAfd
         DS1R6e6wTsfdigYMgG9GGGmmU542t0cyGvA+R5dV55+gRUvT4S1PieNVKFEoNXe/PRVg
         ae2J4wyJdzzu0SgJ7AAl0Gvu1Fx7VmufNMIfaKHb3FsBXMd2QCPI8tP2PTaAHxMd1I3x
         moYQ==
X-Gm-Message-State: AOAM532qcFqfGH50DpBoBXgAy58gIghQWNu+oCKNjHR0Ijhl6e+7ESvR
        vL0av0sgCifueDSmslPre6cCcUObBM4=
X-Google-Smtp-Source: ABdhPJzlGqRSYtzG7iRGLwrhcYUGb8QCPhwDrAARgN5lDVQzlzD+kDNPHUUeBHUnd5BH26gN0yraPQ==
X-Received: by 2002:a1f:430a:: with SMTP id q10mr19025436vka.4.1592241202143;
        Mon, 15 Jun 2020 10:13:22 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id i203sm1051604vke.7.2020.06.15.10.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:13:21 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id 190so9767689vsr.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:13:21 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr21432512vsx.169.1592241200678;
 Mon, 15 Jun 2020 10:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-3-git-send-email-rbokka@codeaurora.org> <CAD=FV=XSfMPehyCLB25hct+GE8JtU=5J=04KyU4AoHfg9cs50A@mail.gmail.com>
 <472dc7d7-2e23-0f1a-8e1a-839c4c9c1f7a@linaro.org>
In-Reply-To: <472dc7d7-2e23-0f1a-8e1a-839c4c9c1f7a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 10:13:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VjgxvtwZVkq8nXRk_6aHDKQOGp3wp1YJBbsG=BZhVcKw@mail.gmail.com>
Message-ID: <CAD=FV=VjgxvtwZVkq8nXRk_6aHDKQOGp3wp1YJBbsG=BZhVcKw@mail.gmail.com>
Subject: Re: [RFC v2 2/3] drivers: nvmem: Add QTI qfprom-efuse support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 15, 2020 at 3:44 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> > * Reading should still read "corrected", not "raw".  Added a sysfs
> > knob to allow you to read "raw", though.
>
> We could create an additional nvmem read-only provider in future if
> required to read raw!.

Makes sense.  For now module parameter (which can be tweaked from
sysfs) seemed like at least an easy to get access to the raw values
for testing.  Other than for checking that the driver works OK,
though, I'm under the impression that you should never read the raw
values back.

-Doug
