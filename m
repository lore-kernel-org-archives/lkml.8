Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D95C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D1C208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eDTkRHSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH1HFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:05:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgH1HFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:05:12 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S732Nk000598;
        Fri, 28 Aug 2020 09:04:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=m2SsIVbZ8bq+LCqCl4N5OrX5gyKuZhvtBav4WtS2mAU=;
 b=eDTkRHSp7Dc4QdaJHdJjRcB2J6q+TGniyud3FkuxdaVF/OOCKDLMj93KJN1e2KS0t3d/
 rh+SCLUBaDRUD9/ONnE+0UsVWw6savd+yh/0S4PUU2+ZBT7g6IGZRprT+4doK2i4B9wB
 BYzZkiZN5eBH/D7HaSUwxDvMStSp9Jc7WR6FMjeFSxdOTsm9Nk4+tKZSADsulUIliVBi
 4gFuBSFRyRmLFH7bhUuZ+Hlxn1s3kQUMfUiag0+l2jQRBgQ0X82ALQeIwb1SmJ1NKnwL
 4qqHTxK7HEP1ADOv2JHHeaCL3lo1NdL/SkSMST8MK4HG8ZM3D1EdPJSo++76NwOVOWzS 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b6xj14m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 09:04:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13705100034;
        Fri, 28 Aug 2020 09:04:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC32721F66C;
        Fri, 28 Aug 2020 09:04:51 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 09:04:51 +0200
Subject: Re: [PATCH v2] ARM: STM32: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <linux@armlinux.org.uk>, <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
References: <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
 <20200722192046.69334-1-grandmaster@al2klimov.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f6d9e6d7-60ea-85c3-9291-c7c01befc7ef@st.com>
Date:   Fri, 28 Aug 2020 09:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722192046.69334-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_03:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander

On 7/22/20 9:20 PM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---

Applied on stm32-next.

Thanks.
Alex

