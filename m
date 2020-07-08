Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F922C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F45207DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgGHQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:28:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51508 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730141AbgGHQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:28:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068GEDxN175857;
        Wed, 8 Jul 2020 12:28:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325hg20d4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 12:28:44 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068GFkYr179063;
        Wed, 8 Jul 2020 12:28:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325hg20d3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 12:28:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068GQiUV023700;
        Wed, 8 Jul 2020 16:28:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h4nxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 16:28:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068GSe1U3408290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 16:28:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFF4A405B;
        Wed,  8 Jul 2020 16:28:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54175A4064;
        Wed,  8 Jul 2020 16:28:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 16:28:39 +0000 (GMT)
Message-ID: <1594225718.23056.257.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 2/3] ima-evm-utils: beautify the code to
 make it more readable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, vt@altlinux.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 12:28:38 -0400
In-Reply-To: <20200707033548.21640-2-tianjia.zhang@linux.alibaba.com>
References: <20200707033548.21640-1-tianjia.zhang@linux.alibaba.com>
         <20200707033548.21640-2-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_13:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 11:35 +0800, Tianjia Zhang wrote:
> @@ -625,7 +625,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
>  	unsigned char hash[MAX_DIGEST_SIZE];
>  	int hashlen, sig_hash_algo;
>  
> -	if (sig[0] != 0x03) {
> +	if (sig[0] != EVM_IMA_XATTR_DIGSIG) {
>  		log_err("xattr ima has no signature\n");
>  		return -1;
>  	}

This last hunk didn't apply properly.  The error message now includes
the filename.  I've fixed this patch.  In the future, please post
patches against the next-testing branch.

thanks,

Mimi

