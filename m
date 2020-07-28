Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F82C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FF720775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG1Ch3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:37:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgG1Ch2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:37:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S2WBY0049835;
        Mon, 27 Jul 2020 22:37:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32j2paw380-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 22:37:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06S2Wdbo051238;
        Mon, 27 Jul 2020 22:37:17 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32j2paw37q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 22:37:17 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06S2VPTa015633;
        Tue, 28 Jul 2020 02:37:16 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 32gcy5dvn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 02:37:16 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06S2bBv663308088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 02:37:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25A59BE054;
        Tue, 28 Jul 2020 02:37:15 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C3FBE05A;
        Tue, 28 Jul 2020 02:37:11 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.132.76])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Jul 2020 02:37:11 +0000 (GMT)
References: <159579157320.5790.6748078824637688685.stgit@hbathini> <159579235754.5790.5203600072984600891.stgit@hbathini>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pingfan Liu <piliu@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RESEND PATCH v5 08/11] ppc64/kexec_file: setup backup region for kdump kernel
In-reply-to: <159579235754.5790.5203600072984600891.stgit@hbathini>
Date:   Mon, 27 Jul 2020 23:37:08 -0300
Message-ID: <87d04gxt4b.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_16:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxlogscore=751 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> Though kdump kernel boots from loaded address, the first 64KB of it is
> copied down to real 0. So, setup a backup region and let purgatory
> copy the first 64KB of crashed kernel into this backup region before
> booting into kdump kernel. Update reserve map with backup region and
> crashed kernel's memory to avoid kdump kernel from accidentially using
> that memory.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
