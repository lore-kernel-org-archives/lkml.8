Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452CC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38712074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhkyJ6FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgGPTcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgGPTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:32:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684CC061755;
        Thu, 16 Jul 2020 12:32:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g20so5621199edm.4;
        Thu, 16 Jul 2020 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Er29iuItgybp037jv9kMz4TXZ3T9JN/1wmnIzHGCcJY=;
        b=qhkyJ6FK0Xl4wfWxID9ZGqoG1uEOS27tzc2LQi40P5VfNsimjcF09y75b1Ue5NBVEP
         rt2u26m+Lm9cGs9krQqAp2wY4zOxZXI9HapMaEERG4uBzEGAtncO3lmJEEubNJu4Y3yH
         naSlufnOgutcP61Y9bZsB6RFX6D3ukm2jnRc9Gi5IAgiFqO+PVWlYIEt/8+KM9NMyKVb
         6jrpw79OHfoxmiQ6N45bzqavSzThUkUV0owpZ74fIvPkvrnrlItx2rzkHhJZWjdBx7LD
         qYYMsQUJyW5CtCQnuNKSot0ya0XuxlLHQzDAiNHxdBDXBnbfbszGfYkVpBcUIvXFqlIk
         JBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er29iuItgybp037jv9kMz4TXZ3T9JN/1wmnIzHGCcJY=;
        b=k86y7vJSm/IL0YYi6zWn5XejN7EM69FLQRU+8GhjSBSM60rJ4JwO0DNQDaiG8SHp8O
         0pQ424Sf9y5f9TYfJ4Q/zDSAT6YvWndnHETyUaQpMa6BP9WJKbYBp0ncIaExbtFSGVYy
         wvX3Zouwkptc0rg0KC4YjkW28Fp4E3IpPPAFMx5H9TOxWbFp9/Cy9mW9EnNMJd+PM0s3
         9Tzn2ONpqhAEIiF5eVl4fDE8Dq/7Ke+VkpYPkxBlAY5AIS5NW2tUahJBHDnJLUt/KaHw
         XhDslodD5bQvK9eymTEbaxZY6syMVytBocpN1cJyWHaJQsYNg37Evon6hC7jJhQbRQvg
         dMZw==
X-Gm-Message-State: AOAM533jq3PcUtH6ENm7GdjvKpeqxuRFZ81SR4hhvmGXrlg2j0NMYjhU
        481RrWFxL8bju7HqohnHaz4I6U0HEyGspkLzybA=
X-Google-Smtp-Source: ABdhPJyQeQgkp5aENNOH3sMYdibgQSrdgRTanWuqo6EmsTYow4zD5OiS0EvIETdAm+f0iA6LxJBG84ybjiFQA21OjEg=
X-Received: by 2002:a05:6402:17f6:: with SMTP id t22mr6089512edy.141.1594927942421;
 Thu, 16 Jul 2020 12:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200716172611.5349-1-bruno.thomsen@gmail.com>
 <20200716172611.5349-2-bruno.thomsen@gmail.com> <CAOMZO5B7cJmF4e78xbErzBHfMw4MuF09eXti4xAUFcKOGKXqNw@mail.gmail.com>
In-Reply-To: <CAOMZO5B7cJmF4e78xbErzBHfMw4MuF09eXti4xAUFcKOGKXqNw@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 16 Jul 2020 21:32:06 +0200
Message-ID: <CAH+2xPCa2GNgtJ_5hr3dcaXzA+EB4JLfCsqDJQQY4pbxuw-4JQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Den tor. 16. jul. 2020 kl. 20.01 skrev Fabio Estevam <festevam@gmail.com>:
> On Thu, Jul 16, 2020 at 2:26 PM Bruno Thomsen <bruno.thomsen@gmail.com> wrote:
>
> > Limitations: Ethernet PHY type auto detection does not
> > work when using reset-{assert-us,deassert-us,gpios}
> > properties so it's using a fixed PHY type ID for now. Auto
> > detection worked when using the deprecated FEC properties
> > phy-reset-{gpios,duration,post-delay}.
>
> I think we need to understand this better. Why does it fail?

Yes, we need to locate the root cause.

> I gave a test on an imx6q-sabresd and the Ethernet PHY (AR8031) could
> be properly detected using reset-{assert-us,deassert-us,gpios}
> properties inside the mdio node.

Okay, thanks.

> Is this a Micrel KSZ8081 specific issue?

Maybe, I'm actually beginning to suspect that the issue might be related
to polling vs interrupt mode. As all partially related examples I have seen
uses interrupt mode and I have only configured poll mode. But the hardware
does have the interrupt signal connected to the imx7.

> Please report this issue to the Ethernet PHY folks.

I'm going to send an Ethernet PHY mail tomorrow with the details I know
at the moment. Just wanted to get an updated version of the device tree
out in case of any other issues not related to the PHY part.

/Bruno
