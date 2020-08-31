Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE55208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErnRZpso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHaL0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHaLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:23:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BFBC0619C4;
        Mon, 31 Aug 2020 04:11:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so6127654ljg.13;
        Mon, 31 Aug 2020 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBA4lq2eEQKdGHPVfH2eabmn96FgpdkcBhGUfAGX+XY=;
        b=ErnRZpsoXkfyLCLtQE5j1JkYXYav1PYsV3Kz3NBeIhhYGxZ4ecxuCZqaaz8kWZ8qFn
         Qcn4S81KqgjH8W0L7VPkF2H9uBcfZ6UFIWkj+XS8lSTL9GQqcOcUXncYAZAg0NyoaED0
         vRM4AyZM35HWKXMwnxBoHWo/WFxU61jiuWFf/XiJiyAgbAbCPKoTRYGKmA8TJN2gm0Te
         9ubR6gT627JikVLpcb56tHRizXjATx4PESxLbPiHfqQaQHOBYP50v7PDafgYtVRGf5op
         FI4XAA+nQAtWBNm2Dd8KuzvYsRMuXSRCn+JHCnVcHGAeGWhAoQLxEMcpCT1oSfNXeJ9y
         6WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBA4lq2eEQKdGHPVfH2eabmn96FgpdkcBhGUfAGX+XY=;
        b=a9pQz/OlXQl8ttQyo+sPote9wcax4mY9L7pvjsGjLES0P5mvvc6m9SLWTs0Tx6XQpF
         9mJLYoIFE9NRWzM/VuLxdAcpJlBmXT/0LbcAc58l1OoGYiTgeJInkyxkJQaGHjEtESIn
         0mNZgVreAwdI3Gjb+kkn5/sdPAgarBzihla4SQfSol4STVzFUDB8PCEPFKhW5hlOEObo
         EPHqijHgw7GGcz5Wvxl0gQzotZYUwGG7IkbPBg4P8r+m03CJDlrQZZN5wyPLptDliq8e
         B1RX7zQrZMaLrVqhLpSjRxO64q4kV6oDStc9GgmCNV9gWWGfAKT5vGNLMYC8QFpBB2ut
         q6sw==
X-Gm-Message-State: AOAM532wF1hiCZ5OJ0qdUjVkgk3qCx2OI29+MXkaWC6iWAy4hJhPF4/e
        HrXL+WrEaWSxlOprVqUya2fdjxl9zyQXYZSXDVI=
X-Google-Smtp-Source: ABdhPJwA7vR5LMMHSN4kugDzrXHP3J3xVzsqnP9cu6m2rp/oIWQd/kzDb9npXb8ifZUvX/m5YqBn75rFPyixmNtUDNc=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr485243ljd.44.1598872312530;
 Mon, 31 Aug 2020 04:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <1598895387-22313-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1598895387-22313-1-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 31 Aug 2020 08:11:43 -0300
Message-ID: <CAOMZO5DsFoq3QvVy+FAhQjnCOpJcyJOiEBPYEBnEzn39aD4ESA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM64: dts: imx8mp: correct sdma1 clk setting
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Aug 31, 2020 at 6:22 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> Correct sdma1 ahb clk, otherwise wrong 1:1 clk ratio will be chosed so
> that sdma1 function broken. sdma1 should use 1:2 clk, while sdma2/3 use
> 1:1.
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Please add a Fixes tag.

Thanks
