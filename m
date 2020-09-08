Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79099C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A10F205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PxQ3DtuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgIHQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:20:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730607AbgIHQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088DVXE9184251;
        Tue, 8 Sep 2020 09:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=b3/S8z+XcaaneUPd0EkP9D6v+v/IBiNDUrZwO6+VVqU=;
 b=PxQ3DtuIBtdFPySbUQO+rKJRdIUg9KQ8b2RVHhIxmeJ3XpQYz57ze6WAW7AHBAD2EqMU
 ho5QC+zU9Q6L54085XtrhluZ6ynYToJU0MIf9HoQ9t9OlVx3ZnJ+3LIdd9dytpAplxnc
 4zfD+xMMhALdVm0RE0z78h25N7F8JGBLBtjgaaeBDN0cXkdwJKU/r8Zx/+W1ZlnRDwal
 EvAZPmsmCfEKf9QOt6zOlkXdduHB6AUiL8JaN0iBHdO5zDxxO+DQqkN/Uj9qrliDY8G7
 THM84qhlk79sI4/1wqYkLV+wigcbB5XEIiH/IECfucDCbA0A0f3yyLenDhYOo2jSzxgp zQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33eat2gk3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 09:41:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088DcMhS019719;
        Tue, 8 Sep 2020 13:41:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8bgev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:41:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088Dfkjf36897102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 13:41:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D4CC4C059;
        Tue,  8 Sep 2020 13:41:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07984C040;
        Tue,  8 Sep 2020 13:41:45 +0000 (GMT)
Received: from osiris (unknown [9.171.47.162])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Sep 2020 13:41:45 +0000 (GMT)
Date:   Tue, 8 Sep 2020 15:41:44 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        rafael.j.wysocki@intel.com, svens@linux.ibm.com
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20200908134144.GH14136@osiris>
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_06:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=863 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=3 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:30:31PM +0200, peterz@infradead.org wrote:
> 
> After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> bunch more RCU violations that were previously hidden.
> 
> Switch the idle->seqcount over to using raw_write_*() to avoid the
> lockdep annotation and thus the lock tracepoints.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/kernel/idle.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thank you!
