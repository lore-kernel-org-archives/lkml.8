Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C93C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94DC21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eV7BHwUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCBNx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:53:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgCBNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:53:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022Dbu4C031928;
        Mon, 2 Mar 2020 13:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h1eCHVy/pMUEf9B7gboazc7d0KQ49jfH5mCfHZatf7Q=;
 b=eV7BHwUe7VvQ7Kt+hr/ElSezfJ0lEMwJtDSugJlmszKeqpUnnyZ8g9swTlyZVhGCXprC
 Ofr7NK0d4GtKEqJW7VxZJqE1SjK/wi5uiFtCF4sgDWCvYtHj0SedY633JzjUInixTIai
 jrTUq4dNMYeJwELiatworTsn31COSuFInJOwaP1PHjk7Pbwir5DjQIsm7R86b3CLdq+/
 /L9WEwO6jZjY9/2EhF7xE/MDeJEklbivyhGPRJ13k0MIFO+EYf/hPkb6WjX9CMa45kpI
 eYSuVFOYU0vMiV35noZnLMKMypRhdvIuGDqTOFjcbNs59umOh05i8to2GgOmmvYPyvun ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwqftev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 13:53:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022DqxgM100444;
        Mon, 2 Mar 2020 13:53:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yg1gv50s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 13:53:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 022Dr35C022595;
        Mon, 2 Mar 2020 13:53:03 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Mar 2020 05:53:03 -0800
Date:   Mon, 2 Mar 2020 16:52:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Joe Perches <joe@perches.com>,
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
Message-ID: <20200302135251.GA24372@kadam>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:25:51PM +0100, Alexander Potapenko wrote:
> On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > Certain copy_from_user() invocations in binder.c are known to
> > > unconditionally initialize locals before their first use, like e.g. in
> > > the following case:
> > []
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > []
> > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > >
> > >               case BC_TRANSACTION_SG:
> > >               case BC_REPLY_SG: {
> > > -                     struct binder_transaction_data_sg tr;
> > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > >
> > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> >
> > I fail to see any value in marking tr with __no_initialize
> > when it's immediately written to by copy_from_user.
> 
> This is being done exactly because it's immediately written to by copy_to_user()
> Clang is currently unable to figure out that copy_to_user() initializes memory.
                                                    ^^
typo s/to/from/.

It feels more useful to annotate copy_from_user().  That would be useful
for Smatch as well.

regards,
dan carpenter

