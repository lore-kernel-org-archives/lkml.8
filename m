Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E748C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F95206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECIY2Fn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGGKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgGGKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067AGnYh151572;
        Tue, 7 Jul 2020 10:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QkojGzHg40T2ilD1fUyYLuv+tLqZ5zRbN8tsposQC00=;
 b=ECIY2Fn6FNjqM/2N6nwvSlVjLeu5n3qLTZ4APuUqn55rMXWDOdeM28yQVtPSjBxUeGq5
 msuTIVPs/A06Os/8jxotO+mHVmS7jJDVODBUC3vH2jUJTRpkwS3Egc3Cwlh9f02vJ3TY
 noH6uXyZI6s6Gv/zz4g2hUhVayAmCBRvnlariiQeIrAglBfdTGagjsWmuGD2dV0VC32p
 HpN8Hj8CUnAa8XWJTQbYugnVVWYc3XPKG1/TdYDhhHzbf6HtzoBy29jRdO6up3OZbGQ9
 BcVL7mT28tsMC642dhnvhTqjtVBp5zLpJKWBQKnBYQnSfKcPjT6ELIWKOUu54U5GrxVp PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 322kv6bcj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 10:16:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067AD1aL079281;
        Tue, 7 Jul 2020 10:16:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 324n4qwxxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 10:16:48 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 067AGhWM023739;
        Tue, 7 Jul 2020 10:16:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 03:16:43 -0700
Date:   Tue, 7 Jul 2020 13:16:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH 2/9] usb: cdns3: Improvement: removed not needed
 variables initialization
Message-ID: <20200707101633.GV2571@kadam>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-3-pawell@cadence.com>
 <20200707062341.GC16073@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707062341.GC16073@b29397-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:23:32AM +0000, Peter Chen wrote:
> On 20-07-01 08:19:57, Pawel Laszczak wrote:
> > Patch remove some variables initialization from core.c and drd.c
> > file.
> > 
> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > ---
> >  drivers/usb/cdns3/core.c |  4 ++--
> >  drivers/usb/cdns3/drd.c  | 19 +++++++++----------
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > index eaafa6bd2a50..c3dac945f63d 100644
> > --- a/drivers/usb/cdns3/core.c
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> >  	struct device *dev = cdns->dev;
> >  	enum usb_dr_mode best_dr_mode;
> >  	enum usb_dr_mode dr_mode;
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	dr_mode = usb_get_dr_mode(dev);
> >  	cdns->role = USB_ROLE_NONE;
> > @@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> >  		goto err;
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> >  err:
> >  	cdns3_exit_roles(cdns);
> >  	return ret;
> > diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> > index 58089841ed52..4939a568d8a2 100644
> > --- a/drivers/usb/cdns3/drd.c
> > +++ b/drivers/usb/cdns3/drd.c
> > @@ -29,7 +29,6 @@
> >   */
> >  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> >  {
> > -	int ret = 0;
> >  	u32 reg;
> >  
> >  	switch (mode) {
> > @@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> >  		return -EINVAL;
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  int cdns3_get_id(struct cdns3 *cdns)
> > @@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns)
> >  int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> >  {
> >  	int ret, val;
> > -	u32 reg = OTGCMD_OTG_DIS;
> >  
> >  	/* switch OTG core */
> >  	if (on) {
> > -		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> > +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> > +		       &cdns->otg_regs->cmd);
> >  
> >  		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> >  		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> > @@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
> >   */
> >  static int cdns3_init_otg_mode(struct cdns3 *cdns)
> >  {
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	cdns3_otg_disable_irq(cdns);
> >  	/* clear all interrupts */
> > @@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
> >  		return ret;
> >  
> >  	cdns3_otg_enable_irq(cdns);
> > -	return ret;
> > +
> > +	return 0;
> >  }
> >  
> >  /**
> > @@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
> >   */
> >  int cdns3_drd_update_mode(struct cdns3 *cdns)
> >  {
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	switch (cdns->dr_mode) {
> >  	case USB_DR_MODE_PERIPHERAL:
> > @@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
> >  int cdns3_drd_init(struct cdns3 *cdns)
> >  {
> >  	void __iomem *regs;
> > -	int ret = 0;
> >  	u32 state;
> > +	int ret;
> >  
> >  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> >  	if (IS_ERR(regs))
> > @@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
> >  					cdns3_drd_thread_irq,
> >  					IRQF_SHARED,
> >  					dev_name(cdns->dev), cdns);
> > -
> >  	if (ret) {
> >  		dev_err(cdns->dev, "couldn't get otg_irq\n");
> >  		return ret;
> > @@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
> >  		return -ENODEV;
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> 
> Is this necessary?
> 

"return ret;" is not immediately clear like a "return 0;".  I review a
lot of return values so it's really important that the code is clear.
I'm looking for places which return both postives and negatives.  These
should always be documented but the majority are not.

Also another thing is that when people do:

	ret = some_function();
	if (!ret)
		return ret;

I review all of those because a bug that we sometimes see is that the
if statement is reversed and the ! should be removed.  A third thing is
that people sometimes do silly things with the last if statement in the
function.

	ret = one();
	if (ret)
		return ret;

	ret = two();
	if (ret)
		goto free_one;

	ret = three();
	if (!ret)
		return ret;   // <-- UGH!!!!

	free(two);
free_one:
	free(one);

Please look for this and tell people to not write code like that.  It's
always better to do failure handling instead of success handling.

regards,
dan carpenter
