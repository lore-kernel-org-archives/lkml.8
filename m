Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB0EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFAB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jzU7nG3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEOJhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:37:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEOJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:37:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04F9bLbF036068;
        Fri, 15 May 2020 04:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589535441;
        bh=oEOAmMlHbDMdqsu88ZGLxuLWEWcpJCtqZ15QYDx+IUw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jzU7nG3RyRqg6BiOsRLMPw7ivW7oO7DL8JhD/D2ayGFbOq74L/3O4lJ784OqebItk
         opK2uoHt0VsAzV8vSHkmXTK/X2QJ7N5cJnTV7jek8KhrqeOE3Jcjp/1HS8hMyTBytg
         sA4u68GfCAethfqAYljk4lJLBx7oI48U2G1SOo7k=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04F9bL47130041
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 04:37:21 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 May 2020 04:37:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 May 2020 04:37:21 -0500
Received: from [10.250.151.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04F9bHhi005235;
        Fri, 15 May 2020 04:37:18 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-main: Update otap-del-sel
 values
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>
References: <20200507181526.12529-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <ed7068a6-3441-be0c-cf78-63e0988e91af@ti.com>
Date:   Fri, 15 May 2020 15:07:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507181526.12529-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tero,

On 07/05/20 11:45 pm, Faiz Abbas wrote:
> According to the latest AM65x Data Manual[1], a different output tap
> delay value is optimum for a given speed mode. Update these values.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> v2: Rebased to the latest mainline kernel
> 

Gentle ping.

Thanks,
Faiz
