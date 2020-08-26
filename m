Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F70C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E472078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEnbnMrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHZQwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:52:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgHZQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:52:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGnqlQ064879;
        Wed, 26 Aug 2020 16:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CrsB4hOh/IOUnBY1dl7dcxJi5+3Jl0r1xaa80gDONMo=;
 b=UEnbnMrP8mqj5BsJHIGuOjnCvJvNvGoC+ag0xw9anfWjXhUaUECQhQF2OLCc2JG7Qheg
 HkhT8TLGzCc2QclrFIuCnlauQiMFVJLqb1Dq5Ofy14Wfx8ptWG5GWT238ek+YIUin/pm
 QY1MUFSQRXhO0N8dj3LJkDfLydyYZCk4wJNoEmg1RisTI1AlIHDPMQUbFBjRgYBYYNBl
 9SyOkSxuTxXUzZKsI0n7pISnAIRnI3RNi0syAGRuTruKvGqfiWVGZXuGeHexGBsL7anW
 agzrUuJFnpeVfCXi0SV/8yzGqo17fiiagCDUqsv5iyWk9+uZq4Xs7692FiCT4I3M6N+p mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 333dbs1n5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 16:52:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGoqCN123571;
        Wed, 26 Aug 2020 16:52:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9mcwt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 16:52:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QGqcr4031493;
        Wed, 26 Aug 2020 16:52:39 GMT
Received: from [10.74.108.37] (/10.74.108.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 09:52:38 -0700
Subject: Re: [PATCH] memory: emif: Remove bogus debugfs error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200826113759.GF393664@mwanda>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <10387fe0-579a-de71-44ad-ac585ff604d6@oracle.com>
Date:   Wed, 26 Aug 2020 09:52:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200826113759.GF393664@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 4:37 AM, Dan Carpenter wrote:
> Callers are generally not supposed to check the return values from
> debugfs functions.  Debugfs functions never return NULL so this error
> handling will never trigger.  (Historically debugfs functions used to
> return a mix of NULL and error pointers but it was eventually deemed too
> complicated for something which wasn't intended to be used in normal
> situations).
> 
> Delete all the error handling.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
Looks good to me !!

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
