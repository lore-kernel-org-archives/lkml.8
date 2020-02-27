Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB4C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4C924690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NwfcjcTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgB0LCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:02:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgB0LCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:02:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RAvRpZ063272;
        Thu, 27 Feb 2020 11:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JrWkxcpYwv12whhcDhmRkpXEZKuaivw3ooDPUiSTgno=;
 b=NwfcjcTmq7qQscXkXQ5394JuVzPiNAInx6JWtVRSrf9DpzgbTypCV+h4qPGj3arVdG6u
 wOPvGaOJ6/SGq2odAXz04+MpR6EIMQMNnBrqOQu0t031phAMdNvri+rF10be6mddWtla
 FDnzcFv2CNdHDqnWhv3sGh2FkPppXyV2DbqazxKfNqxUH/Npu4yh25ogekteyACm4rKf
 TjnpDlL8HZ6ADvcwfSElHd+aNKszEcPlYetJHyP8e0yWwuVAAYH1GODLCuol1kdSmuli
 ZSfTcn+cZ64OcdYJ/m8t17n0WnMN+Fcx27I6PXpY/KPCITmczicwWT5ORNk27nMMLRt6 Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsnj7vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 11:01:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RAugSZ091839;
        Thu, 27 Feb 2020 11:01:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ydcsc3y79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 11:01:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RB1KIa015901;
        Thu, 27 Feb 2020 11:01:20 GMT
Received: from [10.39.232.60] (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 03:01:20 -0800
Subject: Re: [patch 00/10] x86/entry: Consolidation - Part I
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225213636.689276920@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <51331157-eef1-f064-f098-faae7b2d25d7@oracle.com>
Date:   Thu, 27 Feb 2020 12:01:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225213636.689276920@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 10:36 PM, Thomas Gleixner wrote:
> Hi!
> 
> This is the first batch of a 73 patches series which consolidates the x86
> entry code.
> 
> This work started off as a trivial 5 patches series moving the heavy
> lifting of POSIX CPU timers out of interrupt context into thread/process
> context. This discovered that KVM is lacking to handle pending work items
> before entering guest mode and added the handling to the x86 KVM
> code. Review requested to make this a generic infrastructure.
> 
> The next series grew to 25 patches implementing the generic infrastructure,
> converting x86 (and as a POC ARM64) over, but it turned out that this was
> slightly incomplete and still had some entanglement with the rest of the
> x86 entry code as some of that functionality is shared between syscall and
> interrupt entry/exit. And it also unearthed the nastyness of IOPL which got
> already addressed in mainline.
> 
> This series addresses these issues in order to prepare for making the entry
> from userspace and exit to userspace (and it's counterpart enter guest) a
> generic infrastructure in order to restrict the necessary ASM work to the
> bare minimum.
> 
> The series is split into 5 parts:
> 
>      - General cleanups and bugfixes
> 
>      - Consolidation of the syscall entry/exit code
> 
>      - Autogenerate simple exception/trap code and reduce the difference
>        between 32 and 64 bit
> 
>      - Autogenerate complex exception/trap code and provide different entry
>        points for #DB and #MC exceptions which allows to address the
>        recently discovered RCU vs. world issues in a more structured way
> 
>      - Convert the device interrupt entry code to use the same mechanism as
>        exceptions and traps and finally convert the system vectors over as
>        well. The last step after all those cleanups is to move the return
>        from exception/interrupt logic (user mode work, kernel preemption)
>        completely from ASM into C-code, so the ASM code just has to take
>        care about returning from the exception, which is horrible and
>        convoluted enough already.
> 
> At the end the x86 entry code is ready to move the syscall parts out into
> generic code and finally tackle the initial problem which started all of
> this.
> 
> The complete series is available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry
> 
> which contains all 73 patches. The individual parts are tagged, so this
> part can be retrieved via:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part1
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------
>   entry/entry_32.S          |   19 +++++++------------
>   include/asm/irq.h         |    2 +-
>   include/asm/mce.h         |    3 ---
>   include/asm/traps.h       |   17 +++++++----------
>   kernel/cpu/mce/core.c     |   12 ++++++++++--
>   kernel/cpu/mce/internal.h |    3 +++
>   kernel/irq.c              |    3 +--
>   kernel/traps.c            |   41 ++++++++++++++++++++++++++++++++++-------
>   8 files changed, 63 insertions(+), 37 deletions(-)
> 

For part I:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

for all patches. I had a slight concern about patch 08 and propagating a different
error_code, but I agree with your argument that it is limited to 32-bit process and
now matches with the 64-bit behavior.

alex.
