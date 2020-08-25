Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C228C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EC52075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BslcMvlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHYMvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:51:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15346C061574;
        Tue, 25 Aug 2020 05:51:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y2so13676079ljc.1;
        Tue, 25 Aug 2020 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z0t3K+QLoeioxTOOGGcWlYv6LhGdZE1xgkuzCwfl6I=;
        b=BslcMvlA00KIenKbUhG69iU/HgJJyCGKkU9LCQGUJg4hzTV1AF7AtA3IfXyHYynqkj
         E584RJXo+mJRSbQ0t1i3M9BS4bWr9T9tpRsi17etVCkqu+a45wbxGP5C6h3ZLn34T+mz
         F6HNbTKtgGDK639gCsCx+yvuI/IoQ6asl1cGmoC95/cTtCAiJ7RhdZwaNiCyfNikrywR
         c6wFUV9CXtNpOj4Y2Uath3LcmZaB++Cw6hTngDM8HpXsq+17+ebKIFcj3+sX1cU93ZPX
         6sWVaCJ/AZPViXuGBBYD9Z6KbC8z9Zc7mmF1RlQHXDKnFdpWc/ExxDbE/X9cN+pJRCxk
         J7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z0t3K+QLoeioxTOOGGcWlYv6LhGdZE1xgkuzCwfl6I=;
        b=gKynM1Ztp9jkZF0328284qIQyvpWklQbgcGaGGNJ4cPTNq9YsfMoRxzxT8befaciql
         llYwH9enWgHfo/H+tRLaehFVSd0QceXU5+QkMndKrZnRXCEwsy7l+JW0Y5zlhmK9tbEj
         pmXOSb5saFtd/2reQq/PBEM7A3ZraDdu2DuYX/ljv2+jcW+UKBwpOkZ6nS0l/6XM68m/
         V1MWlapOhuhnhK9onjtxjoHBK2jfSAp3Cuzc0Zl0shVUH5qmxcBmHta082jZLnLnz6j+
         igZQpxi1jueBHPP14qc2U7cs/sOJa7WJCGef92ZwuwlSEFnm93zHW9Z80P+nwI9ZchLe
         1WoQ==
X-Gm-Message-State: AOAM531TS7L0UuLLGqxSwp81i02KwLhwZv5mZ+0hN01og7sTRAtK4Z/P
        lQf1GpbekKQQfpPDP8xwZSoW6d6pWblBzeu2YC4=
X-Google-Smtp-Source: ABdhPJwmAXSB4sPIlEhiDhTQQ4uyWKneA5ej6i1dzJ0HZftooX5KdSQEzmLDZQNCBJ71+jbZrBVTfavtSJ1qlp4VYFA=
X-Received: by 2002:a2e:8ed4:: with SMTP id e20mr5152175ljl.403.1598359863461;
 Tue, 25 Aug 2020 05:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825030406.373623-1-cphealy@gmail.com>
In-Reply-To: <20200825030406.373623-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Aug 2020 09:50:51 -0300
Message-ID: <CAOMZO5C3MpiV_c0iwQHmf74O35WpT1kkwtkASSBoFnL+=JXvJA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: nvmem: Add syscon to Vybrid OCOTP driver
To:     Chris Healy <cphealy@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        stable <stable@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Aug 25, 2020 at 12:04 AM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Add syscon compatibility with Vybrid OCOTP driver binding. This is
> required to access the UID.
>
> Fixes: 623069946952 ("nvmem: Add DT binding documentation for Vybrid
> OCOTP driver")

Fixes line should not be split even when greater than 80 columns.

Shawn can probably fix while applying it.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
