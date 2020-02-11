Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA7BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DE32082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzbKWW3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgBKMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:52:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBKMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:52:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BCmLIA066454;
        Tue, 11 Feb 2020 12:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=rE7Zehtx2dawIbSxjiRh/i2QUfiJy6O8qQf5qYOAZKU=;
 b=FzbKWW3j0hNkAg1OSDTaHVwrNKFE+bbUBegzGjank3BuIdYHX+ImNvTZ8Aoy0M6lkQuG
 RQ6sBOx77XAMYxJNc25nbcoWrPYbLMNzW2GxpJre+aWfmTdGe9WOACGri+ood0PoaUd4
 EUfF/dzrhkFK5VcZ6nQqipwP73J9yLLnJj7H/mYeOJ5KIbZZ0l4OnmoJU7vXTeQuezk2
 DSOSiXptbgj8Q+cb/wKgXjv28ZfNycXTmyBv60u5j3KUn9DiBDWVQLMW9fTN5AYiRs+B
 0M8bmuN72aHKHqqJj9npVFX5jQTIJpdhCMclPb6haEYE6jU/dBRCNS8FS2pHsvH/SJgj gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y2k8833h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 12:52:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BCkbwf002502;
        Tue, 11 Feb 2020 12:52:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y26q17y7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 12:52:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BCqeQO032556;
        Tue, 11 Feb 2020 12:52:40 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 04:52:40 -0800
Date:   Tue, 11 Feb 2020 15:52:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [[PATCH staging] 3/7] staging: wfx: fix init/remove vs IRQ race
Message-ID: <20200211125232.GF1778@kadam>
References: <cover.1581410026.git.mirq-linux@rere.qmqm.pl>
 <8f0c51acc3b98fc55d6960036daef7556445cd0a.1581410026.git.mirq-linux@rere.qmqm.pl>
 <20200211092354.GE1778@kadam>
 <20200211103931.GA26303@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200211103931.GA26303@qmqm.qmqm.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=8 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=8 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:39:31AM +0100, Michał Mirosław wrote:
> On Tue, Feb 11, 2020 at 12:23:54PM +0300, Dan Carpenter wrote:
> > On Tue, Feb 11, 2020 at 09:46:54AM +0100, Michał Mirosław wrote:
> > > @@ -234,8 +234,8 @@ static void wfx_sdio_remove(struct sdio_func *func)
> > >  	struct wfx_sdio_priv *bus = sdio_get_drvdata(func);
> > >  
> > >  	wfx_release(bus->core);
> > > -	wfx_free_common(bus->core);
> > >  	wfx_sdio_irq_unsubscribe(bus);
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > This calls sdio_release_host(func);
> > 
> > > +	wfx_free_common(bus->core);
> > >  	sdio_claim_host(func);
> > >  	sdio_disable_func(func);
> > >  	sdio_release_host(func);
> >         ^^^^^^^^^^^^^^^^^^^^^^^^
> > so is this a double free?
> 
> This is paired with sdio_claim_host() just above.

Ah...  I misread wfx_sdio_irq_unsubscribe(), sorry.

regards,
dan carpenter

