Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981132076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404587AbgFXPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:54 -0400
Received: from foss.arm.com ([217.140.110.172]:32964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404564AbgFXPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EECF1FB;
        Wed, 24 Jun 2020 08:16:52 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDDE13F73C;
        Wed, 24 Jun 2020 08:16:49 -0700 (PDT)
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com>
 <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
 <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
 <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com>
 <20200624150434.GH5472@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <381de683-df5e-4112-5690-13dd9272ae22@arm.com>
Date:   Wed, 24 Jun 2020 16:16:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624150434.GH5472@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 16:04, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 03:25:33PM +0100, Robin Murphy wrote:
> 
>> And yeah, anyone who pipes up suggesting that places where an ERR_PTR value
>> could be passed to probe_err() could simply refactor IS_ERR() checks with
>> more uses of the god-awful PTR_ERR_OR_ZERO() obfuscator gets a long stare of
>> disapproval...
> 
> We could also have a probe_err_ptr() or something that took an ERR_PTR()
> instead if there really were an issue with explicitly doing this.

Yeah, for all my lyrical objection, a static inline <blah>_ptr_err() 
helper to wrap <blah>_err() with sensible type checking might actually 
be an OK compromise if people really feel strongly for having that utility.

(and then we can debate whether it should also convert NULL to -ENOMEM 
and !IS_ERR to 0... :D)

Robin.
