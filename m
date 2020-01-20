Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A898021835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eHtTY6c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgATNei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:34:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:34:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KDX2dB045765;
        Mon, 20 Jan 2020 13:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4RZ/iUBw64s4UkNe4jkVsvA9CN5NJnP7F69TwV/NGVo=;
 b=eHtTY6c6KWRKZXDPTNU+vmhH+9B+LIypChrEtFpt+0u75e4IdnuFPIYUO3Ir3nrhg9t8
 rokp6/k59MhoGHeO/Gjop1grLGxQo+VyLSOVwzt/sYS9E+CpJ+NOXay/S+1cbPW6V1qI
 U51QKiAq4d5404tTkliPGRmnrXqV0OmS0GjRASj1oHNIl8pCfNKTKdrJaZQ16NGU51iW
 OQYkDEslJV/TwmUC+tY4qmRm6lSUXEV9MH53kmIquaAXvHxMWo3ARpMHC01NGh575+m8
 jaOa2+tdBd+k0kIobA5vcrPv/f691riU7cJkifbAvSoGRr72Hkfr3lrDbC9MdOrrIjS9 TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseu7kpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 13:34:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00KDYLWk055891;
        Mon, 20 Jan 2020 13:34:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xmbj1wsef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 13:34:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00KDY3wb012785;
        Mon, 20 Jan 2020 13:34:03 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 05:34:02 -0800
Date:   Mon, 20 Jan 2020 16:37:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+afeecc39f502a8681560@syzkaller.appspotmail.com>,
        arnd@arndb.de, dmitry.torokhov@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Subject: Re: linux-next boot error: KASAN: slab-out-of-bounds Read in
 post_usb_notification
Message-ID: <20200120133758.GK19765@kadam>
References: <20200120082335.GD21151@kadam>
 <0000000000001a91f9059c52f727@google.com>
 <929068.1579526141@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929068.1579526141@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001200117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001200117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 01:15:41PM +0000, David Howells wrote:
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> >   2759          struct {
> >   2760                  struct usb_notification n;
> >   2761                  char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
> >   2762                                 (sizeof(struct usb_notification) -
> >   2763                                  offsetof(struct usb_notification, name))];
> >   2764          } n;
> >   2765  
> >   2766          name_len = strlen(devname);
> >   2767          name_len = min_t(size_t, name_len, USB_NOTIFICATION_MAX_NAME_LEN);
> >                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This limit is too high.  It should be USB_NOTIFICATION_MAX_NAME_LEN -
> > sizeof(struct usb_notification). or just
> > "min_t(size_t, name_len, sizeof(n.more_name));".  n.n.name[] is a
> > zero size array.
> 
> No.  It's not that simple.  If you look at the struct:
> 
> 	struct usb_notification {
> 		struct watch_notification watch;
> 		__u32	error;
> 		__u32	reserved;
> 		__u8	name_len;
> 		__u8	name[0];
> 	};
> 
> There are at least 3, if not 7, bytes of padding after name[] as the struct is
> not packed - and isn't necessarily rounded up to a multiple of 8 bytes either.
> If you look at the definition of more_name[] above, you'll see:
> 
> 	USB_NOTIFICATION_MAX_NAME_LEN -
> 	(sizeof(struct usb_notification) -
> 	 offsetof(struct usb_notification, name))
> 
> That calculates the amount of padding and then subtracts it from the amount of
> name bufferage required.
> 
> USB_NOTIFICATION_MAX_NAME_LEN is 63, which is 64 minus one for the length.

Ah yes...  You're right.  I didn't think about padding.  And even if I
had, I would have thought the hole would have gone before name[] but
it comes after as you say.

regards,
dan carpenter
