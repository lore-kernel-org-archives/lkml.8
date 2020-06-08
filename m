Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2031C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F7D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZsTvqRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgFHT5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:57:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgFHT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:57:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058JqQeF116937;
        Mon, 8 Jun 2020 19:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KDFjcWm9j7Q4j8SV51GuXqHkSHKfdCAlDd8oZwlZJUU=;
 b=gZsTvqRsizIQv9Mzkcr+RseyRpK3il3RRv9/9k8lzK42626sp7VrkybGtYtNxvzIccLq
 vipb0Wtj7op1BhCJjlIp9qFscdQlJE1EOU5jlis2mlbLzdN9r3LAY16jtlvhGlSF+qz7
 Vym2RtTw7hjIPKiauZMVc2hvuFPojcAsqfgHjHdau5LbihbjtnTNiuXAlSlUE28WDdX0
 Y+PMcNNSjD2qA2PJpL0FXqWOCDAq2tNmBKDJihAALw9zheMBlgbfl65iBpkIL0IWO1hM
 Xxq2HXeBZ11ImUTaCnEi3hcGvLtPhvV+Yw6ZEWbY/cClkQ+1MzusFDbCnuvMOkk2hST7 Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smrp1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 19:57:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058JsJHo017653;
        Mon, 8 Jun 2020 19:55:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn23sput-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 19:55:29 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058JtSb7014764;
        Mon, 8 Jun 2020 19:55:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 12:55:28 -0700
Date:   Mon, 8 Jun 2020 22:55:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        harshjain32@gmail.com, John Hubbard <jhubbard@nvidia.com>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        jane.pnx9@gmail.com
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200608195520.GB30374@kadam>
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
 <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
 <20200608191459.GZ30374@kadam>
 <CAFqt6zYqnRWYSKoZ2yAdcAK7WWa311Mmmc3Y3dm8CO9r79ZtYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYqnRWYSKoZ2yAdcAK7WWa311Mmmc3Y3dm8CO9r79ZtYg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=2
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:03:51AM +0530, Souptick Joarder wrote:
> On Tue, Jun 9, 2020 at 12:47 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Tue, Jun 09, 2020 at 12:31:42AM +0530, Souptick Joarder wrote:
> > > > > @@ -189,10 +192,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> > > > >       sg_free_table(&acd->sgt);
> > > > >    err_dma_map_sg:
> > > > >    err_alloc_sg_table:
> > > >
> > > > So now we end up with two unnecessary labels. Probably best to delete two of these
> > > > three and name the remaining one appropriately:
> > >
> > > Hmm, I thought about it. But later decided to wait for review comments
> > > on the same in v1.
> > > I will remove it now.
> >
> > These are all unrelated to pin_user_pages().  Please don't do it in the
> > same patch. Staging code is there because it's ugly...  If you don't
> > want to do unrelated changes to label names then you don't have to.
> 
> What I am planning is to put this changes in a series. One patch will take care
> of pin_user_pages() related changes, 2nd patch will take care of minor bug
> fix in error path + level correction and 3rd patch
> will take care of set_page_dirty() -> set_page_dirty_lock().


Always do bug fixes first.  Always do the easiest least controversial
after first.

Do the error handling bug first.  Change "rv" to int.  That's closely
related to the error handling.  Then set_page_dirty_lock().  Then the
conversion to pin_user_pages().

Then if you want you can do any unrelated clean ups and error label
renames as patch 4.

regards,
dan carpenter

