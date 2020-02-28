Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE0FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3D2246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgB1Omi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:42:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbgB1Omi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:42:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SEeniJ182198
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:42:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepwj904r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:42:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 28 Feb 2020 14:42:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 14:42:32 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01SEgV6k52625422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 14:42:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE4A2AE056;
        Fri, 28 Feb 2020 14:42:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2250EAE045;
        Fri, 28 Feb 2020 14:42:29 +0000 (GMT)
Received: from [9.199.58.51] (unknown [9.199.58.51])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 14:42:28 +0000 (GMT)
Subject: Re: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org,
        irogers@google.com, songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
 <20200206190412.GD1669706@krava> <20200227141110.GF10761@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 28 Feb 2020 20:12:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227141110.GF10761@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022814-0020-0000-0000-000003AE8044
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022814-0021-0000-0000-00002206A41B
Message-Id: <3fa6d985-1401-d767-a4bc-ce0efc420429@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_04:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=915
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/20 7:41 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 06, 2020 at 08:04:12PM +0100, Jiri Olsa escreveu:
>> On Tue, Feb 04, 2020 at 10:22:27AM +0530, Ravi Bangoria wrote:
>>> Few fixes / improvements related to perf annotate.
>>>
>>> v2: https://lore.kernel.org/r/20200124080432.8065-1-ravi.bangoria@linux.ibm.com
>>>
>>> v2->v3:
>>>   - [PATCH v3 2/6] New function annotation_line__exit() to clear
>>>     annotation_line objects.
>>
>> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Thanks applied the series to perf/urgent as it contains a fix.

Thanks Arnaldo. I don't see patch #5 and #6 in perf/urgent. You missed them?
Or didn't consider for perf/urgent :) ?

Ravi

