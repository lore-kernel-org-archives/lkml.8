Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92487C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4354422B49
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xV3TfPG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgH0HDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:03:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51414 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbgH0HDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:03:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R6qpS3005548;
        Thu, 27 Aug 2020 09:03:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=zTYlE8txNi8j4pKHdQtyqm86ciy1hB6NNeBayyhFyv4=;
 b=xV3TfPG7sPs/B1knAi2ouMJEWOkWCF5gS+9SrVj7yy768JsEC/MzqsCy7iveMwiOYEXh
 y02iEJ98W+LP7wDoVEQfk1mLfyF864qv+os2OeGWLzN92TQCpnB3Z9BWWKkHKafjF6qD
 v1R/LtWed8EkW7go6YMNqKuYCTNJPK4k74Bkkju8z4KEaF2lgSS/EKfq87Sie9uLEV6g
 sc17+1BM8wLw30AvbNm2xiUHiIGLGDZxSOIBJ9NXB1H1htpoCplMc5WrsbjxL48UF2mH
 sJ2gJTfqPlBgkoIEyhLBE8Qa6iqUypwKRsglJbapCvcymDFTNcUTkT9qDpxSzR0AaKnI ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b6xccj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:03:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D157410002A;
        Thu, 27 Aug 2020 09:03:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFD28210F88;
        Thu, 27 Aug 2020 09:03:06 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 09:03:05 +0200
Subject: Re: [PATCH 8/9] rpmsg: virtio: use rpmsg_ns driver to manage ns
 announcement
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-9-arnaud.pouliquen@st.com>
 <20200825165433.GA4141387@xps15>
 <c1b81b38-c155-3183-ed67-822c4f87ec71@st.com>
 <20200826221030.GB4141387@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <c6dc8282-7c84-730b-2946-378078b1e514@st.com>
Date:   Thu, 27 Aug 2020 09:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826221030.GB4141387@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 12:10 AM, Mathieu Poirier wrote:
> I had another very long look at this...  I haven't had the time to look in your
> next serie so the end result is not yet clear in my head.  But...
> 
> In __rpmsg_create_channel() the new code is testing for VIRTIO_RPMSG_F_NS in
> order to allocate the ops, which means that the rpdev that is fed to
> virtio_rpmsg_announce_create/destroy() are associated with a virtproc_info.
> Moreover there is a test in virtio_rpmsg_announce_create/destroy() that checks 
> for VIRTIO_RPMSG_F_NS already.  So if the rpdev was created from another
> interface than the name announcement then no message would be sent.  
> 
> So it seems to me that the last two patches could be dropped and things would
> still work properly.

Yes the last 2 patches concerns the TX part. Drop them could also be an option.
  
> 
> The good news is that I reviewed V2 today and things look good.  I will wait to
> review your next set before adding RB tags.  The down side is that having spent
> a fair amount of time on your set, I need to look at other people's work if I
> want to be fair to everyone.  As such I have to push back the review of your
> other set to next week.

That's fair! And this will give me time to have a look to the detach series. 

Thanks,
Arnaud

> 
> Thanks,
> Mathieu
> 
