Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B8C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95EC20780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587157440;
	bh=DhWNVWOqZx1xUnVY8JrrFO5mlaVF1QdWfVeryqtw7YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tQ0r7ncmyCw7DXJIx+4VW0i5PGysX7BNWW3DRAnDIP6BcaiiKzpbzZWPVgV5STOX9
	 LXXjjzvdAhqe+0a3N3RN+7iu/xLLiWKqX0MPykODItIQRyrSzBeZELAp50ZKkq1S7/
	 /7gonJl3yweVzlFz1EPoD2BqIgHPji4uAbavXKK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDQVD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgDQVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:03:59 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:03:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l60so3194204qtd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rayXkPMTvyEUYklaCAtMjFG9Chmi5MuVc5AOhvk8N7Q=;
        b=YPNeihe8y1OAZFazdpXRjIQpI3r+nJVGEdfGAbNf5sYUf0qUhr8nj2WB/cVcf2K7WO
         PgLDX2OHZG2G7hGYobOwJX8Q4Yg1dkOOaba8wIMc9vt+OQsPwFtiHBnb1hUyjGqX4LAe
         ++wecYiw1HIsF+Avn+rrzd1SxpNqmZbVtGjGQmXbtl5jX2QIGIs5mLCs5g4ZzThIJiVc
         1c6e5h2qpziyXZt5NqQdn8LlJfBNtHl1n843IUMSiEDrD3BY/tj7gOkhAnMl/cv+1SuW
         cZc3gfv8k5daaugxxpOZS1I0iOI9iYqUyKEtbvZkyzlx/WTz26IOiWdb/OZvYK6GwOMD
         EkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rayXkPMTvyEUYklaCAtMjFG9Chmi5MuVc5AOhvk8N7Q=;
        b=aN+FcAhEGiwStXamyAzDaQeSoqaQiq6BoHSqa1UcDOGHKdda0JKTbedTj/POS78qeh
         sCp2eD5Sha5X3b5ZevV5C96V91g4ktprjg/OIECVFnqaveaTuOj+72dFqiIwLjJlgGcp
         dnSPKME9k5FwJJYapx10uei7Bm8ub96uAGZ3xyDthMtP1ywFWV+qxidRwV/YYDEaIO5+
         uP2WnZQQPBwDS5qt8Pnop5LFQtpJ9lenRy5CXPMnheUx/Mr5Or2LN3m8LNrlnTDUCIRw
         kvxq5cW9eZgtHHKW+88EhscxEdBaSYyTLRHWzyfRj29p6aIEQmKLSuXbcCgxCdHKdZr1
         fJog==
X-Gm-Message-State: AGi0PuaOW7OwaQiMv+PdSkg2bwhCBMJHREBoexOimLBqoIDHD2TPFhPK
        +NuJbFKnMhUB2KCbzJ79TBPUKbk8pqw=
X-Google-Smtp-Source: APiQypKIVQ8hdaQ1vCuE867BQCUCmtBXe+Xpywn6R7+5hJxsZTFQRclqRPdZKOoS8F649kM4cVnHXg==
X-Received: by 2002:ac8:5645:: with SMTP id 5mr5021838qtt.151.1587157438243;
        Fri, 17 Apr 2020 14:03:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c4b0])
        by smtp.gmail.com with ESMTPSA id l24sm9684293qtp.8.2020.04.17.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:03:57 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:03:56 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [Poke: Tejun] Re: [RFC v3 03/11] drm/vblank: Add vblank works
Message-ID: <20200417210356.GD43469@mtj.thefacebook.com>
References: <20200417194145.36350-1-lyude@redhat.com>
 <20200417194145.36350-4-lyude@redhat.com>
 <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 17, 2020 at 04:16:28PM -0400, Lyude Paul wrote:
> Hey Tejun! So I ended up rewriting the drm_vblank_work stuff so that it used
> kthread_worker. Things seem to work alright now. But while we're doing just
> fine with vblank workers on nouveau, we're still having trouble meeting the
> time constraints needed for using vblank works for i915's needs. There still
> seems to be a considerable latency between when the irq handler for the vblank
> interrupts fires, and when the actual drm_vblank_work we scheduled starts:
...
> Tejun, do you have any idea if we might be able to further reduce the latency
> from the scheduler here? I believe we're already using pm_qos to at least
> reduce the latency between when the vblank interrupt fires and the interrupt
> handler starts, but that still isn't enough to fix the other latency issues
> apparently. We're also already setting the priority of kthread_worker->task to
> RT_FIFO as well.

I don't think the kernel can do much better than what you're seeing. I don't
know the time scale that you need - is it some tens of microseconds range? I'm
definitely not an expert on the subject but on generic kernels I don't think
you can achieve anything sub millisec with any kind of reliability.

If the timing is that tight and it's not a hot path, the right solution may be
polling for it rather than yielding the cpu and hoping to get scheduled in
time.

> Also, of course, let me know if you're not happy with the
> __kthread_queue_work() changes/kthread_worker usage in drm_vblank_work as well

Just glanced over it and I still wonder whether it needs to be that tightly
integrated, but we can look into that once we settle on whether this is the
right direction.

Thanks.

-- 
tejun
