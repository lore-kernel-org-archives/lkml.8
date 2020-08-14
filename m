Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF32074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dp2O7B1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHNVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:34:28 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:6538 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgHNVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:34:28 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ELMYqP017847;
        Fri, 14 Aug 2020 22:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=apBYV70I3ke9U2rudRI7Z/BYmo6lMSbGaBtjTjz53fw=;
 b=dp2O7B1a0uXd4qYEnXQeUKNyjYkpHntHffBOjY9Me9BlnGC7KwoDN4WaMQHwAilcSAmZ
 PrARh4QpSfBOnEXJLY6eA+3uLVHSzT+BIqut1FuWCKQQP3j01j9sUUoR4boMMoJvfJIy
 g16YMxP9xSQHpOOehDWpcfk03s2d380+weXJmZXNOCuszW2JmojaIH5j8nFeRbxYU9KR
 44/NQpDh+b8xd0QMlnLyN7M65TDtYY/vVO+W1ZyO3jO26Zo4tpVJqACBC2vr0n2Rbl6f
 bdJON0DEHLMA1I2Pcn/h5Ax2kGzdrQ7VUe3JpfKrPYBjhToYM3T7+EfnndBZ5yrWmOaa hA== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 32sm5j032h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Aug 2020 22:30:36 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 07EL2Bga020888;
        Fri, 14 Aug 2020 17:30:35 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 32sqcyct4b-1;
        Fri, 14 Aug 2020 17:30:34 -0400
Received: from [0.0.0.0] (stag-ssh-gw01.bos01.corp.akamai.com [172.27.113.23])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id B054F3BA27;
        Fri, 14 Aug 2020 21:30:34 +0000 (GMT)
Subject: Re: [PATCH v2] dynamic debug: allow printing to trace event
To:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     mingo@redhat.com, kernel@axis.com, corbet@lwn.net,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
References: <20200814133151.7759-1-vincent.whitchurch@axis.com>
 <20200814131531.01b43c91@oasis.local.home>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <461439ab-0720-e3cc-f49f-f294fbba4129@akamai.com>
Date:   Fri, 14 Aug 2020 17:30:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814131531.01b43c91@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_13:2020-08-14,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=699
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_16:2020-08-14,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=617 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/20 1:15 PM, Steven Rostedt wrote:
> On Fri, 14 Aug 2020 15:31:51 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
>> index aa9ff9e1c0b3..f599ed21ecc5 100644
>> --- a/include/linux/dynamic_debug.h
>> +++ b/include/linux/dynamic_debug.h
>> @@ -27,13 +27,16 @@ struct _ddebug {
>>  	 * writes commands to <debugfs>/dynamic_debug/control
>>  	 */
>>  #define _DPRINTK_FLAGS_NONE	0
>> -#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
>> +#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
> 
> The above looks like a cleanup unrelated to this patch, and probably
> should be on its own.

I read it as we used to have this one thing called 'print', which really meant
printk, but now that we also have the ability to output to the trace buffer,
what does 'print' mean now? So I read it as being part of this change.

> 
>>  #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
>>  #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
>>  #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
>>  #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
>> +#define _DPRINTK_FLAGS_TRACE		(1<<5)	
>> +#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
>> +					 _DPRINTK_FLAGS_TRACE)


Is _DPRINTK_FLAGS_PRINT actually used anywhere? Looks to me like
it can be removed.

This is a feature I've wanted for dynamic debug for a while. Thanks for
implementing it!

Dynamic can be enabled on the command line in order to print things early
in boot (I think ftrace can as well), I want to make sure that there are
no ordering issues here? And things wouldn't blow up if we enable printing
to the ftrace buffer early on via dyanmic debug?

Thanks,

-Jason
