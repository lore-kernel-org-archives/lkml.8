Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6B5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGbuyRmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHJM5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:57:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbgHJM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:57:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ACXNxO155708;
        Mon, 10 Aug 2020 08:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VMwEKzoZEaQk2ASQ7NtMoW86yLosO08DxQSBN107Xss=;
 b=ZGbuyRmOuMWjJPT05GuFnKXT0pmVVT2tUXC1cfojw0WGcmcOFOZQhIZ0bcIyRNCnAVsU
 T1uLKsU+/y5U5xSLamq9dpX4U4B9B+Elz4+dC9gSFQmQBHSzhULp6lD7cqxg5NzaIO2M
 yswVtfbVC1A3cnjdLWHbZHerOkQFwhn+DyfhmoR+QztKXyR1eziav/9qSLCFh45lhEWl
 NS5yq8u75fLiRAOg4zKDuUYTI1KMCH18muEsOx9in9BamhEDgPMdXxP+S8N6CZAC3nwa
 mU6Vp3fqFGaukjbKeO255U7rHmvYpXkGxEHEcKJ60qBc1dVF1P25fCayay9+oJ23zEof 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sraqtqpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 08:57:09 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07ACXMIG155697;
        Mon, 10 Aug 2020 08:57:08 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sraqtqne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 08:57:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07ACuN4O006919;
        Mon, 10 Aug 2020 12:57:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 32skp81cyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 12:57:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07ACv3Vb63504762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 12:57:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42E7211C04C;
        Mon, 10 Aug 2020 12:57:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 781CD11C058;
        Mon, 10 Aug 2020 12:57:02 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.68.156])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Aug 2020 12:57:02 +0000 (GMT)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/objtool: Fix unnecessary jumps
To:     Youling Tang <tangyouling@loongson.cn>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <1597032374-7936-1-git-send-email-tangyouling@loongson.cn>
Message-ID: <bbe25938-479d-7a84-b1ee-941ad8088a1c@linux.vnet.ibm.com>
Date:   Mon, 10 Aug 2020 18:27:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597032374-7936-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_07:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 suspectscore=8 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=775
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/20 9:36 am, Youling Tang wrote:
> There is no need to jump to the "out" tag when "ret < 0", just return
> directly to "ret".
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  tools/objtool/check.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e034a8f..94b166d 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c

[snip]

> 
>  	if (file.elf->changed) {
>  		ret = elf_write(file.elf);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  	}
> 
>  out:

the out label code is no more required with this change, so remove
it and return 0 for warnings for now.  Previously cleanup() function
was called under the out label for both fatal errors (ret < 0) and
warnings.  Now that cleanup() function is removed, the out label is
no longer required.

-- 
Kamalesh
