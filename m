Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871372086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgHDJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:22:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgHDJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:22:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07491N6Q114855;
        Tue, 4 Aug 2020 05:22:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32q4m0gr2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 05:22:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0749FvE5022553;
        Tue, 4 Aug 2020 09:22:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 32n0189wcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 09:22:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0749MQeu64553452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 09:22:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28AB5AE055;
        Tue,  4 Aug 2020 09:22:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5876AE057;
        Tue,  4 Aug 2020 09:22:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Aug 2020 09:22:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
References: <20200803055645.79042-1-svens@linux.ibm.com>
        <20200803055645.79042-3-svens@linux.ibm.com>
        <87ft93ncaa.fsf@nanos.tec.linutronix.de>
        <yt9dmu3b3jo3.fsf@linux.ibm.com>
        <87a6zbn29n.fsf@nanos.tec.linutronix.de>
        <20200803184428.GA3973@osiris>
        <873653mswn.fsf@nanos.tec.linutronix.de>
Date:   Tue, 04 Aug 2020 11:22:20 +0200
In-Reply-To: <873653mswn.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 03 Aug 2020 21:27:36 +0200")
Message-ID: <yt9d5z9yhik3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxlogscore=832 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thomas Gleixner <tglx@linutronix.de> writes:
> Heiko Carstens <hca@linux.ibm.com> writes:
>
>> On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
>>> +/**
>>> + * vdso_update_begin - Start of a VDSO update section
>>> + *
>>> + * Allows architecture code to safely update the architecture specific VDSO
>>> + * data.
>>> + */
>>> +void vdso_update_begin(void)
>>> +{
>>> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>> +
>>> +	raw_spin_lock(&timekeeper_lock);
>>> +	vdso_write_begin(vdata);
>>> +}
>>
>> I would assume that this only works if vdso_update_begin() is called
>> with irqs disabled, otherwise it could deadlock, no?
>
> Yes.
>
>> Maybe something like:
>>
>> void vdso_update_begin(unsigned long *flags)
>> {
>> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>
>> 	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
>> 	vdso_write_begin(vdata);
>
> Shudder. Why not returning flags?
>
>> }
>>
>> void vdso_update_end(unsigned long *flags)
>
> Ditto, why pointer and not value?
>
>> {
>> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>
>> 	vdso_write_end(vdata);
>> 	__arch_sync_vdso_data(vdata);
>> 	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
>> }
>>
>> ? Just wondering.
>
> Thought about that briefly, but then hated the flags thing and delegated
> it to the caller. Lockdep will yell if that lock is taken with
> interrupts enabled :)
>
> But aside of the pointer vs. value thing, I'm fine with doing it in the
> functions.

Thanks Thomas & Heiko. I'll incorporate the changes into my patchset and
send an updated version. Thomas, i think it's fine if i update your
patch and we take it through the s390 tree?

Regards
Sven
