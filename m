Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C492077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgDCKfG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:35:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgDCKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:35:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033AY8xd027371
        for <linux-kernel@vger.kernel.org>; Fri, 3 Apr 2020 06:35:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304hjc8hb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:35:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 3 Apr 2020 11:34:43 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Apr 2020 11:34:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033AXubl43581948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 10:33:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 032B24C04A;
        Fri,  3 Apr 2020 10:35:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9570F4C044;
        Fri,  3 Apr 2020 10:34:59 +0000 (GMT)
Received: from localhost (unknown [9.85.72.61])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Apr 2020 10:34:59 +0000 (GMT)
Date:   Fri, 03 Apr 2020 16:04:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/6] powerpc/idle: Add accessor function to always read
 latest idle PURR
To:     ego@linux.vnet.ibm.com
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
        <1585308760-28792-3-git-send-email-ego@linux.vnet.ibm.com>
        <1585734073.0qmf6bbdoa.naveen@linux.ibm.com>
        <20200403061536.GA9066@in.ibm.com>
In-Reply-To: <20200403061536.GA9066@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040310-0020-0000-0000-000003C0CAAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040310-0021-0000-0000-000022197A4A
Message-Id: <1585909343.fw0f8jg7ug.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_07:2020-04-02,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> On Wed, Apr 01, 2020 at 03:12:53PM +0530, Naveen N. Rao wrote:
>> Hi Gautham,
>> 
>> Gautham R. Shenoy wrote:
>> >From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> >+
>> >+static inline u64 read_this_idle_purr(void)
>> >+{
>> >+	/*
>> >+	 * If we are reading from an idle context, update the
>> >+	 * idle-purr cycles corresponding to the last idle period.
>> >+	 * Since the idle context is not yet over, take a fresh
>> >+	 * snapshot of the idle-purr.
>> >+	 */
>> >+	if (unlikely(get_lppaca()->idle == 1)) {
>> >+		update_idle_purr_accounting();
>> >+		snapshot_purr_idle_entry();
>> >+	}
>> >+
>> >+	return be64_to_cpu(get_lppaca()->wait_state_cycles);
>> >+}
>> >+
>> 
>> I think this and read_this_idle_spurr() from the next patch should be moved
>> to Patch 4/6, where they are actually used.
> 
> The reason I included this function in this patch was to justify why
> we were introducing snapshotting the purr values in a global per-cpu
> variable instead of on a stack variable. The reason being that someone
> might want to read the PURR value from an interrupt context which had
> woken up the CPU from idle. At this point, since epilog() function
> wasn't called, the idle PURR count corresponding to this latest idle
> period would have been accumulated in lppaca->wait_cycles. Thus, this
> helper function safely reads the value by
>    1) First updating the lppaca->wait_cycles with the latest idle_purr
>    count.
>    2) Take a fresh snapshot, since the time from now to the epilog()
>    call is also counted under idle CPU. So the PURR cycle increment
>    during this short period should also be accumulated in lppaca->wait_cycles.
> 
> 
> prolog()
> |	snapshot PURR
> |
> |
> |
> Idle
> |
> | <----- Interrupt . Read idle PURR ---- update idle PURR;
> |                              	         snapshot PURR;
> |                                   	 Read idle PURR.       
> |
> epilog()
> 	update idle PURR
> 

Yes, I understand. It makes sense.

> 
> However, if you feel that moving this function to Patch 4 where it is
> actually used makes it more readable, I can do that.

My suggestion was from a bisectability standpoint though. This is a 
fairly simple function, but it is generally recommended to ensure that 
newly added code gets exercized in the patch that it is introduced in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst#n119


Regards,
Naveen

