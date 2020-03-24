Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CABAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7E42076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y9LrjfN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgCXNb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:31:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgCXNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:18:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ODEJG6117997;
        Tue, 24 Mar 2020 13:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MrZ138bhiXcJdJRI+ryfmNjwFfj6OQKyTqRsmXx8b3M=;
 b=y9LrjfN6LaK38tyOBzdQQyajEPc54XelAm8dn2sdmMElO+u+w6soTWRsOy/BitKZ9Muk
 ZJeEvKFirnwgUjE7R2zhj0K7uUtMC4cO2HiULO9ktUSEEZQVA6FeVFzHl4c5k4iQYgtL
 RR/wQy8IDCuyiRFyMuhVI0/WXiR4tYrm6wjyRWGU6039PVjfaeJwHudVeX30Au1qDOpq
 Nqh33P98lbxdMfHO/TOWPxJpk1R5hzFPtpP0SIqRNj5qin+orhB8m+0sJX2k4M7iqUks
 uxzMQEP8nRAOG/073p81PNlN3NBbf81hcvTcmSCKVKMAWjTww/U4BbjVsUVA0k7bEU8a KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yx8ac15xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:18:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ODDb8v087480;
        Tue, 24 Mar 2020 13:18:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yxw6mpsak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:18:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ODIcmT026864;
        Tue, 24 Mar 2020 13:18:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 06:18:38 -0700
Date:   Tue, 24 Mar 2020 16:18:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use ARRAY_SIZE instead of hardcoded
 size
Message-ID: <20200324131830.GD4672@kadam>
References: <20200318174015.7515-1-oscar.carter@gmx.com>
 <20200324095456.GA7693@jiffies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324095456.GA7693@jiffies>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:54:56AM +0000, Quentin Deslandes wrote:
> On 03/18/20 18:40:15, Oscar Carter wrote:
> > Use ARRAY_SIZE to replace the hardcoded size so we will never have a
> > mismatch.
> > 
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> > Changelog v1 -> v2
> > - Use ARRAY_SIZE(priv->cck_pwr_tbl) everywhere instead of introducing a new
> >   variable to hold its value.
> > 
> >  drivers/staging/vt6656/main_usb.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> > index 5e48b3ddb94c..acfcc11c3b61 100644
> > --- a/drivers/staging/vt6656/main_usb.c
> > +++ b/drivers/staging/vt6656/main_usb.c
> > @@ -23,6 +23,7 @@
> > 
> >  #include <linux/etherdevice.h>
> >  #include <linux/file.h>
> > +#include <linux/kernel.h>
> >  #include "device.h"
> >  #include "card.h"
> >  #include "baseband.h"
> > @@ -145,7 +146,7 @@ static int vnt_init_registers(struct vnt_private *priv)
> > 
> >  	init_cmd->init_class = DEVICE_INIT_COLD;
> >  	init_cmd->exist_sw_net_addr = priv->exist_sw_net_addr;
> > -	for (ii = 0; ii < 6; ii++)
> > +	for (ii = 0; ii < ARRAY_SIZE(init_cmd->sw_net_addr); ii++)
> >  		init_cmd->sw_net_addr[ii] = priv->current_net_addr[ii];
> >  	init_cmd->short_retry_limit = priv->short_retry_limit;
> >  	init_cmd->long_retry_limit = priv->long_retry_limit;
> > @@ -184,7 +185,7 @@ static int vnt_init_registers(struct vnt_private *priv)
> >  	priv->cck_pwr = priv->eeprom[EEP_OFS_PWR_CCK];
> >  	priv->ofdm_pwr_g = priv->eeprom[EEP_OFS_PWR_OFDMG];
> >  	/* load power table */
> > -	for (ii = 0; ii < 14; ii++) {
> > +	for (ii = 0; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
> >  		priv->cck_pwr_tbl[ii] =
> >  			priv->eeprom[ii + EEP_OFS_CCK_PWR_TBL];
> >  		if (priv->cck_pwr_tbl[ii] == 0)
> > @@ -200,7 +201,7 @@ static int vnt_init_registers(struct vnt_private *priv)
> >  	 * original zonetype is USA, but custom zonetype is Europe,
> >  	 * then need to recover 12, 13, 14 channels with 11 channel
> >  	 */
> > -	for (ii = 11; ii < 14; ii++) {
> > +	for (ii = 11; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
> >  		priv->cck_pwr_tbl[ii] = priv->cck_pwr_tbl[10];
> >  		priv->ofdm_pwr_tbl[ii] = priv->ofdm_pwr_tbl[10];
> >  	}
> > --
> > 2.20.1
> > 
> 
> Looks good, however are we certain priv->cck_pwr_tbl and
> priv->ofdm_pwr_tbl are always the same size?
> 
> What about using a macro for cck_pwr_tbl and ofdm_pwr_tbl size in
> device.h? Or a BUILD_BUG() if array's sizes are different? It could be
> helpful for future developers to say these arrays must be the same size.

That's a bit over engineering something which is pretty trivial.
Normally, we would just make the size a define instead of a magic number
14.

	u8 cck_pwr_tbl[14];
	u8 ofdm_pwr_tbl[14];
	u8 ofdm_a_pwr_tbl[42];

If people change the size in the future (unlikely) and it causes a bug
then they kind of deserve it because they need to ensure all the new
stuff is initialized, right?  If they change it and it results in a
buffer overflow then static checkers would complain.  If they changed it
and it resulted in uninitialized data being used then it would be zero
so that's okay.

So, yeah.  Ideally we would figure out a reason for the magic number 14
and create a define, but it's not strictly required.  This patch makes
the code better and doesn't introduce any problems that weren't already
there.

regards,
dan carpenter

