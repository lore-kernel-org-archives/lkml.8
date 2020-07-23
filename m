Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50525C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3181A206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uimxD5pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgGWKU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:20:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6259 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGWKU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595499626; x=1627035626;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=mwexbzXzuovcPcGVvxhGS581gfOX8CqXGt9l1T0VkAc=;
  b=uimxD5paLBL6V/FqOH5ukZVFOGEjZguYT1Kn8vatxHn1YSefPGvu2wsb
   FmvzjFxIT16DkGHf/zGPOI7actibU+HVspycYM4w9ibjtg2DdFWD4ds2U
   FmE6fAQYp1RtqCWNilzOtL9B0b4Z5nWzlJeg8zO0dExeAo/TT5VaKPtR6
   4=;
IronPort-SDR: YXa7yDZ3nciGHTT09FjqW4zlVhek9a2bmD5EzwTDQY3bV9xe7HuJn30mta4csmcXiBRHQmyu2f
 wSkrlpbxaJcQ==
X-IronPort-AV: E=Sophos;i="5.75,386,1589241600"; 
   d="scan'208";a="60985712"
Subject: Re: [PATCH v5 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jul 2020 10:20:11 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 23FD9A24B9;
        Thu, 23 Jul 2020 10:20:07 +0000 (UTC)
Received: from EX13D08UEB004.ant.amazon.com (10.43.60.142) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Jul 2020 10:20:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB004.ant.amazon.com (10.43.60.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Jul 2020 10:20:06 +0000
Received: from [192.168.8.102] (10.1.213.33) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:20:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>,
        <benh@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <hanochu@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>,
        <jonnyc@amazon.com>, <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200324104918.29578-1-hhhawa@amazon.com>
 <158946977180.3480.12435085393834819053@kwain>
 <CAK8P3a3ndL0U=Q1HAxd3oTPfO6WwQZM3yQvr-TQEnA3ZzhQNYQ@mail.gmail.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <b86d9dbf-f7b0-e741-4dfa-2d76972d38f1@amazon.com>
Date:   Thu, 23 Jul 2020 13:20:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3ndL0U=Q1HAxd3oTPfO6WwQZM3yQvr-TQEnA3ZzhQNYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2020 1:10 PM, Arnd Bergmann wrote:
> Hi Hanna and Antoine,
> 
> I just came across this old series and noticed we had never merged it.
> 
> I don't know if the patches all still apply. Could you check and perhaps
> resend tosoc@kernel.org  if they are still good to go into the coming
> merge window?

Hi Arnd,

Sure, will rebase the patches and send ASAP.

Thanks,
Hanna
