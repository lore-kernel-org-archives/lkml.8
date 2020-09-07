Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D813C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BF208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eAeo/+sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgIGI6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:58:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55112 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgIGI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:58:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0878wDcr122249;
        Mon, 7 Sep 2020 03:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469093;
        bh=aZAz73YCuuEnz9ZtQdZeex1xww8Hg9BA+I0VVwYC1Oc=;
        h=From:To:CC:Subject:Date;
        b=eAeo/+sWvy7Bpv3jHFY5fhcsJ7/j/j/9w12R0tfiWq936iT/1NAHaYpj5XVHoUgj1
         Ghj0i5KNZ/Iptd20QK9TdurufqC33bK0023OXkU+cmxPJoQ9ZzNP32zqOolwsmzxJP
         08fpOsdfBxbBGKgCgwH047U2YfmAgPVasPSXUtPo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878wDap048874;
        Mon, 7 Sep 2020 03:58:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 03:58:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 03:58:13 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878wBar040828;
        Mon, 7 Sep 2020 03:58:12 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>
Subject: [PATCH 0/3] clk: keystone: some minor fixes
Date:   Mon, 7 Sep 2020 11:57:37 +0300
Message-ID: <20200907085740.1083-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

This series contains a few fixes for the TI SCI clock driver.
- Patch #1 is a clear bug fix, where we missed to parse assigned-clock
  data properly to detect which clocks are in use on the SoC.
- Patch #2 is a performance improvement patch which avoids some
  unnecessary round trips to firmware side while setting clock
  frequency.
- Patch #3 fixes some issues with set_rate passed to firmware, where the
  parameters are too strict; namely, firmware fails to handle some cases
  properly if min,tgt,max values for a clock rate are exactly the same
  value. Yeah, the firmware is quite weird here but nothing much else we
  can do from kernel side other than this....

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
