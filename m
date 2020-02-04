Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68A4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8427F2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBDJNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:13:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgBDJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:13:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014998r3003228
        for <linux-kernel@vger.kernel.org>; Tue, 4 Feb 2020 04:13:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xxhfbav0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 04:13:07 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Tue, 4 Feb 2020 09:13:05 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 09:13:03 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0149D1PE60817408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 09:13:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A380642045;
        Tue,  4 Feb 2020 09:13:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46BCA4204F;
        Tue,  4 Feb 2020 09:12:58 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.44.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Feb 2020 09:12:57 +0000 (GMT)
Subject: Re: [PATCH 0/3] pseries: Track and expose idle PURR and SPURR ticks
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
 <87r21ju3ud.fsf@linux.ibm.com>
 <48823589-b105-0da3-e532-f633ade8f0d9@linux.vnet.ibm.com>
 <87k17au4rw.fsf@linux.ibm.com> <1575566328.nhfi897fmd.naveen@linux.ibm.com>
 <1575623305.dgcux6u43j.naveen@linux.ibm.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Tue, 4 Feb 2020 14:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1575623305.dgcux6u43j.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020409-0028-0000-0000-000003D73B93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020409-0029-0000-0000-0000249B95DE
Message-Id: <4d163dc0-fe2f-3682-4085-dc91bda57a20@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_02:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/19 2:44 PM, Naveen N. Rao wrote:
> Naveen N. Rao wrote:
>> Hi Nathan,
>>
>> Nathan Lynch wrote:
>>> Hi Kamalesh,
>>>
>>> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
>>>> On 12/5/19 3:54 AM, Nathan Lynch wrote:
>>>>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>>>>>>
>>>>>> Tools such as lparstat which are used to compute the utilization need
>>>>>> to know [S]PURR ticks when the cpu was busy or idle. The [S]PURR
>>>>>> counters are already exposed through sysfs.  We already account for
>>>>>> PURR ticks when we go to idle so that we can update the VPA area. This
>>>>>> patchset extends support to account for SPURR ticks when idle, and
>>>>>> expose both via per-cpu sysfs files.
>>>>>
>>>>> Does anything really want to use PURR instead of SPURR? Seems like we
>>>>> should expose only SPURR idle values if possible.
>>>>>
>>>>
>>>> lparstat is one of the consumers of PURR idle metric
>>>> (https://groups.google.com/forum/#!topic/powerpc-utils-devel/fYRo69xO9r4). Agree, on the argument that system utilization metrics based on SPURR
>>>> accounting is accurate in comparison to PURR, which isn't proportional to
>>>> CPU frequency.  PURR has been traditionally used to understand the system
>>>> utilization, whereas SPURR is used for understanding how much capacity is
>>>> left/exceeding in the system based on the current power saving mode.
>>>
>>> I'll phrase my question differently: does SPURR complement or supercede
>>> PURR? You seem to be saying they serve different purposes. If PURR is
>>> actually useful rather then vestigial then I have no objection to
>>> exposing idle_purr.
>>
>> SPURR complements PURR, so we need both. SPURR/PURR ratio helps provide an indication of the available headroom in terms of core resources, at maximum frequency.
> 
> Re-reading this today morning, I realize that this isn't entirely accurate. SPURR alone is sufficient to understand core resource utilization.
> 
> Kamalesh is using PURR to display non-normalized utilization values (under 'actual' column), as reported by lparstat on AIX. I am not entirely sure if it is ok to derive these based on the SPURR busy/idle ratio.

Both idle_purr and idle_spurr complement each other and we need to expose both of them.
It will improve the accounting accuracy of tools currently consuming system-wide PURR
and/or SPURR numbers to report system usage.  Deriving one from another, from my
experience makes it hard for tools or any custom scripts to give an accurate system view.
One tool I am aware of is lparstat, which uses PURR based metrics.

-- 
Kamalesh

