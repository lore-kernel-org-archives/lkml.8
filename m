Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F8C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D727208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgD2OIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:08:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727078AbgD2OIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:08:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TE1HGv101120;
        Wed, 29 Apr 2020 10:08:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80pptxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:08:29 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TE1g6I103593;
        Wed, 29 Apr 2020 10:08:29 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80pptwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 10:08:28 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TE6L6x011854;
        Wed, 29 Apr 2020 14:08:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7wst8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 14:08:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03TE8Ofp27787324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 14:08:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E0A4A4059;
        Wed, 29 Apr 2020 14:08:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5124DA405D;
        Wed, 29 Apr 2020 14:08:22 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.83.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Apr 2020 14:08:22 +0000 (GMT)
Date:   Wed, 29 Apr 2020 19:38:19 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, skiboot@lists.ozlabs.org, oohall@gmail.com,
        ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [Skiboot] [PATCH v8 3/3] Self save API integration
Message-ID: <20200429140819.GD4852@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <20200423105438.29034-1-psampat@linux.ibm.com>
 <20200423105438.29034-4-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200423105438.29034-4-psampat@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_05:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pratik Rajesh Sampat <psampat@linux.ibm.com> [2020-04-23 16:24:38]:

> The commit makes the self save API available outside the firmware by defining
> an OPAL wrapper.
> This wrapper has a similar interface to that of self restore and expects the
> cpu pir, SPR number, minus the value of that SPR to be passed in its
> paramters and returns OPAL_SUCCESS on success. It adds a device-tree
> node signifying support for self-save after verifying the stop API
> version compatibility.
> 
> The commit also documents both the self-save and the self-restore API
> calls along with their working and usage.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>

> ---
>  doc/opal-api/opal-slw-self-save-reg-181.rst |  51 ++++++++++
>  doc/opal-api/opal-slw-set-reg-100.rst       |   5 +
>  doc/power-management.rst                    |  48 +++++++++
>  hw/slw.c                                    | 106 ++++++++++++++++++++
>  include/opal-api.h                          |   3 +-
>  include/p9_stop_api.H                       |  18 ++++
>  include/skiboot.h                           |   3 +
>  7 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 doc/opal-api/opal-slw-self-save-reg-181.rst

This patch enables OPAL interface to call stop-api and set self-save.
Basically completes the infrastructure required to use the new
self-save function provided by the microcode.

--Vaidy
