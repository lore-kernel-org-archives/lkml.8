Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662E620671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmO/e8bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgERHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERHUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:20:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD7C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:20:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so7089358lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srjDyr9S0oB/6VDYDy70mCau/zVOnj84hKg9e/vKVUc=;
        b=UmO/e8bHlXbOw6t5litf5UhEV90GLZNKTvruCwSC9H28yYSU/xOoYiclTIFgm3pdnO
         G2mJQ3KyMOKPyxPHdDN0tPhEj22mLv03EN6NEHH+nuquSeVze0Ec3cxhipC/zAyQBbvi
         fNOIkvZANckbPP2uhRAYt7O9BSVI/SbbzeYgycvK4gtnAV+iC6Q0nzy96a5/JGg8E/Ve
         /rtn1LovXJiq6BnEV32NdI6aqSsAOskxgHGNSwF3BdMJLlsPqH2SZfaJ8TJ+2e9pNE7R
         ts0J69gQDaEeKH3Q/j7cgPk+y8d2ApLd5urmJ+WiPGV+0UM70Twzx0MwclzzJc0DIJch
         Hycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srjDyr9S0oB/6VDYDy70mCau/zVOnj84hKg9e/vKVUc=;
        b=tCjf3EaJLEAgXT9NeDHvu88+OU4LDB7M/8LrSriZUReJcBFZ4A1Vc1CnOSxR0mMYG2
         PAjYZ+lES6hQvoVNnxSggx06vmcE1fk3H9khblaID6TUWXpxiYZM1GEvplzpv62TFC5B
         tcxnLVL3oPM3ClCKr+jhM5Ezs0ff8CS1e/LC+NodS7zVpXlu4vABCRPXmLm3hAPbc6t/
         m+Tl1UIr6KvQMuFinxeK8zx5lVNKIo9uA00mUVsgT9th1u4Vh41w1GNSsUPp57PjTZCU
         5cqw6wTN6LM5prttB5TzwqqYu3qFXRL7N9g68eO3cBvzatv4DqDMPTtP/yItVR59H/mb
         9LBw==
X-Gm-Message-State: AOAM531f+KgdJ3HfsWVXDvNmJTgeXBCUiOUIVw5IzFGRIiNM9iTFSIHN
        +0RE7AxSGRP3X4Tf5KbPVgi4JIVbt730QpZHd8uyOQ==
X-Google-Smtp-Source: ABdhPJzRfqaofRPumXvphn7M6BnSMfYofnElhrI84EAZ3W5otCYBNBiXOugxiFN46j+QphGtW23HA+cXFzEqTcDNw+s=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr10546757lft.194.1589786443287;
 Mon, 18 May 2020 00:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200512203524.7317-1-jbx6244@gmail.com> <20200512203524.7317-2-jbx6244@gmail.com>
In-Reply-To: <20200512203524.7317-2-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 09:20:32 +0200
Message-ID: <CACRpkdYrDHNp7esSYw9y7CQoZ1aZojWkhAU_MG4uvmk7nVJbOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: update example
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:35 PM Johan Jonker <jbx6244@gmail.com> wrote:

> The Rockchip dtsi and dts files have been bulk-converted for the
> remaining raw gpio numbers into their descriptive counterparts and
> also got rid of the unhelpful RK_FUNC_x -> x and RK_GPIOx -> x
> mappings, so update the example as well.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
