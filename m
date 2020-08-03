Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB4AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D246207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cj8KgdCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgHCOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:41:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38276 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgHCOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:41:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073EfUOw026937;
        Mon, 3 Aug 2020 09:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596465690;
        bh=zYT9k4890Niz/mBBG6AwDFbRc+Y/kksWo+DFtPoigos=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cj8KgdCJRMs5ESND4yy9MyCoMeO6H1FP+n1Ps2+fpJ1K/VSFKBB2GhgmgWkQnrJ/Y
         kc26q5TaycyGNgpoFkGsqvtxqNbuC47X2puQc+rg66SzGcdlaBg5pCoO9W6Gv2q+j4
         S2NxbPOjsO+4JgfBkafWa8XrGspV44gpkNt/FxL0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073EfU1F103016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 09:41:30 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 09:41:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 09:41:30 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073EfRvd033665;
        Mon, 3 Aug 2020 09:41:27 -0500
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J7200
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, <t-kristo@ti.com>
CC:     <nsekhar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <grygorii.strashko@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>
References: <20200803105359.16744-1-peter.ujfalusi@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
Date:   Mon, 3 Aug 2020 20:11:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200803105359.16744-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/20 4:23 pm, Peter Ujfalusi wrote:
> Update K3 chipinfo driver to support new TI J7200 SoC.
> It's JTAG PARTNO is 0xBB6D.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> ---
>  drivers/soc/ti/k3-socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index af0ba5288e58..bbbc2d2b7091 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -39,6 +39,7 @@ static const struct k3_soc_id {
>  } k3_soc_ids[] = {
>  	{ 0xBB5A, "AM65X" },
>  	{ 0xBB64, "J721E" },
> +	{ 0xBB6D, "J7200" },
>  };
>  
>  static int
> 
