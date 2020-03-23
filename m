Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56859C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345F820735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgCWNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgCWNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:37:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NDX7ZP130625
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:37:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywf2frnvh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:37:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 23 Mar 2020 13:37:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Mar 2020 13:37:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02NDbbJo13041712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:37:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E1E42042;
        Mon, 23 Mar 2020 13:37:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF5634203F;
        Mon, 23 Mar 2020 13:37:33 +0000 (GMT)
Received: from [9.199.48.122] (unknown [9.199.48.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Mar 2020 13:37:33 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 00/15] powerpc/watchpoint: Preparation for more than one
 watchpoint
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <b7148b91-e3db-d48a-7294-5c18fc801933@c-s.fr>
 <429c04e9-7267-55a9-a6f9-1fe9b21ae033@linux.ibm.com>
Date:   Mon, 23 Mar 2020 19:07:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <429c04e9-7267-55a9-a6f9-1fe9b21ae033@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032313-0012-0000-0000-000003963B45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032313-0013-0000-0000-000021D32BAA
Message-Id: <27a3c6c0-3880-406a-3e1e-ccb017e5a77c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_04:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 6:22 PM, Ravi Bangoria wrote:
> 
> 
> On 3/16/20 8:35 PM, Christophe Leroy wrote:
>>
>>
>> Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
>>> So far, powerpc Book3S code has been written with an assumption of only
>>> one watchpoint. But future power architecture is introducing second
>>> watchpoint register (DAWR). Even though this patchset does not enable
>>> 2nd DAWR, it make the infrastructure ready so that enabling 2nd DAWR
>>> should just be a matter of changing count.
>>
>> Some book3s (e300 family for instance, I think G2 as well) already have a DABR2 in addition to DABR.
>> Will this series allow to use it as well ?
> 
> I wasn't aware of that. I'll take a look at their specs and check if they
> can piggyback on this series for 2nd DABR.

There are some differences between G2/e300 DABRs and Book3S DAWRs. G2/e300
DABRs provides some functionalities like "Match if EA less/greater than DABR",
"combined mode" etc. are not present with DAWRs. DBCR on G2/e300 also provides
which DABR caused the exception. So this series might not directly allow to
use DABR2 but, I guess, it should work as base infrastructure.

Ravi

