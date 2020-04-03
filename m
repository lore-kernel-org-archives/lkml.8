Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CD4206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7+i05uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbgDCHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:15:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52544 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbgDCHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:15:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03379pbQ110328;
        Fri, 3 Apr 2020 07:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zaEbL0ZZ07LeDe0TDIlbpai3XR14+4AMw5YEsuH0EdU=;
 b=p7+i05uQdq75mWssCJuP5556zUn5F5j45frt5RNSsqHVThw0VU0732BEyM/r4plvSuXP
 6DUtGbCXhrq4G+4WVlwmJXW9LtnyZFutyBig4zTyFcL7/UdMampLc3WrLzAjN1NU7gwx
 739USei51DW09FhtsRGacoz7pY7vM/oU+MYyjoMWMNAYNcDeHARzOKPLcgOhMqdjZR90
 HwTQmZ5iHo/WnlWSRHhE/y3mF9P8ddOZ+ZBMjMNdE7/ngVGG8XK0fdn93mN1HFZ2DzJk
 u6TBsUqri568sa3z0/b9aDueFDzN4yGPB+rXIlvu/KppBrwUg/RQ7JwXC/e0OdbEkuKL Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cevfdag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 07:15:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0337DAaa060381;
        Fri, 3 Apr 2020 07:15:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjrx9b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 07:15:19 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0337FILE005881;
        Fri, 3 Apr 2020 07:15:18 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 00:15:18 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <20200402152717.GE20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <efd2517c-3353-415a-f65c-33f6668db998@oracle.com>
Date:   Fri, 3 Apr 2020 09:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200402152717.GE20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 5:27 PM, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 10:22:17AM +0200, Alexandre Chartre wrote:
>> With retpoline, the return instruction is used to branch to an address
>> stored on the stack. So, unlike a regular return instruction, when a
>> retpoline return instruction is reached the stack has been modified
>> compared to what we have when the function was entered.
>>
>> Provide the mechanism to explicitly call-out such return instruction
>> so that objtool can correctly handle them.
> 
> https://lkml.kernel.org/r/20200331222703.GH2452@worktop.programming.kicks-ass.net
> 
> And also, the split out version:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=core/objtool&id=ec9d9549901dfd2ff411676dfc624e50219e4d5a
> 

Okay, so I can get rid of my retpoline_ret annotation and use UNWIND_HINT_RET_OFFSET
instead (which is more generic). Basically I can change my RETPOLINE_RET macro to:

.macro RETPOLINE_RET
	UNWIND_HINT_RET_OFFSET
	ret
.endm

Thanks,

alex.
