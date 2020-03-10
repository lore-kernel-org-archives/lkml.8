Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0424673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gkch99+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCJIGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:06:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55972 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJIGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:06:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so199590wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=gCM3eKCMkvTlfMY0Veg8oR2cYHpdLigYutHbLkTujlU=;
        b=Gkch99+E0ayd2h/cgebsu59nkW35SijSWHjaOz7+wxlsHbjPr28l5wD8IXvcPyiPQE
         3Q7GJOwurY2DPxY9f/IBMIZGv2j+VUDCTsSn9pv2l23OgTLs2y59SSC6rbOZrkY+0z/t
         GRKO4lu3CfY4tqfHvm2Efy+NU785WgasVawejcJh1HvqfLDPbzQTPdeTWec0XJJI3laY
         SXw0kwzNtJL1O4AoxZsV7unKW8+OJLGavD268cauZEOm5Nv3pSXotiVWQMxheioCZ2Io
         Skmlq6nVr1MvDckVY6LM7B1DLuv2jDgWzQIefp9tGXb4oA49yFb970OMHW6dAM9Help7
         IvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=gCM3eKCMkvTlfMY0Veg8oR2cYHpdLigYutHbLkTujlU=;
        b=nATHk2eiWPHRCAOHLG5Mhicmp9kAWkNdoTIrYUCiMtB2jjxgkzg3khqFI+GNOGg2LY
         4vPsz7qC4/Uh3XM1PkpMUvIAk13Bf6W4x+eUUHXADOgUtW6z7kh338UxJLoSoXvUOW79
         LLLC23543qN2eX+4RcOcEHFAnEmERMCd0fPVo5sJK0GiLi/zXoV+9PVvOkhdnJBWqn4W
         mjOo7dBSe8zI5FUsB7JxVZWKwz01jt+0Uw2nVO+02f/95YdC3e1BEsDqGSl92TJ2Kxbq
         LtgRtaM0SrJJqwmOWFEEp02f2Xo3dD9Dy+cfpbAJLs0m1hfYOP6JAUMuNkKjSZkoxFLz
         VN0g==
X-Gm-Message-State: ANhLgQ2Jj+toM6HelNJ7+wzidJpyx9D+pv75aXf6eyEKUomnjVo/JR4+
        8RGOyaTxenUt83prv+Zd1aByaw==
X-Google-Smtp-Source: ADFU+vv6gQuXKCcdbbs+cb3EKYqX/MrKjKjjgydELO3mqq1Ovc+aG9SUIv2bXYdKkA5RlQnE/H5Bwg==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr808386wml.90.1583827558238;
        Tue, 10 Mar 2020 01:05:58 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id b16sm62295312wrq.14.2020.03.10.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 01:05:57 -0700 (PDT)
References: <20200309210157.29860-1-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: meson: axg: Remove MIPI enable clock gate
In-reply-to: <20200309210157.29860-1-repk@triplefau.lt>
Date:   Tue, 10 Mar 2020 09:05:56 +0100
Message-ID: <1jd09k4ot7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 09 Mar 2020 at 22:01, Remi Pommarel <repk@triplefau.lt> wrote:

> As discussed here [0], HHI_MIPI_CNTL0 is part of the MIPI/PCIe analog
> PHY region and is not related to clock one. Since MIPI/PCIe PHY driver
> has been added with [1], this region can be removed from the clock
> driver.
>
> Please not that this serie depends on [1] to be merged first.
>
> [0] https://lkml.org/lkml/2019/12/16/119
> [1] https://lkml.org/lkml/2020/1/23/945

Series look good. Will apply after v5.7-rc1

>
> Remi Pommarel (2):
>   clk: meson: axg: Remove MIPI enable clock gate
>   clk: meson-axg: remove CLKID_MIPI_ENABLE
>
>  drivers/clk/meson/axg.c              | 3 ---
>  drivers/clk/meson/axg.h              | 1 -
>  include/dt-bindings/clock/axg-clkc.h | 1 -
>  3 files changed, 5 deletions(-)

