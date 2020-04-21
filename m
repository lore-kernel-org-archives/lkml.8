Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F4C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49A6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgDULSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:18:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbgDULST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:18:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LB3Cvr146768
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:18:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2x1f8b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:18:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 21 Apr 2020 12:17:42 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 12:17:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LBH47849021294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 11:17:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8A7CA4040;
        Tue, 21 Apr 2020 11:18:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66423A4051;
        Tue, 21 Apr 2020 11:18:07 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.160.1])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 11:18:06 +0000 (GMT)
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Tue, 21 Apr 2020 13:18:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420204617.GA23638@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042111-0008-0000-0000-00000374B20B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042111-0009-0000-0000-00004A967774
Message-Id: <6239b798-3bf5-c1a6-8acf-d4e293089145@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_04:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
>> Running commands
>>
>>    ./perf record -e rb0000 -- find .
>>    ./perf report -v
> 
> Or when pressing 'V' in the TUI.
>  
>> reveals symbol names and its addresses. There is a mismatch between
> 
> Yeah, an address that at some point was put there to help with debugging
> the symbol resolution, IIRC how it looked like when looking at
> 
>   readelf -sW vmlinux
> 
> Or any other DSO, for instance, for a glibc symbol here:
> 
> Using 'perf report -s pid,dso,sym' then pressing 'V':
> 
>    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
> 
> [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
>  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
> [acme@five perf]$ 
> 
> Can you check if doing in /lib/modules/.../build/vmlinux produces what
> appears when 'V' is in place?
> 

Yes, I used latest 5.7.0rc2 and did
./perf record -e rb0000 -- find 
./perf report -s pid,dso,sym 
and pressed 'V' in the TUI.

This gives 
     6.06%     9986:find     /lib/modules/5.7  0x1f0c86           v [k] check_chain_key 
and 
[root@m35lp76 ~]# readelf -sW /lib/modules/5.7.0-rc2d-perf+/build/vmlinux | fgrep  check_chain_key
 20698: 00000000001f0c70   486 FUNC    LOCAL  DEFAULT    1 check_chain_key
[root@m35lp76 ~]# 

which is perfectly good and in the range. 

> And perhaps we can also show the DSO offset and the rip as it gets laid
> out in memory in the end? So we have all the informations?
> 
> - Arnaldo
> 

I do not follow you here, do you mean something like DSO-name+offset
for example libc-2.30.so+0x123?

Thanks

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

