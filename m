Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26823C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C022145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st0iZapP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDTHgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:36:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B9C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:36:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so10150627wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mb0X0VbhAnhVtMeOXLuQ8HsuJ6uYYtL6iIOac3n0PJU=;
        b=st0iZapP+zDcsQ4UrQb7rcM/hsGHFlairhxjzCU+eWwjjuseXuqjJPI+WXPiBeW+Ul
         493WUgOLbd3mEM16Cz06eaR8/6bMoVqw5mTtKi8z4TMnE1oxQVpLJVVt+gfkQ+awZtBz
         Llr3jJX2BwEJq6rwnMOXeZHh0HD0SCgTsSVh4nnX6ZlTuAdVem4zbngqA18U1cPELUZ/
         sp8zegHh6y8ehz3646WCK8B67qgzanSNH1hLnjoluhIns84gS4L6UP74qr+2o2ZskG3I
         UFiPAJ0w6uzb0ZGGR3YkpjjQ3s73dRbet54XvXOraKAVsFDH372JkVtKLsg+g+bV0NQf
         x8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mb0X0VbhAnhVtMeOXLuQ8HsuJ6uYYtL6iIOac3n0PJU=;
        b=KGfrgRgV3Apr1/1Fvp8TltzPBUUdok+2pRZOC4G7o/jUfqy3v/SXiOYTBRm8nnUlHx
         vBUwmivfagrle4AGvgMyItWVofRitH/eYUjtB4nqulp/aH6j6q6nXjy+n6qfAigQxyjF
         roWX2/vYY27IOzQN28/nR8YYJbjmt9e/0Y2/w2i+gc9bsJ9wiis7JYu2ZBoY85efuapw
         9yE/u8tEeLBY7fQxL5s+Ig14ScMN+Ycbc1roz2haj+AyLxdLeQjFhhzaSjDMEfQjvU8/
         L5f5Lji5MSsQBup9URHBh8ehhHkGTo13vk2HW37UIsPyG0GBbdUpZ9Hdx0HBPhkljoPE
         StvA==
X-Gm-Message-State: AGi0PuZhEDsHPxJ5/qaAamIXRb/zbiC+L820FoWhuWH7BFR8pDmilXNb
        sr2m9gi4jhI7HLuhXMNrkYN4Wg==
X-Google-Smtp-Source: APiQypJ25Kjm3y9Zgopg3qXJE7CUHbyrlxsvNzWf6js5QWhmpv4/KdDycmxZJtwyZTMEA2yfKfjtHw==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr15810229wma.28.1587368201801;
        Mon, 20 Apr 2020 00:36:41 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id w18sm19085wrn.55.2020.04.20.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:36:41 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:36:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ran Bi <ran.bi@mediatek.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v12 5/6] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200420073639.GL3737@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1586333531-21641-6-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200416091438.GA2167633@dell>
 <1587112169.12875.2.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587112169.12875.2.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Ran Bi wrote:

> On Thu, 2020-04-16 at 10:14 +0100, Lee Jones wrote:
> > On Wed, 08 Apr 2020, Hsin-Hsiung Wang wrote:
> > 
> > > From: Ran Bi <ran.bi@mediatek.com>
> > > 
> > > This add support for the MediaTek MT6358 RTC. Driver using
> > > compatible data to store different RTC_WRTGR address offset.
> > > This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> > > driver which only needed by armv7 CPU without ATF.
> > > 
> > > Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Acked-by: Sebastian Reichel <sre@kernel.org>
> > > Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > 
> > Please place these in chronological order.  They should provide some
> > history, rather than a unordered slab list of random sign-offs.
> > 
> 
> I suppose that you mean the order should be like below, right?
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>

This would imply that it was reviewed before it was written, which
would subsequently imply time-travel, so I suggest not.

Author(s)
Review(s)/Acks(s)/Tested(s) /* ideally in the order they were received */
Sub-maintainer sign-off     /* if applicable */
Maintainer sign-off

> > > ---
> > >  drivers/power/reset/mt6323-poweroff.c |  2 +-
> > >  drivers/rtc/rtc-mt6397.c              | 18 +++++++++++++++---
> > >  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
> > >  3 files changed, 24 insertions(+), 5 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
