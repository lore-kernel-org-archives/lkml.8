Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30A520737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598477837;
	bh=HPaU+WLmH8Up9dbawX9m8TWCy298k6grQDHV0In6+KU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uMY5MB654ZgzebkO1r+VD038pK44l0MdoTAI7XDsqP0m7wCZdwcDjefByT2fowqUv
	 ceCWnEqbXxUuiW+//WKBM9zSVeU6wz27KgcotU7XZKNYtDWJRtM+NgmjTpvSuhvQgS
	 qo6Q1T9QyKrQIAjVCKHbd1QRRt1yDHDhFjLMg+GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHZVhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHZVhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:37:09 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FF321741;
        Wed, 26 Aug 2020 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598477828;
        bh=HPaU+WLmH8Up9dbawX9m8TWCy298k6grQDHV0In6+KU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i+WldLivHRTc3R1bfkdzm5Kym06TT4gGIqZrgYUSMlRObzrm46C3XYbgA7KZJ21/w
         R439ybGpDUNecYLNeGxbOMM1TPJsoVFL8uhhuQEzOkHFhkzTwoRZqZZRu9XSJi4saN
         YNSECrzL0rHunIOsZkIfZhGuk/7akHqNgQVazlWU=
Received: by mail-oi1-f173.google.com with SMTP id h3so2840333oie.11;
        Wed, 26 Aug 2020 14:37:08 -0700 (PDT)
X-Gm-Message-State: AOAM530c08qMotJLlKryC0zMu8hDrqNBulw4Z22WsWlr5qfyk2JmPfXd
        w/RzF7K+MNnlJ/wYSszuxYBwYgv6fhSIr8RUiw==
X-Google-Smtp-Source: ABdhPJx0muTX50Xibauscdj9Ch7KyrdQTtAYP1PDy7xQ1tspzduZDSEmMIEfhMj1BvPf0p6iq6Naml8IzwohGlR+4eU=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr5257004oia.147.1598477827897;
 Wed, 26 Aug 2020 14:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826183805.19369-1-andre.przywara@arm.com> <20200826183805.19369-2-andre.przywara@arm.com>
In-Reply-To: <20200826183805.19369-2-andre.przywara@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Aug 2020 15:36:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLiEQQBarRkp5NzVb+FPs6PaXdh6Fem2KKAvMR+OywCDA@mail.gmail.com>
Message-ID: <CAL_JsqLiEQQBarRkp5NzVb+FPs6PaXdh6Fem2KKAvMR+OywCDA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: timers: sp-804: Convert to json-schema
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:38 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> This converts the DT binding documentation for the ARM SP-804 timer IP
> over to json-schema.
> Most properties are just carried over, the clocks property requirement
> (either one or three clocks) is now formalised and enforced.
> As the former binding didn't specify clock-names, and there is no
> common name used by the existing DTs, I refrained from adding them.
> The requirement for the APB clock is enforced by the primecell binding
> already.

At least add 'clock-names: true' so you can add 'additionalProperties:
false'. Otherwise, looks good to me.

Rob
