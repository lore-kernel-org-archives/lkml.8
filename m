Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5521C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EE206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDGGXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:23:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgDGGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:23:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03762uRI031910
        for <linux-kernel@vger.kernel.org>; Tue, 7 Apr 2020 02:23:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082nwcphw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:23:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Tue, 7 Apr 2020 07:22:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Apr 2020 07:22:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0376N9A048824412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 06:23:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F0E211C050;
        Tue,  7 Apr 2020 06:23:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA21011C04C;
        Tue,  7 Apr 2020 06:23:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Apr 2020 06:23:08 +0000 (GMT)
Received: from [9.206.167.98] (unknown [9.206.167.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E8253A01C9;
        Tue,  7 Apr 2020 16:23:02 +1000 (AEST)
Subject: Re: [PATCH] Fix: buffer overflow during hvc_alloc().
To:     Andrew Melnichenko <andrew@daynix.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, virtualization@lists.linux-foundation.org
References: <20200405204024.1007843-1-andrew@daynix.com>
 <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
 <CABcq3pHMSN9vZRrV1xL6nA7HOK-+wnFSEQsqTqFVvKr4usNbOg@mail.gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Tue, 7 Apr 2020 16:23:06 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABcq3pHMSN9vZRrV1xL6nA7HOK-+wnFSEQsqTqFVvKr4usNbOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040706-4275-0000-0000-000003BB1F68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040706-4276-0000-0000-000038D07F10
Message-Id: <06ecf4d9-80d7-fbfd-3f95-9241d8d0d5cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004070051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 6:05 pm, Andrew Melnichenko wrote:
> 
>     Steps to Reproduce:
> 
>     1. boot guest with command [1]
>     2. load and unload virtio_console inside guest with loop.sh
>         # cat loop.sh
>          while [ 1 ]
>          do
>     modprobe virtio_console
>     lsmod | grep virt
>     modprobe -r virtio_console
>     lsmod | grep virt
>          done
> 
> 
> 
>     Actual results:
>     Guest reboot and can get vmcore-dmesg.txt file
> 
> 
>     Expected results:
>     Guest works well without error
> 
> 
>     Additional info:
>     The whole log will attach to the attachments.
> 
>     Call Trace:
>     [   22.974500] fuse: init (API version 7.31)
>     [   81.498208] ------------[ cut here ]------------
>     [   81.499263] pvqspinlock: lock 0xffffffff92080020 has corrupted
>     value 0xc0774ca0!
>     [   81.501000] WARNING: CPU: 0 PID: 785 at
>     kernel/locking/qspinlock_paravirt.h:500

[snip]

Thanks!

You should include an appropriate excerpt from this - the WARNING 
message and stack trace, and the steps to reproduce - in the commit 
message of the patch.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

