Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB16C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0FB2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JH9clXki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCZLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:00:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727590AbgCZLAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:00:05 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QAw3le004718;
        Thu, 26 Mar 2020 11:59:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ePaRO2xQxOSssih3ATmMumUDQxzntYCKLl5miAQMV5w=;
 b=JH9clXkigdRraWQGXYGOr5OIW5C0DUutbVjb3FjeIpaKChItgfANVt8ZSlPcbAJ29JQF
 pcXwgEF3oq3ZiT6SlQBovqwa4XPGP0NoiabrJ1AzHyhzX0GHTYH3irwUrSjfNk3+j+np
 MT1qeeRo276ThIrrCloKGNcKxcoD8mSyc/Q08WnSeXaDcNLF2dPbyfV++pERS0Cba980
 YiUF7ir7TU7okOhmKfyC+9/kHPHg9eqRHCH3HiiCWeBH5MBY+kRZw76BxYUJOne1rqH5
 W9AZOg+uxLaMXCevPQSgT805s254FyCGJhIvJkehDIav9m5nVL/6W/ykSz11n5fRACKz Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ywappb5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 11:59:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 84D8F100038;
        Thu, 26 Mar 2020 11:59:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DC9E2A5553;
        Thu, 26 Mar 2020 11:59:48 +0100 (CET)
Received: from lmecxl0889.tpe.st.com (10.75.127.46) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 11:59:38 +0100
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.cz>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
 <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
 <1e4ce821-dd9b-bb04-774b-58a255834cf5@st.com>
 <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
 <f97d9dc54178e4344512bc7986265f101f4639c6.camel@perches.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <54d9b379-ba51-b29c-db58-6e305773ee96@st.com>
Date:   Thu, 26 Mar 2020 11:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f97d9dc54178e4344512bc7986265f101f4639c6.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_02:2020-03-26,2020-03-26 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/20 1:01 AM, Joe Perches wrote:
> On Wed, 2020-03-25 at 14:31 +0100, Jiri Slaby wrote:
>> The question was exactly about that: can a compiler optimize it to a
>> bare number or will strlen call remain there?
> 
> $ cat str.c
> #include <string.h>
> 
> int foo(void)
> {
> 	return strlen("abc");
> }
> 
> $ gcc -c -O2 str.c
> $ objdump -d str.o
> str.o:     file format elf64-x86-64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo>:
>    0:	f3 0f 1e fa          	endbr64 
>    4:	b8 03 00 00 00       	mov    $0x3,%eax
>    9:	c3                   	retq   
> 
> 
same result with  arm gcc using  -O1 or -Og:

str.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <foo>:
   0:	e3a00003 	mov	r0, #3
   4:	e12fff1e 	bx	lr

So in conclusion replacing sizeof by srlen even if not optimized in -o0, right?

Thanks,
Arnaud
