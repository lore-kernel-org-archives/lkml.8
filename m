Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C47206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kasV+ord"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLXZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:25:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:25:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CNPcT3118517;
        Fri, 12 Jun 2020 18:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592004338;
        bh=vSJmVG1Yb4c22HzpQT7H8mhhnMWJDDSK63IzEUlWtVM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kasV+ordfReIz/XL3HVaRwiCg09Y4fYhTiLiJ/xVRXTt9d4N6zsAcxEc0yKsnGm0d
         Mumsa2QzcmEvnBlSJpfh676QnXR7AvdL/DcWQ+bX1NX/TmJGMyHZGsUC52It7eWSwR
         gOyf3MxsXZvzj6md37rOu2ATN1o1CW7MK7fb39SQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CNPcuV108046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 18:25:38 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 18:25:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 18:25:38 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CNPc1b130186;
        Fri, 12 Jun 2020 18:25:38 -0500
Subject: Re: [RESEND PATCH] dt-bindings: property-units: Add picoseconds type
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200602164219.3159-1-dmurphy@ti.com>
 <e7644623-e9c2-2ebc-8bbd-1bd5dea8942a@ti.com>
 <20200612221701.GA3916707@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f7fdc140-0f3e-8977-5183-2a5f3189d45c@ti.com>
Date:   Fri, 12 Jun 2020 18:25:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612221701.GA3916707@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 6/12/20 5:17 PM, Rob Herring wrote:
> On Thu, Jun 11, 2020 at 02:46:28PM -0500, Dan Murphy wrote:
>> Bump
> Merge window. Will apply when over.

No worries.  Just wanted to make sure it was seen and not lost.

Dan

