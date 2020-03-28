Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880FC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F880206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/vurdna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgC1LSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:18:54 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38788 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:18:54 -0400
Received: by mail-lj1-f181.google.com with SMTP id w1so12825737ljh.5;
        Sat, 28 Mar 2020 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mn1ytLBqSAPBNw3XMPojcu/ZhP1LOxFipDY249AI3+0=;
        b=j/vurdna05CpEPiYbgWaMbXlO1MSn4s6AHli5VB0CRBQUIL3tn/IsFdGyopV0K3H6s
         7AXxFX+50Ui0uBudNqvmSb7LA0mF2kQiib+sKXYdbh+5mqIYBcEOLY/SUc3u+xiIva+g
         uFRxkAE4GSZyvbU3rtCg1qZSbURWZ5emEMzXelXG2ipoCL6yM0t4hnvH7V0csTnmXW6N
         Q5A/5z0tjCD/X9qXmobQvxl+LKG4sq7eB5C8+Zb8GImVfabGY+co+ZWkPGW0asWwx95D
         oHolnrdhO1IEHoQyfA2ta+ueYLSHBCQ4XzFRuPGIFFfF6BhTXsJZfD5bSkHLwSxUh/Kc
         CMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mn1ytLBqSAPBNw3XMPojcu/ZhP1LOxFipDY249AI3+0=;
        b=klGhelfZQWCiOGhi4+xrkjdWC4r0/maTL9BSZyS59YAYkQnJYmcF4JAIv2mAhg4rQw
         0xHIACIMf7Of0roqe7DAh8Ky5u0ijFhF0HfnX2aGS2Ydl6SSpd9Ip435N2W5Nfep93Od
         yaiBLpT3DtbuYys2aD5oBX2eaKRUROxRGB0+p01MACVOl+Ol0UGRC9ECqC4aInvIEx+3
         Q46ssZyY/PgJfjIZa3yWRCOZfNnFMFEUc6kBQRAjwPRZNvPv1X1ELRQrujNd3pyHV3dE
         JCHYRTAjUCh6M4Cu+lYaw6YxP9FAOM1JFNERKJJy/Bjods/sNYNV6G/33iMEV1zmIrX0
         40aw==
X-Gm-Message-State: AGi0PubX4GhuJSoNQ4HxE9SJmNcjutodynaJTQeh1sLv5eP2wbNJ3eYt
        daHj58eGKnzKBTdWQq+8ELNa2x6sK1apBS4jx6w=
X-Google-Smtp-Source: APiQypLE0oLlT/o3yAjG6ThkJD82LP/2VPbDKk0L+GjVnht7omgSVfHwuAggLs+wNUYJlyQmbGiwLidjVdGS9lfq8T4=
X-Received: by 2002:a2e:9105:: with SMTP id m5mr2054389ljg.37.1585394331360;
 Sat, 28 Mar 2020 04:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
In-Reply-To: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 28 Mar 2020 08:18:42 -0300
Message-ID: <CAOMZO5CZX=C2zSjXV0LTvNvAyqWkzLgR=OoRS=uY1wa4rXshVg@mail.gmail.com>
Subject: Re: i.MX8MN Errors on 5.6-RC7
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Fri, Mar 27, 2020 at 11:50 PM Adam Ford <aford173@gmail.com> wrote:
>
> I am getting a few errors on the i.MX8MN:
>
> [    0.000368] Failed to get clock for /timer@306a0000
> [    0.000380] Failed to initialize '/timer@306a0000': -22
> [    7.203447] caam 30900000.caam: Failed to get clk 'ipg': -2
> [    7.334741] caam 30900000.caam: Failed to request all necessary clocks
> [    7.438651] caam: probe of 30900000.caam failed with error -2
> [    7.854193] imx-cpufreq-dt: probe of imx-cpufreq-dt failed with error -2
>
> I was curious to know if anyone else is seeing similar errors.  I
> already submitted a proposed fix for a DMA timeout (not shown here)
> which matched work already done on i.MX8MQ and i.MX8MM.
>
> I am not seeing huge differences between 8MM and 8MN in the nodes
> which address the timer, caam or imx-cpufreq-dt.
>
> If anyone has any suggestions, I'd love to try them.

I don't have access to a i.MX8MN board at the moment, but I am
wondering if the errors could be AT-F related.

Which version do you use? Could you try
https://source.codeaurora.org/external/imx/imx-atf/log/?h=imx_5.4.3_2.0.0
?

Regards,

Fabio Estevam
