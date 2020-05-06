Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC83C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9AC20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEFFam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:30:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgEFFam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:30:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04653OOR128725;
        Wed, 6 May 2020 01:30:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8sp1hge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 01:30:05 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04655q7w135977;
        Wed, 6 May 2020 01:30:04 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8sp1hf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 01:30:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0465U1F5003746;
        Wed, 6 May 2020 05:30:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5rdxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 05:30:02 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0465Txts45088912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 05:29:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E15F4C044;
        Wed,  6 May 2020 05:29:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FEFD4C04E;
        Wed,  6 May 2020 05:29:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  6 May 2020 05:29:56 +0000 (GMT)
Date:   Wed, 6 May 2020 10:59:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
Message-ID: <20200506052955.GA8259@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com>
 <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200504164724.GA28697@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_01:2020-05-04,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Oleg Nesterov <oleg@redhat.com> [2020-05-04 18:47:25]:

> uprobe_write_opcode() must not cross page boundary; prepare_uprobe()
> relies on arch_uprobe_analyze_insn() which should validate "vaddr" but
> some architectures (csky, s390, and sparc) don't do this.
> 
> We can remove the BUG_ON() check in prepare_uprobe() and validate the
> offset early in __uprobe_register(). The new IS_ALIGNED() check matches
> the alignment check in arch_prepare_kprobe() on supported architectures,
> so I think that all insns must be aligned to UPROBE_SWBP_INSN_SIZE.
> 
> Another problem is __update_ref_ctr() which was wrong from the very
> beginning, it can read/write outside of kmap'ed page unless "vaddr" is
> aligned to sizeof(short), __uprobe_register() should check this too.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Thanks Oleg.

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---


-- 
Thanks and Regards
Srikar Dronamraju
