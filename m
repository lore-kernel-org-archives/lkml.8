Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46DC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B282082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgD2OGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:06:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgD2OGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:06:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TE2M0R087844;
        Wed, 29 Apr 2020 10:05:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me469ts9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:05:52 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TE2it7090253;
        Wed, 29 Apr 2020 10:05:52 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me469tm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:05:51 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TE3Vdh010400;
        Wed, 29 Apr 2020 14:05:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7wsqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 14:05:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03TE5cCm65732862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 14:05:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4034C04E;
        Wed, 29 Apr 2020 14:05:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 851594C040;
        Wed, 29 Apr 2020 14:05:36 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.83.72])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Apr 2020 14:05:36 +0000 (GMT)
Date:   Wed, 29 Apr 2020 19:35:33 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, skiboot@lists.ozlabs.org, oohall@gmail.com,
        ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [PATCH v8 2/3] API to verify the STOP API and image compatibility
Message-ID: <20200429140533.GC4852@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <20200423105438.29034-1-psampat@linux.ibm.com>
 <20200423105438.29034-3-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200423105438.29034-3-psampat@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_05:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pratik Rajesh Sampat <psampat@linux.ibm.com> [2020-04-23 16:24:37]:

> From: Prem Shanker Jha <premjha2@in.ibm.com>
> 
> Commit defines a new API primarily intended for OPAL to determine
> cpu register save API's compatibility with HOMER layout and
> self save restore. It can help OPAL determine if version of
> API integrated with OPAL is different from hostboot.
> 
> Change-Id: Ic0de45a336cfb8b6b6096a10ac1cd3ffbaa44fc0
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/77612
> Tested-by: FSP CI Jenkins <fsp-CI-jenkins+hostboot@us.ibm.com>
> Tested-by: Jenkins Server <pfd-jenkins+hostboot@us.ibm.com>
> Tested-by: Hostboot CI <hostboot-ci+hostboot@us.ibm.com>
> Reviewed-by: RANGANATHPRASAD G. BRAHMASAMUDRA <prasadbgr@in.ibm.com>
> Reviewed-by: Gregory S Still <stillgs@us.ibm.com>
> Reviewed-by: Jennifer A Stofer <stofer@us.ibm.com>
> Reviewed-on: http://rchgit01.rchland.ibm.com/gerrit1/77614
> Tested-by: Jenkins OP Build CI <op-jenkins+hostboot@us.ibm.com>
> Tested-by: Jenkins OP HW <op-hw-jenkins+hostboot@us.ibm.com>
> Reviewed-by: Daniel M Crowell <dcrowell@us.ibm.com>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>

> ---
>  include/p9_stop_api.H                    | 25 ++++++++++
>  libpore/p9_cpu_reg_restore_instruction.H |  7 ++-
>  libpore/p9_hcd_memmap_base.H             |  7 +++
>  libpore/p9_stop_api.C                    | 58 +++++++++++++++++++++++-
>  libpore/p9_stop_api.H                    | 26 ++++++++++-
>  libpore/p9_stop_util.H                   | 20 ++++----
>  6 files changed, 130 insertions(+), 13 deletions(-)

This stop-api code will help OPAL check and use self-save functions so
that different versions of OPAL can be loaded and run with different
versions of low level firmware stack.

--Vaidy
