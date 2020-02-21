Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ABC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09DE24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1ko8Q38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBUNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:50:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41889 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:50:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so1529327lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sf0tmWDionUelC4/eEP2OfX8tKBTBWojUFpEbrDtJPI=;
        b=w1ko8Q38gPPhRlUWLFuBF+6XHvtbBVeQklCnr8Gw/u8ROuTSyq04eYQM0bdmspxzCp
         dr+C/U8tS7ilCuKVMfB19EOudBucFcWH32l4Z/4WjId23QTMMxZVtzKwqdk2ciPsHnHf
         c3/e1Q+mKv0Z53+lJ0F1acoE8nUlDnTXtrzIAXvQwEMaRv9fu8QlWIg8wve+w0sdVpQQ
         xKWPTYRyH1m3kSosukY9S5C1QHlvGg4HNvN/rXzAE7Z+IuKKzGkobxWuzjf0ml7BHoVZ
         CMdG0jLsOjr4PHjV1a/BHHuJHHqG8uiBDqVgiH2/Ba2mcZS4crO3QyhZH2iaKJ7tTRx2
         WrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sf0tmWDionUelC4/eEP2OfX8tKBTBWojUFpEbrDtJPI=;
        b=bjs3FA9KPm5fxtdDECJ8iMnkBuvj7FQrf856FMxgZ/XOVHdOxETMWO+sEWlRGhUDoN
         +ZsB/8DQqzkSdfaUyUVJv0d+oAvpYm/brShl+X1j1fmrexGiYG1PEmrmv8CKRWk0+ivB
         onIqywfRwWQRcFj+OPHY/Yrl//GjCyUEvR+hekAqKZx019cGcGrrQBlGUf2OfXSl5aW4
         fFY4BkbYyB9/SgiEYhtp2R44nlAwIrGuvUUMeGFdunwZmjr02yeaZoK/98sIhkC8sZba
         qB2XIvdE0LKWFMcz1zrP9fWfukWiVU5ITTsH4Qcvw1wPi7RTdl77xqhMp2aaJyyaGyE0
         Kpyw==
X-Gm-Message-State: APjAAAVWXNnl5hCwCGe9gRo850oiqJ+A0S3EjczVFG1DFc2QvOORARft
        AKUVBFmd0JzF5Y1bt6DCNeHj5kOEzfJ00xTmNQRB6Q==
X-Google-Smtp-Source: APXvYqym050fla+7rVCMpBCZ6/aTMWJZ+KVkmueegzulH2SioUXqzwGBCOQZip0WoqthmngGhqwS/5mD0MnafMEDZPU=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr8062209lfm.4.1582293013774;
 Fri, 21 Feb 2020 05:50:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com> <a851b8c54662e6fdabfb9e1c9990de59649c1fdb.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <a851b8c54662e6fdabfb9e1c9990de59649c1fdb.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:50:02 +0100
Message-ID: <CACRpkdbkVv_NocFBxjbupkwgXiio3qmZJuXOssuQxyhnzt7Yxg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] power: supply: add battery parameters
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:38 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Add parsing of new device-tree battery bindings.
>
>      - tricklecharge-current-microamp
>      - precharge-upper-limit-microvolt
>      - re-charge-voltage-microvolt
>      - over-voltage-threshold-microvolt
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
