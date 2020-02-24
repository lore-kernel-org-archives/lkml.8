Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC4C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B7A20726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBXN0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:26:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbgBXN0L (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:26:11 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ODPql4060860
        for <Linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:26:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu12vtgj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:26:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 24 Feb 2020 13:25:26 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 13:25:23 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ODPMPc36635096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 13:25:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A72E4C046;
        Mon, 24 Feb 2020 13:25:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F1CE4C04E;
        Mon, 24 Feb 2020 13:25:15 +0000 (GMT)
Received: from [9.199.54.250] (unknown [9.199.54.250])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 13:25:14 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
To:     Jin Yao <yao.jin@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 24 Feb 2020 18:55:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224022225.30264-3-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022413-0020-0000-0000-000003AD1BE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022413-0021-0000-0000-000022052D60
Message-Id: <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_04:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=993 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jin,

On 2/24/20 7:52 AM, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
> 
> We should support the annotation functionality even without symbols.
> 
> This patch fakes a symbol and the symbol name is the string of address.
> After that, we just follow current annotation working flow.
> 
> For example,
> 
> 1. perf report
> 
> Overhead  Command  Shared Object     Symbol
>    20.67%  div      libc-2.27.so      [.] __random_r
>    17.29%  div      libc-2.27.so      [.] __random
>    10.59%  div      div               [.] 0x0000000000000628
>     9.25%  div      div               [.] 0x0000000000000612
>     6.11%  div      div               [.] 0x0000000000000645
> 
> 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
> 
> Annotate 0x0000000000000628
> Zoom into div thread
> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
> Browse map details
> Run scripts for samples of symbol [0x0000000000000628]
> Run scripts for all samples
> Switch to another data file in PWD
> Exit
> 
> 3. Select the "Annotate 0x0000000000000628" and ENTER.
> 
> Percent│
>         │
>         │
>         │     Disassembly of section .text:
>         │
>         │     0000000000000628 <.text+0x68>:
>         │       divsd %xmm4,%xmm0
>         │       divsd %xmm3,%xmm1
>         │       movsd (%rsp),%xmm2
>         │       addsd %xmm1,%xmm0
>         │       addsd %xmm2,%xmm0
>         │       movsd %xmm0,(%rsp)
> 
> Now we can see the dump of object starting from 0x628.

If I press 'a' on address, it's not annotating. But if I annotate
by pressing enter, like you explained, it works. Is it intentional?

Ravi

