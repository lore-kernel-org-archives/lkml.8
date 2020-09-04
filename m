Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E847C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68747206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KF7I1vpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgIDFyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:54:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60806 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:54:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0845rjLP115317;
        Fri, 4 Sep 2020 00:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599198825;
        bh=MdmoxK2AeCCqej9xs0bxxv1OBv8ANR9M3r35yVubq2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KF7I1vpZblhqUvzvqPDfcc5ojQRfe0fri66/dNK0eCxj7EcMxE8xoV0fzh1i0j96z
         1NYjejsCdRJjtexH5w+A+LZoeuu5c1y4eKByCTTmdoIMplTwsHmjgj5/CTzm5Bed3t
         +55tDZ+y+Qxy6jRZlBUWgnoJZAtEBM8w7cZY6D3Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0845rjpx089883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Sep 2020 00:53:45 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 00:53:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 00:53:44 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0845reXd081865;
        Fri, 4 Sep 2020 00:53:41 -0500
Subject: Re: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Swapnil Jakhade <sjakhade@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <yamonkar@cadence.com>, <jsarha@ti.com>, <nsekhar@ti.com>,
        <praneeth@ti.com>, <nikhil.nd@ti.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
 <71452de7-80e7-0144-4802-e3370c00854b@ti.com>
 <20200904022948.GE9369@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <ae3b4dfb-72a7-2734-e104-7fa5b24d81f5@ti.com>
Date:   Fri, 4 Sep 2020 08:53:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904022948.GE9369@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/09/2020 05:29, Laurent Pinchart wrote:

>> Laurent mentioned that atomic_check should not change state. Note that
>> cdns_mhdp_validate_mode_params also changes state, as it calculates tu_size, vs and line_thresh.
> 
> .atomic_check() isn't allowed to change any global state, which means
> both hardware state and data in cdns_mhdp_device. The drm_bridge_state
> (and thus the cdns_mhdp_bridge_state) can be modified as it stores the
> state for the atomic commit being checked.
> 
>> There seems to be issues with mode changes, but I think the first step would be to clarify the
>> related code a bit. cdns_mhdp_validate_mode_params() is misnamed, I think it should be renamed to
>> calculate_tu or something like that.
>>
>> cdns_mhdp_bandwidth_ok() should take display_fmt or bpp as a parameter, as currently it digs that up
>> from the current state.
>>
>> Probably cdns_mhdp_validate_mode_params() would be better if it doesn't write the result to the
>> state, but returns the values. That way it could also be used to verify if suitable settings can be
>> found, without changing the state.
> 
> This use case is actually a very good example of proper usage of the
> atomic state :-) .atomic_check() has to perform computations to verify
> the atomic commit, and storing the results in the commit's state
> prevents duplicating the same calculation at .atomic_commit() time.

Yes, you're right.

But it's still not good, as cdns_mhdp_validate_mode_params uses link details to do the calculations,
but we do link training only later and thus the calculations are invalid.

cdns_mhdp_validate_mode_params is also called from the HPD interrupt, and there it changes the
current bridge state. link_mutex is being held in every place where cdns_mhdp_validate_mode_params
is called, so I guess it's fine.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
