Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71124C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00B2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXMhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:37:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbgCXMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:37:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OCXodb112960
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:37:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7t8gtd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:37:32 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 24 Mar 2020 12:37:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 12:37:27 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02OCbQ9G1179942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 12:37:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7ED811C05C;
        Tue, 24 Mar 2020 12:37:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACFB311C04A;
        Tue, 24 Mar 2020 12:37:24 +0000 (GMT)
Received: from [9.199.62.35] (unknown [9.199.62.35])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 12:37:24 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf dso: Fix dso comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
Date:   Tue, 24 Mar 2020 18:07:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324104843.GS1534489@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032412-0028-0000-0000-000003EA8E73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032412-0029-0000-0000-000024AFF7F5
Message-Id: <3cf2bd1b-e1c2-f82f-a06a-ce0d5e4b5eac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 4:18 PM, Jiri Olsa wrote:
> On Tue, Mar 24, 2020 at 09:54:24AM +0530, Ravi Bangoria wrote:
>> Perf gets dso details from two different sources. 1st, from builid
>> headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
>> header does not have dso_id detail. And dso from MMAP2 samples does
>> not have buildid information. If detail of the same dso is present
>> at both the places, filename is common.
>>
>> Previously, __dsos__findnew_link_by_longname_id() used to compare only
>> long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
>> from 'struct map' to 'struct dso'") also added a dso_id comparison.
>> Because of that, now perf is creating two different dso objects of the
>> same file, one from buildid header (with dso_id but without buildid)
>> and second from MMAP2 sample (with buildid but without dso_id).
>>
>> This is causing issues with archive, buildid-list etc subcommands. Fix
>> this by comparing dso_id only when it's present. And incase dso is
>> present in 'dsos' list without dso_id, inject dso_id detail as well.
>>
>> Before:
>>
>>    $ sudo ./perf buildid-list -H
>>    0000000000000000000000000000000000000000 /usr/bin/ls
>>    0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
>>    0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
>>
>>    $ ./perf archive
>>    perf archive: no build-ids found
>>
>> After:
>>
>>    $ ./perf buildid-list -H
>>    b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
>>    641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
>>    675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
>>
>>    $ ./perf archive
>>    Now please run:
>>
>>    $ tar xvf perf.data.tar.bz2 -C ~/.debug
>>
>>    wherever you need to run 'perf report' on.
>>
>> Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> looks good, do we need to add the dso_id check to sort__dso_cmp?

I guess with different filename there is no need to compare dso_id.
But for same filename, adding dso_id cmp will separate out the
samples:

Ex, Without dso_id compare:

   $ ./perf report -s dso,dso_size -v
     66.63%  /home/ravi/a.out                                  4096
     33.36%  /home/ravi/Workspace/linux/tools/perf/a.out       4096

   $ ./perf report -s dso,dso_size
     99.99%  a.out                 4096


With below diff:

   -       return strcmp(dso_name_l, dso_name_r);
   +       ret = strcmp(dso_name_l, dso_name_r);
   +       if (ret)
   +               return ret;
   +       else
   +               return dso__cmp_id(dso_l, dso_r);


   $ ./perf report -s dso,dso_size
     99.99%  a.out                 4096
     33.36%  a.out                 4096

though, the o/p also depends which other sort keys are used along
with dso key. Do you think this change makes sense?

Ravi

