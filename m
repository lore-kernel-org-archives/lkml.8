Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0173C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913CD207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U9ADaXXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgATIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:20:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36708 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:20:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00K8JGFD122135;
        Mon, 20 Jan 2020 08:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=rWSkzO4kWyFHYtTM9gCwBTK5rn1TFL358t/mnlVX4do=;
 b=U9ADaXXTDyRSCpgjUHFDXS1lrjRSx7WLn1u3X5FwStHAHsvyiBXYgjsh9xTJVJG/vfX2
 XjkUKOtI5bqxb9hpRAhPk41FpgV6guQ2A/HKyPwBi27X8VE2a3g4BzXZzYUsbhfcnjOs
 OOUQWSX/ljaO4IWFrm3MzmP9+NUar74RHooLIo+8hhkVB/z4H48AevJWxjtidz/m93jq
 Ieph0UV1flPZxUdwMQkI4L6HW9Cb5eSSwY88bQZ1eW/7Mfn350/Gksmay4i4KFclWQTR
 ArfY9P612XWlccgMJHLfrS29eIU/8mjV7H1eBu0eG2OYCkZO6Knp3CcSoqN2MUFSO/dN YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xksypwndp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:19:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00K8JN0v061108;
        Mon, 20 Jan 2020 08:19:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xmc5k5wd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:19:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00K8JlOM009066;
        Mon, 20 Jan 2020 08:19:47 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 00:19:46 -0800
Date:   Mon, 20 Jan 2020 11:23:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     syzbot <syzbot+afeecc39f502a8681560@syzkaller.appspotmail.com>,
        dhowells@redhat.com
Cc:     arnd@arndb.de, dmitry.torokhov@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Subject: Re: linux-next boot error: KASAN: slab-out-of-bounds Read in
 post_usb_notification
Message-ID: <20200120082335.GD21151@kadam>
References: <0000000000001a91f9059c52f727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001a91f9059c52f727@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001200074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9505 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001200074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey David,

This crash was from commit 72cc88648972 ("usb: Add USB subsystem
notifications").

drivers/usb/core/devio.c
  2752  static noinline void post_usb_notification(const char *devname,
  2753                                             enum usb_notification_type subtype,
  2754                                             u32 error)
  2755  {
  2756          unsigned int name_len, n_len;
  2757          u64 id = 0; /* We can put a device ID here for separate dev watches */
  2758  
  2759          struct {
  2760                  struct usb_notification n;
  2761                  char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
  2762                                 (sizeof(struct usb_notification) -
  2763                                  offsetof(struct usb_notification, name))];
  2764          } n;
  2765  
  2766          name_len = strlen(devname);
  2767          name_len = min_t(size_t, name_len, USB_NOTIFICATION_MAX_NAME_LEN);
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This limit is too high.  It should be USB_NOTIFICATION_MAX_NAME_LEN -
sizeof(struct usb_notification). or just
"min_t(size_t, name_len, sizeof(n.more_name));".  The n.n.name[] is a
zero size array.

  2768          n_len = offsetof(struct usb_notification, name) + name_len;
  2769  
  2770          memset(&n, 0, sizeof(n));
  2771          memcpy(n.n.name, devname, n_len);
                                          ^^^^^
name_len was intended here.

  2772  
  2773          n.n.watch.type          = WATCH_TYPE_USB_NOTIFY;
  2774          n.n.watch.subtype       = subtype;
  2775          n.n.watch.info          = n_len;
  2776          n.n.error               = error;
  2777          n.n.name_len            = name_len;
  2778  
  2779          post_device_notification(&n.n.watch, id);
  2780  }

regards,
dan carpenter
