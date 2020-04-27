Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F0C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AF1206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgD0MXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:23:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgD0MXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:23:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RC29qp080239;
        Mon, 27 Apr 2020 08:23:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me43pm1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 08:23:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03RC5jOw095212;
        Mon, 27 Apr 2020 08:23:15 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me43pm0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 08:23:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03RCK3ib005876;
        Mon, 27 Apr 2020 12:23:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5ktvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 12:23:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03RCM2Go61210936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 12:22:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA659AE053;
        Mon, 27 Apr 2020 12:23:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6EA5AE04D;
        Mon, 27 Apr 2020 12:23:05 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.133.133])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Apr 2020 12:23:05 +0000 (GMT)
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
 <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
 <20200424150631.GN19437@kernel.org>
 <db6de799-564a-273e-99ad-40817f2b970a@linux.ibm.com>
 <20200424182336.GO19437@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <e6d751f0-910c-5611-9072-bf259b90ecd7@linux.ibm.com>
Date:   Mon, 27 Apr 2020 14:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424182336.GO19437@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_07:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 8:23 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 24, 2020 at 08:01:22PM +0200, Thomas Richter escreveu:
>> On 4/24/20 5:06 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Apr 24, 2020 at 02:37:01PM +0200, Thomas Richter escreveu:
>>>> On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
>>>>>> Running commands
>>>>>>
>>>>>>    ./perf record -e rb0000 -- find .
>>>>>>    ./perf report -v
>>>>>
>>>>> Or when pressing 'V' in the TUI.
>>>>>  
>>>>>> reveals symbol names and its addresses. There is a mismatch between
>>>>>
>>>>> Yeah, an address that at some point was put there to help with debugging
>>>>> the symbol resolution, IIRC how it looked like when looking at
>>>>>
>>>>>   readelf -sW vmlinux
>>>>>
>>>>> Or any other DSO, for instance, for a glibc symbol here:
>>>>>
>>>>> Using 'perf report -s pid,dso,sym' then pressing 'V':
>>>>>
>>>>>    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
>>>>>
>>>>> [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
>>>>>  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
>>>>> [acme@five perf]$ 
>>>>>
>>>>> Can you check if doing in /lib/modules/.../build/vmlinux produces what
>>>>> appears when 'V' is in place?
>>>>>
>>>>> And perhaps we can also show the DSO offset and the rip as it gets laid
>>>>> out in memory in the end? So we have all the informations?
>>>>>
>>>>> - Arnaldo
>>>>>
>>>>
>>>> Arnaldo,
>>>>
>>>> having verified this also works in the TUI mode using 'V', are you going to pick
>>>> this patch?
>>>
>>> That would be a change in behaviour, the original intent was to show the
>>> value one would get from the ELF symbol table, isn't that the case?
>>>
>>
>> I think there is a misunderstanding.
>>
>> Your example above refers to libc, which shows the addresses
>> correctly (on x86 and s390). I was refering to the kernel dso.
>> The issue only shows up on the kernel DSO (vmlinux and kallsyms)
>>
>> When I use the -v option (or 'V' in TUI) I get this
>>
>>   3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key
>>                                               ^^^^^^^
>> This address is not correct as compared to readelf on vmlinux file:
>>
>> [root@m35lp76 linux]# readelf -sW vmlinux| fgrep check_chain_key
>>  20698: 00000000001f0c70   486 FUNC    LOCAL  DEFAULT    1 check_chain_key
>> [root@m35lp76 linux]# 
>>
>> The problem are the mapping functions with are applied for the kernel DSO.
>> In dso__process_kernel_symbol() the mapping is adjusted (around line 903)
>> and  function hist_entry_iter_add() saves the modified address in the
>> struct hist_entry->ip. This address is used from now on and printed.
>>
>> Let me know and I will double check this and rework the commit message
>> as it was not good enough.
> 
> Yeah, this may be me not understanding something right, I saw this was a
> corner case, that only happens in debug mode (ok, better provide good
> info here...), so I haven't devoted more than cursory attention to this
> and may be making a bad judgement, so I thought that since this doesn't
> seems urgent, better leave it to when I manage to have solid time to
> devote to this or someone else looks at this.
> 
> Sorry, but these have been difficult time for everybody, and I fear, for
> me, I have to prioritise all the time.
> 
> - Arnaldo
>  

Yes, it is not easy these days.
I just wanted to make sure this patch is not lost. I already have been
asked when this will be fixed.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
