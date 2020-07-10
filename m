Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1044207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387900;
	bh=roVKF9WachsmsskcJZjXabT8G0JYpFRwtH55QGG8Ys8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EGVn3ElNLXeEbrokCZMbyXZz6p7s1r3glEHlP/05tpO8U80mhSAoB+arZ+3ztnNnV
	 UiHjXWN251mtjc5ztEkgi/qonDS2mnSWk/itp4lCqA76wLTRWLTf9rPD+hpyhjW1tE
	 ZoLQEdxx7bmxNPvtR4ZtawjO6RyPfgARi/ENO2ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGJNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:31:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE8620578;
        Fri, 10 Jul 2020 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387898;
        bh=roVKF9WachsmsskcJZjXabT8G0JYpFRwtH55QGG8Ys8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ovFL5uznNZwgSUCQqQuc49b3L2yB3zwOqRg1TS2fda5WJPfTXSySKVdluS6kFtKN
         07MFLtqfnOmOQ5Uawwt/84sGSEpq6JEHsJ+njKN+vIMFwxKzYUMtBJKb38CwLzT4hj
         ZpK+Zy7lAui02JYNYC8edVnp2a50pKcidY4K1t6M=
Date:   Fri, 10 Jul 2020 15:31:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 2/5] driver core: add deferring probe reason to
 devices_deferred property
Message-ID: <20200710133143.GA2085030@kroah.com>
References: <CAHp75VegHLG5tgVFjwmpmDfSqELqNXcb9dFSM4jLRx+anW7Lsw@mail.gmail.com>
 <CGME20200702134434eucas1p233a3f66f5bdb4b97f4f49d2d43d45297@eucas1p2.samsung.com>
 <20200702134421.6412-1-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134421.6412-1-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:44:21PM +0200, Andrzej Hajda wrote:
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is dev_err_probe function introduced
> recently, ie. if dev_err_probe will be called with -EPROBE_DEFER instead of
> printk the message will be attached to a deferred device and printed when user
> reads devices_deferred property.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
> v8:
> - improved commit message

I'm totally confused by this series.  Can you resend the whole thing,
as a full series, not just random individual patches in the series
incremented?  It's a pain to try to fish them all out as to which is the
"latest" with all of the needed reviewed by lines :(

thanks,

greg k-h
