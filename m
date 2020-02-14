Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD98C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A71206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBNNyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:54:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728223AbgBNNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:54:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EDnn3Z146732
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:54:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y5vhpgm3a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:54:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 14 Feb 2020 13:54:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Feb 2020 13:54:13 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01EDsC0654984722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 13:54:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BFC452057;
        Fri, 14 Feb 2020 13:54:12 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.191])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE5A55205A;
        Fri, 14 Feb 2020 13:54:11 +0000 (GMT)
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
 <20200213143048.GA22170@kernel.org>
 <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
 <20200213181140.GA28626@kernel.org>
 <20200214094550.228422235c7785519c7f24cc@kernel.org>
 <c249efd1-f705-4739-baad-c94257706489@linux.ibm.com>
 <20200214130057.GB13462@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 14 Feb 2020 14:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214130057.GB13462@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021413-0012-0000-0000-00000386D1C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021413-0013-0000-0000-000021C3589A
Message-Id: <6d57be05-abaa-4ff5-1a07-6deb34fbb3d4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_04:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 2:00 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 14, 2020 at 10:44:06AM +0100, Thomas Richter escreveu:
>> On 2/14/20 1:45 AM, Masami Hiramatsu wrote:
>>> On Thu, 13 Feb 2020 15:11:40 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
>>>>> On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>  
>>>>>> Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
>>>>>>> This test places a kprobe to function getname_flags() in the kernel
>>>>>>> which has the following prototype:
>>>>  
>>>>>>>   struct filename *
>>>>>>>   getname_flags(const char __user *filename, int flags, int *empty)
>>>>  
>>>>>>> Variable filename points to a filename located in user space memory.
>>>>>>> Looking at
>>>>>>> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
>>>>>>> the kprobe should indicate that user space memory is accessed.
>>>>  
>>>>>>> The following patch specifies user space memory access first and if this
>>>>>>> fails use type 'string' in case 'ustring' is not supported.
>>>>  
>>>>>> What are you fixing?
>>>>  
>>>>>> I haven't seen any example of this test failing, and right now testing
>>>>>> it with:
>>>>  
>>>>>> [root@quaco ~]# uname -a
>>>>>> Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>> [root@quaco ~]#
>>>>  
>>>>> This bug doesn't happen on x86 or other archs on which user-address space and
>>>>> kernel address space is same. On some arch (ppc64 in this case?) user-address
>>>>> space is partially or completely same as kernel address space. (Yes, they switch
>>>>> the world when running into the kernel) In this case, we need to use different
>>>>> data access functions for each spaces. That is why I introduced "ustring" type
>>>>> for kprobe event.
>>>>> As far as I can see, Thomas's patch is sane.
>>>>
>>>> Well, without his patch, on x86, the test he is claiming to be fixing
>>>> works well, with his patch it stops working, see the rest of my reply.
>>>
>>> OK, let me see.
>>>
>>>
>>>> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> index 7cb99b433888..30c1eadbc5be 100644
>>>> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
>>>>  	local verbose=$1
>>>>  	if [ $had_vfs_getname -eq 1 ] ; then
>>>>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
>>>> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
>>>> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
>>>> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
>>>> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
>>>>  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>>>>  	fi
>>>>  }
>>>
>>> This looks no good (depends on architecture or debuginfo). In fs/namei.c,
>>>
>>> struct filename *
>>> getname_flags(const char __user *filename, int flags, int *empty)
>>> ...
>>>         kname = (char *)result->iname;
>>>         result->name = kname;
>>> ...
>>>         result->uptr = filename;
>>>         result->aname = NULL;
>>>         audit_getname(result);
>>>         return result;
>>> }
>>>
>>> And the line number script, egreps below line.
>>>
>>>         result->uptr = filename;
>>>
>>> However, the probe on this line will hit *before* execute this line.
>>> Note that kprobes is a breakpoint, which breaks into this line execution,
>>> not after executed.
>>>
>>> So, I thik at this point, result->uptr should be NULL, but filename and
>>> result->name already have assigned value.
>>>
>>> Thus, the fix should be something like below.
>>>
>>>> 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
>>>> - 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>>>> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
>>>
>>> Thomas, is this OK for you too, or would you have any reason to trace
>>> result->uptr?
>>>
>>> Thank you,
>>>
>>
>> Thank you very much for your help!!!
>>
>> I started from scratch and just installed linux 5.6.0rc1 without
>> any changes and got this failure:
>>
>> [root@m35lp76 perf]# ./perf test  66 67
>> 66: Use vfs_getname probe to get syscall args filenames   : FAILED!
>> 67: Check open filename arg using perf trace + vfs_getname: FAILED!
>> [root@m35lp76 perf]#
>>
>> Now I applied Masami's patch and this is the result
>>
>> [root@m35lp76 perf]# ./perf test  66 67
>> 66: Use vfs_getname probe to get syscall args filenames   : Ok
>> 67: Check open filename arg using perf trace + vfs_getname: Ok
>> [root@m35lp76 perf        
>>
>> Can we commit this patch?
>> Thanks a lot
> 
> So, I'll keep authorship to Thomas but will add a committer note stating
> Masami's correction, is that ok?
> 
> - Arnaldo
> 

Sure go ahead.


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

