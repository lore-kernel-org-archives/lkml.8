Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B831C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7C520792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgGUDZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:25:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgGUDZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:25:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L33Lb2118592;
        Mon, 20 Jul 2020 23:25:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32dhprt72k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 23:25:05 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06L3EPZh159648;
        Mon, 20 Jul 2020 23:25:04 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32dhprt71r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 23:25:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06L3Kncs010724;
        Tue, 21 Jul 2020 03:25:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq83ckp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 03:25:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06L3OxBx59244558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 03:24:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1828FAE053;
        Tue, 21 Jul 2020 03:24:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FC91AE045;
        Tue, 21 Jul 2020 03:24:55 +0000 (GMT)
Received: from [9.199.47.202] (unknown [9.199.47.202])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 03:24:55 +0000 (GMT)
Subject: Re: [PATCH v4 10/10] powerpc/watchpoint: Remove 512 byte boundary
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com>
 <20200717040958.70561-11-ravi.bangoria@linux.ibm.com>
 <CACzsE9og50tH9jRZjWYDgbFxdTkDXJq3gMuP8uxPWfrrREo=4w@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <8ee4424b-ca42-082d-d845-0e06357c8b8f@linux.ibm.com>
Date:   Tue, 21 Jul 2020 08:54:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACzsE9og50tH9jRZjWYDgbFxdTkDXJq3gMuP8uxPWfrrREo=4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_19:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

On 7/20/20 12:24 PM, Jordan Niethe wrote:
> On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>>
>> Power10 has removed 512 bytes boundary from match criteria. i.e. The watch
>> range can cross 512 bytes boundary.
> It looks like this change is not mentioned in ISA v3.1 Book III 9.4
> Data Address Watchpoint. It could be useful to mention that in the
> commit message.

Yes, ISA 3.1 Book III 9.4 has a documentation mistake and hopefully it
will be fixed in the next version of ISA. Though, this is mentioned in
ISA 3.1 change log:

   Multiple DEAW:
   Added a second Data Address Watchpoint. [H]DAR is
   set to the first byte of overlap. 512B boundary is
   removed.

I'll mention this in the commit description.

> Also I wonder if could add a test for this to the ptrace-hwbreak selftest?

Yes, I already have a selftest for this in perf-hwbreak. Will send that soon.

Thanks,
Ravi
