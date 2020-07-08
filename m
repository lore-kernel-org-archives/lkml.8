Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2CE206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgGHKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:32:16 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:32856 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgGHKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:32:16 -0400
Received: from belgarion ([86.210.166.159])
        by mwinf5d09 with ME
        id 0aY52300c3SgWc603aYBzt; Wed, 08 Jul 2020 12:32:13 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 08 Jul 2020 12:32:13 +0200
X-ME-IP: 86.210.166.159
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 06/32] usb: gadget: udc: pxa27x_udc: Fix a bunch of kerneldoc issues
References: <20200706133341.476881-1-lee.jones@linaro.org>
        <20200706133341.476881-7-lee.jones@linaro.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 08 Jul 2020 12:32:05 +0200
In-Reply-To: <20200706133341.476881-7-lee.jones@linaro.org> (Lee Jones's
        message of "Mon, 6 Jul 2020 14:33:15 +0100")
Message-ID: <878sfuxpp6.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> Mostly bitrotted argument descriptions/names.  Also the removal
> of a blank line in the middle of a kerneldoc header, which is
> not allowed.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/usb/gadget/udc/pxa27x_udc.c:398: warning: Function parameter or member 'ep' not described in 'ep_write_UDCCSR'
>  drivers/usb/gadget/udc/pxa27x_udc.c:398: warning: Excess function parameter 'udc' description in 'ep_write_UDCCSR'
>  drivers/usb/gadget/udc/pxa27x_udc.c:479: warning: Function parameter or member 'udc' not described in 'set_ep0state'
>  drivers/usb/gadget/udc/pxa27x_udc.c:479: warning: Excess function parameter 'dev' description in 'set_ep0state'
>  drivers/usb/gadget/udc/pxa27x_udc.c:506: warning: Excess function parameter 'req' description in 'inc_ep_stats_reqs'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1476: warning: bad line:
>  drivers/usb/gadget/udc/pxa27x_udc.c:1697: warning: Function parameter or member 'udc' not described in 'udc_enable'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1697: warning: Excess function parameter 'dev' description in 'udc_enable'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1750: warning: Function parameter or member 'g' not described in 'pxa27x_udc_start'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1750: warning: Excess function parameter 'bind' description in 'pxa27x_udc_start'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1784: warning: Excess function parameter 'driver' description in 'stop_activity'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1800: warning: Function parameter or member 'g' not described in 'pxa27x_udc_stop'
>  drivers/usb/gadget/udc/pxa27x_udc.c:1800: warning: Excess function parameter 'driver' description in 'pxa27x_udc_stop'
>  drivers/usb/gadget/udc/pxa27x_udc.c:2358: warning: Function parameter or member 'pdev' not described in 'pxa_udc_probe'
>  drivers/usb/gadget/udc/pxa27x_udc.c:2358: warning: Excess function parameter '_dev' description in 'pxa_udc_probe'
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
