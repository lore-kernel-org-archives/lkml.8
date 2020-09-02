Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052EC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6920758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yTpM3i7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBDgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:36:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIBDgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:36:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0823abVE022335;
        Tue, 1 Sep 2020 22:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599017797;
        bh=TyFs6MA6geWsu2B6sGQmrQ3S8a8sRQLeWTZwTsdi9v8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yTpM3i7KJXJ7kZRbKKaffFDuM7DizvUEp00MzQj4EYtL2VjfAOdSPODudDTTaYyJg
         8W72S7iepYYFjrWCvphE4j6lZeJB4uxf72Q2wds3Wl3MGCsiBpYtIEqadIS0qKXV1+
         8BxCQoXHwFU0opjkrMuoVrLm9Tx1GEmSueZ2dIIg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0823abnH120427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 22:36:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 22:36:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 22:36:37 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0823aXao031827;
        Tue, 1 Sep 2020 22:36:33 -0500
Subject: Re: [PATCH 0/7] arm64: dts: ti: k3-*: Squash up
 node_name_chars_strict warnings
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <e284241e-7db8-c9ba-5512-8551abce6566@ti.com>
Date:   Wed, 2 Sep 2020 09:06:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/20 4:00 am, Nishanth Menon wrote:
> Hi,
> 
> This is one part of cleanups meant for make W=2 dtbs for 5.10 on TI
> dtbs. Hopefully we dont see node_name_chars_strict warnings anymore.
> 
> As part of this cleanup, I ran a cross check of nodes that are
> part of K3 as of right now, Vs what is "generic" definition as per 0.3
> dt specification:
> https://pastebin.ubuntu.com/p/kp3g4ktBYp/
> 
> I dont think the remaining have a good reference, at least in my
> subjective view.
> 
> In possibly some cases, bootloaders may need to sync before doing DT
> fixup etc.
> 
> Nishanth Menon (7):
>   arm64: dts: ti: k3-am65*: Use generic gpio for node names
>   arm64: dts: ti: k3-am65*: Use generic clock for serdes clock name
>   arm64: dts: ti: k3-*: Use generic pinctrl for node names
>   arm64: dts: ti: k3-am65-base-board Use generic camera for node name
>     instead of ov5640
>   arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for
>     node name
>   arm64: dts: ti: k3-*: Use generic adc for node names
>   arm64: dts: ti: k3-*: Fix up node_name_chars_strict errors

Series looks good to me,

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
