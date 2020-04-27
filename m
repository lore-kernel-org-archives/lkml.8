Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A4C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E822420738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpSP43aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD0RFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0RFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:05:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22BC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:05:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so9301710pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugUiSTA51a3TxFzvH/Md8sJqfO5EABbD3KGZpESGulo=;
        b=zpSP43aKOka+ao+TyrRuSjP9XbICnrOvk2mLe/OYmlgP0KXPOh9Y+4BJqAm2Sdar38
         xLRA5zqPQs2DKq8Ydj7/gWTgw2xP/oPerB8VxOGu1JUC1QlcVeV+NBgHrvjswZfnD4eZ
         2HfmLknQQFmIX/aU5vMeXowKtt0B+x0NcUU44KDW9kRpj2yqnggaIw5vKK3EQKD76BhA
         henIaE1eO4hq36X2x/INYe5wRnkFM0deVb3gqqhQBEL9B8GjCFFRwpeGx4xbh1lygQC9
         53Pw9LRS0N78Xppp1rFcUQRhA7SwQn8A3oH4undZIugEiJALgS2gJ74rkZP1DzzkVqyP
         nUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugUiSTA51a3TxFzvH/Md8sJqfO5EABbD3KGZpESGulo=;
        b=cxGnTkbg0WEQweTg5JdBiYdq42KG4EsrDJfs6mO33ge9EtuuZNM8BOVyV5T2z4JKQO
         xL1DA/qqdIaJH2EIo+l479qQQWinA8JRi/wooD7TLndIGUoobUCwgN5g8b9Nl3TuSLXY
         5ks0mhnIDU7MqaO9cPlkh9syrOEZugSr2sGVs8SEisQopBqW5t/EjPmGK4w1b2M7UdMI
         v3OFFFhGn+I+ZeeFthjZ2Vlq0rden4+TiWIK0O6QLdX3dxk9F0Q16tR9cLqwi+K3W+cJ
         +4DJ1x+y8ELIns2Oac5ukdbFQMevk0mj7dX/gBtF4ts0KK3TEMFEXtiDWFfajSjkmK/P
         e5Rw==
X-Gm-Message-State: AGi0Pub1ycQ9C4WioqH6IwlVvDG2qIxoRm0wdvtbB/waISlTGp1wacgK
        D4n006XkYGXwrkz0K4EVfHogk8UBbA4=
X-Google-Smtp-Source: APiQypItDToSKZEi0i1ntlAw5OVKT4qn3Sw0vM2nyEVQmNub6gpTp3JIr7K7r4zvaoRLgGYg7a0Ctw==
X-Received: by 2002:a63:b649:: with SMTP id v9mr21343786pgt.402.1588007141308;
        Mon, 27 Apr 2020 10:05:41 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 140sm10385889pfw.96.2020.04.27.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:05:40 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:05:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/5] coresight: Minor sparse and style fixes
Message-ID: <20200427170539.GC10601@xps15>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:58:00AM -0700, Stephen Boyd wrote:
> I got a report that kcalloc() didn't exist in coresight-cti-platform.c
> on arm builds and that looked like we didn't include very many headers
> to get prototypes of functions like kcalloc(), etc. The first patch fixes
> this problem by including the headers and then the rest of these
> patches fix minor sparse and style issues that I saw while looking
> through the coresight directory.
> 
> Pathes based on v5.7-rc1.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> 
> Stephen Boyd (5):
>   coresight: Include required headers in C files
>   coresight: Mark some functions static
>   coresight: Don't initialize variables unnecessarily
>   coresight: Initialize arg in sparse friendly way
>   coresight: Avoid casting void pointers

I have applied patches 2, 3 and 4, so no need to send them again.  Note that I
dropped changes to coresight-cti.c and coresight-etb10.c in patch 2 as the
changes were already in my coresight-next branch.

Thanks,
Mathieu

> 
>  .../coresight/coresight-cti-platform.c          | 11 ++++++++---
>  .../hwtracing/coresight/coresight-cti-sysfs.c   | 17 ++++++++++++-----
>  drivers/hwtracing/coresight/coresight-cti.c     |  6 +++---
>  drivers/hwtracing/coresight/coresight-cti.h     | 10 +++++++++-
>  drivers/hwtracing/coresight/coresight-etb10.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-etm3x.c   |  2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c   |  2 +-
>  .../hwtracing/coresight/coresight-platform.c    |  4 ++--
>  drivers/hwtracing/coresight/coresight-priv.h    |  9 ++++++---
>  drivers/hwtracing/coresight/coresight-tmc.c     |  2 +-
>  10 files changed, 44 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
> -- 
> Sent by a computer, using git, on the internet
> 
