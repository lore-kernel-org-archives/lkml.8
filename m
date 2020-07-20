Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41532C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CC5207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W5mHTqxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGTH2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:28:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:28:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06K7Sagj001411;
        Mon, 20 Jul 2020 02:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595230116;
        bh=4tf5ULnVtQ9E433Ndn2ggyp9DNG66VBQs5JJ6heww+Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W5mHTqxIVIorxFWFvz6oSBjYdtapN5W/a4pXu2X/Yidn7jal5VIQUR/GUK8pA1Mxb
         5rQprs9CxEpSXBZiRrmarq5ckCWkpi7pSWpso2QKEE1tMWagItFxtPYpryibFF3aBT
         mYFdmW9jzvrsBCAsUjhPzssD8gEN+ORrH+LOob5I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06K7SanY050304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 02:28:36 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 02:28:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 02:28:36 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06K7SXi5064729;
        Mon, 20 Jul 2020 02:28:34 -0500
Subject: Re: [PATCH] soc: ti/ti_sci_protocol.h: drop a duplicated word +
 clarify
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200719003145.21100-1-rdunlap@infradead.org>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <54d19b9e-2439-eed2-ff8e-82a1acb4ff33@ti.com>
Date:   Mon, 20 Jul 2020 10:28:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200719003145.21100-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2020 03:31, Randy Dunlap wrote:
> Drop the repeated word "an" in a comment.
> Insert "and" between "source" and "destination" as is done a few
> lines earlier.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Lokesh Vutla <lokeshvutla@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   include/linux/soc/ti/ti_sci_protocol.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200717.orig/include/linux/soc/ti/ti_sci_protocol.h
> +++ linux-next-20200717/include/linux/soc/ti/ti_sci_protocol.h
> @@ -226,8 +226,8 @@ struct ti_sci_rm_core_ops {
>    *			and destination
>    * @set_event_map:	Set an Event based peripheral irq to Interrupt
>    *			Aggregator.
> - * @free_irq:		Free an an IRQ route between the requested source
> - *			destination.
> + * @free_irq:		Free an IRQ route between the requested source
> + *			and destination.
>    * @free_event_map:	Free an event based peripheral irq to Interrupt
>    *			Aggregator.
>    */
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
