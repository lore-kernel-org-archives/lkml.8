Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0D20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rA2N9Wzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504246AbgDNSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:43:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47704 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgDNSnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:43:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03EIhCkm062470;
        Tue, 14 Apr 2020 13:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586889792;
        bh=6CljWIoXWSxwxXZenC1pQJ7+o0R3BPNiiWr1BNk8S4c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rA2N9WzmWP9JIdVJDHEaFx/9x0EJbx6le6nY8QWJO9JnRvalnnAagpQY0rQmjZi63
         MSeN8isom4q9xqL0mYSMWgHWV8/f1JLcrYmat6QvVC4WE580GZEn4KDcgKTqDN/BJv
         d7hDxftD4rne4Sl3mEFQeLxp6SpclKc/ZrVv5Jbk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03EIhCBj051149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Apr 2020 13:43:12 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Apr 2020 13:43:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Apr 2020 13:43:11 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03EIhBV0037834;
        Tue, 14 Apr 2020 13:43:11 -0500
Subject: Re: [PATCH v2 0/2] Misc. rproc fixes around fixed memory region
 support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200319162321.20632-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b2f0a057-adac-dd98-2e5d-f3f4ad9fb4bf@ti.com>
Date:   Tue, 14 Apr 2020 13:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200319162321.20632-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/19/20 11:23 AM, Suman Anna wrote:
> Hi All,
> 
> This is a minor revised version of the fixes around fixed memory region
> support [1]. Patch 1 is updated to address Arnaud's review comments about
> the hard-coded memory region.

I would like to get these patches into the current -rc's. There is some 
discussion on patch 1 whether we should go back to the v1 version 
instead. Can you give me your preference between the two, so that I can 
post a v3 on top of 5.7-rc1.

regards
Suman

> 
> Please see the v1 cover-letter [1] for the details on the issues.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/cover/11422723/
> 
> Suman Anna (1):
>    remoteproc: Fix and restore the parenting hierarchy for vdev
> 
> Tero Kristo (1):
>    remoteproc: fall back to using parent memory pool if no dedicated
>      available
> 
>   drivers/remoteproc/remoteproc_core.c   |  2 +-
>   drivers/remoteproc/remoteproc_virtio.c | 15 +++++++++++++++
>   include/linux/remoteproc.h             |  2 ++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 

