Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53936C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C002075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgEKJFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:05:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:05:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04B939Ot109199;
        Mon, 11 May 2020 05:05:33 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wsc2wc93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 05:05:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04B915f7029312;
        Mon, 11 May 2020 09:05:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 30wm559mfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:05:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04B95S2B61079688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 09:05:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D5D74C052;
        Mon, 11 May 2020 09:05:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6A0C4C044;
        Mon, 11 May 2020 09:05:27 +0000 (GMT)
Received: from sig-9-145-153-65.de.ibm.com (unknown [9.145.153.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 May 2020 09:05:27 +0000 (GMT)
Message-ID: <2dbdf71e427a4b1df365412df34c773bc57528a9.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH -next] s390/cio: Remove unused inline
 functionidset_sch_get_first
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
To:     YueHaibing <yuehaibing@huawei.com>, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, gustavo@embeddedor.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 11:05:27 +0200
In-Reply-To: <20200508140643.30540-1-yuehaibing@huawei.com>
References: <20200508140643.30540-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_03:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=843
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 suspectscore=3 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.
This patch will be part of the s390's next patch submission.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Regards,
Vineeth


On Fri, 2020-05-08 at 22:06 +0800, YueHaibing wrote:
> commit 8ebd51a705c5 ("s390/cio: idset.c: remove some unused
> functions")
> left behind this, remove it
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/s390/cio/idset.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
> index 77d0ea7b381b..45f9c0736be4 100644
> --- a/drivers/s390/cio/idset.c
> +++ b/drivers/s390/cio/idset.c
> @@ -59,18 +59,6 @@ static inline int idset_contains(struct idset *set,
> int ssid, int id)
>  	return test_bit(ssid * set->num_id + id, set->bitmap);
>  }
>  
> -static inline int idset_get_first(struct idset *set, int *ssid, int
> *id)
> -{
> -	int bitnum;
> -
> -	bitnum = find_first_bit(set->bitmap, set->num_ssid * set-
> >num_id);
> -	if (bitnum >= set->num_ssid * set->num_id)
> -		return 0;
> -	*ssid = bitnum / set->num_id;
> -	*id = bitnum % set->num_id;
> -	return 1;
> -}
> -
>  struct idset *idset_sch_new(void)
>  {
>  	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);

