Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A831C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A6D24654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GhoRijdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCIXmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:42:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38935 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCIXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:42:22 -0400
Received: by mail-ua1-f66.google.com with SMTP id o16so1201014uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL60yvqP17+87Rab6fvAhdcpzTiQp9Hyy7OzdcPOYHM=;
        b=GhoRijdRaItCIr5f5A+ZVc0Iiqe03XDUV1BOqHP+FAq9KrAxzS07U/WDD+UXQDiAQM
         uhQUfvip86VgSl6LDWkiNDIvC+ThokPCOM7iauHtXgrs/G+7NgvZOo7d5bvCfMD9c0kk
         UCvfmAhqwMJM47jGn681VBMy+caXQQVqXwFA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL60yvqP17+87Rab6fvAhdcpzTiQp9Hyy7OzdcPOYHM=;
        b=jICT07Zttt4wgBK2H44k/JItxKaJOKnnq/iyBYz/A92GKFc25dltuzOWtE/gM47Jls
         /jn/OjaUlSUDWF4IJFe2dx/CIegWcbpIcd0iDM5pdhAMaAjY/Tjs+5/UHAMC+ijTNn1o
         49ywl6GH/xxN53DskgLY1bnbt7bmn5JSjk1LO+7gCsq2X/RcNaS34r9m5UgO+u/Bx+5q
         pqqD1oO9ydTZfIJIhtaxe+UosQtEcac9cGJMRoGtq5jQpiFtNbfAvbcCqvzVQMvQ2Dw5
         D18DHsqljJkgee3R0rYvsKIe0LDBIoMHuhugoOS6EQr9XTlMKqshA2U8HxGp4cxWczI3
         Qrlw==
X-Gm-Message-State: ANhLgQ2U0f1MT0XozwVVWO8y5HzP7+kvlydnnc8RXBU0fiCksUUY5YKE
        B712dt3IYs2D1Puq/y3he6QX4mbaBPg=
X-Google-Smtp-Source: ADFU+vunLklMdJ0Kw/Sxpl0w441d+BNX/Jyhp0qxXcIgzqf0Kp1c7S7r7Af/LsevajzvtSDmDwiIig==
X-Received: by 2002:ab0:2a1a:: with SMTP id o26mr10476401uar.62.1583797339987;
        Mon, 09 Mar 2020 16:42:19 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id k6sm10643053vsc.26.2020.03.09.16.42.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 16:42:18 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id g21so1633773uaj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:18 -0700 (PDT)
X-Received: by 2002:ab0:a90:: with SMTP id d16mr6178141uak.22.1583797338104;
 Mon, 09 Mar 2020 16:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Mar 2020 16:42:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBCaRhnMenyxg3-j2G2xgB9jebhe2pyh=6pzrq=JCbMg@mail.gmail.com>
Message-ID: <CAD=FV=WBCaRhnMenyxg3-j2G2xgB9jebhe2pyh=6pzrq=JCbMg@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] Invoke rpmh_flush for non OSI targets
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Changes in v13:
> - Address Stephen's comment to maintain COMPILE_TEST
> - Address Doug's comments and add new APIs for start and end transaction
>
> Changes in v12:
> - Kconfig change to remove COMPILE_TEST was dropped in v11, reinclude it.
>
> Changes in v11:
> - Address Doug's comments on change 2 and 3
> - Include change to invalidate TCSes before flush from [4]
>
> Changes in v10:
> - Address Evan's comments to update commit message on change 2
> - Add Evan's Reviewed by on change 2
> - Remove comment from rpmh_flush() related to last CPU invoking it
> - Rebase all changes on top of next-20200302
>
> Changes in v9:
> - Keep rpmh_flush() to invoke from within cache_lock
> - Remove comments related to only last cpu invoking rpmh_flush()
>
> Changes in v8:
> - Address Stephen's comments on changes 2 and 3
> - Add Reviewed by from Stephen on change 1
>
> Changes in v7:
> - Address Srinivas's comments to update commit text
> - Add Reviewed by from Srinivas
>
> Changes in v6:
> - Drop 1 & 2 changes from v5 as they already landed in maintainer tree
> - Drop 3 & 4 changes from v5 as no user at present for power domain in rsc
> - Rename subject to appropriate since power domain changes are dropped
> - Rebase other changes on top of next-20200221
>
> Changes in v5:
> - Add Rob's Acked by on dt-bindings change
> - Drop firmware psci change
> - Update cpuidle stats in dtsi to follow PC mode
> - Include change to update dirty flag when data is updated from [4]
> - Add change to invoke rpmh_flush when caches are dirty
>
> Changes in v4:
> - Add change to allow hierarchical topology in PC mode
> - Drop hierarchical domain idle states converter from v3
> - Address Merge sc7180 dtsi change to add low power modes
>
> Changes in v3:
> - Address Rob's comment on dt property value
> - Address Stephen's comments on rpmh-rsc driver change
> - Include sc7180 cpuidle low power mode changes from [1]
> - Include hierarchical domain idle states converter change from [2]
>
> Changes in v2:
> - Add Stephen's Reviewed-By to the first three patches
> - Addressed Stephen's comments on fourth patch
> - Include changes to connect rpmh domain to cpuidle and genpds
>
> Resource State Coordinator (RSC) is responsible for powering off/lowering
> the requirements from CPU subsystem for the associated hardware like buses,
> clocks, and regulators when all CPUs and cluster is powered down.
>
> RSC power domain uses last-man activities provided by genpd framework based
> on Ulf Hansoon's patch series[3], when the cluster of CPUs enter deepest
> idle states. As a part of domain poweroff, RSC can lower resource state
> requirements by flushing the cached sleep and wake state votes for various
> resources.
>
> [1] https://patchwork.kernel.org/patch/11218965
> [2] https://patchwork.kernel.org/patch/10941671
> [3] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=222355
> [4] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=236503
>
> Maulik Shah (3):
>   arm64: dts: qcom: sc7180: Add cpuidle low power states
>   soc: qcom: rpmh: Update dirty flag only when data changes
>   soc: qcom: rpmh: Invoke rpmh_flush for dirty caches
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/rpmh.c              | 27 ++++++++++---
>  2 files changed, 100 insertions(+), 5 deletions(-)

Did you happen to get a chance to test your patch against my cleanup /
documentation patch?  AKA:

https://lore.kernel.org/r/20200306235951.214678-1-dianders@chromium.org

-Doug
