Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2520678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596442406;
	bh=Z3NZjfOhC3W1xjPseRYdO9bMJt2sAUY1ZaWIH+d8s3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T80+sd4sPi2T0kxJhYTF8Ss6SZpOxzJLDOtY57I08NdVtzlpaS0K1Z8aVlc/Z0muS
	 6ymFrNCsWn2RYK+TkyFmA1I4fsK7reUZyll2uP5VjoAPo2aRU2Ew051SEQFmLjj4Ij
	 bYNkxanzmeJFXprZs9yEMmfr+Mvy1YapR04bM4YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHCINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCINZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BAC2065E;
        Mon,  3 Aug 2020 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596442404;
        bh=Z3NZjfOhC3W1xjPseRYdO9bMJt2sAUY1ZaWIH+d8s3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBQ3T5G6cVuW2XdvkWSc8FKh7JkTjwtGogcsfy4HRaitDqgYtSBLD3G5CyjW5nUlY
         rkib/sFZ6aeA7DqVjCX+odRY9EZrf0omTkTtF216Y0O/vwlywmTs9txgx1fWSY2d6o
         OsbZ3hrWfMn/QGwF4kS/tivppXPWerTqRiA9f260=
Date:   Mon, 3 Aug 2020 10:13:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1] kobject: Restore old behaviour of kobject_del(NULL)
Message-ID: <20200803081307.GB493272@kroah.com>
References: <20200803073859.43664-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803073859.43664-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:38:59AM +0300, Andy Shevchenko wrote:
> The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
> kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
> with NULL pointer. Restore the old behaviour.
> 
> Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/kobject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 3afb939f2a1c..f5f5273031d2 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -637,7 +637,7 @@ static void __kobject_del(struct kobject *kobj)
>   */
>  void kobject_del(struct kobject *kobj)
>  {
> -	struct kobject *parent = kobj->parent;
> +	struct kobject *parent = kobj ? kobj->parent : NULL;

I _HATE_ "? :" logic, and it obscures the logic in this function, just
add a simple:
	if (!kobj)
		return;

to this function please.

thanks,

greg k-h
