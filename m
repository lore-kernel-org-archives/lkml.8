Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68636C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C8D206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XW7w8SzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCLNfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:35:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:35:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CDCgmT138323;
        Thu, 12 Mar 2020 13:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8eL3ngH8o4nYxwhQl9n+3pxiVcSSs/F/ZP4OEMZrBeQ=;
 b=XW7w8SzFCKHip1D7SeHiG0FvAel7Gi6AY749Fb3KOx1GqdNJAYW6UhuIEET1yARipYxK
 X/8wYSSelOQlPqAJD5NINcmpp2wq8gurGKfw3cvcxz4blsmxEJVaCbI0xYET5kRPj4iy
 Gpsk3KEOoC9ZxsyJrMA8h6vFXZk9GUPDg9fTqxu1UAdXyDn6YlG/BMcUZlnZTMtHzTpg
 4Mkiu8CVcl/72+Np7NVxL9DyeFjqrpjG8TnE68Yhs0IAeUgF9MasxVwOmpNC3wjMg5Ir
 C+acTk6xsNGZFtlcyGWbyHz6J2yUW14g0Usc0tB/gH3rhBck8rb69r8cw2p4887rveI8 lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yp9v6cpx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 13:34:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CDKI0H113519;
        Thu, 12 Mar 2020 13:34:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yp8r0djg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 13:34:52 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CDYn4N024325;
        Thu, 12 Mar 2020 13:34:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 06:34:48 -0700
Date:   Thu, 12 Mar 2020 16:34:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: general protection fault in syscall_return_slowpath
Message-ID: <20200312133442.GH11561@kadam>
References: <000000000000ff323f05a053100c@google.com>
 <CALCETrV-wMcO8eqzzQX1Jh20Zn-mEkYpQbd+cfCdcgV+AYsaKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV-wMcO8eqzzQX1Jh20Zn-mEkYpQbd+cfCdcgV+AYsaKA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 09:29:04AM -0700, Andy Lutomirski wrote:
> On Sat, Mar 7, 2020 at 11:45 PM syzbot
> <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
> >
> 
> I bet this is due to entirely missing input validation in
> con_font_copy() and/or fbcon_copy_font().

The only thing we use in con_font_copy() is op->height and we clamp it
to 0-MAX_NR_CONSOLES (64).

regards,
dan carpenter

