Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B83C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F0C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="yMmYS8Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbgF2Ulv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbgF2TOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:06 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 04:07:43 PDT
Received: from pmg01-out3.zxcs.nl (pmg01-out3.zxcs.nl [IPv6:2a06:2ec0:1:b::ffeb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B503C00862C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:07:43 -0700 (PDT)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (Zxcs) with ESMTP id BE0761035FD;
        Mon, 29 Jun 2020 12:59:04 +0200 (CEST)
Received: from web0081.zxcs.nl (web0081.zxcs.nl [IPv6:2a06:2ec0:1::81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pmg01.zxcs.nl (Zxcs) with ESMTPS;
        Mon, 29 Jun 2020 12:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BeEd1bjgVqI+6WM8IxHn3yBv6gBN5vUlSzEvbSv2GPY=; b=yMmYS8VgDQ27kiSVRfsNHb29iE
        LPmdLaagH+bhjYa54+X3DMcJw/nqLZV5COm0Da2zOkefygoaxdrpUEvEHZmBtFVSzEFG9x1NIuXin
        I1E5JmsDND6n2nkV9HZuv+1p5MFjUc+FoJDbKytPhTvY0MRa2F7TDed2QfZrlyxmEPFezW39If8ZR
        llTMADSiNPRmBiZ72ZBx/mxD1WsEvyqYe2WHWTx83dzz1qTw7J73QFk0CDdeDSqELEzDMvAGMy+OK
        9/A/IOH366nZ3vtIYr10sHMVvuSCsLkY1HJ6TRYo0Gx2ZTuUb633j1zBZovb0Pz192M3r0YlsTIN3
        zIejNerg==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:48016 helo=mail-slave02.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.93.0.4)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jprV9-004AMs-6x; Mon, 29 Jun 2020 12:59:03 +0200
MIME-Version: 1.0
Date:   Mon, 29 Jun 2020 12:59:02 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     laurent.pinchart@ideasonboard.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v2 2/5] drm: panel: Add Starry KR070PE2T
In-Reply-To: <20200628072819.GB8391@pendragon.ideasonboard.com>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
 <20200320112205.7100-3-dev@pascalroeleven.nl>
 <20200628072819.GB8391@pendragon.ideasonboard.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <d43b324fa26638c179650e3c52adbf32@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Good catch. It's actually the connector type which is wrong. The 
connector_type should be DRM_MODE_CONNECTOR_DPI. If you would include 
this in your patch series, you can have my acked-by.

Regards,
Pascal

On 2020-06-28 09:28, Laurent Pinchart wrote:
> Hi Pascal,
> 
> On Fri, Mar 20, 2020 at 12:21:33PM +0100, Pascal Roeleven wrote:
>> The KR070PE2T is a 7" panel with a resolution of 800x480.
>> 
>> KR070PE2T is the marking present on the ribbon cable. As this panel is
>> probably available under different brands, this marking will catch
>> most devices.
>> 
>> As I can't find a datasheet for this panel, the bus_flags are instead
>> from trial-and-error. The flags seem to be common for these kind of
>> panels as well.
>> 
>> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
>> ---
>>  drivers/gpu/drm/panel/panel-simple.c | 29 
>> ++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c 
>> b/drivers/gpu/drm/panel/panel-simple.c
>> index e14c14ac6..b3d257257 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -2842,6 +2842,32 @@ static const struct panel_desc 
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
>> +
>> +static const struct panel_desc starry_kr070pe2t = {
>> +	.modes = &starry_kr070pe2t_mode,
>> +	.num_modes = 1,
>> +	.bpc = 8,
>> +	.size = {
>> +		.width = 152,
>> +		.height = 86,
>> +	},
>> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | 
>> DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> 
> I'm trying to fix inconsistencies in the panel-simple driver, and this
> caught my eyes. MEDIA_BUS_FMT_RGB888_1X24 isn't a correct format for
> LVDS panels. MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> MEDIA_BUS_FMT_RGB888_1X7X4_SPWG or MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA
> should be used instead. As I couldn't find documentation for the panel,
> I can't tell which format is correct. Could you please help ?
> 
>> +};
>> +
>>  static const struct drm_display_mode starry_kr122ea0sra_mode = {
>>  	.clock = 147000,
>>  	.hdisplay = 1920,
>> @@ -3474,6 +3500,9 @@ static const struct of_device_id 
>> platform_of_match[] = {
>>  	}, {
>>  		.compatible = "shelly,sca07010-bfn-lnn",
>>  		.data = &shelly_sca07010_bfn_lnn,
>> +	}, {
>> +		.compatible = "starry,kr070pe2t",
>> +		.data = &starry_kr070pe2t,
>>  	}, {
>>  		.compatible = "starry,kr122ea0sra",
>>  		.data = &starry_kr122ea0sra,
> 
> --
> Regards,
> 
> Laurent Pinchart

