Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A20C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72B24672
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCBEJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:09:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbgCBEJL (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:09:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0223p2KT101014
        for <Linux-kernel@vger.kernel.org>; Sun, 1 Mar 2020 23:09:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfn15g6mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:09:09 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 2 Mar 2020 04:09:08 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 04:09:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022492oN46530942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 04:09:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04CDFAE051;
        Mon,  2 Mar 2020 04:09:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49217AE04D;
        Mon,  2 Mar 2020 04:09:00 +0000 (GMT)
Received: from [9.124.31.175] (unknown [9.124.31.175])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 04:09:00 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] perf report: Support annotation of code without
 symbols
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 2 Mar 2020 09:38:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227043939.4403-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030204-4275-0000-0000-000003A7394B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030204-4276-0000-0000-000038BC3CDF
Message-Id: <ff574b62-d8b4-79df-2752-e63eb70ad5d0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_09:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=826 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/20 10:09 AM, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
> 
> We should support the annotation functionality even without symbols.
> 
> The first patch uses al_addr to print because it's easy to dump
> the instructions from this address in binary for branch mode.
> 
> The second patch supports the annotation on stripped binary.
> 
> The third patch supports the hotkey 'a' on address for annotation.

For the series:
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Ravi

