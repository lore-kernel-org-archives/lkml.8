Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9402CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C02020656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKc50qWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBUOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:42:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42469 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgBUOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:42:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so2417673ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfwhgDHEklncUQidyHCpGyvOwyCft49V7Fap/k80gu8=;
        b=RKc50qWQW5JUHoFyHSCc18gTHWep0/bdQ7X3lrnM61wt7aD4JHP7ydRJcxLKBtccpA
         5HKI6An997w+9x3Eu5GfnhcACLBcAZxJUHKFM5XkRUfSmIw2pX3T8soMHxPBc2ZVhZPk
         otxGRG0yTGT/yaPO7i5Sn0AkvbsA09CEvbFAuhO+HUGUEVVmCURiPVApBIQU5siRjq04
         xbFt4Q/mIAvMHcIA7+xdHWEjz6F1jfwEu/fSPBBjaHiUIcAKyVIgTPEZqVj8/Oi1peMK
         el5DLBPv/5P5oZ6B6f5A1KjXdmJ96YmIpBUKSI7posaQELJidKfJ9HhHZVsq8cLrd3zK
         4jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfwhgDHEklncUQidyHCpGyvOwyCft49V7Fap/k80gu8=;
        b=aCIjkytIULxPD+wWMQYd2jTBj3OJWnG6HTYk0ecw+xC2zc3Z5gXXO681OR32EJi53c
         DJRvCIXxpzhRKeLALTvgWAJiNtCrVB11X25lhWbqfXB2WO+SKf3n06ZhD2FR+rba7fn+
         /7zKgzM+2X87DTWJt1OIxu4LeYer7Lz3beMcfnmzWfi6RXhpSbX1K5YuJujFKYmW+TBC
         TRSplFT88JlXYMaccd2tDupOfNiwQbqsLklfzYGHrgx0XiFiPkfBFfl/VgS4uZmo3/ZV
         rEeKPotl1w2QrL4K37+0ONgsMRfSFj9qg3SK6yzMKCvWg+f5KEAxAYyKDTwlR66cgOAo
         skSg==
X-Gm-Message-State: APjAAAXqSMLiDeSdfwR67l7L9WMmTFoaBLf2A1pgy+haBfazvPFc32QE
        7oe0HNeLXetxDO4GsS1f6Ovt/LMgOo1HQqDXpUY9Nw==
X-Google-Smtp-Source: APXvYqzgoeW5K8DqPL4tqHNwBvjMIGmjMtAVsQtMYi5lx4Vk/lJjNQQy6wkBDm/+PCOZbQHMB3p9VjdLQVGYccMGcI0=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr23010571ljg.223.1582296172343;
 Fri, 21 Feb 2020 06:42:52 -0800 (PST)
MIME-Version: 1.0
References: <1582012300-30260-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1582012300-30260-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:42:41 +0100
Message-ID: <CACRpkdZS9V_XugLuvzhWfd9Pk8xO4SBakShZ+RMeyK4z8fGQhg@mail.gmail.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: pinctrl: Convert i.MX8MQ to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 8:57 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Convert the i.MX8MQ pinctrl binding to DT schema format using json-schema
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
>         - use uint32-matrix instead of uint32-array for fsl,pins.

Patch applied with Rob's Review tag.

Yours,
Linus Walleij
