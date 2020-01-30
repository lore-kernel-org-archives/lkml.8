Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA29C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161CE2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3LLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:11:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgA3LLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:11:07 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UB9cEU025698
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 06:11:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfh1u6j8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 06:11:06 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 30 Jan 2020 11:11:04 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 11:11:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UBB0w642467410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 11:11:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E9642042;
        Thu, 30 Jan 2020 11:11:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97A5442047;
        Thu, 30 Jan 2020 11:10:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.154])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jan 2020 11:10:59 +0000 (GMT)
Date:   Thu, 30 Jan 2020 13:10:57 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Damian Tometzki <damian.tometzki@familie-tometzki.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
 <20200130075549.GA6684@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130075549.GA6684@zn.tnic>
X-TM-AS-GCONF: 00
x-cbid: 20013011-0020-0000-0000-000003A5714E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013011-0021-0000-0000-000021FD2636
Message-Id: <20200130111057.GA21459@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_03:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=772 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 08:55:49AM +0100, Borislav Petkov wrote:
> Hello Damian,
> 
> On Thu, Jan 30, 2020 at 06:47:14AM +0100, Damian Tometzki wrote:
> > in my qemu env the system isnt coming up. I tried both with and without the
> > changes from Borislav.
> 
> in the future, please do not hijack the thread like that but start a new
> one or open a bug on bugzilla.kernel.org. Your issue is something else.
> 
> > 0.605193] ------------[ cut here ]------------
> > [    0.605933] General protection fault in user access. Non-canonical
> > address?
> 
> There it is.
> 
> > [    0.605948] WARNING: CPU: 0 PID: 1 at arch/x86/mm/extable.c:77
> > ex_handler_uaccess+0x48/0x50
> > [    0.606931] Modules linked in:
> > [    0.606931] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0 #15
> > [    0.606931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> > [    0.606931] RIP: 0010:ex_handler_uaccess+0x48/0x50

...
 
> It looks like dquot_init->register_sysctl_table-> ... does copy_to_user
> at some point and it goes off into the weeds and %rsi becomes
> non-canonical.
> 
> Please start a new thread or open a bug and upload your .config and
> dmesg. We'll continue debugging that there.

Maybe that won't be needed.

It seems that this a random boot crash caused by 987f028b8637cfa7 ("char:
hpet: Use flexible-array member") and fix is on the way:

https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne.jp/
 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

-- 
Sincerely yours,
Mike.

