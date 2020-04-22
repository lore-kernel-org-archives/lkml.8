Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CDC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012852075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OroIEo2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgDVKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbgDVKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:33:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59EC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:33:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so756770plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=3XIGZouvYh+rdqKpGPlhY0A3zplshUQshCiuW1z0Fm0=;
        b=OroIEo2pxba4gr0tsT1jLqWC23fjBzJTimQwB9Axn7lbyljR3+UTYxvbK+bg/jfvoj
         zpmsjYAiOtOpvNZJ5YM3mvg129qQ8O6ScLc4x+BupjaEn0Vj2DGRsxZXKhEmj1a3eLYe
         e5DWBvgnCMfhF2tj6u+bWxLeRaIl8bGpgvFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=3XIGZouvYh+rdqKpGPlhY0A3zplshUQshCiuW1z0Fm0=;
        b=Ivc+gDqLChEyExIX0vwu+w8J7d6q+e0Z6ggEudbuJ868rOkkuMDmILHCVLISWEY/95
         UGpWasq5caCYWSi72w3HC3QqJqwfhoqeZP8O8FgQ0+irKh/222TaQOZkZbGOKX/G8GLa
         l58AmPMTjrltjia6lGPaWGcZ6DLifyujQeTYrrmPFZuoYxJa19uSgY894DC5IoYv+kSx
         B5kifPB6fQa6wblHnfqv1NGjIEMhFXeMvqCV4j915GiH0esxdqvvCnAKVb9rbiVt7Gre
         inVv711iuFiMSrOJrM8lNHlEjuDDpC2jDCena3mHVgWeZysW903W5xvXMEp1FbsieKnY
         9aMw==
X-Gm-Message-State: AGi0PuY2ZKBTokKK7W7qX+n6HmscTfGIaFS3GyONyrPcrgivqlqnLgeg
        KFLuaqNyib4faCY2LCG1dwzGfw==
X-Google-Smtp-Source: APiQypLMsLCwNYw2W3WRKMiDhv7mlWTPpb3vt1ZnWuWcCzDQuh+O3OakzilAgwJ3En97vlFAATzJWA==
X-Received: by 2002:a17:902:ba86:: with SMTP id k6mr26705713pls.47.1587551608817;
        Wed, 22 Apr 2020 03:33:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 71sm4959579pfw.111.2020.04.22.03.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:33:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200421102745.v3.3.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
References: <20200421102745.v3.1.I2d44fc0053d019f239527a4e5829416714b7e299@changeid> <20200421102745.v3.3.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
Subject: Re: [PATCH v3 3/3] soc: qcom: rpmh-rsc: Remove the pm_lock
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
Date:   Wed, 22 Apr 2020 03:33:27 -0700
Message-ID: <158755160722.163502.9129728895530548942@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-21 10:29:08)
>         case CPU_PM_ENTER_FAILED:
>         case CPU_PM_EXIT:
> -               cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_=
pm);
> -               goto exit;
> +               atomic_dec(&drv->cpus_in_pm);
> +               return NOTIFY_OK;
> +       default:
> +               return NOTIFY_DONE;

Can this be split out and merged now? It's a bugfix for code that is in
-next.
