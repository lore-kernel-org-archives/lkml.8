Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04522063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgDMQHr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:07:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731231AbgDMQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:07:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DG2web011621;
        Mon, 13 Apr 2020 12:05:09 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b87dbchg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 12:05:08 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03DFuTns017940;
        Mon, 13 Apr 2020 16:05:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 30b5h6dv2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 16:05:07 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03DG56AR49676558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:05:06 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 183EEC6055;
        Mon, 13 Apr 2020 16:05:06 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF704C6057;
        Mon, 13 Apr 2020 16:05:05 +0000 (GMT)
Received: from localhost (unknown [9.85.131.151])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Apr 2020 16:05:05 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vdsotest] Use vdso wrapper for gettimeofday()
In-Reply-To: <1c2c6da1-e10f-d2a8-fc5e-ecf405879df5@c-s.fr>
References: <0eddeeb64c97b8b5ce0abd74e88d2cc0303e49c6.1579090596.git.christophe.leroy@c-s.fr> <871rrzjq5j.fsf@linux.ibm.com> <1c2c6da1-e10f-d2a8-fc5e-ecf405879df5@c-s.fr>
Date:   Mon, 13 Apr 2020 11:05:04 -0500
Message-ID: <87d08b8j7z.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_07:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=1 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Hi Nathan,
>
> Le 16/01/2020 à 17:56, Nathan Lynch a écrit :
>> Hi Christophe,
>> 
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> To properly handle errors returned by gettimeofday(), the
>>> DO_VDSO_CALL() macro has to be used, otherwise vdsotest
>>> misinterpret VDSO function return on error.
>>>
>>> This has gone unnoticed until now because the powerpc VDSO
>>> gettimeofday() always succeed, but while porting powerpc to
>>> generic C VDSO, the following has been encountered:
>> 
>> Thanks for this, I'll review it soon.
>> 
>> Can you point me to patches for the powerpc generic vdso work?
>> 
>
> I have not seen any update on the vdsotest repository, have you been 
> able to have a look at the patch ?

Thanks for the reminder. I've applied this now.
