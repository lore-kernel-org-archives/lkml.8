Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F607C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CD820826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTOfIrn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgEUUe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:34:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgEUUe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:34:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LKYNk9061073;
        Thu, 21 May 2020 15:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590093263;
        bh=mbogiIJ51R5QdW+/MJYLWt5NYi1vk9juLL/j738tJCo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JTOfIrn9vJEzT/LRspFQIMrCSlPqJJnn4ru/b7uHRnVtzsSxSaxmLmhL9ttwV25Bi
         yMuW0kejsUuQhuzawDezhpBFGLEyiFwPShWFfJ0TPyVJ5/TMdrhiI5Ih60VymwLByk
         MEqU9suBWd/tk7nLCDvuC2PXV0i4vTIYv+c0orZw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LKYNoE057209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 15:34:23 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 15:34:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 15:34:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LKYM42068417;
        Thu, 21 May 2020 15:34:22 -0500
Date:   Thu, 21 May 2020 15:34:22 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <od@zcrc.me>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
Message-ID: <20200521203422.GA25575@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200520150111.76658-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200520150111.76658-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:01:11PM +0200, Paul Cercueil wrote:
> The function dma_controller_irq() locks up the exact same spinlock we
> locked before calling it, which obviously resulted in a deadlock when
> CONFIG_SMP was enabled. This flew under the radar as none of the boards
> supported by this driver needs SMP.
> 
> Fixes: 57aadb46bd63 ("usb: musb: jz4740: Add support for DMA")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Queued for v5.8. Thanks.
-Bin.
