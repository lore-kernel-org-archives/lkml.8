Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21AEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE63206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loUAgXR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGQQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:34:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B937C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:34:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so6917167pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xw5eUX+MZ+bmcxQAKtDsuHQZ6yCgppTetd7vLvUz4qs=;
        b=loUAgXR6TgzfZfK9rM7DllDJbsul8EaR/UfI289vyS+nfis33rOQM5fYJEX4ITh0r4
         SHTPYHTZ+jQnNL7+LhJieY47o4O1Uu12pI9K8IBR0fE/TtrBKEooKJAa3hcMGZaQkLmu
         OJwNAKc/9pbRWZssGyri77mh15eAMwx+lAAtfg4Py9ifUZUKVCWyoTl6hthSbCB+kPy/
         142CVWThboigtcBKdn+ExxA/zZvOZw0CNNmt6FVjVliMK2uBDrgs0Nhc+H9bqRByfPE3
         c6+oeh5PPKnTiMX8JSHSakyUVC0nSi97uvWqs7aIMbGKdYtNodDXbX/R1Zb91J24DuMY
         2c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xw5eUX+MZ+bmcxQAKtDsuHQZ6yCgppTetd7vLvUz4qs=;
        b=qu6ivoV+2R4DmrkhlobQ7jVYX2iNG0ZRABGFCQxTnMTMqiVKGVSY1+u8aOuY26Dyuu
         dIF+z37lYRjSVSyg5iixdXtJWYyr/S4Xb71wdxZjIDsej3b3jZ7Lm10PvVj0RvDQ+dBU
         rGC1LEsMBGT4U5svEgyY3FlKMVKNFObco6IF8FkEKzaZqZ98pDURu14wubdZPwgc0soj
         mYkm1kkduFvktD3bXy91NxaI6+bxHpR5DUtcIgrQI3Pxx817saaCJC0wDP46SmtwI+hP
         P186+gCNUclI4wXBcBXlIFXPliD3kmtqPsCYasYCQbkorQguqTFQo67bOHWSpA36HBVT
         u4fQ==
X-Gm-Message-State: AOAM533rH6lCdgDC3eqR6sMgBjeSOaCpQrQCjOm2Vlba80vQw0JxZDE3
        BtHmSV/YJ5t0erav+mE5RglFn608
X-Google-Smtp-Source: ABdhPJxtVgIRwUHKaHolsuYZn26bW06h3oCTLbMEEc9ZNfz/0/VTsKIld8nkywxmECR2BbL7DR0HOA==
X-Received: by 2002:a63:e241:: with SMTP id y1mr9621578pgj.410.1595003677157;
        Fri, 17 Jul 2020 09:34:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm8128562pfq.205.2020.07.17.09.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 09:34:36 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:34:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix sleeping in invalid context during
 device link deletion
Message-ID: <20200717163434.GA119309@roeck-us.net>
References: <CGME20200716214531eucas1p2c173df09a6e00ef15dfae43ce8f1f9cd@eucas1p2.samsung.com>
 <20200716214523.2924704-1-saravanak@google.com>
 <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b37125c-96f5-c59c-f170-934d68c9bed1@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:13:04AM +0200, Marek Szyprowski wrote:
> Hi Saravana,
> 
> On 16.07.2020 23:45, Saravana Kannan wrote:
> > Marek and Guenter reported that commit 287905e68dd2 ("driver core:
> > Expose device link details in sysfs") caused sleeping/scheduling while
> > atomic warnings.
> >
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
> > 2 locks held by kworker/0:1/12:
> >    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> >    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
> > Preemption disabled at:
> > [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> > ----- 8< ----- SNIP
> > [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
> > [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
> > [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
> > [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
> > [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
> > [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xee921fb0 to 0xee921ff8)
> >
> > This was caused by the device link device being released in the context
> > of srcu_invoke_callbacks().  There is no need to wait till the RCU
> > callback to release the device link device.  So release the device
> > earlier and move the call_srcu() into the device release code. That way,
> > the memory will get freed only after the device is released AND the RCU
> > callback is called.
> >
> > Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1->v2:
> > - Better fix
> > - Changed subject
> > - v1 is this patch https://lore.kernel.org/lkml/20200716050846.2047110-1-saravanak@google.com/
> >
> > Marek and Guenter,
> >
> > I reproduced the original issue and tested this fix. Seems to work for
> > me. Can you confirm?
> 
> Confirmed, this one fixes the issue! :)
> 
Same here.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> > Thanks,
> > Saravana
> >
> >   drivers/base/core.c | 45 +++++++++++++++++++++++++++------------------
> >   1 file changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 5373ddd029f6..ec16b97d45ed 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -306,10 +306,34 @@ static struct attribute *devlink_attrs[] = {
> >   };
> >   ATTRIBUTE_GROUPS(devlink);
> >   
> > +static void device_link_free(struct device_link *link)
> > +{
> > +	while (refcount_dec_not_one(&link->rpm_active))
> > +		pm_runtime_put(link->supplier);
> > +
> > +	put_device(link->consumer);
> > +	put_device(link->supplier);
> > +	kfree(link);
> > +}
> > +
> > +#ifdef CONFIG_SRCU
> > +static void __device_link_free_srcu(struct rcu_head *rhead)
> > +{
> > +	device_link_free(container_of(rhead, struct device_link, rcu_head));
> > +}
> > +
> >   static void devlink_dev_release(struct device *dev)
> >   {
> > -	kfree(to_devlink(dev));
> > +	struct device_link *link = to_devlink(dev);
> > +
> > +	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> >   }
> > +#else
> > +static void devlink_dev_release(struct device *dev)
> > +{
> > +	device_link_free(to_devlink(dev));
> > +}
> > +#endif
> >   
> >   static struct class devlink_class = {
> >   	.name = "devlink",
> > @@ -730,22 +754,7 @@ static void device_link_add_missing_supplier_links(void)
> >   	mutex_unlock(&wfs_lock);
> >   }
> >   
> > -static void device_link_free(struct device_link *link)
> > -{
> > -	while (refcount_dec_not_one(&link->rpm_active))
> > -		pm_runtime_put(link->supplier);
> > -
> > -	put_device(link->consumer);
> > -	put_device(link->supplier);
> > -	device_unregister(&link->link_dev);
> > -}
> > -
> >   #ifdef CONFIG_SRCU
> > -static void __device_link_free_srcu(struct rcu_head *rhead)
> > -{
> > -	device_link_free(container_of(rhead, struct device_link, rcu_head));
> > -}
> > -
> >   static void __device_link_del(struct kref *kref)
> >   {
> >   	struct device_link *link = container_of(kref, struct device_link, kref);
> > @@ -758,7 +767,7 @@ static void __device_link_del(struct kref *kref)
> >   
> >   	list_del_rcu(&link->s_node);
> >   	list_del_rcu(&link->c_node);
> > -	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> > +	device_unregister(&link->link_dev);
> >   }
> >   #else /* !CONFIG_SRCU */
> >   static void __device_link_del(struct kref *kref)
> > @@ -773,7 +782,7 @@ static void __device_link_del(struct kref *kref)
> >   
> >   	list_del(&link->s_node);
> >   	list_del(&link->c_node);
> > -	device_link_free(link);
> > +	device_unregister(&link->link_dev);
> >   }
> >   #endif /* !CONFIG_SRCU */
> >   
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
