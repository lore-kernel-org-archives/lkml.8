Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061852078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7IinM6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHZPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgHZPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:24:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:24:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m22so3389235eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9x0ycL1XFrShopot+03WmqZeGgtPZTl9aD3LEaSjmx4=;
        b=Y7IinM6ZUKTtXipGA7LaNbiDXJj2W6H+embTruHch6qWuMQl1IKvqpRDyJ39YfjKv5
         IIRLpLlufOdyCspVWYAhAZ+Lwl6Bx5a87yJPlnYFlsQWR+KA/Ebq45z3aFM7P4eqAY3K
         a6TFD1j04hqGAqK9GAa/k4PhAv4ac4xtFcQy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x0ycL1XFrShopot+03WmqZeGgtPZTl9aD3LEaSjmx4=;
        b=d9HGyhPVsYPBJ43ajIiT0SE02SQkN1QtmPSSpHYuBtl0Aj1W/2bgsNu4iYjtJE7cVK
         EQ9AQJvgXW31D7EAX/edYjjUAtSnJIHIm3uhp/Nb47DlyKqBLui0a0zdVk/AAMoZ4AeJ
         vT+1L8WWk1dC00f5nZCbMHxMAJg/0xmDiL0F/WK9XIXiIkMZoyjVuABbAJa3ctZxzyJF
         A7GXM3od+1Qffv7wUwvH63Oe9z4S2pVYStQ8WEaknS3yO//xSJb68GlfsmLcNMQywQpx
         Vd3NuDi440/20JiXzCVfT4iwNvbXNCRrbwOHLgTXnz4BZ+9KUjg9PdKVdLb/cbzMHprZ
         9mMQ==
X-Gm-Message-State: AOAM5319YFfF9bT4Ei2gBOuBUEIGCLUNLrgSNVNfhCtHyY91W4osHyJC
        BbGpGQw5s/SftOufEHtxdJuMDOdJ/d5CQQ==
X-Google-Smtp-Source: ABdhPJzvWBtAA2zA+GmZ7TmKCH2GjC1eP7/+S/DA+wkhxro44sZdKk0cZVttbFWz7Kojr7QLGPlemQ==
X-Received: by 2002:a17:906:ad99:: with SMTP id la25mr15499971ejb.63.1598455443543;
        Wed, 26 Aug 2020 08:24:03 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a8sm2448748ejx.73.2020.08.26.08.24.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:24:02 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id c10so2089758edk.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:24:02 -0700 (PDT)
X-Received: by 2002:a50:b081:: with SMTP id j1mr15023825edd.291.1598455442039;
 Wed, 26 Aug 2020 08:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200815033908.3108730-1-gwendal@chromium.org>
In-Reply-To: <20200815033908.3108730-1-gwendal@chromium.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 26 Aug 2020 09:23:50 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Cz-C7_xEV6G2=P6yVjiF_VNhCc4H5BJ961m-ai8OUNFQ@mail.gmail.com>
Message-ID: <CAHQZ30Cz-C7_xEV6G2=P6yVjiF_VNhCc4H5BJ961m-ai8OUNFQ@mail.gmail.com>
Subject: Re: [PATCH] platform: cros_ec: Add fields to command traces
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:39 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> In ftrace, add more fields to the cros_ec command event:
> - Add size of commands to check if they are properly set.
> - Add offset (in case an EC is cascaded being another EC),
> to allow proper command output
>
> With:
> echo 1 > events/cros_ec/cros_ec_cmd/enable
> We now have (on samus)
>
> invalid command for the sensor stack:
> ectool-6942  [002] ....  3082.783116: cros_ec_request_done: version: 3,
>  offset: 0, command: EC_CMD_MOTION_SENSE_CMD, outsize: 2, insize: 19,
>  ec result: EC_RES_INVALID_PARAM, retval: 0
>
> powerd accessing PD EC being the main EC:
> powerd-1272  [002] ....    40.644026: cros_ec_request_done: version: 0,
>  offset: 1, command: EC_CMD_USB_PD_POWER_INFO, outsize: 1, insize: 16,
>  ec result: EC_RES_SUCCESS, retval: 16
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Acked-by: Raul E Rangel <rrangel@chromium.org>
