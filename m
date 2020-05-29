Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F3BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A8207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3Sr0pZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgE2LyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:54:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2Lx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:53:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TBqG6r143006;
        Fri, 29 May 2020 11:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Btj8TnsnvVtswy+efh0SNsqef1MHWBON7iyK08stdgk=;
 b=S3Sr0pZeV8W2oX7blFHa/S4XEL7FNBaGuMflJ3Z47YrETokhco7nq4VJG4A+TGa56LTv
 NZ76rVb12QqJv7Tya7n9abEsUFqVHa2Vn0I1GA9MfCPEp2sWYjahHMOZriOMiJPvRbbV
 EUlMCoWkTG09clNRuwqMjmu2ZcxNA0FO7QI3hLNpT+32VDAnVBgFxXbI2pnbhmyrnmBv
 ro1O/icBMJVnOOk9GV3X640Ix/JRsr1Xo6L5LhRyz/sEesmn3lgh6slftDS4Vk3A7Bpz
 ZMEW8b3Vo1k1a4I1xfm0HI91k0NN+YVOckAAGatIGiVlva99wHqllWvtSRwwurespk5T bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 318xe1sxhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 11:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TBricA129324;
        Fri, 29 May 2020 11:53:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31a9ku4jqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 11:53:48 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TBrkXw030487;
        Fri, 29 May 2020 11:53:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 04:53:46 -0700
Date:   Fri, 29 May 2020 14:53:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rspringer@google.com,
        John Hubbard <jhubbard@nvidia.com>, toddpoynor@google.com
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
Message-ID: <20200529115330.GO30374@kadam>
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110408.GJ30374@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anyway, can you resend with the commit message re-written.  To me the
information that's most useful is from the lwn article:

   "In short, if pages are being pinned for access to the data
    contained within those pages, pin_user_pages() should be used. For
    cases where the intent is to manipulate the page structures
    corresponding to the pages rather than the data within them,
    get_user_pages() is the correct interface."

What are the runtime implications of this patch?  I'm still not clear on
that honestly.

When I'm reviewing patches, I also want to know how a bug was
introduced.  In this case the original author did everything correctly
but we've just added some new features (cleanups.  whatever).

I did skim the LWN article back in December but I don't remember the
details so I really want all this stuff re-stated in each commit
message.

regards,
dan carpenter

