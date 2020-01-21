Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5922C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE5324656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAULhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:37:17 -0500
Received: from olimex.com ([184.105.72.32]:50061 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:37:16 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:37:12 -0800
Subject: Re: [PATCH 1/2] dmaengine: sun4i: Add support for cyclic requests
 with dedicated DMA
To:     Vinod Koul <vkoul@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com> <20200115123137.GJ2818@vkoul-mobl>
 <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
 <20200121083514.GE2841@vkoul-mobl>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <54b1a38f-3903-49b7-d20b-f97824a528ba@olimex.com>
Date:   Tue, 21 Jan 2020 13:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121083514.GE2841@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/20 10:35 AM, Vinod Koul wrote:
> On 15-01-20, 18:07, Maxime Ripard wrote:
>> On Wed, Jan 15, 2020 at 06:01:37PM +0530, Vinod Koul wrote:
>>> On 10-01-20, 16:11, Stefan Mavrodiev wrote:
>>>> Currently the cyclic transfers can be used only with normal DMAs. They
>>>> can be used by pcm_dmaengine module, which is required for implementing
>>>> sound with sun4i-hdmi encoder. This is so because the controller can
>>>> accept audio only from a dedicated DMA.
>>>>
>>>> This patch enables them, following the existing style for the
>>>> scatter/gather type transfers.
>>> I presume you want this to go with drm tree (if not let me know) so:
>>>
>>> Acked-by: Vinod Koul <vkoul@kernel.org>
>> There's no need for it to go through DRM, it can go through your tree :)
> okay in that case I have applied now :), thanks
>
Hi,

Should I keep this patch in the future series or drop it?

Best regards,
Stefan Mavrodiev

