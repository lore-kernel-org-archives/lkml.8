Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F5EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380B0206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1B9gtJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898294AbgDOSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404681AbgDOSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:04:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEDFC061A0C;
        Wed, 15 Apr 2020 11:04:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so1025274wrs.6;
        Wed, 15 Apr 2020 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8FRo478arD7m2qucaLnwOdz/3bXv43FR5ZsgyXv6Ho=;
        b=R1B9gtJSvwts8ntK8Ij1ZQRxo8KVqPjQ6/oq/phrw5hrO5rLWL2vP1nB3wa5pny7rt
         WSRQrcQvkGUI8Twji47UJrYONgw77+rFQKPQfQkSDNdUC/ieAMbtaRKm8sow9kWRXLng
         +8DL+vVHegL0QTBbH0DAp76R5w33ZHKqeAy2yTiEz8OM312FtqDi5lpoBa3ASRWQiDqP
         oGwfwqwXRu3UwLf9m2NR/DsSLLrEqTtvr28dRJqs3Ip4yRnIgwO6z8t9NSH0J9KuFsJT
         u8L2LrqO2uhCbzznqVIB87X3lhf68FDIcYpOE0YSKKwWWBp29Qxf00vQFTZvzrxibsVR
         gPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8FRo478arD7m2qucaLnwOdz/3bXv43FR5ZsgyXv6Ho=;
        b=a3xADp5VagEA9o2wXLXGWiR3hdEpSqi6D/jJMJHWpdhiJQfB1eSLwbrkIGL77zrnMK
         y1NSefbsuLQqXthQafoKLHXGC8iybiCmtMpu5ZJOXm64UuZ3nrElh+66Wb+X2abkyryK
         v+AhcdCuL8MqJqSaqYSMrLfKc12DqTgdAhUaRlO6fEoB0+s08Oq0VmRRGrbBNBx8qvtC
         z2l7uBwrK/9PRa1Dj9dfNwlYqCgr9OU66K2xxrzFtyVSCUpmMOG7v55scPo0L0VVSq0T
         5AB/8AOTwSovpBCa5LIQPtHu5TQHKFnv4+VwH50EO39nd6apA3n0JNptToArLYHT4CfU
         9Vkw==
X-Gm-Message-State: AGi0PuYGHTkmaKcPPPtyWGvn+ZhLwPQBjoZCE84nzgso9hMegX0eOrek
        igVDa95aTAcXgtjOcOGxS4Z3jTxCr1boP57WNL46p6Ut
X-Google-Smtp-Source: APiQypLa70wxauBl8Umg57eLoV2a9izwUGC+7DVCaUZ6CGZwb2JceU+aC/f7UF2fV14mwbXBnJnREvKjneYMEJflMqU=
X-Received: by 2002:a5d:420d:: with SMTP id n13mr30497310wrq.204.1586973894505;
 Wed, 15 Apr 2020 11:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200331203551.20914-1-mporter@konsulko.com>
In-Reply-To: <20200331203551.20914-1-mporter@konsulko.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 15 Apr 2020 21:04:43 +0300
Message-ID: <CAEnQRZCqeJkRPEUYL3k8seuNusLZ6QpT-X-A7E20AMHSYcmaUA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: fix dma peripheral type for SAI nodes
To:     Matt Porter <mporter@konsulko.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yibin.gong@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:36 PM Matt Porter <mporter@konsulko.com> wrote:
>
> The peripheral type specified in the dma phandle for each SAI node
> is incorrect. Change it to specify the SAI peripheral.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Hi Matt,

Why do you think this is incorrect?  AFAIK script number 2 works fine
for SAI. Can you add
more details on what bug are you encountering?

Adding Robin the owner of SDMA.
