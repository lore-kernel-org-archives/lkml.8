Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67127C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C99D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdHivTWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGMJJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:09:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EFC061755;
        Mon, 13 Jul 2020 02:09:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so15748698ejd.13;
        Mon, 13 Jul 2020 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPq+1064nUjoP3AXAvvq32qxXsugr4iXuysyx1Ff+Gw=;
        b=sdHivTWiZ2/uua+CVTccpyDrZw1nLce9WO7TvUpR4BQcCnDDeTUam7oK0g4Iazv3DU
         HieesRj3iB/zuh3cjLrGjAtKHFKGhb8X9iVmxqAKrvDvSfhB41v1W2xCJ0QJc71xoyVz
         CRw+qsQE/8ktF+nWRiYrmWzPvEHxLznKV4e4o7J14I+Hkhd5Z/L7DIEPdgT9lVicJtma
         x0gx/otfnns21glNQFEmrw3SnM5Rcm/aohN8aLzZ/fHG2+re5JkRCvTtqRb4AXPDPopp
         eG6ww4cYD9RjKVCW4q/hj/O2PQ2KTsDOYpJsao0+2XtjjlCqRsZT2RiGRVc8u9Rf48WL
         Gf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPq+1064nUjoP3AXAvvq32qxXsugr4iXuysyx1Ff+Gw=;
        b=habgG33POIcK/V8g1gJgTUFvCNiskr8g5ZnrI6ZAO0FAItqzf5nRzPXhFFmLCaEmh4
         f5JbfXYnxWTLxzioSOp1vBBKfLzbhAXSSXHL6+XlV7RA2cEhbUZmLWIfsv7A4C0Dwra6
         QPPG3mP6o5yPO5NnKos6YFbLY6LfFqZm3lI4Cq7LUQd9LNux/PXKo09QRcHqs8EL8lMf
         vLmkyAVM8zqzhR4jtjL16IePrsi2h2XjWpOQHMNFiEAjZq8v7NG8kmemotlQLvcoZwze
         muU/uaK8VqFsApEswkTGEOHimcjhq/P7hXa/FSmL5bLu0ixtg2beIM0XkYQDZ2jep8wm
         gqpw==
X-Gm-Message-State: AOAM533JIvJaYJm3W0QPFqoCOkBVKK/y3HcBf+eHsYM6pYafvLpsMCkm
        C7ds4Ox8SDsocZbvmmgrrS7YrwYfkwWH+YFyaoc=
X-Google-Smtp-Source: ABdhPJyT2HlInEXbCQPixVQnafVFJ2BdW2qlOoqR956QbDNaf0iqvDUk2aWcn9bwwA3U3QHXazIZS44Bgxe0H3izqz4=
X-Received: by 2002:a17:906:2318:: with SMTP id l24mr76826035eja.291.1594631372297;
 Mon, 13 Jul 2020 02:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
 <20200712173044.GL6110@Mani-XPS-13-9360> <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
 <20200713030055.GA2978@Mani-XPS-13-9360>
In-Reply-To: <20200713030055.GA2978@Mani-XPS-13-9360>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 13 Jul 2020 14:38:55 +0530
Message-ID: <CABHD4K-JdzcNa2YqH2KnVtVQrjoaVp+Y0L6F1jJNm2iN-pJ3=A@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Fixed regulators are used to nicely model the regulators which aren't tied to
> any PMIC. But for some cases we use them to represent supplies when there is
> no support for the specific PMIC present in the kernel and they are turned
> on/configured by the bootloader (this is what happening here).
>
> And there is no use of declaring fixed regulators when there is no consumer.
> Even if you don't define these, the corresponding supplies in the board will
> always be in the same state configured by the bootloader. So I'd suggest you
> to remove this for now.

Checked the schematics and regulator name is the same for both eMMC and uSD
Shall we keep uSD regulator sd_vcc to be consistent across ACTIONS platform?

> Since I don't have the schematics to check, please make sure you name the
> regulators as mentioned in the schematics (this could vary from board to board,
> so don't just copy from others).
>

Sure, point noted.

Thanks
-Amit.
