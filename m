Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7615FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89A2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCLLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:48:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgCLLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:48:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CBiYWo140092
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:48:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqkw31vub-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:48:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 12 Mar 2020 11:48:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Mar 2020 11:48:33 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CBmWg229950146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 11:48:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3E584C062;
        Thu, 12 Mar 2020 11:48:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C16104C052;
        Thu, 12 Mar 2020 11:48:31 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 11:48:31 +0000 (GMT)
Subject: Re: [PATCH] perf documentation: Add desription forHEADER_TRACING_DATA
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20200303070846.18335-1-tmricht@linux.ibm.com>
 <20200311135815.GD19277@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Thu, 12 Mar 2020 12:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311135815.GD19277@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031211-0008-0000-0000-0000035C0F06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031211-0009-0000-0000-00004A7D5896
Message-Id: <747c8b92-a342-3e0c-4232-19df02250496@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_03:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 2:58 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 03, 2020 at 08:08:46AM +0100, Thomas Richter escreveu:
>> Add description and layout in the perf.data file for
>> the header part describing trace data used in commands
>> perf record -e XXX
>> where XXX is a probe or tracepoint.
> 
> Did you write this from scratch?  I was going thru it and couldn't find
> what that "Note member 'ftrace_count' can be zero." refers to, couldn't
> find this ftrace_counter, is this outdated?
> 
> [root@five ~]# find /sys/kernel/debug/tracing/events/ -type f | xargs grep ftrace_count
> [root@five ~]# find /sys/kernel/debug/tracing/events/ -name ftrace_count
> [root@five ~]# uname -a
> Linux five 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@five ~]#
> 
> The part about using a probe and then go on dissecting it is really
> nice, I'll try reproducing it soon,
> 
> Thanks,
> 

Arnaldo,
        
yes, I wrote this from scratch. I decided to invest some time into the
documentation after I have spent nearly 3 week in debugging why commands

  perf record -e probe:vfs_getname

followed by

  perf report 
  
did not print the file name on s390. Remember we talked about failing
test case 65: Check open filename arg using perf trace + vfs_getname.
(Steven Rostedt and Masami Hiramatsu helped me on this).

On ftrace_count: This is not a file available in /sys/kernel/debug/tracing.
It is a value saved in function

tracing_data_get
  record_ftrace_files
     copy_event_system --> Check for some format file in directories
                           /sys/kernel/debug/tracing/events/ftrace/*/
Depending on what probe was defined, there is no hit and zero is written
to the output.

Hope this helps.
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

