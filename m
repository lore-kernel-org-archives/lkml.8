Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45F520656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NI9LWtJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHJUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:24:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:24:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AKN2g1042379;
        Mon, 10 Aug 2020 20:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rjxCOpOQTVr5tT+NHdq88IK32fuUTfE4iiryPENO3WM=;
 b=NI9LWtJPTrGI3wgeNZvy7O6sysr/1bij4kppotBX8F1lVejbbzovl6Ri1WB8v1/GwzVx
 koQCKN9GXZ9YorO/JXVAbq3ZnAThqiV15rXFghvzEGJYBJg/murHSZrA49ZW7FAtqTRG
 jk5jV1q89XXd/tWnMHkJ/Qkw6rGczSHxuqBlmRB2CTVrrAhQUeIQtC4gao4p+3qTOBAn
 zI6u0xB2kOHDiNjb6TXI354BgVD1/nw2mULNR5VELbX3czngSBE02dDas//N91BQBLb2
 Wx3FhMrOiUFLkkeA1Kt4doj77D3YRUko2fM48gMDP+qPola6MviYxsopNMzG9x6wqpHy Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32sm0mgtmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 20:24:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AKDFfI026503;
        Mon, 10 Aug 2020 20:22:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32t5y1vvy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 20:22:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07AKMU2K016832;
        Mon, 10 Aug 2020 20:22:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 13:22:30 -0700
Subject: Re: [PATCH 01/10] mm/hugetlb: not necessary to coalesce regions
 recursively
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-2-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ef97c47-f193-7664-fbcc-21fbaa27c26a@oracle.com>
Date:   Mon, 10 Aug 2020 13:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807091251.12129-2-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=959 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=957 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 2:12 AM, Wei Yang wrote:
> Per my understanding, we keep the regions ordered and would always
> coalesce regions properly. So the task to keep this property is just
> to coalesce its neighbour.
> 
> Let's simplify this.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Thanks!  It is unfortunate that the region management code is difficult
to understand.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
