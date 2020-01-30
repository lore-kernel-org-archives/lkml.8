Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B714C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB820702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgA3MBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:01:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgA3MBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:01:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UC118I012367
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:01:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubctas5v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:01:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 30 Jan 2020 12:00:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 12:00:02 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UC02uR41943280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 12:00:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02343A4059;
        Thu, 30 Jan 2020 12:00:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A4B3A4057;
        Thu, 30 Jan 2020 12:00:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.59.112])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jan 2020 12:00:00 +0000 (GMT)
Date:   Thu, 30 Jan 2020 13:59:59 +0200
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
References: <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
 <20200130075549.GA6684@zn.tnic>
 <20200130111057.GA21459@linux.ibm.com>
 <20200130115326.GG6684@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130115326.GG6684@zn.tnic>
X-TM-AS-GCONF: 00
x-cbid: 20013012-0012-0000-0000-000003822555
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013012-0013-0000-0000-000021BE7F9A
Message-Id: <20200130115959.GA24611@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_03:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=859
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:53:26PM +0100, Borislav Petkov wrote:
> On Thu, Jan 30, 2020 at 01:10:57PM +0200, Mike Rapoport wrote:
> > It seems that this a random boot crash caused by 987f028b8637cfa7 ("char:
> > hpet: Use flexible-array member") and fix is on the way:
> > 
> > https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne.jp/
> 
> Hmm, I don't see the connection at a first glance except that both stack
> traces lead somewhere down the bowels of k*alloc...

I've seen similar crash with my qemu/kvm and bisected it to that commit.

The hpet allocation is off-by-one and as a result hpet corrupts the memory
somewhere in the slab
 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

-- 
Sincerely yours,
Mike.

