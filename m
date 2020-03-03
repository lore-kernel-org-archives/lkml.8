Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F99C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355A20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R8PIDa7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgCCOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:16:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgCCOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:16:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023ECuOA151981;
        Tue, 3 Mar 2020 14:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sL7wL8dxkuL7cejD6WDz6jQpyi/urX1RqkURUcQ6Hm0=;
 b=R8PIDa7h7n73FWTMf4ULgW7d4Sxbf6/7FwEtaw59UMThqkUhwYppNzzxPXfmiC5SyN6a
 uVqcxpRlPB+hclsL3pvwuXciDb6wVt3PMYqogu2NwpZxotE+z54W2L8glgtgssj4j4WA
 VcW7tVubSwDwrHxM3QsdYc56BofoBt7fpjJ9SdTQPpyIOiTrGoO1cXbF8loz9t8Sw4Qb
 ZyZNIXTOen1NLDgCW801FJInvMWik/RJqtBQUE83uYCUeVkLkWrHTGTy8RrZzdAW+rCq
 WsIlrsJSlnzrRYQ286qXEWyi8ja9VXxRS1K9XFYb8aPwUw4GWMfisw8G0SJMM5yHcAQf ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yghn338ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 14:16:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023EEhdE084667;
        Tue, 3 Mar 2020 14:16:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yg1ekttds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 14:16:10 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023EG5OL002159;
        Tue, 3 Mar 2020 14:16:05 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 06:16:05 -0800
Date:   Tue, 3 Mar 2020 17:15:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Alexander Potapenko <glider@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
Message-ID: <20200303141554.GG4118@kadam>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
 <CAG_fn=U2T--j_uhyppqzFvMO3w3yUA529pQrCpbhYvqcfh9Z1w@mail.gmail.com>
 <20200303093832.GD24372@kadam>
 <58c1f1bf6b30bd5c39184cd9c09f25a9b9d67a68.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c1f1bf6b30bd5c39184cd9c09f25a9b9d67a68.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 05:56:51AM -0800, Joe Perches wrote:
> > The real fix is to initialize everything manually, the automated
> > initialization is a hardenning feature which many people will disable.
> > So I don't think the hardenning needs to be perfect, it needs to simple
> > and fast.
> 
> Dan, perhaps I don't understand you.
> Can you clarify what you mean?

I'm basically agreeing with you.

Even though copy_from_user() might only initialize part of the struct
we should just record that it initializes the struct without getting
bogged down in details.  The annotation should be simple.

If the automated system to initialize stack variables doesn't work 100%
that's okay because it's a supplement and not a replacement for manually
initializing stack variables.

regards,
dan carpenter

