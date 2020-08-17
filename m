Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF45C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C30A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B23vGSGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHQIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:03:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5468C061388;
        Mon, 17 Aug 2020 01:03:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so16629070ejx.12;
        Mon, 17 Aug 2020 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8lJJFkNRM2mQ3INesc1kxCJDj6B3uCKl4u2j50ADQI=;
        b=B23vGSGevzfNv6EF5eGEsL3A07/GM4LHEFYJBmoc/pci4MN7xgXY7FhFpWDvIcyVMg
         Z4Y4G33DK2CpADFyUcwWKvJuqIZoEWIBVv4OqsbxDYwcpGqC+ShrfYwaZv0wfjUwRcyu
         zJJVlotVPXyhs+sbkvZzo9M/wC/GnRRf5/fIgzwgw4ZO9GVpezuV+1sDOvYUJQsRlWdP
         Vf+cI+xzg2TGV/0I7w44NF9jMpSOj9sB/ImotFy0etwmA/nCMBxX0a5giVSC7mbZduk0
         NWQY488zfXCVOSnoGaL2dyOY9FtaTgEjDmpj8LI4HvWucUQMYKRdtpiGazC0+yblHHAK
         WWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8lJJFkNRM2mQ3INesc1kxCJDj6B3uCKl4u2j50ADQI=;
        b=szUTx3W1FKTBw/5vlIl4YTD4Wgf4KHBlrqXm2BSN3SIzzGEnZfgufzlmIQ6rikQELX
         rtd4c8g/RDl2d4x5wtpecfNlq8VSp218yHa4uJvqs3eSsZDf2+7t6SWKnV1OxW/EdQIY
         9Fz32FIWk4AyWilKRi0t0bynSZfEJLNJH1+sgoUXv+YNH97uclleAa96O+xGNci7mpKg
         Z3eMDs9NvLNFEBBQAHV7mmh1awVi/tDijqw31IZJ/Mmf3iJFxRzG2La+cRHHfsA5pHx2
         omnfelxbRLFgRUgm8/WLeXs5+NBJtBX31tzjG1WnfDbtBYfOMLQC+Ma20uvHyeHaCvcm
         86Ng==
X-Gm-Message-State: AOAM533GOqhnJmcngkHOTKXw8Nje0+JvklUig9eLACnnDx+UEnu57jCv
        V5q/lWb4eAWJaJApNW0eXKnZUkkNHAzjcV/pdnw=
X-Google-Smtp-Source: ABdhPJw1PoPe50YgkrFDTydqp+gNYUWa8xEe+OyOLnYkr36LYEcsyxYKHbDSId6sHC89UXnZQsn9ev13HE+oTuTieu0=
X-Received: by 2002:a17:906:c18d:: with SMTP id g13mr13687290ejz.239.1597651427657;
 Mon, 17 Aug 2020 01:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-9-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-9-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:48:42 +0800
Message-ID: <CAA+hA=R2YOncsOPXMaQ8TkJJLRQXf2TJyozdAMUF6U3Bnhsj3A@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] clk: imx8mp: Add audio shared gate
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> According to the RM, the CCGR101 is shared for the following root clocks:
> - AUDIO_AHB_CLK_ROOT
> - AUDIO_AXI_CLK_ROOT
> - SAI2_CLK_ROOT
> - SAI3_CLK_ROOT
> - SAI5_CLK_ROOT
> - SAI6_CLK_ROOT
> - SAI7_CLK_ROOT
> - PDM_CLK_ROOT
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
