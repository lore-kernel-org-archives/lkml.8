Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DB92073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590762149;
	bh=RkeR650zfGCJsNZtNXgK+oXddYLTE3lOl6fFJdEccpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTjNM+nBMY15c3tp6C/8tlQKAH6vSLeRHyW2yfV0ajN6MRLap0gxCRrZE24bSGFkd
	 zY9M0f9n7pq5pRg+k9uHcQRIT6cewUJsGfmJuBOZH4qEgo7cSig21zNjxXqNT7HHRy
	 zaeE6rfWb1hGrvsmAf8LcYL3bQp3zAoOZz1HFBoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgE2OW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgE2OW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:22:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC2C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:22:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v15so1112179qvr.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ix+cUMA7VWZjUxxEomL14sVRUd4IGnLNVDxddc9pyY=;
        b=UuriEmIWzUei9Q184u5xLp+VbvH9zE9yQK0jj5aGlJzuLg/EOYNpNBpInPGYE5Hflz
         MhvxybMOjtNWUEn+xse42S9muRFk9vdNe2TjX1F9rOuSN6wgmKCwHX3m+SHUqHLNqvAL
         i/9KPavsEKW4WmLSwzvOILEeh2xRGoiLEjOAAwMWYKcppe5OHhP4TP8u6OYwV5UxmIbX
         fpEt3r/EHak6IxDIXgu/OxWn7AeVGznHex278j5cTGSk8QxqVdRaQOm7P7yaS/33ITQw
         cnAG+wdzUIDOgdTbSNt36Lvix9XG/zFsu34XHZrdi24owBS4hvJdnQRC+JXX9GngMIgI
         ybcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7ix+cUMA7VWZjUxxEomL14sVRUd4IGnLNVDxddc9pyY=;
        b=K4St7DYQqyaMoLplxRA/igynZK/VHPol4PFi0F73CZiohLKAKgp2qwxS1RxqCpZL/p
         UhRbj90aqE/fAz9BQnEQRo5fqfui2Uj2ND+A4ZDkQbCSA9AADg8vcTriDQPFZmYJdicR
         0vF8fZn9bvVuW7/3RQ/ur5ReREiqRq0GRYfTreSsIBiNKeH2LyC7Rg3/OSHZ3Em+kTuR
         w6hb/t7ZmZy5078o+nRsSUwxBSsnx3J7m/98rArPPXWoHNLcvb35lR+bko28qJ74Tphx
         u0c189k/JOWuQI9YqGbHhL2aNgWzb2673OJeFmz1rkUVGvIYV3//Av9PSxVEawZkcLZO
         y+4A==
X-Gm-Message-State: AOAM5306qBNyhncEMNEI6LsK5a15lZxihMx8tM0JeBXRAR0x10zIkMjd
        RDbaYKaqj3BDusvnxqwPwoNmWWoA
X-Google-Smtp-Source: ABdhPJx+owSyk7kcntgx5K1LMeSdd6aFvYEgKAOMhTizvrolJhs2wc0k7mKNAYCnNJ0XXB+XAjcZXg==
X-Received: by 2002:a0c:b60c:: with SMTP id f12mr8505901qve.244.1590762147189;
        Fri, 29 May 2020 07:22:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id y66sm7647947qka.24.2020.05.29.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:22:26 -0700 (PDT)
Date:   Fri, 29 May 2020 10:22:23 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/4] workqueue: void unneeded requeuing the pwq in
 rescuer thread
Message-ID: <20200529142223.GC3530656@mtj.duckdns.org>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529065903.1758-2-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:58:59AM +0000, Lai Jiangshan wrote:
> 008847f66c3 ("workqueue: allow rescuer thread to do more work.") made
> the rescuer worker requeue the pwq immediately if there may be more
> work items which need rescuing instead of waiting for the next mayday
> timer expiration.  Unfortunately, it checks only whether the pool needs
> help from rescuers, but it doesn't check whether the pwq has work items
> in the pool (the real reason that this rescuer can help for the pool).
> 
> The patch adds the check and void unneeded requeuing.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied to wq/for-5.8.

Thanks.

-- 
tejun
