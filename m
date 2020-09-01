Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19902206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598963556;
	bh=GbYILGf9owsru9Trfmhg5VlNgGut8XnhrnMaJfvZAGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lz5stTyW5e7wL0NdvYiG4wWiUCRSBQ7F7E56lYUs4DeIcN7MJRly9EAH3dls7KLoO
	 wDXf5wqF4JKATqQ+j8wu7ZxcEjph6mh763nZXJ9kMHWbu6DdLehUThxxcARGJgwByB
	 Je9T+r2D4kBMF+o+MHrfH8AePZV+T4hq2qWr8yI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIAMc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:32:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46708 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgIAM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:26:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id u126so938734oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 05:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dvxr5aR9PGvFfLjPU7Vmkjhlr/vq/G2WfM5yrxufIcQ=;
        b=O7sZk15W+GdKQIt9qbrLErV0zAygJkDepPcTvRIttECz2q/J6pPsTp8HZvPqqZb/MC
         RGJivKFCS4EzALDDucRMKZ8Sa4A4Brhd7wh6hcXz2IJNCSDS3nzRreFZP1tZWz19Ebo2
         KKYFesucu/p1dSWsKK03teMX8r8bqFScVZa9488x5f2/Yg3m2jXZ9gZJIZVCF9ounBSZ
         UhcOOuKgDxyrhX63/6BiIFhZJDEZa7Qies0aJ6l3up+ryUTLo/+W06dpsEGnMjP1V+Mn
         xBwnC9E84lAiPLRp/REfmi+Ad1jKXtRnqdAqDf9oZCqA2B3h2MOqX1W3iHABDEGias/t
         9BNg==
X-Gm-Message-State: AOAM531jP1I/DoXTG2o6zcVc0ROLDbsuZ2y6nVUobcvQZepL3uUK1gxM
        hkuSGntm0Mf77oURT/V288hqjpHTRHfykoNojrDZZztC
X-Google-Smtp-Source: ABdhPJz1IcXHl/k7EkYAGnRxtGMLHMYDc3sWCuu7Ipd81gGgkCy3uVsr9exVZ9CBq80zdNNNYk6KJZY1uUbBctz+9cs=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr936643oiy.103.1598962653352;
 Tue, 01 Sep 2020 05:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200831221007.1506441-1-saravanak@google.com>
In-Reply-To: <20200831221007.1506441-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Sep 2020 14:17:22 +0200
Message-ID: <CAJZ5v0j+pwiaSbAuhyEYbzqda5f7HRf9+AmEC6hOTqLp5XcxmQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix device_pm_lock() locking for device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <dongas86@gmail.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 12:10 AM Saravana Kannan <saravanak@google.com> wrote:
>
> This commit fixes two issues:
>
> 1. The lockdep warning reported by Dong Aisheng <dongas86@gmail.com> [1].
>
> It is a warning about a cycle (dpm_list_mtx --> kn->active#3 --> fw_lock)
> that was introduced when device-link devices were added to expose device
> link information in sysfs.
>
> The patch that "introduced" this cycle can't be reverted because it's fixes
> a real SRCU issue and also ensures that the device-link device is deleted
> as soon as the device-link is deleted. This is important to avoid sysfs
> name collisions if the device-link is create again immediately (this can
> happen a lot with deferred probing).
>
> 2. device_link_drop_managed() is not grabbing device_pm_lock().
>
> When device_link_del() calls __device_link_del() (device_link_del() ->
> device_link_put_kref() kref_put() -> __device_link_del()) it grabs the
> device_pm_lock().
>
> However, when device_link_drop_managed() calls __device_link_del()
> (device_link_drop_managed() -> kref_put() -> __device_link_del()) it
> doesn't grab device_pm_lock(). There's nothing special about managed
> device-links that remove the need for grabbing device_pm_lock(). So, this
> patch makes sure device_pm_lock() is always held when deleting managed
> links.
>
> And thanks to Stephen Boyd for helping me understand the lockdep splat.
>
> Fixes: 843e600b8a2b ("driver core: Fix sleeping in invalid context during device link deletion")
> Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
> [1] - https://lore.kernel.org/lkml/CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com/
> Reported-by: Dong Aisheng <dongas86@gmail.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> Rafael,
>
> A bigger question I had is why we need to grab device_pm_lock() around
> device_link_del() in the first place. I understand the need to grab it
> during device_link_add() -- it's because we are checking the supplier is
> in the dpm_list and because we are reordering devices on the dpm_list.
>
> But during deletion, we don't need to do either one of those.  So, why
> do we even need to grab the device_pm_lock() in the first place.

It is not strictly necessary AFAICS.

> The device_links_write_lock() that we already grab before deleting a device
> link seems like it'd be sufficient. If you agree we don't need to grab
> device_pm_lock() during deletion, then I can change this patch to just
> delete that locking.

Yes, please.

Thanks!
