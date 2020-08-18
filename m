Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EBC2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2TvXiR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHRIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:55:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I8dTEU146527;
        Tue, 18 Aug 2020 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=ypMmPEUlq3Yxhzd7jzu+s7Sa9xrgm3qmWGDGHZc3Rh8=;
 b=h2TvXiR43obexQKfP6a5I4bygDNU2o/mt/RKDe/cQzuboa35uvre8Df41Iiy5TsicMtW
 i32TK3BdsdZfe0VzB/t89TeFS7qDOsSNmUrXLQHRo3/xSZDc43k1plhSZmcnplmVtE35
 qzzlm2kxbNY3C+emIQ03MbkGH0ZtNK/9lqPNvS1FsEutZTNhVdyF3nnzTmXVLFI+1SSD
 AxTk8vKgARZB7ys3T49TedWTDq/cfT2N29RDXbFqeCNZELu+ZxPbj3rutHbObyxEwduP
 cjdjOroPCRwhhrsLHkKcdGUA3mjH/IsFA+FNQkuGSd5TqS0/ZaIoTR8t28O9Zp+8tg82 rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304sc2ctm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 04:55:52 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I8qBFl019374;
        Tue, 18 Aug 2020 08:55:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3304bt0e7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 08:55:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I8sJrR52494772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 08:54:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D4C4A405F;
        Tue, 18 Aug 2020 08:55:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC28A4062;
        Tue, 18 Aug 2020 08:55:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 08:55:47 +0000 (GMT)
Subject: Re: [PATCH 2/2] tasks: Add task_struct addr for lx-ps cmd
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597721575.git.riteshh@linux.ibm.com>
 <99e6236ed1b67140dae967dbf802c0eabd7b0eba.1597721575.git.riteshh@linux.ibm.com>
 <1566dd81-a906-068d-ccc9-ed9cde8571d7@siemens.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 18 Aug 2020 14:25:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1566dd81-a906-068d-ccc9-ed9cde8571d7@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200818085547.ADC28A4062@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_06:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 11:10 AM, Jan Kiszka wrote:
> On 18.08.20 06:04, Ritesh Harjani wrote:
>> task_struct addr in lx-ps cmd seems helpful
>>
>> <e.g. o/p>
>>        TASK          PID    COMM
>> 0xffffffff82c2b8c0   0   swapper/0
>> 0xffff888a0ba20040   1   systemd
>> 0xffff888a0ba24040   2   kthreadd
>> 0xffff888a0ba28040   3   rcu_gp
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   scripts/gdb/linux/tasks.py | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
>> index 0301dc1e0138..17ec19e9b5bf 100644
>> --- a/scripts/gdb/linux/tasks.py
>> +++ b/scripts/gdb/linux/tasks.py
>> @@ -73,11 +73,12 @@ class LxPs(gdb.Command):
>>           super(LxPs, self).__init__("lx-ps", gdb.COMMAND_DATA)
>>   
>>       def invoke(self, arg, from_tty):
>> +        gdb.write("{:>10} {:>12} {:>7}\n".format("TASK", "PID", "COMM"))
>>           for task in task_lists():
>> -            gdb.write("{address} {pid} {comm}\n".format(
>> -                address=task,
>> -                pid=task["pid"],
>> -                comm=task["comm"].string()))
>> +            gdb.write("{} {:^5} {}\n".format(
>> +                task.format_string().split()[0],
>> +                task["pid"].format_string(),
>> +                task["comm"].string()))
>>   
>>   
>>   LxPs()
>>
> 
> This patch is confusing me. We already dump the task address. What the
> patch changes is adding a header and some conversions of the values. Can
> you elaborate?

You are right. Sorry for the confusion. I will update the commit msg (in
v2) to reflect that this patch adds the header and formats the spacing.
Without the patch we get it like this:-

0xffffffff82c2b8c0 <init_task> 0 swapper/0
0xffff888a0ba20040 1 systemd
0xffff888a0ba24040 2 kthreadd
0xffff888a0ba28040 3 rcu_gp

-ritesh
