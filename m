Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A98DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D0820838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imC5TArq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgHZLDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgHZK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:59:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:59:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so1859829ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ07glJRUlujBHQIx5bKBzGB4Fimv+n7xk0tDfDGawQ=;
        b=imC5TArqeZzinupXCuhbCqJNrpAWmo9t9jlD7hJhFyWU81ail+EURE1f7j22wwVriD
         26x03YW4SsJeVCT72uhIV+SWLV6VJazC+aXCxNij5qAb0QsQXUBB5R9KOKf5EzCAmxxQ
         yfwtwINlWLYIaA9yOzXqF9etCk5BltbOGEjv/Jyd0NwQ+eByVYdUV55bzbl1keU8tPfz
         cHUm70tvDnby9saPlRC13G+MJlPHKV2Q3G0YqIwksa9JZ7XGdc7Zi2/+2TLL/gyKquhD
         PGpGQ/7DeBPAcKsaMGNzz/6rrm3riqx4sWAtLWkSUJB8us6ArRkDlsQ/tSiuTCf9Jhda
         EHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ07glJRUlujBHQIx5bKBzGB4Fimv+n7xk0tDfDGawQ=;
        b=K7kw8SGum4hdJ6M1UBGWCXzWt1cxHBlOwCOND0Ohn5kDizMlxagAF8q13SIkGgqICc
         0VGb24mgL85MICUjDbTbMOLZV4oAasEnCdDbSHfRufjxSuv1bHcce2GJpaxBO6V/ziR7
         A9Xw2cg487rCnpq6j+bYRKNCfwIW0gkf0j/QAPUPD0MRW2jaeyAhQJRdEDIYUk+7PwBR
         6rXhLbKFnhkANylA0aiXedfnx+LlwBn59QKHl3MxbekNr5ECSX0DoW8M04MgKFWzOoWf
         Gkir/En9aQ5qziHr74hFB6ZsOCYHlGuvoJiz1v8AgV+tMxAZ7/Uj0oDcWTrNL+fZIMBt
         W0Vw==
X-Gm-Message-State: AOAM530+xBXiPlDrggHGLNSJmFH4tN5k5Gz4vGmnHXs9UdCHJpyjSQ3q
        U/BuP2hAQsbq3/NefBtewLNUU1iZvc3AcgnjhH8=
X-Google-Smtp-Source: ABdhPJwnAhNtvGts/m9GSYWVu4CbYcH2h0n/znDkPvUH2bw1aDzmSWvWr0jJIzTxWBkAGcuiQemJqusogm4e4Jlk4Og=
X-Received: by 2002:a2e:9c8b:: with SMTP id x11mr6377914lji.218.1598439579576;
 Wed, 26 Aug 2020 03:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
 <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
 <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
 <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
 <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com> <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
In-Reply-To: <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Aug 2020 07:59:28 -0300
Message-ID: <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl:
 tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Aug 26, 2020 at 7:32 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> But the previous platform data that was removed in 8cdcd8aeee281 ("spi:
> imx/fsl-lpspi: Convert to GPIO descriptors") set different values for
> different boards. So maybe some DTS should be using num-cs?

Could you provide an example of an imx dts that should use num-cs?
