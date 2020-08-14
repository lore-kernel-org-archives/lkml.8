Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D697E2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="azmpoUWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHNHOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:14:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41476 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHNHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:14:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07E7DdSD034276;
        Fri, 14 Aug 2020 02:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597389219;
        bh=6HpcResJMgUsplZKJl9InYJFIkGZ0vKUjGDdIgYfgCs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=azmpoUWWOIKErTnQ7IQEMPyjuqShMOVh5rLf2IFmCQPUE4uF5C8Ki6IjMvGl6nKD6
         syJ7Jo7EnMyftV676QxAGcObgWgR6VBrJw2eWVZES6Tw5/IQa9IDVYiwtpaB3O4Qor
         aXvquofpqpRU5tqK0A9BqoCsPuZyQ3pspVF14m9A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07E7DdGw019060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 02:13:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 14
 Aug 2020 02:13:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 14 Aug 2020 02:13:39 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07E7DZDS073565;
        Fri, 14 Aug 2020 02:13:36 -0500
Subject: Re: [PATCH v8 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
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
 <1596713672-8146-2-git-send-email-sjakhade@cadence.com>
 <20200811003638.GB13513@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <89942101-52c4-e1bb-3605-569b311da89f@ti.com>
Date:   Fri, 14 Aug 2020 10:13:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811003638.GB13513@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 03:36, Laurent Pinchart wrote:

> I've got a chance to study the J721E datasheet, and it shows the DP
> bridge has 4 inputs, to support MST. Shouldn't this already be reflected
> in the DT bindings ? I think it should be as simple as having 4 input
> ports (port@0 to port@3) and one output port (port@4).

I think this is a good point, mhdp has 4 input streams.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
