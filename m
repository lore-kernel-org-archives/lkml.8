Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F71C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="fVlYSUL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgCKKXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:23:35 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:56892 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKKXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KUYFXWlpQlmFH24r8Wc5r2V9DxU5tyqeUGSEwgUr8+Q=; b=fVlYSUL8RtKiaLK+JCly783CUT
        bQDL7isowG8X1gOXi2I85W5/gMHUHIC4FSzD8OW1/o61mz0vWnRudp/zGM5c3t0qzaa7i8ETgfqqf
        a8KVpjSFwT4VR0KeXhB2LxdDqpCRIe2GiAaceLOEOBIKLgIFfn9EW6JNzqEGo2dGrOdgCB+pfzAit
        b9pMpMjFeD0QwAipMjZGS5alpouqBRrbGS/0cSEtx3bWL9YL50o+Sr0WDooGTSiQSLWiv3UtAE4Us
        Nkfae1FhXs5St/J1DAjVMf1MA/eKiVIAtcNOr56M10d7vcZ6VBQDIIc2jadGIvKUBlGU51V+6fQf2
        3/DMnvhQ==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:33546 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jByWN-000AQ6-8k; Wed, 11 Mar 2020 11:23:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 11 Mar 2020 11:23:27 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] drm/panel: Add Starry KR070PE2T
In-Reply-To: <20200310185422.GA22095@ravnborg.org>
References: <20200310102725.14591-1-dev@pascalroeleven.nl>
 <20200310102725.14591-2-dev@pascalroeleven.nl>
 <20200310185422.GA22095@ravnborg.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <280a128711458950b55b070dbf6f07a1@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-10 19:54, Sam Ravnborg wrote:
> A few things to improve.
> 
> The binding should be a separate patch.
> subject - shall start with dt-bindings:
> Shall be sent to deveicetree mailing list.

Hi Sam,

Thank you very much for your review.
I did consider this. The reason I combined the patches, is that the 
binding depends on the display so I thought they were related in some 
way. Didn't know the correct procedure to handle this. I will split them 
apart in v2.

>> ---
>>  .../display/panel/starry,kr070pe2t.txt        |  7 +++++
>>  drivers/gpu/drm/panel/panel-simple.c          | 26 
>> +++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt 
>> b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
>> new file mode 100644
>> index 000000000..699ad5eb2
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
>> @@ -0,0 +1,7 @@
>> +Starry 7" (800x480 pixels) LCD panel
>> +
>> +Required properties:
>> +- compatible: should be "starry,kr070pe2t"
>> +
>> +This binding is compatible with the simple-panel binding, which is 
>> specified
>> +in simple-panel.txt in this directory.
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c 
>> b/drivers/gpu/drm/panel/panel-simple.c
>> index e14c14ac6..027a2612b 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -2842,6 +2842,29 @@ static const struct panel_desc 
>> shelly_sca07010_bfn_lnn = {
>>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>>  };
>> 
>> +static const struct drm_display_mode starry_kr070pe2t_mode = {
>> +	.clock = 33000,
>> +	.hdisplay = 800,
>> +	.hsync_start = 800 + 209,
>> +	.hsync_end = 800 + 209 + 1,
>> +	.htotal = 800 + 209 + 1 + 45,
>> +	.vdisplay = 480,
>> +	.vsync_start = 480 + 22,
>> +	.vsync_end = 480 + 22 + 1,
>> +	.vtotal = 480 + 22 + 1 + 22,
>> +	.vrefresh = 60,
>> +};
> 
> Please adjust so:
> vrefresh * htotal * vtotal == clock.
> I cannot say what needs to be adjusted.
> But we are moving away from specifying vrefresh and want the
> data to be OK.

Just like Ville Syrjälä, I ran the numbers and vrefresh indeed 
calculates to 59.58.
