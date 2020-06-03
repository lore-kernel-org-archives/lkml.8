Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C79C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ABF205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WgRbpApD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCR1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:27:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:27:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HLwEE117316;
        Wed, 3 Jun 2020 17:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3x+vehfn6cj584x/VrWmDRRX+hJkbPZQN232qjzBkFY=;
 b=WgRbpApDE+HlxmC8QHfy1jL5emI3gUYPRsFg5qQw0K6NPq2zLgcuFETGWeoXOML2Ivyu
 O0Md6TfA/5hooZyVIPEVvMbRxFgG/958hZxKEu7DUBFeLW3IJ/jODdQk003xDwdhVB5b
 h9yvf4v2eftzGuqU8V3EUVvuRDEVutRwNTqfOVAWTgNH36jDR+jSvRqz3fFSxnatARPu
 BYEc2WDypMkChA6QuRNAsQqAIAIBM7qZL/NmxJ0NyOfRdQKIO2b1NheUQMf2KqERP0LF
 n5bZOk4Oe7GSof+7+F9HHoIzar0f1PCL0/+czFLwFlwG13bx/n4hzFR+px+upHBQ/QwI cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewr2krb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:27:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HI2NZ107611;
        Wed, 3 Jun 2020 17:27:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju3k0mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:27:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053HR4kM008395;
        Wed, 3 Jun 2020 17:27:04 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:27:04 -0700
Subject: Re: [PATCH 1/2] mm: cma: fix the name of CMA areas
To:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org
Cc:     guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
 <20200603084025.62740-2-song.bao.hua@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7b533da9-f321-cb2d-b960-37dc7b8885a9@oracle.com>
Date:   Wed, 3 Jun 2020 10:27:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603084025.62740-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 1:40 AM, Barry Song wrote:
> if users give a name saved in stack, the current code will generate magic
> pointer.
> if users don't give a name(NULL), kasprintf() will always return NULL as
> we are at the early stage. that means cma_init_reserved_mem() will return
> -ENOMEM if users set name parameter as NULL.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Thank you

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
