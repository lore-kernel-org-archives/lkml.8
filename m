Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F27C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F8920870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgCEHjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:39:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32889 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:39:20 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1j9l3v-0004nj-SJ
        for linux-kernel@vger.kernel.org; Thu, 05 Mar 2020 07:36:55 +0000
Received: by mail-wm1-f70.google.com with SMTP id q20so1240017wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9CtJGdUYHnqq8YEJwS2KCkXmlOvHXAh2xw0RAmgI+qI=;
        b=YyBp+mJ1pMhCPASBPDMhVQF34rTdgmmBTO/mnAJ4o4diM7ebTsji9LxvQ1fNsscSEO
         KhCFslVuvnGDTC5RediaV4ss57Xqhu2wxene7seEROICVkwx0YEAU5iluRI6uRUJGmQ7
         DjK284Z6NjOJ+/fOefrt1R3pQv0IE5f4NUsi+YLB7wa6RsXTlxsD2QE8TNvVPkUGRLJ4
         5RBasJQtdrlLOdOMYKzZnblaImBFZr8FOqZXw1+wnQ+EYTME54+i5zea6ZubohWH0CJ7
         WgZV4LlWo4IJHD+Q2R1Emxv1VY/H1pcdY9054vLsQWr73NtTgq+qLguvWLtFn5D0b+lU
         ELMg==
X-Gm-Message-State: ANhLgQ1CSKj3TpjtpdZqV1ojM1gPnIH4E2mxETESuZZc2rLVoQTbAWZk
        NryWZCoutZ/Iv5cht5czgZ/oAGY2Et1zkw8TYIpKUisgsJBn2lkyLFodkAmqKFxf8jvbiOysXvQ
        afJUZrFkyt6QLqJOLdR80CdX4ZZl+anKf/5SpEob+7g==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr8559537wrq.299.1583393815467;
        Wed, 04 Mar 2020 23:36:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs+cCHLCvfbTBArpsEG//QQD/rfqrcaua3+QIrsXxad2+Z6Ca4YiR4vehAh1+uayLJcx2rLBg==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr8559502wrq.299.1583393815072;
        Wed, 04 Mar 2020 23:36:55 -0800 (PST)
Received: from localhost (host96-127-dynamic.32-79-r.retail.telecomitalia.it. [79.32.127.96])
        by smtp.gmail.com with ESMTPSA id q12sm45991919wrg.71.2020.03.04.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 23:36:54 -0800 (PST)
Date:   Thu, 5 Mar 2020 08:36:53 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: free ptp clock properly
Message-ID: <20200305073653.GC267906@xps-13>
References: <20200304175350.GB267906@xps-13>
 <1830360600.13123996.1583352704368.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1830360600.13123996.1583352704368.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:11:44PM -0500, Vladis Dronov wrote:
> Hello, Andrea, all,
> 
> ----- Original Message -----
> > From: "Andrea Righi" <andrea.righi@canonical.com>
> > Subject: [PATCH] ptp: free ptp clock properly
> > 
> > There is a bug in ptp_clock_unregister() where ptp_clock_release() can
> > free up resources needed by posix_clock_unregister() to properly destroy
> > a related sysfs device.
> > 
> > Fix this by calling posix_clock_unregister() in ptp_clock_release().
> 
> Honestly, this does not seem right. The calls at PTP clock release are:
> 
> ptp_clock_unregister() -> posix_clock_unregister() -> cdev_device_del() ->
> -> ... bla ... -> ptp_clock_release()
> 
> So, it looks like with this patch both posix_clock_unregister() and
> ptp_clock_release() are not called at all. And it looks like the "fix" is
> not removing PTP clock's cdev, i.e. leaking it and related sysfs resources.

That's absolutely right, thanks for the clarification!

With my "fix" we don't see the the kernel oops anymore, but we're
leaking resources, so definitely not a valid fix.

> 
> I would guess that a kernel in question (5.3.0-40-generic) has the commit
> a33121e5487b but does not have the commit 75718584cb3c, which should be
> exactly fixing a docking station disconnect crash. Could you please,
> check this?

Unfortunately the kernel in question already has 75718584cb3c:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?h=hwe&id=c71b774732f997ef38ed7bd62e73891a01f2bbfe

It looks like there's something else that can free up too early the
resources required by posix_clock_unregister() to destroy the related
sysfs files.

Maybe what we really need to call from ptp_clock_release() is
pps_unregister_source()? Something like this:

From: Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] ptp: free ptp clock properly

There is a bug in ptp_clock_unregister() where ptp_clock_release() can
free up resources needed by posix_clock_unregister() to properly destroy
a related sysfs device.

Fix this by calling pps_unregister_source() in ptp_clock_release().

See also:
commit 75718584cb3c ("ptp: free ptp device pin descriptors properly").

BugLink: https://bugs.launchpad.net/bugs/1864754
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/ptp/ptp_clock.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ac1f2bf9e888..468286ef61ad 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -170,6 +170,9 @@ static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
+	/* Release the clock's resources. */
+	if (ptp->pps_source)
+		pps_unregister_source(ptp->pps_source);
 	ptp_cleanup_pin_groups(ptp);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
@@ -298,11 +301,6 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 		kthread_cancel_delayed_work_sync(&ptp->aux_work);
 		kthread_destroy_worker(ptp->kworker);
 	}
-
-	/* Release the clock's resources. */
-	if (ptp->pps_source)
-		pps_unregister_source(ptp->pps_source);
-
 	posix_clock_unregister(&ptp->clock);
 
 	return 0;
-- 
2.25.0
