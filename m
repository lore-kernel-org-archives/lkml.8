Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B9F207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgFERoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:44:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbgFERon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:44:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055HZk8N149886;
        Fri, 5 Jun 2020 13:44:38 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31f9dc63rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 13:44:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055HeqDg005894;
        Fri, 5 Jun 2020 17:44:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 31bf484pkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 17:44:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055HiYhu47448126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 17:44:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E800A5204E;
        Fri,  5 Jun 2020 17:44:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id BD26B52050;
        Fri,  5 Jun 2020 17:44:33 +0000 (GMT)
Date:   Fri, 5 Jun 2020 19:44:33 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: kprobes string reading broken on s390
Message-ID: <20200605174433.GA82185@tuxmaker.boeblingen.de.ibm.com>
References: <20200605110533.GA57038@tuxmaker.boeblingen.de.ibm.com>
 <20200605132541.GB31829@lst.de>
 <20200606015806.c8f9cafc3c6c52b8854d6cd3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606015806.c8f9cafc3c6c52b8854d6cd3@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 cotscore=-2147483648 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami,

On Sat, Jun 06, 2020 at 01:58:06AM +0900, Masami Hiramatsu wrote:
> Hi Sven,
> 
> On Fri, 5 Jun 2020 15:25:41 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Yes, this looks correct.  You probably want to write a small changelog
> > and add a Fixes tag, though.
> > 
> > On Fri, Jun 05, 2020 at 01:05:34PM +0200, Sven Schnelle wrote:
> > > Hi Christoph,
> > > 
> > > with the latest linux-next i noticed that some tests in the
> > > ftrace test suites are failing on s390, namely:
> > > 
> > > [FAIL] Kprobe event symbol argument
> > > [FAIL] Kprobe event with comm arguments
> > > 
> > > The following doesn't work anymore:
> > > 
> > > cd /sys/kernel/tracing
> > > echo 'p:testprobe _do_fork comm=$comm ' >kprobe_events
> > > echo 1 >/sys/kernel/tracing/events/kprobes/testprobe/enable
> > > cat /sys/kernel/tracing/trace
> > > 
> > > it will just show
> > > 
> > > test.sh-519   [012] ....    18.580625: testprobe: (_do_fork+0x0/0x3c8) comm=(fault)
> > > 
> > > Looking at d411a9c4e95a ("tracing/kprobes: handle mixed kernel/userspace probes
> > > better") i see that there are two helpers for reading strings:
> > > 
> > > fetch_store_string_user() -> read string from user space
> > > fetch_store_string() -> read string from kernel space(?)
> > > 
> > > but in the end both are using strncpy_from_user_nofault(), but i would
> > > think that fetch_store_string() should use strncpy_from_kernel_nofault().
> > > However, i'm not sure about the exact semantics of fetch_store_string(),
> > > as there where a lot of wrong assumptions in the past, especially since
> > > on x86 you usually don't fail if you use the same function for accessing kernel
> > > and userspace although it's technically wrong.
> 
> Thanks for fixing!
> This report can be a good changelog.
> Please resend it with Fixed tag as Christoph said.

Which SHA1 should the Fixes tag carry? The one from linux-next?

Regards
Sven
