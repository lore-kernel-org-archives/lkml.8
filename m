Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646CDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4651E206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCHSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:18:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbgHCHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:18:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07373wVO130488;
        Mon, 3 Aug 2020 03:18:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pa5rwcfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 03:18:05 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07376IgH138173;
        Mon, 3 Aug 2020 03:18:05 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pa5rwcf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 03:18:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07376gmC003714;
        Mon, 3 Aug 2020 07:18:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh1wsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 07:18:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0737I0Mh30540090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 07:18:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 680B542042;
        Mon,  3 Aug 2020 07:18:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E408A4204B;
        Mon,  3 Aug 2020 07:17:59 +0000 (GMT)
Received: from funtu.home (unknown [9.171.45.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 07:17:59 +0000 (GMT)
Subject: Re: [PATCH] s390/pkey: Remove redundant variable initialization
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
References: <20200802111526.4883-1-tianjia.zhang@linux.alibaba.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <297c9d42-14ed-8972-d3f0-954a6fe9859f@linux.ibm.com>
Date:   Mon, 3 Aug 2020 09:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802111526.4883-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008030046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.20 13:15, Tianjia Zhang wrote:
> In the first place, the initialization value of `rc` is wrong.
> It is unnecessary to initialize `rc` variables, so remove their
> initialization operation.
>
> Fixes: f2bbc96e7cfad ("s390/pkey: add CCA AES cipher key support")
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 74e63ec49068..58140506a8e7 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -818,7 +818,7 @@ static int pkey_keyblob2pkey2(const struct pkey_apqn *apqns, size_t nr_apqns,
>  static int pkey_apqns4key(const u8 *key, size_t keylen, u32 flags,
>  			  struct pkey_apqn *apqns, size_t *nr_apqns)
>  {
> -	int rc = EINVAL;
> +	int rc;
>  	u32 _nr_apqns, *_apqns = NULL;
>  	struct keytoken_header *hdr = (struct keytoken_header *)key;
>  
> @@ -886,7 +886,7 @@ static int pkey_apqns4keytype(enum pkey_key_type ktype,
>  			      u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
>  			      struct pkey_apqn *apqns, size_t *nr_apqns)
>  {
> -	int rc = -EINVAL;
> +	int rc;
>  	u32 _nr_apqns, *_apqns = NULL;
>  
>  	if (ktype == PKEY_TYPE_CCA_DATA || ktype == PKEY_TYPE_CCA_CIPHER) {
Thanks, I've picked this one and committed to the s390 subsystem.
