Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA5DC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9462F2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgA0Hfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:35:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgA0Hfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:35:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R7ZWij021084
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 02:35:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrk3b6s1s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 02:35:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 27 Jan 2020 07:34:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 07:34:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00R7YOaf45678828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 07:34:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D99F4C046;
        Mon, 27 Jan 2020 07:34:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A85D4C044;
        Mon, 27 Jan 2020 07:34:24 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.201])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 07:34:24 +0000 (GMT)
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
 <20200124100742.4050c15e@gandalf.local.home>
 <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
 <20200124113610.662f4afb@gandalf.local.home>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 27 Jan 2020 08:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200124113610.662f4afb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012707-0016-0000-0000-000002E0F511
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012707-0017-0000-0000-00003343AFEF
Message-Id: <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/20 5:36 PM, Steven Rostedt wrote:
> On Sat, 25 Jan 2020 01:31:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Hi Steven and Thomas,
>>
>> On Fri, 24 Jan 2020 10:07:42 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> This looks like a kernel bug, not a libtraceevent parsing bug.  
>>
>> Totally agreed. It was my fault to update the print format.
>> Even if still there is a problem on s390, this patch must be
>> applied.
> 
> Thanks Masami for looking into it.
> 
> Thomas,
> 
> Please still test this patch. If it works, I'd like to add a
> Reported-by and Tested-by tag from you.
> 
> -- Steve
> 
>>
>> Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>

Steven and Masami,

thanks for the patch, it fixes this issue!

PS: I should have sent this description earlier, would have saved a week of debugging
on my side....

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

