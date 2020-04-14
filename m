Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB07C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45C220732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cMRgeWs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439733AbgDNL4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:56:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439721AbgDNL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:56:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EBmdm8015076;
        Tue, 14 Apr 2020 11:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FHLWQFpis8qC0ost0GJpkrUK3UmvMx3TtVVZsTxGv0U=;
 b=cMRgeWs/2IvX4EUo3a/Lvzs1QAww3YiHVsDUnb7nUtGaieQCbJ+cDRNcPdqqreGvcvNY
 iy6hcoXcGVx0N7b8HdF6eaywud0fc1sPgEx66gnVpMlwy0qj74K2MEdbBiSm8szKsdBC
 tOUMKetRp4kjYsB0NoHy+Djxsj/nzGPQHSIn3NmAnkVuGeDYGaD/ORbZtyA1lFkn/I3u
 mcb4s7GhnSXvYe0U0qfdcYeY1jUuj/nzAo5rlQAotADyVg6Jv3nlumq7F/l1/cs6AEBh
 0M6blAkcalb8/xm1hs9JdKz7n7lJe4VxRQURar1Uh/ufc+JfMmpfXGVWrjbUgZLrlLH3 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30b5ar42t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 11:56:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EBliJY083552;
        Tue, 14 Apr 2020 11:56:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30bqchf63b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 11:56:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EBuCNt014251;
        Tue, 14 Apr 2020 11:56:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 04:56:12 -0700
Date:   Tue, 14 Apr 2020 14:56:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ivan Safonov <isaf21@yandex.ru>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] staging: rtl8188eu: Remove function rtw_modular64()
Message-ID: <20200414115604.GF1163@kadam>
References: <20190712071746.2474-5-nishkadg.linux@gmail.com>
 <66fb1e37-107e-54f4-4986-ca4e4bb99d2d@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fb1e37-107e-54f4-4986-ca4e4bb99d2d@yandex.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 mlxlogscore=822
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=890 suspectscore=18 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 04:34:08PM +0300, Ivan Safonov wrote:
> > Remove function rtw_modular64 as all it does is call do_div.
> 
> This is wrong. Macro do_div(x, y) change first argument x, but
> rtw_modular64(x, y) preserve it.
> 
> > +			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
> 
> rounddown(pmlmeext->TSFValue, pmlmeinfo->bcn_interval * 1024) - 1024
> is a better replacement for

You're absolutely correct that the patch is buggy, but I'm not sure that
rounddown() is what we want.

rtw_modular64() took the MOD of x.  So it should be something like:

	tsf = pmlmeext->TSFValue - (pmlmeext->TSFValue % (pmlmeinfo->bcn_interval * 1024)) - 1024; /* us */

But what the heck is that even???  If pmlmeinfo->bcn_interval is zero
or one then the subtraction ends up giving us a negative.

regards,
dan carpenter

