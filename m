Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07CC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F78921741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBEG66 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:58:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbgBEG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:58:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0156nZ86138762
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 01:58:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xym4m7r6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:58:56 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 5 Feb 2020 06:58:54 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 06:58:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0156woOZ36307138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 06:58:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579575204F;
        Wed,  5 Feb 2020 06:58:50 +0000 (GMT)
Received: from localhost (unknown [9.124.35.138])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 03E615204E;
        Wed,  5 Feb 2020 06:58:49 +0000 (GMT)
Date:   Wed, 05 Feb 2020 12:28:49 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     ego@linux.vnet.ibm.com
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
        <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
        <1575564547.si4rk0s96p.naveen@linux.ibm.com>
        <20200203045013.GC13468@in.ibm.com>
        <1580802180.jpxk9s8apz.naveen@linux.ibm.com>
        <20200205041956.GA5401@in.ibm.com>
In-Reply-To: <20200205041956.GA5401@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20020506-0012-0000-0000-00000383CE3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020506-0013-0000-0000-000021C0377E
Message-Id: <1580885398.01q0jv6qlp.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_01:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=545 spamscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002050055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> 
>> With repect to lparstat, the read interval is user-specified and just gets
>> passed onto sleep().
> 
> Ok. So I guess currently you will be sending smp_call_function every
> time you read a PURR and SPURR. That number will now increase by 2
> times when we read idle_purr and idle_spurr.

Yes, not really efficient. I just wanted to point out that we can't have 
stale data being returned if we choose to add another sysfs file.

We should be able to use any other interface too, if you have a 
different interface in mind.


- Naveen

