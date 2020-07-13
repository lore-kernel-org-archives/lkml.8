Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25361C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30C32072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VK9um5eT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgGMNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:38:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53262 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgGMNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:38:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DDaqx3082343;
        Mon, 13 Jul 2020 13:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fUB2CdLSMqMXDoa0rGVYHlfcTSEUJl4Bs0VPYA4d0cs=;
 b=VK9um5eTZliMznZwPnRO+JHHFtIRSuSGXU9L77MxUelBXXaZHUKX9SbwVL1/wOl2Llia
 7tQzswh1pMWFIxPy7EGG5I4XdGA5tCxQ05xL7grGK1aYpJC9taOiinZ8QGUxu5n2o9LW
 fQiCbxIipFRt51heOyAXMUAaPixQF6oRzvUCtw9/ijpoBMn26aA9HmCpGm9zb+1h1ros
 Mdgeby5pvHKIPoxTvAwBZAkmgnXtKvbc2FnF+Ad88f5ciPtPAuusNJsGeUu61M8Rcja9
 lFk1E+uViOEwnzqro6yS6pz5b7/OGnqR3G3lJRUH+g+BQBkiHVWmu2x8nvpoG9iVR+Go sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3275cky1pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 13:38:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DDcYxl173248;
        Mon, 13 Jul 2020 13:38:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 327qbvkc0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 13:38:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DDcTNP026658;
        Mon, 13 Jul 2020 13:38:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 06:38:28 -0700
Date:   Mon, 13 Jul 2020 16:38:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Baidyanath Kundu <kundubaidya99@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] Staging: vc04_services: Fix code indent error
Message-ID: <20200713133821.GS2549@kadam>
References: <20200713072224.7648-1-kundubaidya99@gmail.com>
 <20200713133527.GB3122574@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713133527.GB3122574@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:35:27PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 13, 2020 at 12:52:24PM +0530, Baidyanath Kundu wrote:
> > This patch fixes the checkpatch.pl error:
> > 
> > ERROR: code indent should use tabs where possible
> > 
> > Signed-off-by: Baidyanath Kundu <kundubaidya99@gmail.com>
> > ---
> >  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > index a075cd63da7f..86c00b68f099 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > @@ -294,13 +294,13 @@ static void buffer_to_host_work_cb(struct work_struct *work)
> >  	/* queue the bulk submission */
> >  	vchiq_use_service(instance->service_handle);
> >  	ret = vchiq_bulk_receive(instance->service_handle,
> > -				 msg_context->u.bulk.buffer->buffer,
> > -			         /* Actual receive needs to be a multiple
> > -			          * of 4 bytes
> > -			          */
> > -			         (len + 3) & ~3,
> > -			         msg_context,
> > -			         VCHIQ_BULK_MODE_CALLBACK);
> > +				msg_context->u.bulk.buffer->buffer,
> > +				/* Actual receive needs to be a multiple
> > +				 * of 4 bytes
> > +				 */
> > +				(len + 3) & ~3,
> > +				msg_context,
> > +				VCHIQ_BULK_MODE_CALLBACK);
> 
> Close, you need one more space for these lines, right?
> 

Yeah.  The original has the space and looks correct.

regards,
dan carpenter

