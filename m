Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B713AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9494C20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWqv3ou5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFCMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:11:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:11:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so2415516ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfIwoVqhINbM8JX02JQVBFl5UwDmm1K0R0OAHvfku4E=;
        b=aWqv3ou5Qov3U3msHumGanAGhQDq5piVnxaH/XWJmipKJsOeWVNQIztptBeNCtMWG6
         99b3l7r9pG46qUjWpv+WoQs+yVkeYL+OHYfJzjhbwlgDHanfANKMk5J6k2xrDF0jApcs
         ITr+QKkVRhH2NduIS0rGnMoa1juq/PSUMUe+/Vobm+ot+3yv1cd8yFBR8RpnGpZzbD/i
         KGvscj/DzzzJcfsZ/B2RW2XxwxgRgDyru1kGkFLZGIOB4klILxvqMmjRjUexshZjeou7
         IWTl2Oef6qF/8FD3/+nq6Ege6qhULB4qLz6/BgG3qQflgRe1nkZ+ZiOB0fEUutqZ2TNb
         CrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfIwoVqhINbM8JX02JQVBFl5UwDmm1K0R0OAHvfku4E=;
        b=faLcbsJYw+Au3TKewdDE41WlAEs1OexcdiGqI6sV3LDNlw3SYW0CoqoO3SiPkp6OLg
         3aB5G6PfEEHuL2RiktLvwNG2MmwTMNKMryTXstaJtBuNSOHBB7ateWbpZuqgN489RgMD
         SSX6cRd7xXd6UCfKIxUlkV4Ga7ry2T1Uo7MxflUQ/BrA1AsdAux4IcGUqvmvp5NanBMh
         TOmzLhDBe9gATCkNBaCc780voE5l8+Hr7kmSEf2XXHf/uNMdHmKKXHFtcNUtbMABYYw8
         gaFcg2AWxjwNDPG5eYH7Q4EntsH/FKKFafIqvukmHEMdVC95g9xKqMzaZXWpdFlVd8vW
         wawQ==
X-Gm-Message-State: AOAM533E7w2edM3UUfjGPy4kXJQ7Tw9GgprXDi5qgqPDlD800isKrkOA
        y2Xm8//JG/Sn9VhwDYykTEs5EZzaoemcpHrtnZ3E6w==
X-Google-Smtp-Source: ABdhPJwGPqax4Ku+Y+HnI5jIvzA/eJkmp5Pc0XM9c3bmnH0a+2++YRcBgL324sT+NutIXiJsU51+xCLtJmEUSqS/sw4=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr1798631ljo.338.1591186270117;
 Wed, 03 Jun 2020 05:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513145935.22493-1-benjamin.gaignard@st.com> <20200513145935.22493-15-benjamin.gaignard@st.com>
In-Reply-To: <20200513145935.22493-15-benjamin.gaignard@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jun 2020 14:10:59 +0200
Message-ID: <CACRpkdYu2As27M60ogUoLfX1z=XZSCSx5qTLwm5ADdf9Jy7HGQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] dt-bindings: pinctrl: stm32: Add missing interrupts property
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 5:00 PM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:

> Driver use interrupt-parent field so update the bindings to allow it.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Patch applied.

Yours,
Linus Walleij
