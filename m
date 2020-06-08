Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51540C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1FC206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kv0khIjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFHTRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:17:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52624 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFHTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:17:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058J2iDn120653;
        Mon, 8 Jun 2020 19:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=s6wu2UeefCY6rpeMqQpmkFoglGHU1qGX46btjlzw2a0=;
 b=kv0khIjLq/m9wyDKgTnN7dSU+S7mw76ambZEQNwOMlXVw3pEw367/V79D3QO+FJL4vzD
 u0Ry3CjQmupQKnS+A3UQbxLfJVCryItpdKOAYXNnu/wieUSuvP7UThK7eO4GcltfJyOs
 ZIMez2xrY7lhf5bgzB8itVsIG0ekWp3z00F9Kr9+EC4Pg2vgJE6UXbuFNkejmwBzyUk3
 CNnB8+9myoeU5mGvDJkEYgkFpgmlNVdMgu9LDfNabcqhPkXsRtdxj9V0q7E7E/VpLtKe
 aeo+tr1CZIvbiBeaIUzUHmSCLgUrc5tKpfdbaNrEoEI1LPX0qBUe9OXpDe2gVX9x0VL3 YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31g33m0k2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 19:17:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058IwLvE140061;
        Mon, 8 Jun 2020 19:15:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn23p6yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 19:15:15 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058JFAxJ013602;
        Mon, 8 Jun 2020 19:15:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 12:15:09 -0700
Date:   Mon, 8 Jun 2020 22:14:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        harshjain32@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        jane.pnx9@gmail.com
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200608191459.GZ30374@kadam>
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
 <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 12:31:42AM +0530, Souptick Joarder wrote:
> > > @@ -189,10 +192,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> > >       sg_free_table(&acd->sgt);
> > >    err_dma_map_sg:
> > >    err_alloc_sg_table:
> >
> > So now we end up with two unnecessary labels. Probably best to delete two of these
> > three and name the remaining one appropriately:
> 
> Hmm, I thought about it. But later decided to wait for review comments
> on the same in v1.
> I will remove it now.

These are all unrelated to pin_user_pages().  Please don't do it in the
same patch. Staging code is there because it's ugly...  If you don't
want to do unrelated changes to label names then you don't have to.

Also on a personal note.  The label name should say what the goto does
just like a function name says what the function does.  "goto put_pages;"
Or "goto free_foo;".

Don't do this:

	p = kmalloc();
	if (!p)
		goto kmalloc_failed;

This is a come-from label name and does not provide any information that
is not there on the line above...

If you send a patch which uses your own personal style of label names,
I won't say anything about unless there is a bug.  But just know in your
heart that you are wrong and I have silently reviewed your patch to
drivers/staging.

regards,
dan carpenter
