Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6BB2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RV51vlfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHNIWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:22:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgHNIWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:22:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07E8MEot052857;
        Fri, 14 Aug 2020 03:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597393334;
        bh=nN9rxIxe2PrNFTatI6qBHXFwgSY/cf8NzryVjn5ngHo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RV51vlfgmsP1JFGyB2rQcoIXuXoRwPANRcEX5Aj45esq4Zi5OMRUBg3XvvPEHFlu/
         QO01N9js9Ij4EBMpZ+dESN+wLhFKxYabpmYY7SANfrztFk0umhZM+wsWxCBtM5KO4R
         xZOAnRDmG+dHubwgF3K8y01Vy0UdnxhvMhzrJuxU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07E8MD8R060005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 03:22:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 14
 Aug 2020 03:22:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 14 Aug 2020 03:22:13 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07E8MADr012933;
        Fri, 14 Aug 2020 03:22:10 -0500
Subject: Re: [PATCH v8 2/3] drm: bridge: Add support for Cadence MHDP DPI/DP
 bridge
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <yamonkar@cadence.com>, <jsarha@ti.com>, <nsekhar@ti.com>,
        <praneeth@ti.com>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <1596713672-8146-3-git-send-email-sjakhade@cadence.com>
 <20200811023622.GC13513@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <a2f2ff9d-0c52-12d9-23c5-bab35ef8f8f6@ti.com>
Date:   Fri, 14 Aug 2020 11:22:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811023622.GC13513@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 05:36, Laurent Pinchart wrote:

>> +static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
>> +{
>> +	u32 bus_format = MEDIA_BUS_FMT_RGB121212_1X36;
>> +	struct drm_connector *conn = &mhdp->connector;
>> +	struct drm_bridge *bridge = &mhdp->bridge;
>> +	int ret;
>> +
>> +	if (!bridge->encoder) {
>> +		DRM_ERROR("Parent encoder object not found");
>> +		return -ENODEV;
>> +	}
>> +
>> +	conn->polled = DRM_CONNECTOR_POLL_HPD;
>> +
>> +	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
>> +				 DRM_MODE_CONNECTOR_DisplayPort);
>> +	if (ret) {
>> +		DRM_ERROR("Failed to initialize connector with drm\n");
>> +		return ret;
>> +	}
>> +
>> +	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
>> +
>> +	ret = drm_display_info_set_bus_formats(&conn->display_info,
>> +					       &bus_format, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	conn->display_info.bus_flags = DRM_BUS_FLAG_DE_HIGH;
> 
> Aren't these supposed to be retrieved from the display ? Why do we need
> to override them here ?

DE_HIGH is meant for the display controller. I think this should be in bridge->timings->input_bus_flags

>> +static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>> +				  struct drm_bridge_state *bridge_state,
>> +				  struct drm_crtc_state *crtc_state,
>> +				  struct drm_connector_state *conn_state)
>> +{
>> +	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>> +	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>> +	int ret;
>> +
>> +	if (!mhdp->plugged)
>> +		return 0;
>> +
>> +	mutex_lock(&mhdp->link_mutex);
>> +
>> +	if (!mhdp->link_up) {
>> +		ret = cdns_mhdp_link_up(mhdp);
>> +		if (ret < 0)
>> +			goto err_check;
>> +	}
> 
> atomic_check isn't supposed to access the hardware. Is there a reason
> this is needed ?

We have been going back and forth with this. The basic problem is that to understand which
videomodes can be used, you need to do link training to see the bandwidth available.

I'm not sure if we strictly need to do LT in atomic check, though... It would then pass modes that
can't be used, but perhaps that's not a big issue.

I think the main point with doing LT in certain places is to filter the list of video modes passed
to userspace, as we can't pass the modes from EDID directly without filtering them based on the link
bandwidth.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
