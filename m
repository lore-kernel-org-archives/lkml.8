Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22132C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D1821D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y81IBlfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIISGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:06:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39976 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgIISGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:06:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089F1sVY098364;
        Wed, 9 Sep 2020 10:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599663715;
        bh=MwI22PibRFOWQwMQJkln6M8QN2qmj+Or25iJeEI4Q/Y=;
        h=To:CC:From:Subject:Date;
        b=Y81IBlfQilc6cV1c9BkiR4VIoe/1EjbNtN+ZfKRdB4BkqE3fwOWGf3S8y2RLr/ASc
         HqTEa4+S2TGAl8rtw87UuoFPVqNqg7Do7V6VvvzrtyQ2Jh3OiyVZtE+dXB17R1YY2k
         nDL1xnoW639rF+SRvWfoAKcWNTtwShyi5GrexR1E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 089F1sdk027270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 10:01:54 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 10:01:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 10:01:54 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089F1pP5101317;
        Wed, 9 Sep 2020 10:01:52 -0500
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Subject: [RFC] Device addition to the tlv320adcx140 and tas2562
Message-ID: <8c47c81f-5f83-2cf4-7bf1-62201b35bed3@ti.com>
Date:   Wed, 9 Sep 2020 10:01:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Looking for guidance on how to move forward with adding a device to 
existing drivers.

For the TLV320adcx140 driver I have another device which is register and 
bitmap compatible but it does not support Analog microphones or Line In 
like the x140.

Should I add a new driver specifically for this part or should I add the 
new audio maps, widgets and controls to the existing driver?  This would 
make this existing driver really big in terms of LoC and object size.

Similar question for the TAS2562.  I have a new device that is register 
and bitmap compatible but removes the I/V sense. Adding this new device 
to the existing driver wouldn't be as intrusive as the x140 as the audio 
map and controls are much simpler

Dan

