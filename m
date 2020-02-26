Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC37C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435C924650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582704737;
	bh=HD4JJzN6Z5ogdBDJmkareqDDQZ1mEISl+bI1EQcysu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kz+dAkyEFAxvosPsqiyfCv3SodNBf2cLiSrQGavF+TlpZcP1WRFPhFXc8EW/HVRA3
	 o1GYlT5KGCLGlykLaafNwC/jEy+f/aQWIYjYKCvcG/dnPj0s8qCU/EdLQlZeHRHE6b
	 p5uESLQCwTOeg5MMELIz4WbDUqxC6ldH/dC84MsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBZIMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgBZIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:12:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC742084E;
        Wed, 26 Feb 2020 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704734;
        bh=HD4JJzN6Z5ogdBDJmkareqDDQZ1mEISl+bI1EQcysu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2FFrYzrog7zCSkIvxSZkC2a9VskGHr2Lbs9LbrBVh2Ot+CSftgUMaACNe3/KWbwPs
         ckA2ny2Vl22Ae2Ogff43DbnMgu1tT0f1yRo4dQS1KhBlD+eZWWmG8lh0ruREjNKtJ3
         VHeZsgGK7tZ1mVAmrR+Rwqm/M0z7y9aCaGXP1Qzs=
Date:   Wed, 26 Feb 2020 09:12:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        changbin.du@intel.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, toke@redhat.com, hawk@kernel.org
Subject: Re: [PATCH 1/2] quickstats, kernel sample collector
Message-ID: <20200226081211.GD22801@kroah.com>
References: <20200226023027.218365-1-lrizzo@google.com>
 <20200226023027.218365-2-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226023027.218365-2-lrizzo@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:30:26PM -0800, Luigi Rizzo wrote:
> +static int __init ks_init(void)
> +{
> +	ks_root = debugfs_create_dir("kstats", NULL);
> +	if (IS_ERR_OR_NULL(ks_root)) {
> +		pr_warn("kstats: cannot create debugfs root\n");
> +		return PTR_ERR(ks_root);
> +	}

Do not check debugfs_create_* calls as there is no need to.  Just take
the return value (if you care to use it again) and move on.

Also, the check you made here is incorrect :)

> +	ks_control_dentry = debugfs_create_file("_control", 0644, ks_root,
> +						NULL, &ks_file_ops);
> +	if (IS_ERR_OR_NULL(ks_control_dentry)) {
> +		pr_warn("kstats: cannot create kstats/_control\n");
> +		debugfs_remove_recursive(ks_root);
> +		return PTR_ERR(ks_control_dentry);
> +	}

Same here, just call debugfs_create_file and move on.

You do this same thing in other places too.

thanks,

greg k-h
