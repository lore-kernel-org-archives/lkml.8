Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FCBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6917207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCqyYSiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgEZJU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgEZJU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:20:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D6C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:20:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so21443772ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjIxLurGAZl3ClrqkcDTUozxTD1nDew3Brnlr2xXLqY=;
        b=JCqyYSiMdYS1eYDRtnDeEiedABn2SLAJ9eHMlUwpGPm+5yJt1v4LCf6UvpJc84XRbE
         1cfRRQoLViCSj/Ef6G2XQ1MnDs8XRyleZi6kQTJgM4lW4Eyurn8txIZenaHRroS5F4Ii
         zqWLfi1rIGTUwxWPo6NxZWKxgXdkIdm6Z/9uTNfehAxFi1FZ5QXiVI/oLvhWfxfBZP04
         64YHr1ZbYww9BFPrJ+2zK2C1+oW+dLlk/sZkNNq4aRcvkJ5DbIEeA679CTRIvnoSxtQM
         qA8qkXqWSIUdnpytsjCspoXtwgmZPFRfsVg7QYO2gGDE+hSnc8P9Dw8ZhWPx2fnwvwsb
         qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjIxLurGAZl3ClrqkcDTUozxTD1nDew3Brnlr2xXLqY=;
        b=OhSB2WrDzQKo5REKJ5pgfPIJQoZ8KceGGFUxIzA2EDg+LLQprQ6UN5grvx1hmGycw2
         yk2xfRv7HxD825l4wj81b3HYa88Yp2gETZfedKiPS22KaESyxnpM/dFaFE2K7G9XhTwk
         iZxoHbNQtsOybjOY4rKThrfnWLihc0hTDhOocPuVhbBk/QwYWcTuRKnpnbv3OXt8rQ77
         XniQL3+ojlO0NgLqlh7JPjA62A3jT7LYI7PdiXooElf6C2qInQDQZsHA9x7I/OsNSUYd
         rmo+Y1Rvyi/6abyIEw1jUZEkXPi5wtB/qiE0vJctD5K3TJXMN3meQWLf9I9M4QfrHiuo
         FyfA==
X-Gm-Message-State: AOAM530kFfYwry4qLsX4c9f8i/dTy8rGx0Qv+IR2wQQaBU8Z2N9nnzq4
        nLhhnim+DpFd/A8kw7FveuYN22Vtzjye4K7NIerVbA==
X-Google-Smtp-Source: ABdhPJwg6A/TEx1rm0SmH/Tfvf7jOImMZnrbm86NXCtz4hLlqpfrcSfkYxR6Rag1WIB7c/CsQ4iUICjgpzIFIhw1xII=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr162302ljc.104.1590484855739;
 Tue, 26 May 2020 02:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141134.25819-1-lars.povlsen@microchip.com>
 <20200513141134.25819-2-lars.povlsen@microchip.com> <CACRpkdZa7OM3bqB+zRprEQ3M4m9hG3uPCoYxrdH_O=oxD8zi8Q@mail.gmail.com>
 <87pnb1nf2j.fsf@soft-dev15.microsemi.net> <CACRpkdYesD9sRQZXQNEaBY2Ouu3bjKKGWpRtU-Lpa4AcjyPwXw@mail.gmail.com>
 <87r1v8oz9f.fsf@soft-dev15.microsemi.net>
In-Reply-To: <87r1v8oz9f.fsf@soft-dev15.microsemi.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 11:20:44 +0200
Message-ID: <CACRpkdaJvaqPptPD-A1DriVgBOZGZ4Qf0UsbsjG39ptx6bSJKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add bindings for mscc,ocelot-sgpio
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 4:38 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> Yes, the problem is they're not in sequence. F.ex. you could have ports
> 0,1 enabled, skip 2,3,4 and have 5,6,7 enabled.

Just use disabled nodes.

That would look like this in my idea of a device tree:

pinctrl@nnn {
    gpio0: gpio@0 {
        compatible = "foo";
        status = "ok";
        ....
    };
    gpio1: gpio@1 {
        compatible = "foo";
        status = "ok";
        ....
    };
    gpio2: gpio@2 {
        compatible = "foo";
        status = "disabled";
        ....
    };
    gpio3: gpio@3 {
        compatible = "foo";
        status = "disabled";
        ....
    };
    gpio4: gpio@4 {
        compatible = "foo";
        status = "disabled";
        ....
    };
    gpio5: gpio@5 {
        compatible = "foo";
        status = "ok";
        ....
    };
    gpio6: gpio@6 {
        compatible = "foo";
        status = "ok";
        ....
    };
    gpio7: gpio@7 {
        compatible = "foo";
        status = "ok";
        ....
    };
};

It is common to use the status to enable/disable nodes like this.

In the Linux kernel is is possible to iterate over these subnodes and
check which ones are enabled and disabled while keeping the
index by using something like:

i = 0;
struct device_node *np, *child;
for_each_child_of_node(np, child) {
    if (of_device_is_available(child)) {
        pr_info("populating device %d\n", i);
    }
    i++;
}

Certainly you can use i in the above loop to populate your registers
etc from an indexed array.

This way the consumers can pick their GPIO from the right port
and everything just using e.g.
my-gpios = <&gpio6 4 GPIO_OUT_LOW>;

Yours,
Linus Walleij
