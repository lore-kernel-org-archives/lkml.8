Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E0C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D793920705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HY5JHAEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgAaNlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:41:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35460 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:41:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VDc8Oh018434;
        Fri, 31 Jan 2020 13:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=fRv6nSdD+7TwnjcbDVjABJLy48Vs5zG5zSY2q7qXhMM=;
 b=HY5JHAEqrx0Dq85hL91OO3mRXUHGrqPmtChDkK5sZ7pGfG9UbCYSrnSEVs9NIBNBVr7B
 EvtR+mu96aoyIwHT5HbYvkxRbjluX65gk9SvxMuscoz/7O843EWXexuhVybF6zZ4LTCl
 dqzxW3F+1hRE0Z+pn9Vt2zavcr2gmKMrQAbKeWQsYYZXt3XOKmawPnz5aDjnCgOdRjxv
 OZ/edcQcOgMqql5G2iRwO+w9b+ANBXcxG5yPkGxRHY/9oY/ZDBduHn7501bnc5xXAJAS
 enFvPCw3g8gredgOhFecsptATzUBsbGB9tTVfpKlLycXhDTnpb9o2XbKhA5xH3S0R2kq 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3uteyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 13:41:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VDcj5p178688;
        Fri, 31 Jan 2020 13:39:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xv8nr0cpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 13:39:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00VDdGkk020706;
        Fri, 31 Jan 2020 13:39:16 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 05:39:15 -0800
Date:   Fri, 31 Jan 2020 16:39:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200131133907.GG11068@kadam>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131050651.hlq27kehtir3agf2@kili.mountain>
 <20200131133004.GD10381@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131133004.GD10381@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 02:30:04PM +0100, Johan Hovold wrote:
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
> >  
> >  	/* Check against a simple/standard policy */
> 
> It seems this change would just be papering over these driver bugs. The
> dev_WARN() is there in the first place to allow us to catch them.
> 
> Even if it takes some work, it should be doable to track down and add
> the missing sanity checks to the drivers that lack them. Some have
> already been fixed, and I have some more pending patches to fix or add
> helpers to simplify fixing the remaining ones.

Ah, fine.  I misunderstood what the warning message was about.

regards,
dan carpenter

