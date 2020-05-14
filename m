Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEAC206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgENGJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgENGJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:09:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E622Bf064520;
        Thu, 14 May 2020 02:09:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310sywrywj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 02:09:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E60OBR021023;
        Thu, 14 May 2020 06:09:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3100ub2ykr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 06:09:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04E69F4F64553214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 06:09:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC85A404D;
        Thu, 14 May 2020 06:09:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12D47A4053;
        Thu, 14 May 2020 06:09:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 14 May 2020 06:09:15 +0000 (GMT)
Date:   Thu, 14 May 2020 08:09:14 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [tracing] 06e0a548ba:
 WARNING:at_kernel/trace/ring_buffer.c:#ring_buffer_iter_peek
Message-ID: <20200514060914.GA7686@tuxmaker.boeblingen.de.ibm.com>
References: <20200429090508.GG5770@shao2-debian>
 <20200513091906.GA12720@tuxmaker.boeblingen.de.ibm.com>
 <20200513092922.6d79f6ee@gandalf.local.home>
 <20200513161557.GA73453@tuxmaker.boeblingen.de.ibm.com>
 <20200513153033.3be208ec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513153033.3be208ec@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, May 13, 2020 at 03:30:33PM -0400, Steven Rostedt wrote:
> On Wed, 13 May 2020 18:15:57 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> > Thanks for looking into this. I've attached my /proc/config.gz to this Mail.
> > The x86 system is my Laptop which is a Thinkpad X280 with 4 HT CPUs (so 8 cpus
> > in total). I've tried disabling preemption, but this didn't help.
> > 
> > It's always this check that causes the loop:
> > 
> > if (iter->head >= rb_page_size(iter->head_page)) {
> > 	rb_inc_iter(iter);
> > 	goto again;
> > }
> > 
> > On the first loop iter->head is some value > 0 and rb_page_size returns
> > 0, afterwards it gets twice to this check with both values 0. The third
> > time the warning is triggered. Maybe that information helps.
> 
> I figured out what was causing this, and that's just that the writer and
> the iterator could end up almost "in sync" where the writer writes to each
> of the pages the iterator is trying to read, and this can trigger the three
> failures of "zero commits" per page.
> 
> I had a way to detect this, but then realized that it may be possible for
> an active writer to possibly trigger the other failures to get an event,
> that I just decided to force it to try three times, and simply return NULL
> if an active writer is messing with the iterator. The iterator is a "best
> effort" to read the buffer if there's an active writer. The consumer read
> (trace_pipe) is made for that.
> 
> This patch should solve you issues.
> 
> (care to give a Tested-by: if it works for you?)

Well, as there's no longer a RB_WARN_ON that indeed fixes the issue :-)

Tested-by: Sven Schnelle <svens@linux.ibm.com>

Thanks!

Sven
