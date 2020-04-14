Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06D1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D822063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YprgSRcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437406AbgDNJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437383AbgDNJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:08:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C1C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:08:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z26so11627126ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyjNeTqvfEjZX8vIKzclorxGtdOVdVhWe6jr1cd8Lcw=;
        b=YprgSRcuKMz2TB2H7Js6CV9O0igeW65lMXILU0J5LZC5dkVlZVfMejJaTxk04tAwGb
         SKRQrIaXIHu7IAXDTdwvQIFevn1Pw+oltQRWXV9hhLtCckgmgeuH1V0jUCz6Tf4puJXv
         0wyzzp1faSmkY8mg9d/yHWuGC7GaRgnindjLgjC67KJR0wVTeeLNDcy14kb+eaJy2Sm0
         FJTwfDwSCas6Tp+ruj7SxunLNrOtrbaZ3OLjgQTZODzWeIQZlzHCevccg7vyk4xBmm5J
         44mYUWCTr8x3RfWzk4bU1eOLrjRnG12wzlJ625PyNW41w6trhwqpxDEkPFYGmCGgBXrJ
         TbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyjNeTqvfEjZX8vIKzclorxGtdOVdVhWe6jr1cd8Lcw=;
        b=lGr7yk5C4PyUhZXfNmxiECeJuOR/HiulnBvjJJwl2lIsQ9kWFVyBbSHv4ZK7C9ZxHA
         m9ms0TfJLF5ZT3n1mieGs432L4cH5o/x45N0rqq0R1t9S9O2vDtCq2w34cK8iqcvDkJw
         N0B7LIRxKFZGYwTIxTDjfOSSfCjOau/eZOH7ZPG7xi6D8XHSQ5a0DxpIXtg4lTI4I+83
         Pwu0smcK58kocr0csyIUAP+6DgTbV5XvxXC6hjglUEJV7+AsepCmMPuHzQVl0h6cnFwH
         P3nu48/c3Wj2T8il7TZb9WtfsAvdHV0VNH8ca63LGC7iInjWVMf/UC850PNoMz+rtTYJ
         0lvQ==
X-Gm-Message-State: AGi0PuZEebWm5SUsp0S/MLbV5ApSpt8yn08zXAkyvA8+k60Beegi9d+K
        Zcbl4v1DmDg5cDB2xexOKyv3xNdqQq0RRw4RiRXwzg==
X-Google-Smtp-Source: APiQypLF1woHKulkGKUVOcynI3F6bPW0neabdjjFhnRcaLD4bVyCGbpN1rI1nFV64y7Zz5AswkKA1tI10XRVvnW0pE8=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr12489541ljh.258.1586855329250;
 Tue, 14 Apr 2020 02:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173252.67614-1-stephan@gerhold.net> <20200405173252.67614-2-stephan@gerhold.net>
In-Reply-To: <20200405173252.67614-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Apr 2020 11:08:38 +0200
Message-ID: <CACRpkdYW930B-riUi5OnmsDCJD_piJ+321rgB40bq93ndzSp5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: defconfig: u8500: Enable CONFIG_GP2AP002
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 7:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> sharp,gp2ap002s00f is used as a proximity sensor in
> samsung-golden and samsung-skomer.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Ooops I saw now that I already had this in my "Skomer and misc"
enablement patch. (rebasing my trees today).

I can put this in front of that patch and take it out of mine if you
prefer stepwise enablement.

Yours,
Linus Walleij
