Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71349C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4079320733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0qfTzYTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBJQsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:48:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44867 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727431AbgBJQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:48:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AGiPBI001193;
        Mon, 10 Feb 2020 17:48:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=oG/c7xToD+8agrdTSotNNCOqQBNlCbg+lnwHNTqbVFc=;
 b=0qfTzYTrCTPk3/aNPM2qSH7B0K0E+yfORdkCxhCP9lvNEllYv8KiWHHRe1K32EPAFcvM
 vsEPOot473Hj9MsQINnwnDCa2c3Me2pMp+rRL20Nub0NsuqYf/vfQ2fatcOgeAEL7RL/
 r9tjXQBOAtTdJ1eNmm1yquEooFSzgyN5jrA8pedRqFiqEzl4rWLo4Jm/PItL9+8cgL7+
 AMH/AFvqmZaNtjy6UKj3EZyiaCZk8RXmGd6YpcgOZIjyG+Wydzxztyv5LfX8WrGLgm4t
 yQTI5v8y0uGtYKpghV8IFWItHDo3eYdur0+PL8iTgGx1EmL9AZ8Rp3NqtTPJv5Sd5FmJ 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urguu92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 17:48:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB14610002A;
        Mon, 10 Feb 2020 17:48:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C140F2BAEE6;
        Mon, 10 Feb 2020 17:48:37 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb
 2020 17:48:36 +0100
Subject: Re: [PATCH 1/1] ARM: dts: stm32: add resets property on all DMA nodes
 on stm32mp151
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200204141053.28072-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2fad34db-660f-4e5e-a0b8-16ca05da3125@st.com>
Date:   Mon, 10 Feb 2020 17:48:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204141053.28072-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 2/4/20 3:10 PM, Amelie Delaunay wrote:
> resets property is well-managed in DMA drivers. In previous products,
> there were no reset lines, that's why they are missing here in dma1, dma2,
> dmamux and mdma nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Applied on stm32-next.

Thanks
Alex
