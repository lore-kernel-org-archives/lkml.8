Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7100BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48498206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="urOaUG/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgFWKN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:13:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:13:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NACiMw130688;
        Tue, 23 Jun 2020 10:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d9NXvGnI7jfjN88haka+dzhwSaM03rsBzPrLxMg67vo=;
 b=urOaUG/8b35647aq3cv3VPoLcXIJurE04jXs92+KMevJ2zgMbdC5SZuZWbjyzD1Kczxh
 BeZIFQohc2rLVOzlZsIgsZmiyWVxTg07pjIGT25NL/BTHy0hjkSWNIPKwNCx11JbcHI1
 Zi8+tByNVIaqcaftIov+ZD23cF+KdRbtSxE2uRdWaHOudKqkiJ8zlbmZDQ1XglqHjcLe
 v/zYeV2T0rJsvJj4EZ6gu0OxOpldrPvv+ZNQHWyRVTBE0nOFHqqs66Fb0lBhS+HGIFCf
 9SYoK21jU7GdNOJK9Z7jMh9J1fBAI4LFD2wBqYPydnE82Wrzp/Qn326NOxTuj4s1C7Dh bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31sebbmcc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 10:13:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NA48r3042169;
        Tue, 23 Jun 2020 10:13:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31sv7rjtfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 10:13:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05NADlVr025573;
        Tue, 23 Jun 2020 10:13:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 10:13:46 +0000
Date:   Tue, 23 Jun 2020 13:13:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com,
        christian@brauner.io, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: fix null deref of proc->context
Message-ID: <20200623101339.GJ4151@kadam>
References: <20200622200715.114382-1-tkjos@google.com>
 <20200623085021.GG4151@kadam>
 <20200623090404.xwuhdec6c7p4lnd2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090404.xwuhdec6c7p4lnd2@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=2 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:04:04AM +0200, Christian Brauner wrote:
> On Tue, Jun 23, 2020 at 11:50:21AM +0300, Dan Carpenter wrote:
> > On Mon, Jun 22, 2020 at 01:07:15PM -0700, Todd Kjos wrote:
> > > The binder driver makes the assumption proc->context pointer is invariant after
> > > initialization (as documented in the kerneldoc header for struct proc).
> > > However, in commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > > proc->context is set to NULL during binder_deferred_release().
> > > 
> > > Another proc was in the middle of setting up a transaction to the dying
> > > process and crashed on a NULL pointer deref on "context" which is a local
> > > set to &proc->context:
> > > 
> > >     new_ref->data.desc = (node == context->binder_context_mgr_node) ? 0 : 1;
> > > 
> > > Here's the stack:
> > > 
> > > [ 5237.855435] Call trace:
> > > [ 5237.855441] binder_get_ref_for_node_olocked+0x100/0x2ec
> > > [ 5237.855446] binder_inc_ref_for_node+0x140/0x280
> > > [ 5237.855451] binder_translate_binder+0x1d0/0x388
> > > [ 5237.855456] binder_transaction+0x2228/0x3730
> > > [ 5237.855461] binder_thread_write+0x640/0x25bc
> > > [ 5237.855466] binder_ioctl_write_read+0xb0/0x464
> > > [ 5237.855471] binder_ioctl+0x30c/0x96c
> > > [ 5237.855477] do_vfs_ioctl+0x3e0/0x700
> > > [ 5237.855482] __arm64_sys_ioctl+0x78/0xa4
> > > [ 5237.855488] el0_svc_common+0xb4/0x194
> > > [ 5237.855493] el0_svc_handler+0x74/0x98
> > > [ 5237.855497] el0_svc+0x8/0xc
> > > 
> > > The fix is to move the kfree of the binder_device to binder_free_proc()
> > > so the binder_device is freed when we know there are no references
> > > remaining on the binder_proc.
> > > 
> > > Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
> > > ---
> > >  drivers/android/binder.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index e47c8a4c83db..f50c5f182bb5 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -4686,8 +4686,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
> > >  
> > >  static void binder_free_proc(struct binder_proc *proc)
> > >  {
> > > +	struct binder_device *device;
> > > +
> > >  	BUG_ON(!list_empty(&proc->todo));
> > >  	BUG_ON(!list_empty(&proc->delivered_death));
> > > +	device = container_of(proc->context, struct binder_device, context);
> > > +	if (refcount_dec_and_test(&device->ref)) {
> > > +		kfree(proc->context->name);
> > > +		kfree(device);
> > > +	}
> > 
> > Where is device allocated?
> > 
> > It looks to me like they are allocated in init_binder_device().  So why
> > are calling misc_deregister?  And it looks like the kfree(proc->context->name);
> > is wrong as well because that's from the
> > "device_names = kstrdup(binder_devices_param, GFP_KERNEL);" in
> > binder_init().
> 
> This whole codepath is only hit for binderfs binder devices which are
> allocated in binderfs.c.

Ah.  I see that now.  Thanks!

regards,
dan carpenter

