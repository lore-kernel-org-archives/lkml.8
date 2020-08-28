Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093DEC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE2D208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zsl82uH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgH1Jyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:54:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbgH1Jyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:54:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S9pvI1021742;
        Fri, 28 Aug 2020 11:54:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DlVcODvIHv+k9gcJGCepOeZ5XDXD7sohQvCiNbW0/+k=;
 b=zsl82uH7VLYaJDA9WRaWTo0d2e1f4KOteQgjpXxG9cnbYf5InqvesM2UNAJunTLwM1Ad
 nOc/BgnL9eTibuYcXr61ciIDAZLNX9iWeqdnNw9O4rKHXm6Hsl/vchCBn/xUWGkGYl4y
 OerSkIi9BnKYEYVuiFLyHr5CD7o1QvvLgZHR5bBMQpXhnvfaoeM66QA/UtjEnulscQqJ
 cjGNkrn+Gs8GstRNtWJpw1CSZ79p4u6JKIdLUjCcYa7fTnHclSpNqqfu8uuW/7ybr7iy
 cZ9MOfp65aWp5y2uxqlDXei/vBzXiPJJOFxNa3AyPz5Ca6e+X2A9nAWav0AmmyBvYG2f TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b3hu6rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:54:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7BF010002A;
        Fri, 28 Aug 2020 11:54:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A69262AE6CC;
        Fri, 28 Aug 2020 11:54:40 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 11:54:40 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add resets property to spi device nodes
 on stm32h743
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200814223543.3420540-1-t.schramm@manjaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <171d5344-884f-8974-30a5-42b076d73336@st.com>
Date:   Fri, 28 Aug 2020 11:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814223543.3420540-1-t.schramm@manjaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_06:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias

On 8/15/20 12:35 AM, Tobias Schramm wrote:
> The stm32 spi driver tries to determine the fifo size of spi devices
> dynamically. However, if the spi was already configured by the bootloader
> the fifo size check can become an endless loop, because the driver
> expects the spi to be in its initial "after device reset" state. The
> driver does already support resetting the spi device at probe, thus this
> patch adds only the required device tree properties
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied on stm32-next.

Thanks.
Alex
