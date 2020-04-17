Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1096C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9894620780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nhSCvAIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgDQTB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgDQTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:01:55 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DEC061A0C;
        Fri, 17 Apr 2020 12:01:55 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so2263061edq.7;
        Fri, 17 Apr 2020 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ws0lGObjtWkfbXmBqtfEqFJnV5cJRhTx4fqD0Q8cnBs=;
        b=nhSCvAIn9SOUp/QSQE0a0stljfg8bCGxS/WVOKNAq32tSji2T/MlLN6N5hKSkGs8Q1
         1Hj1P4OBFNbPEuexW2ofGFBJfn2JCZo/h/oBQtj3R+49YApA8xLc9FcENfylm4uZsihr
         PrN3wtI2fyzkxaICZKRlp0Q6qiVeoAMwvDPPmqTmKJpPBpHL9Wlb8FAhu4tTuWNXihox
         i6BZIRxCvdlNTKi6P6++kC1qTTbz2pJsm8GwDRMi3IFnC6psIAObSJOyRv8SOy/9LDea
         kVO0ulyl92+e3ra0I4rZpAXxTtOE5sSFn94sL9qAMs9BHRmLpMgIGprNpDuBiIo2aWcr
         GtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ws0lGObjtWkfbXmBqtfEqFJnV5cJRhTx4fqD0Q8cnBs=;
        b=DeBDyJ1j5c+uddKUXViG6wxB3TSHkF0zo0oegZYpvhKuD+gd4PN3R/q+tSAUjCiRrZ
         qMihFK9rcoyMgF3u0uYmeumo2rdKxV1Zn8CQ8nHCOAXYEr3rEuj9jO5UM6vq/Z8x0v2n
         YscbK6zm3l/tiL0WsJHUqhq1azqIwyN+rzi9vrGY9GsCYVqGtJcwAT28xHMxGKaoFpWx
         wqt+Vmb/W4tEhLKvtys3bFU7h7aeEa8F+b2zSXBLSVS0JQEWRTec67sPQj5g+dberjXm
         dPy+UZAsXYkMu/hKZ6yK30yGA8mfamjGh5Li0FqF50igw+JlKDywx1ngZefIWxMWUKWm
         IilQ==
X-Gm-Message-State: AGi0PuZRPsFghET5JY3nsWRxFrDE/dH4wO2NPHkI1NZm80SL6wgpbaEV
        PoKGvbCNRcIiMHfhyb++3JR1p49i7YKVUPIvjWo=
X-Google-Smtp-Source: APiQypKxFRcocN12xEBF5koGWzrxYBcKMvJXbVGzd+MQqeyCeALK+IsccNlNdyjEYO6sxS47F8FsDBlkB2FlBJzQWwM=
X-Received: by 2002:a05:6402:1496:: with SMTP id e22mr4449267edv.301.1587150114192;
 Fri, 17 Apr 2020 12:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200416121910.12723-1-narmstrong@baylibre.com> <20200416121910.12723-4-narmstrong@baylibre.com>
In-Reply-To: <20200416121910.12723-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 17 Apr 2020 21:01:43 +0200
Message-ID: <CAFBinCCPZCNsj=dA3_fzrPqGCrpRzeJ7OPGErFvUeKW=iW-r9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In order to add support for the Amlogic GXL/GXM USB Glue, this adds
> the corresponding :
super nit-pick: if you have to re-send this for whatever reason, then
please add "new compatible strings with" before "the corresponding"

> - PHY names
> - clock names
> - USB2 PHY init and mode set
> - regmap setup
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
