Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF07BC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdsH+HVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgELLk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgELLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:40:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:40:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so13242808ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBh2Ij2Mc6h1eHLqGqNAJkOw3+vCEXsNgr9h5z6JXHE=;
        b=DdsH+HVDDy5Lk88AKbz9Gwhh8b52rNXxINS4xMWgwDF9EzFtPlwwQAOyKpPTClcpPa
         6jdvgWcUtP5wPYp37W3M2+Mem1mqzhq++9PcWbyaqJ8gHc1zi6NgMfrL3PzO9/CafO8b
         JBeN2FUzaty9be3xf5OFXu91V2fktRRIhP47AuIa9/EUo9+OxbgktJ0rPnWpdsVOGCch
         +lF7y4MIBOUpciZuYEG1/RUNkBnkI55ce524lSvcCeQXqOsBFMc4UTG7X4yayGrrlug8
         0FD80EJ0z4UI21COSMt2BAcOGiKrHzufzzzQj2C/w82DgQNrapc9oNhDS0Dxw+lcAgqJ
         cz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBh2Ij2Mc6h1eHLqGqNAJkOw3+vCEXsNgr9h5z6JXHE=;
        b=VnDXI6zuhA8BEMbpGOOm4UHYl8oYmIzBm9QRcrDtQrh9+6z41K9jdxZVluFpbkALne
         DZHLWlxBoLItkW7nd5jGUmZZM7nbQMUipV0zc7tSSJtk3YP1HKApzWDoDs76xgkHs6oI
         j5yrcL+BVSmZtaja/n76Q7omLn9YzSosPagIHwhgEYclGq8QptT9VOUL/8Gt25px/haO
         q8XmoOZ4YgP6+de1q/M+O1AGh1MjRuuwQhrzrHtduKiolkm8anP4SUZuqw6JoJul1noA
         gvkqClRFUFhh0oKLr5NpuBX4a7Mf97PDjb1rS/48y3qza2OCWxI6KEI09oPyp/zc4JKj
         nnSQ==
X-Gm-Message-State: AOAM533o3lTfC3dgLNyr0ESiJvgy6HDT4B7NzM8ZfQqXn0ZmeP00vghE
        qmAMcRuIkvnVWy8a5H/VZhdwk9gLQN4SSYg8UD1kTA==
X-Google-Smtp-Source: ABdhPJyheSvf/myT4amp2PYksMYzI0WE9OfPY7CV27uprn8yiolw1+hJowASwtw1CCetz1J8xzyyI9ikYuKe4P+PnmA=
X-Received: by 2002:a2e:b609:: with SMTP id r9mr139112ljn.125.1589283655695;
 Tue, 12 May 2020 04:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com> <20200427102812.23251-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20200427102812.23251-3-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 13:40:44 +0200
Message-ID: <CACRpkdZA9vs+ppSybk=kbByyOmbsmmEcMWpytn_LX_b0Kqftqw@mail.gmail.com>
Subject: Re: [PATCH 3/6] pinctrl: lochnagar: Move binding over to dtschema
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:28 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Patch applied.

Yours,
Linus Walleij
