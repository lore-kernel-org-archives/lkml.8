Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B0FC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3539622314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgATRJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:09:13 -0500
Received: from foss.arm.com ([217.140.110.172]:34844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:09:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A5531B;
        Mon, 20 Jan 2020 09:09:12 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FCC83F68E;
        Mon, 20 Jan 2020 09:09:10 -0800 (PST)
Subject: Re: [PATCH v3 4/7] drm/panfrost: Add support for multiple regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200114071602.47627-1-drinkcat@chromium.org>
 <20200114071602.47627-5-drinkcat@chromium.org>
 <7e82cac2-efbf-806b-8c2e-04dbd0482b50@arm.com>
 <20200120170343.GE6852@sirena.org.uk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <aed32f5e-34d9-966b-98d2-2af3d311894a@arm.com>
Date:   Mon, 20 Jan 2020 17:09:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120170343.GE6852@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2020 17:03, Mark Brown wrote:
> On Mon, Jan 20, 2020 at 02:43:10PM +0000, Steven Price wrote:
> 
>> From discussions offline, I think I've come round to the view that
>> having a "soft PDC" in device tree isn't the right solution. Device tree
>> should be describing the hardware and that isn't actually a hardware
>> component.
> 
> You can use an implementation like that separately to it being in the
> device tree, it is perfectly possible to instantiate devices that have
> no representation at all in device tree based on other things that are
> there like board or SoC information, or as subdevices of things that are
> there.

Yes - and I may yet implement a "soft PDC" device if this turns out to
be more than a 'quirk' for a very small number of device. But like you
say - it doesn't need to be (and shouldn't be) in the actual device tree.

For now though I think the code Nicolas has written works well enough
and it's only really worth 'fixing' if we end up with too many 'quirky'
devices.

Steve
