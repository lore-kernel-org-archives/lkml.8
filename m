Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6929620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgGFM2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:28:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729141AbgGFM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:28:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066C1hhb040143;
        Mon, 6 Jul 2020 08:27:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 322jptmtgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 08:27:44 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 066C1iLG040297;
        Mon, 6 Jul 2020 08:27:44 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 322jptmtfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 08:27:44 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066CQXFi013527;
        Mon, 6 Jul 2020 12:27:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 322hd82ad3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:27:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 066CRcCP33292372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 12:27:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C26D04C044;
        Mon,  6 Jul 2020 12:27:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 518814C040;
        Mon,  6 Jul 2020 12:27:37 +0000 (GMT)
Received: from pomme.local (unknown [9.145.43.127])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jul 2020 12:27:37 +0000 (GMT)
Subject: Re: [PATCH v12 00/31] Speculative page faults
To:     Chinwen Chang <chinwen.chang@mediatek.com>,
        Haiyan Song <haiyanx.song@intel.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        miles.chen@mediatek.com
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190606065129.d5s3534p23twksgp@haiyan.sh.intel.com>
 <3d3cefa2-0ebb-e86d-b060-7ba67c48a59f@linux.ibm.com>
 <1c412ebe-c213-ee67-d261-c70ddcd34b79@linux.ibm.com>
 <20190620081945.hwj6ruqddefnxg6z@haiyan.sh.intel.com>
 <1594027500.30360.32.camel@mtkswgap22>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <490c0811-50cd-0802-2cbc-9c031ef309f6@linux.ibm.com>
Date:   Mon, 6 Jul 2020 14:27:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594027500.30360.32.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_09:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/07/2020 à 11:25, Chinwen Chang a écrit :
> On Thu, 2019-06-20 at 16:19 +0800, Haiyan Song wrote:
>> Hi Laurent,
>>
>> I downloaded your script and run it on Intel 2s skylake platform with spf-v12 patch
>> serials.
>>
>> Here attached the output results of this script.
>>
>> The following comparison result is statistics from the script outputs.
>>
>> a). Enable THP
>>                                              SPF_0          change       SPF_1
>> will-it-scale.page_fault2.per_thread_ops    2664190.8      -11.7%       2353637.6
>> will-it-scale.page_fault3.per_thread_ops    4480027.2      -14.7%       3819331.9
>>
>>
>> b). Disable THP
>>                                              SPF_0           change      SPF_1
>> will-it-scale.page_fault2.per_thread_ops    2653260.7       -10%        2385165.8
>> will-it-scale.page_fault3.per_thread_ops    4436330.1       -12.4%      3886734.2
>>
>>
>> Thanks,
>> Haiyan Song
>>
>>
>> On Fri, Jun 14, 2019 at 10:44:47AM +0200, Laurent Dufour wrote:
>>> Le 14/06/2019 à 10:37, Laurent Dufour a écrit :
>>>> Please find attached the script I run to get these numbers.
>>>> This would be nice if you could give it a try on your victim node and share the result.
>>>
>>> Sounds that the Intel mail fitering system doesn't like the attached shell script.
>>> Please find it there: https://gist.github.com/ldu4/a5cc1a93f293108ea387d43d5d5e7f44
>>>
>>> Thanks,
>>> Laurent.
>>>
> 
> Hi Laurent,
> 
> We merged SPF v11 and some patches from v12 into our platforms. After
> several experiments, we observed SPF has obvious improvements on the
> launch time of applications, especially for those high-TLP ones,
> 
> # launch time of applications(s):
> 
> package           version      w/ SPF      w/o SPF      improve(%)
> ------------------------------------------------------------------
> Baidu maps        10.13.3      0.887       0.98         9.49
> Taobao            8.4.0.35     1.227       1.293        5.10
> Meituan           9.12.401     1.107       1.543        28.26
> WeChat            7.0.3        2.353       2.68         12.20
> Honor of Kings    1.43.1.6     6.63        6.713        1.24

That's great news, thanks for reporting this!

> 
> By the way, we have verified our platforms with those patches and
> achieved the goal of mass production.

Another good news!
For my information, what is your targeted hardware?

Cheers,
Laurent.

