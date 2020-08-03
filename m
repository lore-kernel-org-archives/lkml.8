Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B11C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7036722CA1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q2T67Bfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgHCVMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:12:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39776 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgHCVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:12:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073LC5Aj155693;
        Mon, 3 Aug 2020 21:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=coPlDp690bVQKrb6CgS9uUoXxxJcdWaAyy5rOJSG0HM=;
 b=q2T67BfyWrRvIyCoyKQjU6vzRXQ3Tox/4eS6Jx+x2ekBHmLHkDEngbBmZid/mZdHGoVG
 QOziUzwm/obj/ygJBlywfENFUjsNE/4CMGLmyoR/FncUq+0BOSz08E2w/5NKJzFJLADC
 /ZPv5as1Z1sUiSSQzWHMdCuXf3zY4Bt7jArYCnvnp2MRivFfMZoPlKfKtjEbZe6JBMoQ
 x6xMmS0qoYOIkg5qVaL9eYPzrk41mdgmRxd+q4DKB5bfShK/I8WH6S2eBROFIitncXbZ
 1xJ6vjtle/glQNwfAFuPvnyan/lxujVQ8G7iduL5zhtqSFvgNHB+Beq7csiCR/9Vcbgn Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n0r9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 21:12:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073L8tLg176648;
        Mon, 3 Aug 2020 21:10:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32pdhb054u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 21:10:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073LADtD008707;
        Mon, 3 Aug 2020 21:10:13 GMT
Received: from [10.159.240.44] (/10.159.240.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 14:10:13 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
Date:   Mon, 3 Aug 2020 14:10:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On 8/3/2020 1:41 PM, Dave Jiang wrote:
> On 7/24/2020 9:09 AM, Jane Chu wrote:
>> Since
>> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' 
>> attribute"),
>> when issue
>>   # ndctl sanitize-dimm nmem0 --overwrite
>> then immediately check the 'security' attribute,
>>   # cat 
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>>   unlocked
>> Actually the attribute stays 'unlocked' through out the entire overwrite
>> operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
>> that has both bits set indicating 'overwrite' and 'unlocked'.
>> But security_show() checks the mutually exclusive bits before it checks
>> the 'overwrite' bit at last. The order should be reversed.
>>
>> The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
>> assignment is replaced with 'nvdimm->sec.flags' assignment for
>> the NVDIMM_MASTER type.
> 
> May be best to split this fix to a different patch? Just thinking git 
> bisect later on to track issues. Otherwise Reviewed-by: Dave Jiang 
> <dave.jiang@intel.com>

Sure. I take it you meant to separate the typo fix from the change that 
tests the OVERWRITE bit first?

Regards,
-jane
