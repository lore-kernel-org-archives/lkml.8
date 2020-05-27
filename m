Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B540C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7392084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTM+6mEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE0WZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:25:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF6C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:25:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so10695327plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UrkcoQuaLxiVuzBl3c4si8u/h9E04iSwoSUlbmdvB3U=;
        b=QTM+6mEyl1U48qZS1X2Bs8lxuZgLx+ESibA2I/fOxvQDiSNQqI4H0VA3xqtCwGguI3
         lcDHd+3mesCRilx6r7iekESHB1D1zENelwfNE8DOienMrPkaWD7arGBg/7RYhBidTWN9
         /I5r4WxrwcApK7jYAVa7kyVuTiyqDuExEdOx8frDficNZIaDeff47z023727GMDQQ4XZ
         SBoK1hqg/DVtuepGCxP1od7q9ZXbFVDafo1e+1x1sc/9B7kpJ7lkyS2rLaiNq6DXNnu3
         X6Vsz0sVw4feqiuNIjJBcQLg0v7JVsbiFBv8eJY21Ghg11QO2jH1sVKBUi54+cJmNfaA
         jQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UrkcoQuaLxiVuzBl3c4si8u/h9E04iSwoSUlbmdvB3U=;
        b=BN5sdvBRplAKiKPPxESxAuCCtHZRL7Xmeel3II88FDVlaXhdQUCfKEMsRDcB3RTtaC
         Gi8Xb5eInr30/amD0UI2Cq0xuVdYquvzaPAYnGdN/qvVW7NfqlELbpQdvLV0CIcxML9Q
         4JNyVeqQyeAXAPKSeRWLyvF+k1BfpjUIwzKWMRZsy00Mig7Ec7xjUEsowtasHDhrJvgU
         +W4JOm3YdgbCRQolnl00XlCEiyoMbVvK2nUXYXfAB7I5d4WK6zo0NDH3mld1UqaM5tph
         sjlmsmxMg42O6nbhIrPnP9c01JfSpjrJK0MntoKDCtkf8BxgLLItKE7ZwE7HPGTNfodE
         zEvg==
X-Gm-Message-State: AOAM530N/SLRGmrmRgLEl3Mql+KHZ3Us3FkvSGkgSrLt0TcI3o6tUH4p
        DpsMrHANDLraN8mBZOaYlI00K690
X-Google-Smtp-Source: ABdhPJwKO6/xesF0QepFW8GraPwYE6WRxfS/oPShFi1Rw02O/zpwWYCZwAQr/dPr0SzyUC6JM9Fo6g==
X-Received: by 2002:a17:90a:6ba4:: with SMTP id w33mr628283pjj.22.1590618317677;
        Wed, 27 May 2020 15:25:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7sm2957749pfb.1.2020.05.27.15.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 15:25:17 -0700 (PDT)
Date:   Wed, 27 May 2020 15:25:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
Message-ID: <20200527222515.GA89212@roeck-us.net>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200527075048.GD3284396@kuha.fi.intel.com>
 <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com>
 <2407984.idRd5kzSG0@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2407984.idRd5kzSG0@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:01:16AM +0200, Rafael J. Wysocki wrote:
> 
> So Guenter, can you please test the patch below to see if it still introduces
> the problems seen by you on ARM?
> 

arm64 and arm64be boot tests pass with the patch below. Some arm boot
tests fail, but I think that is due to some other problem with -next.
Hard to say for sure at this point because -next is pretty badly broken
overall. I'll need to run some bisects to see what is going on.

Guenter

> ---
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Subject: [PATCH] kobject: Make sure the parent does not get released before its children
> 
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
> 
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> [ rjw: Drop parent reference only when called __kobject_del() ]
> Signed-off-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  lib/kobject.c |   34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/lib/kobject.c
> ===================================================================
> --- linux-pm.orig/lib/kobject.c
> +++ linux-pm/lib/kobject.c
> @@ -599,14 +599,7 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(kobject_move);
>  
> -/**
> - * kobject_del() - Unlink kobject from hierarchy.
> - * @kobj: object.
> - *
> - * This is the function that should be called to delete an object
> - * successfully added via kobject_add().
> - */
> -void kobject_del(struct kobject *kobj)
> +static void __kobject_del(struct kobject *kobj)
>  {
>  	struct kernfs_node *sd;
>  	const struct kobj_type *ktype;
> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
>  
>  	kobj->state_in_sysfs = 0;
>  	kobj_kset_leave(kobj);
> -	kobject_put(kobj->parent);
>  	kobj->parent = NULL;
>  }
> +
> +/**
> + * kobject_del() - Unlink kobject from hierarchy.
> + * @kobj: object.
> + *
> + * This is the function that should be called to delete an object
> + * successfully added via kobject_add().
> + */
> +void kobject_del(struct kobject *kobj)
> +{
> +	struct kobject *parent = kobj->parent;
> +
> +	__kobject_del(kobj);
> +	kobject_put(parent);
> +}
>  EXPORT_SYMBOL(kobject_del);
>  
>  /**
> @@ -663,7 +670,9 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +	struct kobject *parent = kobj->parent;
>  	struct kobj_type *t = get_ktype(kobj);
> +	bool state_in_sysfs = kobj->state_in_sysfs;
>  	const char *name = kobj->name;
>  
>  	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
> @@ -681,10 +690,10 @@ static void kobject_cleanup(struct kobje
>  	}
>  
>  	/* remove from sysfs if the caller did not do it */
> -	if (kobj->state_in_sysfs) {
> +	if (state_in_sysfs) {
>  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>  			 kobject_name(kobj), kobj);
> -		kobject_del(kobj);
> +		__kobject_del(kobj);
>  	}
>  
>  	if (t && t->release) {
> @@ -698,6 +707,9 @@ static void kobject_cleanup(struct kobje
>  		pr_debug("kobject: '%s': free name\n", name);
>  		kfree_const(name);
>  	}
> +
> +	if (state_in_sysfs)
> +		kobject_put(parent);
>  }
>  
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 
> 
> 
