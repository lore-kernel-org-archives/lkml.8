Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC859C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881CD20714
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGPAf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:35:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbgGPAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:35:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G0WP27006018;
        Wed, 15 Jul 2020 20:35:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329r1jcupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:35:16 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G0WQg3006534;
        Wed, 15 Jul 2020 20:35:16 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329r1jcupe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:35:16 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G0KJoq015981;
        Thu, 16 Jul 2020 00:35:15 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 327529cswp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 00:35:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G0ZEiA46334458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 00:35:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 454917805F;
        Thu, 16 Jul 2020 00:35:14 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2BE87805E;
        Thu, 16 Jul 2020 00:35:10 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 00:35:10 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466095278.24747.9161591016931052627.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 08/12] ppc64/kexec_file: setup the stack for purgatory
In-reply-to: <159466095278.24747.9161591016931052627.stgit@hbathini.in.ibm.com>
Date:   Wed, 15 Jul 2020 21:35:07 -0300
Message-ID: <87zh808fgk.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> To avoid any weird errors, the purgatory should run with its own
> stack. Set one up by adding the stack buffer to .data section of
> the purgatory. Also, setup opal base & entry values in r8 & r9
> registers to help early OPAL debugging.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>
> v2 -> v3:
> * Unchanged. Added Tested-by tag from Pingfan.
>
> v1 -> v2:
> * Setting up opal base & entry values in r8 & r9 for early OPAL debug.
>
>
>  arch/powerpc/include/asm/kexec.h       |    4 ++++
>  arch/powerpc/kexec/file_load_64.c      |   29 +++++++++++++++++++++++++++++
>  arch/powerpc/purgatory/trampoline_64.S |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
