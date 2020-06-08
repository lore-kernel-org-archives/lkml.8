Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D592072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgFHO1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:27:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgFHO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:27:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058ERRRI021326;
        Mon, 8 Jun 2020 10:27:29 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g7n7yqry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 10:27:29 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058EPDgE017538;
        Mon, 8 Jun 2020 14:27:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7v51w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 14:27:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058ER8TO27197480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 14:27:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 766E211C05B;
        Mon,  8 Jun 2020 14:27:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 372A011C066;
        Mon,  8 Jun 2020 14:27:08 +0000 (GMT)
Received: from osiris (unknown [9.171.20.146])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Jun 2020 14:27:08 +0000 (GMT)
Date:   Mon, 8 Jun 2020 16:27:06 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390/zcrypt: fix kzalloc-simple.cocci warnings
Message-ID: <20200608142706.GB7478@osiris>
References: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_12:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=808
 suspectscore=1 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:35:48PM +0800, Zou Wei wrote:
> This patch fixes below warning reported by coccicheck
> 
> drivers/s390/crypto/zcrypt_ep11misc.c:198:8-15: WARNING:
> kzalloc should be used for cprb, instead of kmalloc/memset
> 
> Fixes: 7384eb725e2d ("s390/zcrypt: add new low level ep11 functions support file")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, however without Fixes tag, since this was not a bug.
