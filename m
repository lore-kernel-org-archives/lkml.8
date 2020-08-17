Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372DDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037D420772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG3nKFAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHQIAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHQIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:00:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E557C061388;
        Mon, 17 Aug 2020 01:00:11 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a14so11534532edx.7;
        Mon, 17 Aug 2020 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aT9GJIpoiVrp3AgKo147Q6EH+XasIbf7WIRMpBX/T1w=;
        b=AG3nKFAVoMjTMCSMSRmk7b9H3f+0R/4aa2iNI7zZdIIvz8ICsDtmGxJTHk3BWDpIhw
         fE1OccrxPVYeo3c0fPQrNV5STHPxlKGNm83tGdB8oRhbng856RBS/4hhENRxmFfJ6cyz
         4Bg9/WfbajGy1uLQ0VYIKv2JQTCsbBOiarPQCheRChgNOM8ipOhp5Y0I3Rtcg/b1EmzK
         ZV6nZJ+V/avYBFxMs9VGu/9/L+ew+vbttfNf1Mc+PQIMIW/C79rTVcFK+AlBDixMjOPv
         Lfb24Wv/vazDiLMNFohHs7E9VJXngTvGVGo3gHDYIEmX07jFVNqLqUHRVgmlpSCdt7nT
         5hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aT9GJIpoiVrp3AgKo147Q6EH+XasIbf7WIRMpBX/T1w=;
        b=Vg39AC/UV42Tcfh+mv9EOXJGa/pY/O79zJpF8/EhAqVRz4AOzL6GAiWBYTmXV/Pr7q
         wYX71M1gTWRLMV7NfI+reHnP4+/E8+lW1YV4m2e2J3enVbWx5Wf/H3L2TljvGAU30vrS
         Wr1myczBZ55S/iKde23dVKIklN0BNrTU/xCHD0S+bAGAnwTdsaAaPYjxwcDlgsex0pLz
         Ww7hnlPsKr6cbr0+jIOZNATUIAk3F0FiB1/VnaKRvB/uF+ivkseGNZ5ZahXVWmoW9zFO
         P6YA2glWWMQBWjniIVbEIoRcVfG3UbT2dPcGHZx2gdAthAC7JL1HPH3u28TSwlRyiKTd
         JUPA==
X-Gm-Message-State: AOAM531PH8myBSwUn/dL92THM9Gbqka+ywZWGok4MD18T4ojacJmq9bJ
        xXy7IzDrPY59DX1GO+Y17Poyi7yvFyK/HP6d+mA=
X-Google-Smtp-Source: ABdhPJy8jLjmlnCXvwzkcBRFsyOgE7O8bi4Qp4G5PeNMzUmy4Qqwl/YKje5iWwPNgcUOL1q322jqIBOR66HYb091mzA=
X-Received: by 2002:a50:d9c6:: with SMTP id x6mr14190308edj.56.1597651210155;
 Mon, 17 Aug 2020 01:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-3-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:45:04 +0800
Message-ID: <CAA+hA=S6m-4Ac4QwWnQeKNzKkW4ZPGvV7Psh7vHnRNoQ2UWTYA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] dt-bindings: reset: imx8mp: Add audio blk_ctrl
 reset IDs
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

On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> These will be used by the imx8mp for blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
