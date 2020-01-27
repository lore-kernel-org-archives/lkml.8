Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD3DC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5E42087F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DMc65PvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgA0MVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:21:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59788 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbgA0MVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:21:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RCLD8Q066989;
        Mon, 27 Jan 2020 06:21:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580127673;
        bh=RSeYKMT+3bp3WIANarov7X12VsPmEDDnenQn4oId8iE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DMc65PvWGcEcn1yQKNQy7tAxQfhAhoTk4ympXWB/52XVGum8G03UbiqbOCqqGd7tS
         H3hTIOSIXEbUySLSD18I9SMDIgugu6+ujQ4cmMGT9Gyp1AMb6Bqft71CQo6Ybl0OK4
         RBi6irFuLJr9U7Q5dM8JQRLIBJBc6jbwkU8eQDu8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00RCLDGo002417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 06:21:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 06:21:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 06:21:12 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RCL9Vx000740;
        Mon, 27 Jan 2020 06:21:10 -0600
Subject: Re: [PATCH] dt-bindings: fix compilation error of the example in
 intel,lgm-emmc-phy.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        <dafna3@gmail.com>
References: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
 <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
 <9c4a971f-6a65-594e-4a79-9e2aa16e58cb@collabora.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d9888d47-f320-57f4-5773-454673e5762d@ti.com>
Date:   Mon, 27 Jan 2020 17:54:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <9c4a971f-6a65-594e-4a79-9e2aa16e58cb@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/20 7:59 pm, Dafna Hirschfeld wrote:
> 
> 
> On 24.01.20 15:03, Rob Herring wrote:
>> On Fri, Jan 24, 2020 at 5:49 AM Dafna Hirschfeld
>> <dafna.hirschfeld@collabora.com> wrote:
>>>
>>> Running:
>>> export
>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>>
>>> 'make dt_binding_check'
>>>
>>> gives a compilation error. This is because in the example there
>>> is the label 'emmc-phy' but labels are not allowed to have '-' sing.
>>> Replace the '-' with '_' to fix the error.
>>>
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>
>> There's a fix from the author, but you're first to get the fix
>> correct, so:
> Oh, sorry, I was not aware of that.
> Dafna
> 
>>
>> Fixes: 5bc999108025 ("dt-bindings: phy: intel-emmc-phy: Add YAML
>> schema for LGM eMMC PHY")
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Kishon, Please apply these soon as linux-next is broken.
>>

merged now, Thanks!

-Kishon
