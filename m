Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BECD20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PePiNYYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgIAM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:26:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgIAMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:22:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081CA5br153272;
        Tue, 1 Sep 2020 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4SPWy5ATPpSePr/zk4oAtTkrcVNxHSrtJ3Rf//FVJEc=;
 b=PePiNYYykxRrf4D4pHwe7y0RH39jQ81g/Smilgzin4SUjwYdQNaI1QjazIfjhPao9v2P
 Z2HMmke7vg7C5UgjPrFu2BNIW6vS7jW0zYNrBNLTjiHCAYbrbdKswPgx4eveX7Z3GJJm
 DV71SFAwlKzvwP122XNOTEa0lxyPHzZDnjxLA24OBqMl7I0TtYJK9EkEFkBKT8tZHzhx
 lDtiFtzZdQgE2kYa1LD9idqv9ewPXgIwu5naRe8jan8BE7rBBylOG4zBs7RX9ILyzV0c
 oOj/jqRUO6RKKd0cAOo0MGU3qE+c2J/IeN4DIwqDxxt2EGE+VxwmWlAW3/xZbw0G9PvW /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eym3vfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 12:22:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081CB3Qp083536;
        Tue, 1 Sep 2020 12:22:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380srkans-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 12:22:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081CM449025089;
        Tue, 1 Sep 2020 12:22:04 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 05:22:03 -0700
Date:   Tue, 1 Sep 2020 15:21:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Fwd: Re: [PATCH] staging: gdm724x: gdm_tty: corrected macro by
 adding brackets
Message-ID: <20200901122158.GX8299@kadam>
References: <e11b8f5e-1b85-fe24-36d5-c8d707ce4e66@wp.pl>
 <15764d01-0602-18c6-e2b1-089b71a2061d@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15764d01-0602-18c6-e2b1-089b71a2061d@wp.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:06:23PM +0200, antoni.przybylik@wp.pl wrote:
> On 01.09.2020 13:08, Greg KH wrote:
> > On Tue, Sep 01, 2020 at 12:43:11PM +0200, antoniprzybylik wrote:
> > > Such macros are dangerous. Consider following example:
> > > 	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> > > 	GDM_TTY_READY(a + b)
> > > This macro will be expanded in such a way:
> > > 	(a + b && a + b->tty_dev && a + b->port.count)
> > > And it will lead to errors.
> > This is for a pointer, no one would ever do that :)
> 
> Nobody adds a pointer to a pointer, but it's common to add to it some value
> like that:
> 
> GDM_TTY_READY(myptr + 0x1000)

That won't compile at all, because it expands to "gdm + 0x1000->tty_dev".

> 
> > But, if you really worry about this, turn it into an inline function,
> > that way you get the proper typedef safety, which is what something like
> > this should really be, not a macro.
> 
> How to do it? Do I need to send another patch?

Yeah.  If you want.  Or you could just find something else to patch.
Probably just find a different bug and fix that instead...  If at first
you don't succeed, there are tons of other stuff to work on and maybe
you will succeed there.  ;)

regards,
dan carpenter

