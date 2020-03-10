Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E452C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434EE2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fud0k6fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCJIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:38:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:38:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A8cKVK195066;
        Tue, 10 Mar 2020 08:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tUJKrsF3vbWXgwegWn6VLziFB7f7GcF7ssYLeZGED4g=;
 b=Fud0k6fTZuengJXrgQ3QV5RCMTCwwKbug5Wu4CuSpUZJbWo3UlDsJnBxWSVgGWVO0FSY
 0B7DBoSU9aIuJDviGMsnqAqxSTN4rrwJEXYdW8OOMFXo4OqzFoUJHSkEAWr2lER+EJNq
 umTgcYTSqtz7mnT24tzNjqF6gHp3D7zzXmhUkYoXFUaXyDpNhfkUWROBABUdOqvWjIHL
 wL+c4Ki9FXAcm7/NUBizicb0eut7f5GzjnMlKeeNQ8hpA7FCNKxyjmod9Qg4x2Gn3oXc
 n1inrCBb+0ZHaK4TVUC/n/c/WIlIFIWM33GXRmqdxSGm9r8rCrz28/AjHz/QmAqqFQgZ gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ym3jqkmh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 08:38:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A8avKa030700;
        Tue, 10 Mar 2020 08:38:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ymnb3d8q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 08:38:23 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02A8cMr6027094;
        Tue, 10 Mar 2020 08:38:22 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 01:38:21 -0700
Date:   Tue, 10 Mar 2020 11:38:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bfs: prevent underflow in bfs_find_entry()
Message-ID: <20200310083816.GA11561@kadam>
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
 <CAK+_RLm9=DER3fM-HwvM14CEzq8eZCwcTZyoA6tsYdhe1J03sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLm9=DER3fM-HwvM14CEzq8eZCwcTZyoA6tsYdhe1J03sA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:14:27AM +0000, Tigran Aivazian wrote:
> Hello Dan,
> 
> On Sat, 7 Mar 2020 at 06:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > -       int namelen = child->len;
> > +       unsigned int namelen = child->len;
> 
> Thank you, that is sensible, but have you actually verified that
> attempting a lookup of a filename longer than 2.2 billion bytes causes
> a problem? If that's the case, then your patch should be considered.
> If not, it would seem to be a waste of time to worry about something
> that cannot ever happen.

As the commit message says, this is just to silence a static checker
warning about checking for upper bounds but ignoring negatives.  The
check has found a number of problems in the past but it becomes less
useful if security reviewers have to sort through a bunch of false
positives.

regards,
dan carpenter

