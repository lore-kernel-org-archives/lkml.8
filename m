Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0B246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LtptX7y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1XEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:04:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59360 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1XEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:04:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SMwwcP138672;
        Fri, 28 Feb 2020 23:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wQ8OzIWwwn6nu22GCTjS/+psNI0MuWzB3fXupSR6NDk=;
 b=LtptX7y5zaeQytiIC/O1hDaFVyUeHCDNCKNYr4lcYZOUQa/c2B3MiFtrSV92su68CN43
 kQP/uvSMqZR6nlqnn43gEzTuIezZaS+8+4o+lQ3lplbi/PIZfE6yK1xT3/VKlbwq8Coa
 xK7dg2eMY44OxFVacwf4UtE30EfrMk67zJt0IzkvCX5rVITQmdLjWhTXMZHsmStjjCXd
 eI7jQdmKx7kqzZrgVkk0FVpjYK8fK5HWiglkDrKz5WmowS5GtrgyOLHfudqPWDpUm+JR
 wI0EvG0n5U0AM3fkNAbuLKHdhiZ6BkLqUx0tkWW16qNxwUn0k4djF6x0FSo6cFUpP1ir TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct3nqje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 23:04:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SMwChc153779;
        Fri, 28 Feb 2020 23:04:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ydj4s1ax3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 23:04:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SN4RIg028167;
        Fri, 28 Feb 2020 23:04:28 GMT
Received: from [10.11.26.183] (/10.11.26.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 15:04:26 -0800
Subject: Re: [PATCH] genirq/debugfs: add new config option for trigger
 interrupt from userspace
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com>
 <006a08b8bfb991853ede8c9d1e29d6a7@kernel.org>
 <a4b3b41b-b0b9-03cd-c394-05d8f0bfc5f4@oracle.com>
 <bd3f06814b4319ddaaee2bf142aaf465@kernel.org>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <84d0b879-cd4b-57c4-5ad3-57eab7694d45@oracle.com>
Date:   Fri, 28 Feb 2020 15:04:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bd3f06814b4319ddaaee2bf142aaf465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=863 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=913 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 11:54 AM, Marc Zyngier wrote:
> On 2020-02-28 19:13, Joe Jin wrote:
>> Hi Marc,
>>
>> Thanks for your reply.
>>
>> On 2/28/20 8:37 AM, Marc Zyngier wrote:
>>> On 2020-02-28 05:42, Joe Jin wrote:
>>>> commit 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from
>>>> userspace") is allowed developer inject interrupts via irq debugfs, which
>>>> is very useful during development phase, but on a production system, this
>>>> is very dangerous, add new config option, developers can enable it as
>>>> needed instead of enabling it by default when irq debugfs is enabled.
>>>
>>> I don't really mind the patch (although it could be more elegant), but in
>>> general I object to most debugfs options being set on a production kernel.
>>> There is way too much information in most debugfs backends to be comfortable
>>> with it, and you can find things like page table dumps, for example...
>>
>> We should not enable any debug option on production system, actual customer
>> want to resize their BM or VM, cpu offline may lead system not works properly,
>> and if we knew more details of IRQ info it will be very help to identify
>> if it caused by IRQ/vectors, this is the motivation of we want to enable it
>> on production kernel.
> 
> If something doesn't work properly, then you are still debugging, AFAICT.

Yes you're right, there are various reasons to led the problem such like
bad mapping, interrupts lost, vectors used up .... irq debugfs is help to
identify which part caused the problem, and it help to save troubleshooting
time :-)

Thanks,
Joe
