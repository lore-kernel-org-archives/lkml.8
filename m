Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5DC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0133A2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vIGGXyg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBCIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:09:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42976 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBCIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:09:28 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01389AxS093033;
        Mon, 3 Feb 2020 02:09:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580717350;
        bh=SHGNUtZH+GGsjdnH4fW3GSfZiqBh1dX2XaSZkoM0DVQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=vIGGXyg5WoZsOivB00ACn4YVYjBPUMmhMnZrMolw05Ei8DzUUE4nrhIx51mq+BlBP
         GcFBccqy3ETrzImaTH2vnTUCuD2lKC4/LjO886doNODio8vW5T/SsJXXRcNcV8gUdK
         5NdOh3TOdt6aXdP28VxFV8L5QIOF0AoezQoxt9OU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01389APV086217;
        Mon, 3 Feb 2020 02:09:10 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 02:09:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 02:09:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013897tS077934;
        Mon, 3 Feb 2020 02:09:08 -0600
Subject: Re: [PATCH] firmware: ti_sci: Export devm_ti_sci_get_of_resource for
 modules
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>
References: <20200122104031.15733-1-peter.ujfalusi@ti.com>
Message-ID: <88323f5b-1732-f780-5a0d-754026997c2c@ti.com>
Date:   Mon, 3 Feb 2020 10:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122104031.15733-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/01/2020 12.40, Peter Ujfalusi wrote:
> Allow devm_ti_sci_get_of_resource() to be usable from modules.

I would really appreciate if ti_sci maintainers would spare some time on
this and the other two patch ;)

https://lore.kernel.org/lkml/20200122104044.15837-1-peter.ujfalusi@ti.com/
https://lore.kernel.org/lkml/20200122104009.15622-1-peter.ujfalusi@ti.com/

- Péter

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index f13e4a96f3b7..3d8241cb6921 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3332,6 +3332,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>  
>  	return ERR_PTR(-EINVAL);
>  }
> +EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
>  
>  static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
>  				void *cmd)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
