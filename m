Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074892067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:21:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFBQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:21:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052G36Q8046679;
        Tue, 2 Jun 2020 12:21:19 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ds8gsrqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 12:21:19 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052GFB5b008229;
        Tue, 2 Jun 2020 16:21:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 31bf47tktw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 16:21:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052GLD0U27721924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 16:21:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD6D911C04C;
        Tue,  2 Jun 2020 16:21:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656EB11C052;
        Tue,  2 Jun 2020 16:21:13 +0000 (GMT)
Received: from pic2.home (unknown [9.145.35.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 16:21:13 +0000 (GMT)
Subject: Re: [PATCH] cxl: Fix kobject memleak
To:     Wang Hai <wanghai38@huawei.com>, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     mpe@ellerman.id.au, imunsie@au1.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200602120733.5943-1-wanghai38@huawei.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <9ec43143-91c9-0ff0-aa6a-c9fd013eb63d@linux.ibm.com>
Date:   Tue, 2 Jun 2020 18:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602120733.5943-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 cotscore=-2147483648 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/06/2020 à 14:07, Wang Hai a écrit :
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking
> the kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Fixes: b087e6190ddc ("cxl: Export optional AFU configuration record in sysfs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>


Indeed, a call to kobject_put() is needed when the init fails.
Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


> ---
>   drivers/misc/cxl/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index f0263d1..d97a243 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -624,7 +624,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
>   	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
>   				  &afu->dev.kobj, "cr%i", cr->cr);
>   	if (rc)
> -		goto err;
> +		goto err1;
>   
>   	rc = sysfs_create_bin_file(&cr->kobj, &cr->config_attr);
>   	if (rc)
> 
