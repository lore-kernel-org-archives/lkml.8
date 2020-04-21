Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCB9C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED51206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgDUNa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:30:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:30:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LD9Clb132674;
        Tue, 21 Apr 2020 09:30:14 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu6wr5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 09:30:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03LDUCvF028782;
        Tue, 21 Apr 2020 13:30:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 30fs66qu59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 13:30:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LDUC9o32571744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 13:30:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69B0CB205F;
        Tue, 21 Apr 2020 13:30:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42538B2064;
        Tue, 21 Apr 2020 13:30:12 +0000 (GMT)
Received: from localhost (unknown [9.85.163.64])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 13:30:12 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v5 0/5] Track and expose idle PURR and SPURR ticks
In-Reply-To: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
Date:   Tue, 21 Apr 2020 08:30:11 -0500
Message-ID: <877dy92cgs.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> This is the fifth version of the patches to track and expose idle PURR
> and SPURR ticks. These patches are required by tools such as lparstat
> to compute system utilization for capacity planning purposes.
>
> The previous versions can be found here:
> v4: https://lkml.org/lkml/2020/3/27/323
> v3: https://lkml.org/lkml/2020/3/11/331
> v2: https://lkml.org/lkml/2020/2/21/21
> v1: https://lore.kernel.org/patchwork/cover/1159341/
>
> They changes from v4 are:
>
>    - As suggested by Naveen, moved the functions read_this_idle_purr()
>      and read_this_idle_spurr() from Patch 2 and Patch 3 respectively
>      to Patch 4 where it is invoked.
>
>    - Dropped Patch 6 which cached the values of purr, spurr,
>      idle_purr, idle_spurr in order to minimize the number of IPIs
>      sent.
>
>    - Updated the dates for the idle_purr, idle_spurr in the
>      Documentation Patch 5.

LGTM

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

Thanks.
