Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1184C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B8820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jj3cnZCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390250AbgFXKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgFXKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:19:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7865C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:18:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e2so776276qvw.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C6/v5FDFWQu+K+FXq08cjlRQyyzbafWyPUDoa4Irltc=;
        b=jj3cnZCOyOB9NW5CdQjqAVegrA2UgCoaX9vN5SE+cDx5Ij/EqZgnx69yDAe7CAmhe8
         aOZBqYkZpuwrgMZ2Lcl2qZ2Pg7lQTEKxyurHvft6gu/JIA/Na7misgT3ELJ2Yo/YvK+j
         K2TIdcqZmopU46RyJqGNmzoAbLsKnb1WPD/E2plF8iD9ugy//nIgZh1ATKMXGOvSYJrx
         /rPcLMTsznbRDq7QgAqYlZqtAkjwZ4bJBpLWyf+ObIh9D9pk+zIDVQALitwwbE5tL1cX
         HKlyGkK81UEOArvbLGDPDI7Dj1xncuMTl18GUPZ54HUi/yC85eEwucjb7I/k9Nn3hpdV
         KVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C6/v5FDFWQu+K+FXq08cjlRQyyzbafWyPUDoa4Irltc=;
        b=D06aMAFKU0Pr2VaeDXLvwXd7Eh/T0BHZ0d6R5lmCp8sKJlO3R3Xxlqxt0WPASSRJ9s
         hgy6BxpcJrk4DWlrbHnQu3UyKFyWPBc27ptWc5sAV3yzZnAYIwItgETWxkd+NlQ+POxk
         5H+3c3LVwHzMKNAmKas/Fc+w0HLMDZItI/e04RfNmXpkfzpSDkw/kGHm/ZQ22bHaC2+L
         +YTzOZaNYdcNoBEWnhhcs4wOAKfdBNblRXlTquCOtjTafRebT8/6aVE45PaFPtgDr7QT
         K9vMBl+Unl05O398Jtbot44mYzPvOAdE/UKgEFCqa56Tr8MHZ9/XQhMvenKU/XnXlCeu
         28TA==
X-Gm-Message-State: AOAM533aQ10hXLEF8q23hDFBrcbtpLBrZ3aKSlsVDuTVtV6ltauiFhOt
        4taBz/P4+lIEiuTDTqLF8sjJCPx0lo8Pg0l7jfrr5w==
X-Google-Smtp-Source: ABdhPJxyOty9d2vWpwJQ8sY1tPaTNpUtvrolxOFLx9ay2+sbUQy6PmOXqt/+hA79Z2fnVWQc7yZOCL6cO4O2DyjGW28=
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr14074237qvb.96.1592993938042;
 Wed, 24 Jun 2020 03:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <1592393847-1415-1-git-send-email-srinivas.neeli@xilinx.com> <1592393847-1415-4-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1592393847-1415-4-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 12:18:47 +0200
Message-ID: <CAMpxmJVJQ0Kz0xdRr4pmHddWonn8JQ-4pSEZyfr39ApQV73G=A@mail.gmail.com>
Subject: Re: [PATCH V4 3/7] devicetree-binding: Add pmc gpio node
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com, sgoud@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 17 cze 2020 o 13:37 Srinivas Neeli <srinivas.neeli@xilinx.com> na=
pisa=C5=82(a):
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> Add the pmc gpio node to the device tree.
>
> Versal devices are the industry's first adaptive compute
> acceleration platforms.
> https://www.xilinx.com/support/documentation/data_sheets/ds950-versal-ove=
rview.pdf
>
> On the Versal platform, we are using two customized GPIO controllers(IP)
> which were used in Zynq/ZynqMp platform.
> One of them present in the Platform Management Controller(PMC) block and
> other in Processing System(PS) block.
>
> In PMC_GPIO only Bank0,1,3 & 4 are enabled and in PS_GPIO only
> Bank 0 & 3 are enabled.
>
> You can find more details of GPIO IP in ZynqMP TRM General Purpose
> I/O(Chapter-27).
> https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultr=
ascale-trm.pdf
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

I fixed up the subject - should have been "dt-bindings: gpio: ..."

Bartosz
