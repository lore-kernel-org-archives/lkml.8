Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A4C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB6B205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SZzpt3Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCJI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:56:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58696 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:56:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02A8uAcS100759;
        Tue, 10 Mar 2020 03:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583830570;
        bh=nmwVphm5iqbtcL4ZTh/177J0aYFT1Z+EnZLR4E5cQgE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SZzpt3ZduvJWmJ3J1YLkfFV/yWvUzKiAGitrVN0JtlF1Tw1xqFWpunOffDeTt1gGK
         HfuSJIMGmAMIacxwBVvCFE7vidViNoFJoJn0U7ddD2DP9hA614RURFsYfp3Zs9wECs
         RpaCnxDKN7KljmctG3GrqGeIXCJXwcpXtYnJK7Yk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02A8uANm003830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Mar 2020 03:56:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Mar 2020 03:56:10 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Mar 2020 03:56:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02A8u871007532;
        Tue, 10 Mar 2020 03:56:08 -0500
Subject: Re: [Patch v2] media: ti-vpe: cal: fix a kernel oops when unloading
 module
To:     Benoit Parrot <bparrot@ti.com>, Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20200306130839.1209-1-bparrot@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <326ff891-baae-47cb-849d-4cd07793236c@ti.com>
Date:   Tue, 10 Mar 2020 10:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306130839.1209-1-bparrot@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2020 15:08, Benoit Parrot wrote:
> After the switch to use v4l2_async_notifier_add_subdev() and
> v4l2_async_notifier_cleanup(), unloading the ti_cal module would casue a
> kernel oops.
> 
> This was root cause to the fact that v4l2_async_notifier_cleanup() tries
> to kfree the asd pointer passed into v4l2_async_notifier_add_subdev().
> 
> In our case the asd reference was from a statically allocated struct.
> So in effect v4l2_async_notifier_cleanup() was trying to free a pointer
> that was not kalloc.
> 
> So here we switch to using a kzalloc struct instead of a static one.
> To acheive this we re-order some of the calls to prevent asd allocation
> from leaking.
> 
> Fixes: d079f94c9046 ("media: platform: Switch to v4l2_async_notifier_add_subdev")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
> Changes since v1:
> - fix asd allocation leak
> 
>   drivers/media/platform/ti-vpe/cal.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
