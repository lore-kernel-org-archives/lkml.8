Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D76C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517F6206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTj0IrJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgDHP1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:36 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37009 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgDHP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:36 -0400
Received: by mail-pg1-f180.google.com with SMTP id r4so3463626pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pDvcotqin9MFYotH20Ddvllc4oEen5KJQtcAktMMZs=;
        b=KTj0IrJ2HYAK/59HA7DR7goXWRl3VWt+FPwtTBivhZGMOp5zfVeZ5FfDBBCByd5HJF
         8y3lJWN/RC/xvlHZ4yDlKm3DAfqcRmuaryIa+n/7T4TZfvcTl/rjq3WRQ21OFXlh8HZ1
         ALUtiRUJPWuVq7rJHIiMWgZCPemzlXjOqYQhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pDvcotqin9MFYotH20Ddvllc4oEen5KJQtcAktMMZs=;
        b=OqCLG/rRjxR1IInGzxMFPZAJAHqOEsTqIBjBKxHxEC1F0wkyn7/2kJ4OkHDLDOFah8
         VqBazf3C9LsF4GShFMgeCqud9Gho40QLmMTEi2F9xMV89l+ny9p7d9uZ3j0n1MP8LNHo
         GTQps7nDmGDNgdOdmmo904C+Ty232De4A31PHiTlnkyHBdt86Z5ayedf0Z3GOu9+bQ0E
         ZvOoCBnIIAAj+mxb8wj3PPGko3fDFDuEZMiRUmn69GulUlaP6/H+eyLI5U/zmKcOn+Rj
         mqklm1Sn/L22hcbQAJ9iWL3GdYct+wJLpOAWZGE3kt707+gb3CvY4ouvknlLDTSEOTiC
         x/uA==
X-Gm-Message-State: AGi0PuYclGsMSRxDlZIU5ZhTVdylZU06eK6pZe6IZxciJ7WC5U2oHqOU
        kPnEt93565vwh+xr6pocueZQAN12kh4=
X-Google-Smtp-Source: APiQypLONBSrUCK2/91ybqycg5zloxXs3oZ/ZGUxaVdqzvgY+i+p9txzzbTVWhUz3ovZsCUiGCitZg==
X-Received: by 2002:a62:64d5:: with SMTP id y204mr7830184pfb.227.1586357918702;
        Wed, 08 Apr 2020 07:58:38 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id l62sm15807793pgd.82.2020.04.08.07.58.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 07:58:38 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id np9so103414pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:58:38 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr6540930vsr.169.1586356481775;
 Wed, 08 Apr 2020 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
 <1573220319-4287-3-git-send-email-ppvk@codeaurora.org> <CAD=FV=WGUasS=UZxFeSS0Cg=9WxHPMWVFyYae7CFmOxV2_yhJw@mail.gmail.com>
 <001601d60da5$630168d0$29043a70$@codeaurora.org>
In-Reply-To: <001601d60da5$630168d0$29043a70$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Apr 2020 07:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR0YBp7ah82Kg7RzxHdO8Agf5uGNb=58iApShXqbum=A@mail.gmail.com>
Message-ID: <CAD=FV=WR0YBp7ah82Kg7RzxHdO8Agf5uGNb=58iApShXqbum=A@mail.gmail.com>
Subject: Re: [RFC-v2 2/2] mmc: sdhci-msm: Add support for bus bandwidth voting
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        linux-mmc-owner@vger.kernel.org, sbhanu@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 8, 2020 at 5:58 AM <ppvk@codeaurora.org> wrote:
>
> Hi Doug,
>
> You no longer seeing this warning stack with the latest patch set.
> https://lkml.org/lkml/2020/3/23/407
>
> The latest patch set is based on OPP framework and no workqueue's used to queue the work.
> Can you give a try with the latest patch and check if this helps ?

I was only analyzing an error log provided by someone else.  I will
let them know that they should make sure they're on the latest patch
series.

-Doug
