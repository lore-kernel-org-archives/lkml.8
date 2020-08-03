Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239ED20775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHCOKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:10:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727039AbgHCOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:10:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073E3R5p110915;
        Mon, 3 Aug 2020 10:09:53 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pktugjfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 10:09:53 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073E5lg0010478;
        Mon, 3 Aug 2020 14:09:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32n017sbyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 14:09:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073E9nkF15860212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 14:09:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E0C7A4051;
        Mon,  3 Aug 2020 14:09:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1797CA4055;
        Mon,  3 Aug 2020 14:09:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Aug 2020 14:09:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
References: <20200803055645.79042-1-svens@linux.ibm.com>
        <20200803055645.79042-3-svens@linux.ibm.com>
        <87ft93ncaa.fsf@nanos.tec.linutronix.de>
Date:   Mon, 03 Aug 2020 16:09:48 +0200
In-Reply-To: <87ft93ncaa.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 03 Aug 2020 14:29:01 +0200")
Message-ID: <yt9dmu3b3jo3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_13:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008030106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Sven Schnelle <svens@linux.ibm.com> writes:
>
>> - CPUCLOCK_VIRT is now handled with a syscall fallback, which might
>>   be slower/less accurate than the old implementation.
>
> I can understand the slower, but why does it become less accurate?

Because we saved the system/user times as almost the last instruction
when leaving the kernel to userspace. Now it's a bit earlier, because
it is done in the C code. So it's not really related to the syscall
fallback, but the switch from assembly to C.

>> Performance number from my system do 100 mio gettimeofday() calls:
>>
>> Plain syscall: 8.6s
>> Generic VDSO:  1.3s
>> old ASM VDSO:  1s
>>
>> So it's a bit slower but still much faster than syscalls.
>
> Where is the overhead coming from?

It's because we have to allocate a stackframe which we didn't do before,
and the compiler generated code is less optimized than the hand-crafted
assembly code we had before.

>> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
>> +{
>> +	const struct vdso_data *vdso = __arch_get_vdso_data();
>> +	u64 adj, now;
>> +	int cnt;
>> +
>> +	do {
>> +		do {
>> +			cnt = READ_ONCE(vdso->arch.tb_update_cnt);
>> +		} while (cnt & 1);
>
>                 smp_rmb() ?

>> +		now = get_tod_clock();
>> +		adj = vdso->arch.tod_steering_end - now;
>> +		if (unlikely((s64) adj > 0))
>> +			now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
>
>                 smp_rmb() ?
>
>> +	} while (cnt != READ_ONCE(vdso->arch.tb_update_cnt));
>> +	return now;
>>  	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
>>  		lpar_offset = qto.tod_epoch_difference;
>> @@ -599,6 +550,13 @@ static int stp_sync_clock(void *data)
>>  		if (stp_info.todoff[0] || stp_info.todoff[1] ||
>>  		    stp_info.todoff[2] || stp_info.todoff[3] ||
>>  		    stp_info.tmd != 2) {
>> +			vdso_data->arch.tb_update_cnt++;
>> +			/*
>> +			 * This barrier isn't really needed as we're called
>> +			 * from stop_machine_cpuslocked(). However it doesn't
>> +			 * hurt in case the code gets changed.
>> +			 */
>> +			smp_wmb();
>
> WMB without a corresponding RMB and an explanation what's ordered
> against what is voodoo at best.
>
>>  			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>>  					&clock_delta);
>>  			if (rc == 0) {
>> @@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
>>  				if (rc == 0 && stp_info.tmd != 2)
>>  					rc = -EAGAIN;
>>  			}
>> +			smp_wmb(); /* see comment above */
>
> See my comments above :)

:-)

What do you think about my question on using vdso_write_begin/end()?
__arch_get_hw_counter() is called inside a vdso_read_retry() loop, so i
would think that just enclosing this update with vdso_write_begin/end()
should sufficient. But i'm not sure whether arch/ should call these
functions.

Thanks
Sven
