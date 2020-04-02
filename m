Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F88C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5232080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qj+MGh2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgDBOF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:05:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53728 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbgDBOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:05:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032E3ctj138529;
        Thu, 2 Apr 2020 14:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ms8xH/kkDNV/mYEGuuCn0BeytjCFnFwImg1lHQcydx0=;
 b=Qj+MGh2QVdt0s1zM3nqOOUeFIFmKlgQV0gGRoc2uA7QEhsVL7ExBiFNFPs5YeuLCld3J
 GwXgNCQ9Ov4GDChQOpwtumQ8Zf1dfUbWctqbZyOaGB4ne0ViQn7TIAgF38HRL9idgCav
 q9S5PzQEyo/Ax0oCGRGbHgg5szy7PK3lvEKJ0bH/xvrZS9tCqAhUArIoOR4svusGxhgB
 jEZP6Auxi+enX34+x3yWqG9JLaXAIs7tGXVkcCe8JpiHLXTMx3KN6cBSExHJLPtco3vp
 v7gNcQ04ZQE1u2NrhIL1tt1qKpex39ytZpIaBhqcoegZ9gm0TR9b1ae6pxZy/norO1aa oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yune7kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:05:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032E2Ktx023326;
        Thu, 2 Apr 2020 14:05:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 302g4vkty5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:05:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032E4wSg013635;
        Thu, 2 Apr 2020 14:04:58 GMT
Received: from [10.159.243.67] (/10.159.243.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 07:04:58 -0700
Subject: Re: qemu-x86: kernel panic when host is loaded
To:     Thomas Gleixner <tglx@linutronix.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        qemu-discuss@nongnu.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200402093132.GA15839@Red>
 <87eet6nra7.fsf@nanos.tec.linutronix.de>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <18354be1-8dba-84f1-bdf5-6821a5013d78@oracle.com>
Date:   Thu, 2 Apr 2020 07:04:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87eet6nra7.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 2:57 AM, Thomas Gleixner wrote:
> Corentin,
> 
> Corentin Labbe <clabbe.montjoie@gmail.com> writes:
>> On our kernelci lab, each qemu worker pass an healtcheck job each day and after each job failure, so it is heavily used.
>> The healtcheck job is a Linux boot with a stable release.
>>
>> Since we upgraded our worker to buster, the qemu x86_64 healthcheck randomly panic with:
>> <0>[    0.009000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
>>
>> After some test I found the source of this kernel panic, the host is
>> loaded and qemu run "slower".  Simply renicing all qemu removed this
>> behavour.
>>
>> So now what can I do ?
>> Appart renicing qemu process, does something could be done ?
> 
> As the qemu timer/ioapic routing is actually sane, you might try to add
> "no_timer_check" to the kernel command line.
> 

The no_timer_check is already permanently disabled in below commit?

commit a90ede7b17d1 ("KVM: x86: paravirt skip pit-through-ioapic boot check")

In addition, hyperv and vmware also disabled that:

commit ca3ba2a2f4a4 ("x86, hyperv: Bypass the timer_irq_works() check").

commit 854dd54245f7 ("x86/vmware: Skip timer_irq_works() check on VMware")

Dongli Zhang
