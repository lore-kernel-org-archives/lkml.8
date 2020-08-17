Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7120758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd+al1eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHQIBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:01:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BDDC061388;
        Mon, 17 Aug 2020 01:01:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so11550610eds.2;
        Mon, 17 Aug 2020 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EN2v0o+0XsdTY0lNp4TN9i5JDbopDvF1J/b7pMT+zyI=;
        b=rd+al1eCyANacVhtTwjzIKcQZjCwp0EWPXUw1ACl17n/p2xwuIv+ZCFNgAQ1eP81Of
         7cBCLnFe3mYO6+UxVK6ozen1vcJdzzriwaiNuibocM3YLEmkI8V82zHugkd/1oKcIkB6
         Ld0vb0wcvlyGNNVP8RaCkWXJAcdCJMwtcACsoirwgzU14ckJWhiZo6I1OJWIs+oC8BMX
         qk9EKtAPPdNnyjVNTkEuvFr/aPD/cOnYya3u6Tr/OQIi0pv6Sfj64cjle3ZxG7MgaZOA
         KIl6KvMoxBHqxLyDqsDP/iHnjdin3/rJzjpervaGpi8QLFpGRiLGStt4NSNoIxXNE7ZG
         4RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN2v0o+0XsdTY0lNp4TN9i5JDbopDvF1J/b7pMT+zyI=;
        b=VWtF6Q5cYNfnU4ElgqLf0s7uH7DOlBSAHwm7z3NmAssVZUVdL8ZTLjRnln3DMDZvRJ
         PmE6wfWyPzQiPYnvF71v35rytk9qxc7puyNVrVjIzTk5R37CdEh98jc84NkwHqDA3pIw
         ic9ggOJmfbvqdTLBCUgA28wobNgVpQ0pjAkWLbIm36qbMriCx//LdKjF6QYB1u0Zvput
         LxoL/zskOnATNwD19fy59Z4JO91XEPJbHZyn0uOX2csxjR4XbdVjHpRnn7vg3dIpZths
         Y2fUixeUjsZ/y1iSUJ4f8xkoKAF7Q/TK+9HT0L5rHE5cCueEZFDSSMHNWGFMp2i64L/I
         CDMQ==
X-Gm-Message-State: AOAM530rAx0Kbzx1J84n3FhmQ7BF2kDwGUfbMcGrJ0FRYoTkDJsUMagV
        DNtJZR8qcsbF4IlEKO2dQZO+x0JJ0pX+ktyVNWs=
X-Google-Smtp-Source: ABdhPJwcWkrmgIZVTMKRHC3t2ADXdXb0CzKtKH+HgMRqjaazuGVo16S+sjbcE6SvkZ9z+MBHE5y+D22UIZyni6lNGsU=
X-Received: by 2002:a50:fc02:: with SMTP id i2mr13897562edr.121.1597651291135;
 Mon, 17 Aug 2020 01:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-5-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-5-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:46:25 +0800
Message-ID: <CAA+hA=R-3p3D_tLHVLdVoXPQWAW-k8iD-NzY4KerYXDN2cT5gg@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] dt-bindings: clock: imx8mp: Add media blk_ctrl
 clock IDs
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

On Fri, Aug 14, 2020 at 8:14 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> These will be used by the imx8mp for blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
