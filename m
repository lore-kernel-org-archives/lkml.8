Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5070C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgF3IEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:04:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730654AbgF3IDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:03:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U83KU5114915;
        Tue, 30 Jun 2020 04:03:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjxuwuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 04:03:36 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U83Yw6116319;
        Tue, 30 Jun 2020 04:03:34 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjxuwu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 04:03:34 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U80rEh028416;
        Tue, 30 Jun 2020 08:03:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 31wwr8pbmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 08:03:32 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U83Wk153018930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 08:03:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F5D9AE05F;
        Tue, 30 Jun 2020 08:03:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9291BAE05C;
        Tue, 30 Jun 2020 08:03:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 08:03:31 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 30 Jun 2020 10:03:31 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 16/20] misc: genwqe: card_base: Remove set but unused
 variable 'rc'
In-Reply-To: <20200630074224.GH1179328@dell>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-17-lee.jones@linaro.org>
 <fff00e6667c442cac13147ee5095430a@linux.vnet.ibm.com>
 <20200630074224.GH1179328@dell>
Message-ID: <770e66e5f2d7efcea61fc9d57e1053f0@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_02:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 cotscore=-2147483648 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 09:42, Lee Jones wrote:
> On Tue, 30 Jun 2020, haver wrote:
> 
>> On 2020-06-29 16:04, Lee Jones wrote:
>> > Variable 'rc' hasn't been checked since the driver's inception
>> > in 2013.  If it hasn't caused any issues since then, it's unlikely
>> > to in the future.  Let's take it out for now.
>> >
>> > Fixes the following W=1 kernel build warning(s):
>> >
>> >  drivers/misc/genwqe/card_base.c: In function
>> > ‘genwqe_health_check_stop’:
>> >
>> > /home/lee/projects/linux/kernel/drivers/misc/genwqe/card_base.c:1046:6:
>> > warning: variable ‘rc’ set but not used
>> > [-Wunused-but-set-variable]
>> >  1046 | int rc;
>> >  | ^~
>> >
>> > Cc: Michael Jung <mijung@gmx.net>
>> > Cc: Michael Ruettger <michael@ibmra.de>
>> > Cc: Frank Haverkamp <haver@linux.ibm.com>
>> > Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >  drivers/misc/genwqe/card_base.c | 4 +---
>> >  1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/misc/genwqe/card_base.c
>> > b/drivers/misc/genwqe/card_base.c
>> > index 1dc6c7c5cbce9..bceebf49de2d5 100644
>> > --- a/drivers/misc/genwqe/card_base.c
>> > +++ b/drivers/misc/genwqe/card_base.c
>> > @@ -1043,12 +1043,10 @@ static int genwqe_health_thread_running(struct
>> > genwqe_dev *cd)
>> >
>> >  static int genwqe_health_check_stop(struct genwqe_dev *cd)
>> >  {
>> > -	int rc;
>> > -
>> >  	if (!genwqe_health_thread_running(cd))
>> >  		return -EIO;
>> >
>> > -	rc = kthread_stop(cd->health_thread);
>> > +	kthread_stop(cd->health_thread);
>> >  	cd->health_thread = NULL;
>> >  	return 0;
>> >  }
>> 
>> Good idea. Let's remove it Thanks for the contribution.
> 
> No problem, and you are welcome.
> 
>> Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
> 
> Just as an aside, this should be Acked-by, unless you either
> contributed to the patch directly or are in the delivery path i.e. you
> plan to pick the patch and send it to, say Linus, via a pull-request.

Right. Thanks for reminding me. Feel free to send it yourself.
When was the documentation checking introduced? At the time we
contributed the code there was no such checking.

Acked-by: Frank Haverkamp <haver@linux.ibm.com>
