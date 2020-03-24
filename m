Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4EAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C49B20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCXNmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:42:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgCXNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:42:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ODXvBx024135
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:42:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7dc1a4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:42:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 24 Mar 2020 13:42:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 13:42:37 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ODgboH47120636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:42:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89724AE051;
        Tue, 24 Mar 2020 13:42:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8346AE056;
        Tue, 24 Mar 2020 13:42:35 +0000 (GMT)
Received: from [9.199.48.100] (unknown [9.199.48.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 13:42:35 +0000 (GMT)
Subject: Re: [PATCH] perf dso: Fix dso comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
 <3cf2bd1b-e1c2-f82f-a06a-ce0d5e4b5eac@linux.ibm.com>
 <20200324132258.GX1534489@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 24 Mar 2020 19:12:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324132258.GX1534489@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032413-0012-0000-0000-00000396DBA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032413-0013-0000-0000-000021D3CFC8
Message-Id: <04413346-1dc6-3f24-7f3d-3783b800780c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 6:52 PM, Jiri Olsa wrote:
> On Tue, Mar 24, 2020 at 06:07:23PM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
>>> looks good, do we need to add the dso_id check to sort__dso_cmp?
>>
>> I guess with different filename there is no need to compare dso_id.
>> But for same filename, adding dso_id cmp will separate out the
>> samples:
>>
>> Ex, Without dso_id compare:
>>
>>    $ ./perf report -s dso,dso_size -v
>>      66.63%  /home/ravi/a.out                                  4096
>>      33.36%  /home/ravi/Workspace/linux/tools/perf/a.out       4096
>>
>>    $ ./perf report -s dso,dso_size
>>      99.99%  a.out                 4096
>>
>>
>> With below diff:
>>
>>    -       return strcmp(dso_name_l, dso_name_r);
>>    +       ret = strcmp(dso_name_l, dso_name_r);
>>    +       if (ret)
>>    +               return ret;
>>    +       else
>>    +               return dso__cmp_id(dso_l, dso_r);
>>
>>
>>    $ ./perf report -s dso,dso_size
>>      99.99%  a.out                 4096
>>      33.36%  a.out                 4096
>>
>> though, the o/p also depends which other sort keys are used along
>> with dso key. Do you think this change makes sense?
> 
> the above behaviour is something I'd expect from 'dso'
> sort key to do - separate out different dsos, even with
> the same name

Yes it does that as well...

   $ ./perf report -s dso
     66.63%  a.out
     33.36%  a.out

Ravi

