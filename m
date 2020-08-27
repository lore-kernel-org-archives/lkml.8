Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D259206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4CqqHi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgH0IwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgH0IwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:52:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31DC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:52:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so5518403ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYacB22eYqjS0h2EHD7vpnW368MZpgmYVMb0jVEC+0k=;
        b=I4CqqHi8i6aZUgWVs79dQH94/DTsPWfoTtqiUAGLfoUuyChmrVFlCJt2xtstW36Y4j
         srvtiSanJALvFkGgcExhOsRLJbdHal2iROBeZUh3KvND7j42b6+Few3BMJlywvKTA7dk
         ybPUE3SK0t+TFNUTx8lqxIfifMsnc/xuZHJ1ZNs5saEACMpfE+DV06RyD4dc+tMEIecr
         I2BAxZtGiqRHJEg+8eBXUoM9SUQUsRKQoo5M6Pmfww7FbPgNKKtKPjTn0PNhRle64LMB
         waN3UegYTBknmsNPNhbhnfmpgGvCbM23phLffVIVJpeM8L3Z2wTYNWoWZ4Xe4xSgWSpT
         bZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYacB22eYqjS0h2EHD7vpnW368MZpgmYVMb0jVEC+0k=;
        b=WPFJwXBNg+JWvwd8AW7q1jbV7Vq0W5+8EHPhqRGcuN1yn2xGWV/cc+Wb049/rBG+ZC
         UmX42LUbsUJMZesaOD6ZD6DC7sBg/JOUFUleuGQUakh60hJORSnGuIBkoTlDpGZvoeMM
         n6ajWUy6VGu4ODAj3BOr9FPebnE+y3hyQRII5qdym/sjBb+y3rzsVilalyGgNiXf9YGO
         FCfWo7f3rpuOTuyZIu2ZgXaIjvzWgOkK0bl5vZ9mDp9harxwbzjGyz7hDpEKe0SQkoPh
         yYbeFeuS09KcFf3DlkqE4lVR7FO4+0YwxKEJ05x8hFpuj4LSmMSdMWzsEiOdzqW86xqi
         cXfQ==
X-Gm-Message-State: AOAM533vyZBOscsYDahIaVv68YX0T/C3LaTZC2HKaFI3z0M+Psec7Yj7
        F8qxBzo7HzqEDjyVfaTUkGA/BNYuwpZ66Tju7JtCjw==
X-Google-Smtp-Source: ABdhPJzMK/QQzozGDxzhZ1ptVcFeOA7pCMf7o4BoinmpKAwFETGR2jOwjTUEQE5hG43D4uonIeuqoQ+98b/Uh0VfqsM=
X-Received: by 2002:a2e:8144:: with SMTP id t4mr9913723ljg.100.1598518336643;
 Thu, 27 Aug 2020 01:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200817001702.1646-1-zhiyong.tao@mediatek.com>
In-Reply-To: <20200817001702.1646-1-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Aug 2020 10:52:05 +0200
Message-ID: <CACRpkdYedyDcnL5DUD33Z2iT1jEJ_W1gvB_a8VaFnNAH1mKgzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Mediatek pinctrl patch on mt8192
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, sj.huang@mediatek.com,
        seiya.wang@mediatek.com, jg_poxu@mediatek.com,
        sin_jieyang@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:18 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This series includes 3 patches:
> 1.add pinctrl file on mt8192.
> 2.add pinctrl binding document on mt8192.
> 3.add pinctrl driver on MT8192.

Patches applied for v5.10!
Thanks!
Linus Walleij
