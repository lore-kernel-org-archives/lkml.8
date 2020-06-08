Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED742053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgFHO2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:28:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgFHO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:28:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058EM3Dr028140;
        Mon, 8 Jun 2020 10:26:26 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g41dvbs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 10:26:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058EPDg2017538;
        Mon, 8 Jun 2020 14:26:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7v50c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 14:26:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058EPwXY23855244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 14:25:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C889F4C05A;
        Mon,  8 Jun 2020 14:25:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE9E4C059;
        Mon,  8 Jun 2020 14:25:57 +0000 (GMT)
Received: from osiris (unknown [9.171.20.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Jun 2020 14:25:57 +0000 (GMT)
Date:   Mon, 8 Jun 2020 16:25:56 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/3] s390: use scnprintf() in show() methods
Message-ID: <20200608142556.GA7478@osiris>
References: <20200509085608.41061-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509085608.41061-1-chenzhou10@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_13:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011 mlxlogscore=839
 bulkscore=0 suspectscore=1 cotscore=-2147483648 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:56:05PM +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
> 	    
> show() methods should return the number of bytes printed into the
> buffer. This is the return value of scnprintf().
> 
> Chen Zhou (3):
>   s390/crypto: use scnprintf() instead of snprintf()
>   s390: use scnprintf() in sys_##_prefix##_##_name##_show
>   s390/protvirt: use scnprintf() instead of snprintf()
> 
>  arch/s390/crypto/prng.c | 14 +++++++-------
>  arch/s390/kernel/ipl.c  |  2 +-
>  arch/s390/kernel/uv.c   |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)

All applied, even though the buffer has a size of 4k in all cases.
So this doesn't fix anything; but it doesn't hurt as well.
