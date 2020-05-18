Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA899C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8320873
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WThf6v1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgERH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:27:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B04C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:27:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so7130360lfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJ1XXZHLa809JrkSNxJUZ/JipPd9aJu34AY2ufR3PJo=;
        b=WThf6v1b6S2KxRbXHj/9Oireu+MyynbbLkZ1MFbgL3pLhqoZU3sMzsuLnY4tZPZbJC
         OTVz8qGaqEcrRFMJQICoweiOLOujVkUsCilRtMPhCsXoLyy+FELnX/nhWCMIzmA1St57
         oeUHl3W+6aUyb3OwzFTerXc9zhRbFR/bJoqv5TVrh2G85xFBxYFXz/BPPv8GZx8fwIJQ
         0R6ZdLiEC0LCA8vYMQl0dSWZUBEP/5bhoO+5M26+ytXWp8auEv7eBex7vaWTwz0EbxIn
         9F8H+SSiUO1Sthj4JCkE+s746yY3wUBcbpwzFei2RmRLR4uKpyllD3mXJJL2HWyzV3p4
         n2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJ1XXZHLa809JrkSNxJUZ/JipPd9aJu34AY2ufR3PJo=;
        b=guNyORPCF5m/0HbAOKZR/Tg8+uXWOfU07sezIlKIHNsdCVxcuNjviKLrhvwJuuqT5r
         oDg+wE6B7OfLcH4kn785rc+utFM7Dlsa4amoEbpBO515lM15hXI1QOE0qlEp5ySxFTxx
         Wz5nJX70RnuVAwWAsjqiq009pEEjEzNRuR/7MNbHKSNTLf9H10Jon30wTgYuAD5bEPm5
         zHZV6ez7nxtLYmS+GwBVqcoTIN97HxcJZ/AuVZIwVhs+RkBjalos3L5CGS702lCv9+T/
         Rk8cXloo28ifveUNBghX4vq1hz1t9Jlos/ZHfqB9nVgvmNnvi6rVGNG8Y82j3Odad6mE
         c1Ag==
X-Gm-Message-State: AOAM532RAt3WSDixmnlZ2iUk6Bbtdgt6nYZjzQ1D6QpRNcQGJQbQEjBu
        ke1DoSIK7MWyJpPH7qHcX6v1AhysIGBpafGomuYmuw==
X-Google-Smtp-Source: ABdhPJwn0fBaC73INjIQqOnlFYImDyV2n9kQ81vMCk0gUG5pmQgCYmTGjK7ExSWik+vCggtw3kskUhG8gk8uMqBmThE=
X-Received: by 2002:ac2:5588:: with SMTP id v8mr10381677lfg.217.1589786831617;
 Mon, 18 May 2020 00:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com> <20200513095720.8867-6-ckeepax@opensource.cirrus.com>
In-Reply-To: <20200513095720.8867-6-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 09:27:00 +0200
Message-ID: <CACRpkdbj0JvTWb1AFgaM1iV0a_OvPbN45c=y231u-M286TJpmw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] pinctrl: madera: Move binding over to dtschema
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:57 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Looks good to me.
I assume Rob will apply this?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
