Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D08C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C529D20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGGGtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:49:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbgGGGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:49:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0676VDxF113440;
        Tue, 7 Jul 2020 02:49:28 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324fdgxa0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:49:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0676lC5m016610;
        Tue, 7 Jul 2020 06:49:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h32gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 06:49:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0676nOGT58130548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 06:49:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A2A34204C;
        Tue,  7 Jul 2020 06:49:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805C842041;
        Tue,  7 Jul 2020 06:49:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Jul 2020 06:49:23 +0000 (GMT)
Date:   Tue, 7 Jul 2020 09:49:21 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200707064921.GA9411@linux.ibm.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007062234.A90F922DF@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_02:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 cotscore=-2147483648 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 10:56:17PM -0700, Kees Cook wrote:
> On Mon, Jul 06, 2020 at 09:29:46AM -0700, Andy Lutomirski wrote:
> > Is most contexts where 'whitelist' or 'blacklist' might be used, a
> > descriptive phrase could be used instead.  For example, a seccomp
> > filter could have a 'list of allowed syscalls' or a 'list of
> > disallowed syscalls', and just lists could be the 'allowed' or
> > 'accepted' lists and the 'disallowed', 'rejected', or 'blocked' lists.
> > If a single word replacement for 'whitelist' or 'blacklist' is needed,
> > 'allowlist', 'blocklist', or 'denylist' could be used.
> 
> Yup. See:
> https://lore.kernel.org/lkml/202007041703.51F4059CA@keescook/
> specifically the terminology for seccomp is already "allow-list" and
> "deny-list":
> https://github.com/mkerrisk/man-pages/commit/462ce23d491904a0b46252dc97c8cb42391c093e (last year)
> https://github.com/seccomp/libseccomp/commit/0e762521d604612bb4dca8867d4a428a5e6cae54 (last month)
> 
> > Second, I realize that I grew up thinking that 'whitelist' and
> > 'blacklist' are the common terms for lists of things to be accepted
> > and rejected and that this biases my perception of what sounds good,
> > but writing a seccomp "denylist" or "blocklist" doesn't seem to roll
> > off the tongue.  Perhaps this language would be better:
> 
> I have struggled with this as well. The parts of speech change, and my
> grammar senses go weird. whitelist = adjective noun. allow-list = verb
> noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is
> weird.
> 
> And just using "allowed" and "denied" doesn't impart whether it refers
> to a _single_ instance or a _list_ of instances.
> 
> But that's all fine. The change is easy to do and is more descriptive
> even if I can't find terms that don't collide with my internal grammar
> checker. ;)

How about yeslist and nolist? ;-)

> -- 
> Kees Cook
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

-- 
Sincerely yours,
Mike.
