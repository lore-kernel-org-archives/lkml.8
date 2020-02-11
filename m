Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67420C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2AA20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRhx0BDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBKGEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:04:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:04:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B62Xtg158096;
        Tue, 11 Feb 2020 06:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QAyHIyuut4DgxSFNofFfzr4ml5eMRbXwn22LCzLSUyE=;
 b=DRhx0BDLuPT/gBArNKudYreV4mN0yrf27DhykDZXBqbORTGuOSHURWylrTSuYw+lwOY5
 ulJZM3vyeyHJkJL/aNDKoGl43xNN12bBjJEBW+SsnYJRKGtFp5jPvaA9VUJLDuRcq0Lw
 5JcH/aJQOxE/66ovVPUu3DwVXByYkvaaVhlg7d00jsToKC/bfma5FI6VkvjJFcqWH7fw
 jHPj5iOLiE9eYMG2feA8t4HFRcy1MMeFVejwS/okJUm34dEi/FmTb9hEPeYAUR4atR2A
 QwjRhLFX7bJwmxjXIt6/+ctADdIe3RjsPCUIeg6bTlqTWrP1WbSiBg9x5K80Dmh43U/n 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k88135r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 06:03:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B62RkJ143990;
        Tue, 11 Feb 2020 06:03:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y26sp5h2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 06:03:55 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01B63o2X013113;
        Tue, 11 Feb 2020 06:03:52 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 22:03:49 -0800
Date:   Tue, 11 Feb 2020 09:03:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200211060342.GB1778@kadam>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131050651.hlq27kehtir3agf2@kili.mountain>
 <20200210190419.GC1058087@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210190419.GC1058087@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:04:19AM -0800, Greg KH wrote:
> On Fri, Jan 31, 2020 at 08:06:52AM +0300, Dan Carpenter wrote:
> > We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> > ("USB: debugging code shouldn't alter control flow").
> > 
> > The difference between dev_WARN() and dev_err() is that dev_WARN()
> > prints a stack trace and if you have panic on OOPS enabled then it leads
> > to a panic.  The dev_err() function just prints the error message.
> > 
> > Back in the day we didn't have usb emulators fuzz testing the kernel
> > so dev_WARN() didn't cause a problem for anyone, but these days the
> > dev_WARN() interferes with syzbot so let's change this to a dev_err().
> > 
> > Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > 
> >  drivers/usb/core/urb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > index da923ec17612..0980c1d2253d 100644
> > --- a/drivers/usb/core/urb.c
> > +++ b/drivers/usb/core/urb.c
> > @@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
> >  
> >  	/* Check that the pipe's type matches the endpoint's type */
> >  	if (usb_urb_ep_type_check(urb))
> > -		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> > +		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> >  			usb_pipetype(urb->pipe), pipetypes[xfertype]);
> 
> Like others said, we should have the stack trace here.  So can you
> change this to dev_warn() and a stacktrace?
> 

Let's just fix the driver instead.  That was the message I got from the
thread.

regards,
dan carpenter


