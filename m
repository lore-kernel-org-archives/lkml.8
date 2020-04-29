Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA6C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2503920731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgD2ODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgD2ODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TE2Pjv088174;
        Wed, 29 Apr 2020 10:02:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me469ptw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:02:52 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TE2qKG090752;
        Wed, 29 Apr 2020 10:02:52 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me469ps6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:02:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TDoQ7F010553;
        Wed, 29 Apr 2020 14:02:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5rhr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 14:02:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03TE2lls786710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 14:02:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D58AE04D;
        Wed, 29 Apr 2020 14:02:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9994AE051;
        Wed, 29 Apr 2020 14:02:44 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.83.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Apr 2020 14:02:44 +0000 (GMT)
Date:   Wed, 29 Apr 2020 19:32:42 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, skiboot@lists.ozlabs.org, oohall@gmail.com,
        ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [Skiboot] [PATCH v8 1/3] Self Save: Introducing Support for SPR
 Self Save
Message-ID: <20200429140242.GB4852@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <20200423105438.29034-1-psampat@linux.ibm.com>
 <20200423105438.29034-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200423105438.29034-2-psampat@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_05:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pratik Rajesh Sampat <psampat@linux.ibm.com> [2020-04-23 16:24:36]:

> From: Prem Shanker Jha <premjha2@in.ibm.com>
> 
> The commit is a merger of commits that makes the following changes:
> 1. Commit fixes some issues with code found during integration test
>   -  replacement of addi with xor instruction during self save API.
>   -  fixing instruction generation for MFMSR during self save
>   -  data struct updates in STOP API
>   -  error RC updates for hcode image build
>   -  HOMER parser updates.
>   -  removed self save support for URMOR and HRMOR
>   -  code changes for compilation with OPAL
>   -  populating CME Image header with unsecure HOMER address.
> 
> Key_Cronus_Test=PM_REGRESS
> 
> Change-Id: I7cedcc466267c4245255d8d75c01ed695e316720
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/66580
> Tested-by: FSP CI Jenkins <fsp-CI-jenkins+hostboot@us.ibm.com>
> Tested-by: HWSV CI <hwsv-ci+hostboot@us.ibm.com>
> Tested-by: PPE CI <ppe-ci+hostboot@us.ibm.com>
> Tested-by: Jenkins Server <pfd-jenkins+hostboot@us.ibm.com>
> Tested-by: Cronus HW CI <cronushw-ci+hostboot@us.ibm.com>
> Tested-by: Hostboot CI <hostboot-ci+hostboot@us.ibm.com>
> Reviewed-by: Gregory S. Still <stillgs@us.ibm.com>
> Reviewed-by: RAHUL BATRA <rbatra@us.ibm.com>
> Reviewed-by: Jennifer A. Stofer <stofer@us.ibm.com>
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/66587
> Reviewed-by: Christian R. Geddes <crgeddes@us.ibm.com>
> Signed-off-by: Prem Shanker Jha <premjha2@in.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>

> 2. The commit also incorporates changes that make STOP API project
> agnostic changes include defining wrapper functions which call legacy
> API. It also adds duplicate enum members which start with prefix PROC
> instead of P9.
> 
> Key_Cronus_Test=PM_REGRESS
> 
> Change-Id: If87970f3e8cf9b507f33eb1be249e03eb3836a5e
> RTC: 201128
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/71307
> Tested-by: FSP CI Jenkins <fsp-CI-jenkins+hostboot@us.ibm.com>
> Tested-by: Jenkins Server <pfd-jenkins+hostboot@us.ibm.com>
> Tested-by: Hostboot CI <hostboot-ci+hostboot@us.ibm.com>
> Tested-by: Cronus HW CI <cronushw-ci+hostboot@us.ibm.com>
> Reviewed-by: RANGANATHPRASAD G. BRAHMASAMUDRA <prasadbgr@in.ibm.com>
> Reviewed-by: Gregory S. Still <stillgs@us.ibm.com>
> Reviewed-by: Jennifer A Stofer <stofer@us.ibm.com>
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/71314
> Tested-by: Jenkins OP Build CI <op-jenkins+hostboot@us.ibm.com>
> Tested-by: Jenkins OP HW <op-hw-jenkins+hostboot@us.ibm.com>
> Reviewed-by: Daniel M. Crowell <dcrowell@us.ibm.com>
> Signed-off-by: Prem Shanker Jha <premjha2@in.ibm.com>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  include/p9_stop_api.H                    |  79 +-
>  libpore/p9_cpu_reg_restore_instruction.H |   4 +
>  libpore/p9_stop_api.C                    | 954 +++++++++++++----------
>  libpore/p9_stop_api.H                    | 115 ++-
>  libpore/p9_stop_data_struct.H            |   4 +-
>  libpore/p9_stop_util.H                   |   7 +-
>  6 files changed, 721 insertions(+), 442 deletions(-)


These code changes are from hcode component copied as is into OPAL
project for integration and use of stop-api.

Hcode component in cooperation with hostboot would be loaded in memory
before OPAL is loaded. This code will allow runtime changes and usage
of various power management save restore functions.

This patch specifically enables self-save feature by the microcode.

--Vaidy

