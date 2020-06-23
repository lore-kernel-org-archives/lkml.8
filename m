Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9227720774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPrLU7KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgFWKjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:39:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58944 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbgFWKjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:39:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NAc0Rb070633;
        Tue, 23 Jun 2020 10:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=n5XuAR9+O0ifIvp3nJRV9lwMwdmcqKft/1latpOpeYQ=;
 b=LPrLU7KO0gkf8k23PUy0TAS0eZYp+yxfHXBAjkajr7TXfhheo7k/y9bKFyTr72LOP27z
 qMwGSRjqavkOUpC2cZARjsWWlN/4uP5fbIE2I0J0ThuRlx0YsVsVf1QYCaDyrg4fMcOR
 2SmPrY/4Rav17QntGS4MifdDCcex1XlfVggOEDf7qQ2wqN1Hwfd4iOJFgeP2mhdzqMef
 2juKPhaDLe9NuYYAIsVTqp1tutooQ9mlWf3Siu6CNpFlebpI+/YVtIsy6PfpE12R0lTD
 gnpZZjJh0cuFofpTUabw3L6WHbyd3z2x0C8ICmOgRQ3N7Np4vYJ2Juzi4WVhkzk6iOq+ Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31sebbcgfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 10:39:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NAS8CW154650;
        Tue, 23 Jun 2020 10:37:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31sv7rkm22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 10:37:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05NAaw2K028133;
        Tue, 23 Jun 2020 10:36:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 10:36:57 +0000
Date:   Tue, 23 Jun 2020 13:36:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: Re: [kbuild] drivers/usb/gadget/udc/fsl_udc_core.c:1055
 fsl_ep_fifo_status() error: we previously assumed '_ep->desc' could be null
 (see line 1055)
Message-ID: <20200623103651.GZ4282@kadam>
References: <20200622182023.GX4282@kadam>
 <AM6PR04MB54138B87957CFB06EC9DF351F1940@AM6PR04MB5413.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB54138B87957CFB06EC9DF351F1940@AM6PR04MB5413.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:22:18AM +0000, Ran Wang wrote:
> Hi Dan
> 
> On Tuesday, June 23, 2020 2:20 AM, Dan Carpenter wrote:
> 
> <snip>
> 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > drivers/usb/gadget/udc/fsl_udc_core.c:1055 fsl_ep_fifo_status() error: we
> > previously assumed '_ep->desc' could be null (see line 1055)
> > 
> 
> <snip>
> 
> > 
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1047  static int fsl_ep_fifo_status(struct usb_ep *_ep)
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1048  {
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1049  	struct fsl_ep *ep;
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1050  	struct fsl_udc *udc;
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1051  	int size = 0;
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1052  	u32 bitmask;
> > 6414e94c203d92 drivers/usb/gadget/fsl_udc_core.c     Li Yang
> > 2011-11-23  1053  	struct ep_queue_head *qh;
> > 2ea6698d7b9266 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin
> > 2011-04-18  1054
> > 75eaa498c99eeb drivers/usb/gadget/udc/fsl_udc_core.c Nikhil Badola
> > 2019-10-21 @1055  	if (!_ep || _ep->desc || !(_ep->desc->bEndpointAddress&0xF))
> >                                          ^^^^^^^^^ Reversed NULL test.  This will always return -ENODEV.  (Or possibly crash.  But I suspect it always returns -ENODEV instead of crashing).
> 
> So the kernel test reports warning in case of '_ep->desc is null', right? 
> 
> My understanding is that this judgement would return -ENODEV when
> executing '... || _ep-desc ||..' and never execute '_ep->desc->bEndpointAddress' part,
> so crash would not happen, am I right?

Yeah.  I can't imagine how _ep->desc is NULL.  It gets set to non-NULL
in fsl_ep_enable() and then set to NULL in fsl_ep_disable().

regards,
dan carpenter

