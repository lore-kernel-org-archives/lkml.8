Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE502C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B1320768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCRMlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:41:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45450 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgCRMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:41:11 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICWnO9076829
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:41:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu931vajh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:41:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 18 Mar 2020 12:41:07 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 12:41:03 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ICf14949217756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 12:41:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E2DE5205A;
        Wed, 18 Mar 2020 12:41:01 +0000 (GMT)
Received: from [9.199.38.35] (unknown [9.199.38.35])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 12ADF5204F;
        Wed, 18 Mar 2020 12:40:39 +0000 (GMT)
Subject: Re: [PATCH 01/15] powerpc/watchpoint: Rename current DAWR macros
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-2-ravi.bangoria@linux.ibm.com>
 <6ae1865c-fcf6-5bef-2d93-e75b03ed8b44@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 18 Mar 2020 18:10:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6ae1865c-fcf6-5bef-2d93-e75b03ed8b44@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031812-0028-0000-0000-000003E6E48F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031812-0029-0000-0000-000024AC3C6E
Message-Id: <217821bd-5a3e-8e0a-0d42-5f09bf8c4a4d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_05:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 3:44 PM, Christophe Leroy wrote:
> 
> 
> Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
>> Future Power architecture is introducing second DAWR. Rename current
>> DAWR macros as:
>>   s/SPRN_DAWR/SPRN_DAWR0/
>>   s/SPRN_DAWRX/SPRN_DAWRX0/
> 
> I think you should tell that DAWR0 and DAWRX0 is the real name of the register as documented in (at least) power8 and power9 user manual.
> 
> Otherwise, we can't understand why you change the name of the register.

Ok.

Thanks,
Ravi

