Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CD9C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E39020705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="friOxLkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgAaKSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:18:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgAaKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:18:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VAD4Ua028738;
        Fri, 31 Jan 2020 10:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Zfla5rQyVxYn0Di8J8A2YPJxSH/lgFnbZbSWE8cDuM8=;
 b=friOxLkUmslb6FZEXR5OcAwqULRuPe3sMXNoy4xGj5HbPjFxWelwOgmJ3m43+CV7d+8C
 3BQbzOO1k9tdMMO+ljs1LXQm4S675fDCcHjdyLCxu66/uYtZbrpf/4obDO/Pt3wT3DmN
 spZlZZfd+BQuAgyUlFEZM70oFT6Zoy50R4IbB+vSucuA3HvtE+880wP+anOPS76ehQ2p
 L0S4l8wmVgLVCAam7R9nmzNqWaq/lIu5qzPJWkeJ3TSm8/gA95N3G6sHo+7YT1JnwtMX
 zpcekgZrzbYAmkfBXwhZmIsOopBriT754IC3cJpRsJ9RaCvNJjFqTnRo7Ck9u3hNC01Q tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xrearsd2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 10:17:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VAEEsS041154;
        Fri, 31 Jan 2020 10:17:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xv9bwepff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 10:17:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00VAGv2D014997;
        Fri, 31 Jan 2020 10:16:58 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 02:16:57 -0800
Date:   Fri, 31 Jan 2020 13:16:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200131101644.GE11068@kadam>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131090510.7112-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131090510.7112-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 05:05:10PM +0800, Hillf Danton wrote:
> 
> On Fri, 31 Jan 2020 08:06:52 +0300 Dan Carpenter wrote:
> > We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> > ("USB: debugging code shouldn't alter control flow").
> > 
> > The difference between dev_WARN() and dev_err() is that dev_WARN()
> > prints a stack trace and if you have panic on OOPS enabled then it leads
> > to a panic.  The dev_err() function just prints the error message.
> > 
> > Back in the day we didn't have usb emulators fuzz testing the kernel
> > so dev_WARN() didn't cause a problem for anyone, but these days the
> 
> Another free option is perhaps to keep the devoted bot agile if it's
> difficult to list anybody who was mauled by its articulate reports.

It's difficult to parse this email.  I get that you're being sarcastic
but I can't tell what you're being sarcastic about.  :P

I think you're basically saying that syzbot should maintain a white
list of ignored Oopses.  There are two problems with this:  1) Other
people run syzbot so everyone has to run into this bug and then add it
to their own white list.  2)  If the kernel OOpes here then we cannot
test what happens next so it could be hiding bugs.

One idea is that there could be a kernel function which generates a
stack trace but is not an Oops.

regards,
dan carpenter
