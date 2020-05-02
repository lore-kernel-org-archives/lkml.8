Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88459C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F063206F1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YvyzDSf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgEBSaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:30:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45940 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgEBS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:29:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 042ITsJZ010357;
        Sat, 2 May 2020 13:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588444194;
        bh=6Q3yiR2XRiJ8kTEZnUqEqO28fw1ZlmPhXIq8d15/v34=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YvyzDSf1idXJAUrEd22hGo0xf2Iphgvq3YscDCYaQ9YIor/9NCQJ3HaBj5pcDsOIH
         sWOpPM21vStVVsOSOPXFgkP6nk3wm63Tfs9Ih6B1auT9qGm1F1ohMxqHDZEcg7iXgR
         /maCgPMomHeUe/yT22HAXxoiwL328vD8xkDXqbTI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 042ITspx096198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 May 2020 13:29:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 2 May
 2020 13:29:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 2 May 2020 13:29:54 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 042ITr6B018688;
        Sat, 2 May 2020 13:29:54 -0500
Subject: Re: [PATCH v3 0/2] Misc. rproc fixes around fixed memory region
 support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200420160600.10467-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <181b6c56-420c-f306-f2cf-53380ad1f37b@ti.com>
Date:   Sat, 2 May 2020 13:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420160600.10467-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 4/20/20 11:05 AM, Suman Anna wrote:
> Hi Bjorn,
> 
> This is another minor revision of the fixes around fixed memory region
> support [1] series. Patch 1 is revised to go back to the logic used in v1
> after a long discussion on the v2 version [2]. The other suggestions can
> be future improvments as they would require corresponding platform driver
> changes. Please look through the discussion there and let us know your
> preference. Patches are based on v5.7-rc1.
> 
> I really appreciate it if you can target the series for the current 5.7 -rc's.
> The fixes would apply for all 5.1+ kernels.

Ping on these.

regards
Suman

> 
> Please see the v1 cover-letter [1] for the details on the issues.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/cover/11422723/
> [2] https://patchwork.kernel.org/comment/23274389/
> 
> Suman Anna (1):
>    remoteproc: Fix and restore the parenting hierarchy for vdev
> 
> Tero Kristo (1):
>    remoteproc: Fall back to using parent memory pool if no dedicated
>      available
> 
>   drivers/remoteproc/remoteproc_core.c   |  2 +-
>   drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 

