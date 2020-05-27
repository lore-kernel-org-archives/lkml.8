Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B2E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgE0J41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:56:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgE0J40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:56:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R9avKN187802;
        Wed, 27 May 2020 05:55:50 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 316vrwfvn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 05:55:50 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R9tibR003749;
        Wed, 27 May 2020 09:55:50 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 316uf9p7ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 09:55:50 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R9tnt231654298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 09:55:49 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 759EEAC059;
        Wed, 27 May 2020 09:55:49 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3624DAC05F;
        Wed, 27 May 2020 09:55:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.125.124])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 May 2020 09:55:46 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v8 5/5] powerpc/papr_scm: Implement support for
 PAPR_SCM_PDSM_HEALTH
In-Reply-To: <20200527041244.37821-6-vaibhav@linux.ibm.com>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com>
 <20200527041244.37821-6-vaibhav@linux.ibm.com>
Date:   Wed, 27 May 2020 15:25:45 +0530
Message-ID: <87pnap7lcu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=873 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> This patch implements support for PDSM request 'PAPR_SCM_PDSM_HEALTH'
> that returns a newly introduced 'struct nd_papr_pdsm_health' instance
> containing dimm health information back to user space in response to
> ND_CMD_CALL. This functionality is implemented in newly introduced
> papr_scm_get_health() that queries the scm-dimm health information and
> then copies this information to the package payload whose layout is
> defined by 'struct nd_papr_pdsm_health'.
>
> The patch also introduces a new member 'struct papr_scm_priv.health'
> thats an instance of 'struct nd_papr_pdsm_health' to cache the health
> information of a nvdimm. As a result functions drc_pmem_query_health()
> and flags_show() are updated to populate and use this new struct
> instead of a u64 integer that was earlier used.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-aneesh
