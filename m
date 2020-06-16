Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A182098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgFPNZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:25:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgFPNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:25:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GD3P9i070097;
        Tue, 16 Jun 2020 09:25:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7npex1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 09:25:05 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GD3ST1070372;
        Tue, 16 Jun 2020 09:25:04 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7npevt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 09:25:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GDJkA3032303;
        Tue, 16 Jun 2020 13:25:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 31mpe7wd5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 13:25:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GDOx0L34275416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 13:24:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EBDBAE051;
        Tue, 16 Jun 2020 13:24:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0398DAE053;
        Tue, 16 Jun 2020 13:24:59 +0000 (GMT)
Received: from osiris (unknown [9.171.4.37])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jun 2020 13:24:58 +0000 (GMT)
Date:   Tue, 16 Jun 2020 15:24:57 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: fix syscall_get_error for compat processes
Message-ID: <20200616132457.GA4166@osiris>
References: <20200602180051.GA2427@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602180051.GA2427@altlinux.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=794 clxscore=1011 impostorscore=0 malwarescore=0
 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:00:51PM +0300, Dmitry V. Levin wrote:
> If both the tracer and the tracee are compat processes, and gprs[2]
> is assigned a value by __poke_user_compat, then the higher 32 bits
> of gprs[2] are cleared, IS_ERR_VALUE() always returns false, and
> syscall_get_error() always returns 0.
> 
> Fix the implementation by sign-extending the value for compat processes
> the same way as x86 implementation does.
> 
> The bug was exposed to user space by commit 201766a20e30f ("ptrace: add
> PTRACE_GET_SYSCALL_INFO request") and detected by strace test suite.
> 
> This change fixes strace syscall tampering on s390.
> 
> Fixes: 753c4dd6a2fa2 ("[S390] ptrace changes")
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: stable@vger.kernel.org # v2.6.28+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/s390/include/asm/syscall.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thank you!
