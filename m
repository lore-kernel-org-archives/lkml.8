Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBAC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4329B20575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZFzjLXB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgD0KlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:41:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50782 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0KlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:41:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RAf6ME098168;
        Mon, 27 Apr 2020 05:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587984066;
        bh=+e9snjuVn8/9SAIvEDXDG4BktGSSOERgBnlvNMxv+ZU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ZFzjLXB4pT1g/ASFlNO+oxvU14by/GfQqc+5rQb1XLLTe/zWsxnu75t2+Ihzi6Y5E
         SCsy52iQSNX1G6QgaGoTXEri2PqJQ6pjYnXWnh3hJ1AEPDMCEJh/seAsIAqjYqXues
         AIO2Hdk8qmfX75Dt1AKvj9GLN7CLxWzxZ0zqBNFE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RAf6Hk074046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 05:41:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:41:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:41:06 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RAf337009038;
        Mon, 27 Apr 2020 05:41:04 -0500
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j721e-main.dtsi: Add DSS node
To:     Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
 <20200422091512.950-2-tomi.valkeinen@ti.com>
 <ade3a177-f060-bc40-bcc1-494093e3071d@ti.com>
 <47b7f858-a8d9-1c3b-4dca-2cc493f6730f@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <df93da78-132a-d02e-6561-5bb5fdfe7e53@ti.com>
Date:   Mon, 27 Apr 2020 13:41:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <47b7f858-a8d9-1c3b-4dca-2cc493f6730f@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 13:37, Jyri Sarha wrote:
> On 27/04/2020 13:09, Tero Kristo wrote:
>>> +        status = "disabled";
>>
>> Again, why disabled by default?
>>
> 
> tidss device is not functional without a defined video-port. The driver
> is not implemented in a way that it would handle a broken configuration
> gracefully.

What/where/when is the video-port going to be defined then? Is this 
going to be done in an overlay?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
