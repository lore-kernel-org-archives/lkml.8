Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CCBC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A21E206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSzf/+ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgD1JUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727055AbgD1JUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:20:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFEC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:20:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so16295737lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICN7dCbBx+6WcoJArMnBEzGvK72rSzOZiK5dL2bPeD0=;
        b=GSzf/+wsv5cyATIz/phw1ojwp4XlksxZM2jEHxqwTKLBsfOj2Tm8SPZhPYNBd+ZYiw
         kkFCMlrO12KSyLfwW6Npq2lked/S06URs6P2h7WJVdy8hHZ+CBtRGQCAQDMgJyyyLRaO
         IvBJ7XYQ5jC0tIiRtVPN2ODt0VtbClcg2ZPs2tMKCR1du0uNpaTy0bAsbdFeW8k/6lVQ
         KjKh1X855w6wNtJ5KK+z0/TMd5dyQCBrcsoXmCGNxSxdiKBaLmy+WoA5p4sO8gqIU4K/
         yvpoXibwcg0tLpNTItn8e408z//AZ+7vFd8F9xxOLytU2lVZhMpt9K7sasBX3FT6nu4o
         4phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICN7dCbBx+6WcoJArMnBEzGvK72rSzOZiK5dL2bPeD0=;
        b=tE0UmvkRVpvVnuq45vW0SIFn0dd56GYEAKPFz/aYi730hlcb816nGzA+C2VKv1yYbm
         Zl/78OzWjT9AzpUVwvN1WdgW8O8skV9hbuy0h0J1sFl4s8ivk5DUQRc6xHl9n8HK8zcZ
         ReywfEtu/h+5KC53u8iElFVfUj4dS51Az2lRlokrGwIU56sZXlSJ4tkN2f6YsMjybfgU
         rpn5xfSYvbUhdc3DF+4iCOjPyxypKul/bD6YsQzMNFyfzi2NfZK/drlYjbyXqLPEYyJH
         6h95Ubab0xfV7tVKynEUanXUwzt+4yxmlW+FDBnpxsWN1quL1WzvupIe1jL12s0L86LS
         9Jdg==
X-Gm-Message-State: AGi0PuaSek/1P2jIpDuGM1axn5BpcGJe50YOkphqnnkt2eQ7X1TwB2Gr
        9ODnWq7mMyXmbYep7fW4/70uWupDrLonpQazUnbj7AsE
X-Google-Smtp-Source: APiQypIus6ZMe4qjasmN97t76YaFjK6cebZ/M2PBOdjLaAbJq41X1LdszKoDynGbta+EZNl04COKBV/jynSPVQp9okk=
X-Received: by 2002:a19:42c3:: with SMTP id p186mr349742lfa.194.1588065647258;
 Tue, 28 Apr 2020 02:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 11:20:36 +0200
Message-ID: <CACRpkdb9ZmoD5x1g7O-BHFWJ3qNMBGrrVN_=ygDAMuXe76xuFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Qualcomm SM8250 TLMM binding and driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 8:19 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Binding and driver for the Qualcomm SM8250 TLMM pinctrl block

Applied both patches. Thanks!

As noted elsewhere Qualcomm is full circle now recycling the
number of their first Snapdragon QSD8250 SoC from 2007
for a new SM8250 SoC only 13 years later :D

Yours,
Linus Walleij
