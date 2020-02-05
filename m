Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970FC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2D92082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBEIHy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 03:07:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbgBEIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 03:07:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01587jWZ138276
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 03:07:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmgc2eu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:07:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 5 Feb 2020 08:07:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 08:07:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01587lc145875350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 08:07:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D01EA404D;
        Wed,  5 Feb 2020 08:07:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE019A4059;
        Wed,  5 Feb 2020 08:07:46 +0000 (GMT)
Received: from localhost (unknown [9.124.35.138])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Feb 2020 08:07:46 +0000 (GMT)
Date:   Wed, 05 Feb 2020 13:37:45 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
        <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
        <b26cedb0-8b12-71b6-63d2-990186cd49e5@c-s.fr>
In-Reply-To: <b26cedb0-8b12-71b6-63d2-990186cd49e5@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20020508-0016-0000-0000-000002E3D0EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020508-0017-0000-0000-00003346AFF0
Message-Id: <1580889776.690kj4ppmj.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_02:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> 
> 
> Le 27/11/2019 à 13:01, Gautham R. Shenoy a écrit :
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> 
>> On Pseries LPARs, to calculate utilization, we need to know the
>> [S]PURR ticks when the CPUs were busy or idle.
>> 
>> The total PURR and SPURR ticks are already exposed via the per-cpu
>> sysfs files /sys/devices/system/cpu/cpuX/purr and
>> /sys/devices/system/cpu/cpuX/spurr.
>> 
>> This patch adds support for exposing the idle PURR and SPURR ticks via
>> /sys/devices/system/cpu/cpuX/idle_purr and
>> /sys/devices/system/cpu/cpuX/idle_spurr.
> 
> Might be a candid question, but I see in arch/powerpc/kernel/time.c that 
> PURR/SPURR are already taken into account by the kernel to calculate 
> utilisation when CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected.
> 
> As far as I understand, you are wanting to expose this to userland to 
> redo the calculation there. What is wrong with the values reported by 
> the kernel ?

As you point out, it is only done with 
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE, but isn't available with NO_HZ_FULL, 
which happens to be the distro default nowadays.

- Naveen

