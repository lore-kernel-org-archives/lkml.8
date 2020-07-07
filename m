Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED020708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YH4zkoq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGGKWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:22:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgGGKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:22:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067AGfkq151520;
        Tue, 7 Jul 2020 10:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fXRcMvxUVPeqWOFyk/pdZZdlZf5LEo7EAEDg/Ih0ZN4=;
 b=YH4zkoq6AwJDe5YAADqYfNUAdxNe8S1UTSwnXCRvwazrOrlKkwSt4mlNIFV5DWTdkJQC
 ltk/I95FviY3NK9dzyQlGDjEvfhSgwt2gN4xYTdGL8RnRWxr08o+sZouHkWp5gJaNR6I
 oTbhC5GWeTpcF9pExE/Gp1Dpig8IAhT+v7jtamGTHjn7oJ/Gju0QhZCZuaUKqhJXvf9m
 J65tGWfXK8zs4Ew5vkTqid92Em5W3M8G6QKNjytp3jN6XA/ObcGg6Sp2zTkFwwmjkuHD
 owMh8CJ8SfqH6UJdD+lbAhVU3Amm0H53W0hkHiXXj2auVP09JdVK1AcvxXN1G7QnRj5r GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 322kv6bd9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 10:22:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067AJ3f1094555;
        Tue, 7 Jul 2020 10:22:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 324n4qx5ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 10:22:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 067AM5kH015577;
        Tue, 7 Jul 2020 10:22:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 03:22:05 -0700
Date:   Tue, 7 Jul 2020 13:21:57 +0300
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
Subject: Re: [PATCH 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and
 CDNS3_ID_HOST
Message-ID: <20200707102157.GW2571@kadam>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-7-pawell@cadence.com>
 <20200707063059.GE16073@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707063059.GE16073@b29397-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:30:50AM +0000, Peter Chen wrote:
> On 20-07-01 08:20:01, Pawel Laszczak wrote:
> > Patch adds 2 definitions that make it easier to understand the code.
> > 
> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > ---
> >  drivers/usb/cdns3/drd.c | 4 ++--
> >  drivers/usb/cdns3/drd.h | 3 +++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> > index 6fe092c828b3..8e7673da905e 100644
> > --- a/drivers/usb/cdns3/drd.c
> > +++ b/drivers/usb/cdns3/drd.c
> > @@ -87,7 +87,7 @@ bool cdns3_is_host(struct cdns3 *cdns)
> >  {
> >  	if (cdns->dr_mode == USB_DR_MODE_HOST)
> >  		return true;
> > -	else if (!cdns3_get_id(cdns))
> > +	else if (cdns3_get_id(cdns) == CDNS3_ID_HOST)
> >  		return true;
> >  
> >  	return false;
> > @@ -98,7 +98,7 @@ bool cdns3_is_device(struct cdns3 *cdns)
> >  	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
> >  		return true;
> >  	else if (cdns->dr_mode == USB_DR_MODE_OTG)
> > -		if (cdns3_get_id(cdns))
> > +		if (cdns3_get_id(cdns) == CDNS3_ID_PERIPHERAL)
> >  			return true;
> >  
> >  	return false;
> > diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> > index 35b6d459ee58..3889fead9df1 100644
> > --- a/drivers/usb/cdns3/drd.h
> > +++ b/drivers/usb/cdns3/drd.h
> > @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
> >  /* Only for CDNS3_CONTROLLER_V0 version */
> >  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> >  
> > +#define CDNS3_ID_PERIPHERAL		1
> > +#define CDNS3_ID_HOST			0
> > +
> 
> Instead of adding MACRO, I prefer adding comments at the code to indicate
> "ID=0" means it is host mode, "ID=1" means it is device mode.

The comment can only be in one place but the macro can be used
everywhere and is immediately readable.  I suggested this patch, but now
that I see it I'm still surprised how much I like it.

regards,
dan carpenter

