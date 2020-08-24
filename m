Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A3EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97F82074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V1AEHDn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHXL2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:28:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHXL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:27:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OBKWRC003341;
        Mon, 24 Aug 2020 11:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=27ZxFSs8lL0sEkaFc/hN0oGCfd20QQ91QvBcgAUQqeo=;
 b=V1AEHDn/vZHb1Ge/eAg/XSHhVO44p6uYsOgsiCX3Eaqi3Caq4YI6WJQgSTIGLC4KS0uj
 U7rvF4oe465fdDH19OEW7jvftJkSmjX2duWDpFkFkt0qzrJN9DPXAXj56bi3LZf0YSy3
 U+TheXIC1LAzXISF/4Q+N11cYPohXtIHeDPc6xab8CvczRflrOoqu0WFQWyepnrF8LF+
 C9wqpPH88UMM4zNpD1ytLssID6sjtyHc4Z9Ox/+mr6xDMrwwXw9OUpKYYEB9wdsFfH8M
 HkWuOCS2eM0F0c4PX2Q01x87AK+HBq/dak1KMozoWpCMo1JBP7FnTIR41UAP3xqjMtvp cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333cshv189-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 11:27:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OBPD5E095470;
        Mon, 24 Aug 2020 11:27:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 333r9h24bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 11:27:20 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07OBRJIf026538;
        Mon, 24 Aug 2020 11:27:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 04:27:18 -0700
Date:   Mon, 24 Aug 2020 14:27:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Tomer Samara <tomersamara98@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v4 2/2] staging: android: Remove BUG from
 ion_system_heap.c
Message-ID: <20200824112708.GM5493@kadam>
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <a39407f84031eaeed5e65a7aab515a079edf5fcc.1598023524.git.tomersamara98@gmail.com>
 <3eba90dc-128f-49da-41a6-81494653d535@infradead.org>
 <20200824112457.GI1793@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824112457.GI1793@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:24:57PM +0300, Dan Carpenter wrote:
> On Fri, Aug 21, 2020 at 09:25:26AM -0700, Randy Dunlap wrote:
> > On 8/21/20 8:28 AM, Tomer Samara wrote:
> > > Remove BUG() from ion_sytem_heap.c
> > > 
> > > this fix the following checkpatch issue:
> > > Avoid crashing the kernel - try using WARN_ON &
> > > recovery code ratherthan BUG() or BUG_ON().
> > > 
> > > Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> > > ---
> > >  drivers/staging/android/ion/ion_system_heap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> > > index eac0632ab4e8..00d6154aec34 100644
> > > --- a/drivers/staging/android/ion/ion_system_heap.c
> > > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > > @@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
> > >  	for (i = 0; i < NUM_ORDERS; i++)
> > >  		if (order == orders[i])
> > >  			return i;
> > > -	BUG();
> > > +	/* This is impossible. */
> > >  	return -1;
> > >  }
> > 
> > Hi,
> > Please explain why this is impossible.
> > 
> > If some caller calls order_to_index(5), it will return -1, yes?
> > 
> 
> I was happy enough with the comment as-is given that I suggested it.
> But an alternative comment could be "/* This is impossible.
> We always pass valid values to this function. */

Another option is to just change the BUG_ON() to a WARN_ON().  I feel
like that communicates the same thing but makes checkpatch happy.

regards,
dan carpenter

