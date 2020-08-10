Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EE9206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QFenTlRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHJNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:35:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHJNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:35:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ADQdd9065062;
        Mon, 10 Aug 2020 13:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZoFNtGOgKnmwtMTwnga7c/TfJhLygj/dIZvuHNo7VXA=;
 b=QFenTlRMew5xcSJTqq4hYb9NLpXTU9LctLcm4bRuviFMYMlpLszmsbsVNIoLDiZNTdq8
 oesVtdD7HV6el+8vc5WR55S6BbBxelH/AlL8naXwLFm5jt5XbqgZWo5nET++fDWIF9MT
 zRa0lLEEpWA4SOEK3fb3hKDfYU4+R0f//HLAXu80q5E3vVU7QOVTlESYcywq59W+XVvW
 ctTB0LuALBXaDYQnYDRDmUESJgua32dCVg6QbDQr4OvNStW2brjV3mpZihBGaHHBVPSF
 4WKxSpho8Vgdef1X4+Dm55Rs2yhpISV0+NQmMtmFed24wz7mwnPpH70mF3V3VEggxcPn Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32sm0meghp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 13:34:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ADTSPe127534;
        Mon, 10 Aug 2020 13:34:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32t5mmjwg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 13:34:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07ADYvDM022568;
        Mon, 10 Aug 2020 13:34:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 13:34:57 +0000
Date:   Mon, 10 Aug 2020 16:34:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/usb/core/devio.c:1155 do_proc_control() error:
 copy_from_user() 'tbuf' too small (4096 vs 8192)
Message-ID: <20200810133450.GD5493@kadam>
References: <202008081337.Z6BAxT0d%lkp@intel.com>
 <20200810121222.GA18639@lst.de>
 <20200810121433.GB18639@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810121433.GB18639@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:14:33PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 10, 2020 at 02:12:23PM +0200, Christoph Hellwig wrote:
> > As far as I can tell the warning is valid as we copy a user controlled
> > amount into a fixed sized buffer.  But this an old condition not actually
> > created by this commit..
> 
> Actually, is is not.  do_proc_control checks the legnth, but does it
> using a somewhat pointless local variable, which might have confused
> smatch.

I think what's happening is that this is using PAGE_SIZE = 8096 and
smatch assumes that it's always 4096.  It seems obvious in retrospect
that you can't assume page size if 4096 but I'm not sure how to
calculate the actual page size...

Normally I filter all Smatch kbuild bot warnings manually before
forwarding them but this one was sent directly.

regards,
dan carpenter

> 
> > 
> > On Sat, Aug 08, 2020 at 01:26:39PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   049eb096da48db0421dd5e358b9b082a1a8a2025
> > > commit: c17536d0abde2fd24afca542e3bb73b45a299633 usb: usbfs: stop using compat_alloc_user_space
> > > date:   2 weeks ago
> > > config: nds32-randconfig-m031-20200808 (attached as .config)
> > > compiler: nds32le-linux-gcc (GCC) 9.3.0
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > smatch warnings:
> > > drivers/usb/core/devio.c:1155 do_proc_control() error: copy_from_user() 'tbuf' too small (4096 vs 8192)
> > > 
> > > vim +/tbuf +1155 drivers/usb/core/devio.c
> > > 
> > >   1104	
> > >   1105	static int do_proc_control(struct usb_dev_state *ps,
> > >   1106			struct usbdevfs_ctrltransfer *ctrl)
> > >   1107	{
> > >   1108		struct usb_device *dev = ps->dev;
> > >   1109		unsigned int tmo;
> > >   1110		unsigned char *tbuf;
> > >   1111		unsigned wLength;
> > >   1112		int i, pipe, ret;
> > >   1113	
> > >   1114		ret = check_ctrlrecip(ps, ctrl->bRequestType, ctrl->bRequest,
> > >   1115				      ctrl->wIndex);
> > >   1116		if (ret)
> > >   1117			return ret;
> > >   1118		wLength = ctrl->wLength;	/* To suppress 64k PAGE_SIZE warning */
> > >   1119		if (wLength > PAGE_SIZE)
> > >   1120			return -EINVAL;
> > >   1121		ret = usbfs_increase_memory_usage(PAGE_SIZE + sizeof(struct urb) +
> > >   1122				sizeof(struct usb_ctrlrequest));
> > >   1123		if (ret)
> > >   1124			return ret;
> > >   1125		tbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
> > >   1126		if (!tbuf) {
> > >   1127			ret = -ENOMEM;
> > >   1128			goto done;
> > >   1129		}
> > >   1130		tmo = ctrl->timeout;
> > >   1131		snoop(&dev->dev, "control urb: bRequestType=%02x "
> > >   1132			"bRequest=%02x wValue=%04x "
> > >   1133			"wIndex=%04x wLength=%04x\n",
> > >   1134			ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
> > >   1135			ctrl->wIndex, ctrl->wLength);
> > >   1136		if (ctrl->bRequestType & 0x80) {
> > >   1137			pipe = usb_rcvctrlpipe(dev, 0);
> > >   1138			snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
> > >   1139	
> > >   1140			usb_unlock_device(dev);
> > >   1141			i = usb_control_msg(dev, pipe, ctrl->bRequest,
> > >   1142					    ctrl->bRequestType, ctrl->wValue, ctrl->wIndex,
> > >   1143					    tbuf, ctrl->wLength, tmo);
> > >   1144			usb_lock_device(dev);
> > >   1145			snoop_urb(dev, NULL, pipe, max(i, 0), min(i, 0), COMPLETE,
> > >   1146				  tbuf, max(i, 0));
> > >   1147			if ((i > 0) && ctrl->wLength) {
> > >   1148				if (copy_to_user(ctrl->data, tbuf, i)) {
> > >   1149					ret = -EFAULT;
> > >   1150					goto done;
> > >   1151				}
> > >   1152			}
> > >   1153		} else {
> > >   1154			if (ctrl->wLength) {
> > > > 1155				if (copy_from_user(tbuf, ctrl->data, ctrl->wLength)) {
> > >   1156					ret = -EFAULT;
> > >   1157					goto done;
> > >   1158				}
> > >   1159			}
> > >   1160			pipe = usb_sndctrlpipe(dev, 0);
> > >   1161			snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT,
> > >   1162				tbuf, ctrl->wLength);
> > >   1163	
> > >   1164			usb_unlock_device(dev);
> > >   1165			i = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), ctrl->bRequest,
> > >   1166					    ctrl->bRequestType, ctrl->wValue, ctrl->wIndex,
> > >   1167					    tbuf, ctrl->wLength, tmo);
> > >   1168			usb_lock_device(dev);
> > >   1169			snoop_urb(dev, NULL, pipe, max(i, 0), min(i, 0), COMPLETE, NULL, 0);
> > >   1170		}
> > >   1171		if (i < 0 && i != -EPIPE) {
> > >   1172			dev_printk(KERN_DEBUG, &dev->dev, "usbfs: USBDEVFS_CONTROL "
> > >   1173				   "failed cmd %s rqt %u rq %u len %u ret %d\n",
> > >   1174				   current->comm, ctrl->bRequestType, ctrl->bRequest,
> > >   1175				   ctrl->wLength, i);
> > >   1176		}
> > >   1177		ret = i;
> > >   1178	 done:
> > >   1179		free_page((unsigned long) tbuf);
> > >   1180		usbfs_decrease_memory_usage(PAGE_SIZE + sizeof(struct urb) +
> > >   1181				sizeof(struct usb_ctrlrequest));
> > >   1182		return ret;
> > >   1183	}
> > >   1184	
> > > 
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > 
> > 
> > ---end quoted text---
> ---end quoted text---
