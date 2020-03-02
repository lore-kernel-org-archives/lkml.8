Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AAAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C560B246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3+4zIV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCBJO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:14:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44442 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgCBJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:14:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id a14so5108065pgb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbYJ7iAwXtw3qHGCUh262XjdCqjxTMtijdsn55mpS/k=;
        b=H3+4zIV9HKnladukMOmDiZ35Gh/ZxJkO+dJiwuEemnKI1pSCuFwnbo5kTUHGcNkzja
         iWny9D9Hw1lNAz+K343wDuZayoQ1sd66CbkM4/1TDx8z7vk1tSDrbZbKt0MmipVWuycZ
         lT35C/oqjozLxSUo1k3yLoaexycalsdjq8PHtm8/Eu5IOyv6yFRoIRbX0fjFnk/NfMk2
         2dzsiZoF8CjAVBsRhiYXGQW6KI6xN+IFKt1n6E6vdYHLAkZccDAcC4xIS3mh9Wj5eLQz
         lfykrvVM/Q6Sq3z1IN9LPtxfSw/OpW9J1fDy1+hTWM/+bEPDbpOwuqQCu+zPeDZ1Ei3Y
         FExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbYJ7iAwXtw3qHGCUh262XjdCqjxTMtijdsn55mpS/k=;
        b=UmGA7KnhaV769eVvfTLsv8sWLknG6zOxADzieCuJ1w9gKgxLtfea5HxXnlBk8bjnJQ
         pcJZTuDKVOQPcnu2alpt65DRzEKZvsWnLx8i8xRpiEYeQML4yKAegZmElfSGQHYB6f+s
         E0cB43v9Sv+AuHtWk2p9wkC8Tlotf7vjemy8nTmD65El81pEfwBcv2UfnShyV6tK7kax
         q2vAtu75XDjcHD3Mwq/YZ2FfkS0t1w9foMwt5R14oLWrSW9/lZspNWF6v0R2Z03j5Ok2
         b2wCmcC0hpEwPkN+xr6oPdFl6Dxr0V1LC5cUnDpLB+HXs/cXiLqV2wvQF77FxmyGJ5LK
         nntg==
X-Gm-Message-State: APjAAAXy1u5tqXxR3zqAqTPt84dgJxpeagI3oItq0BJn3M4Z3d/dDXU4
        FVdRtQgoUHs6As8g7T07mrFmNSL2
X-Google-Smtp-Source: APXvYqymaBUya5ytmvTtp0PboZnQb4U/lUzOvBaqSiMlQfHTNZhmekB97K4JS5Z9cfet6TyDGqGnrA==
X-Received: by 2002:a63:131f:: with SMTP id i31mr19023174pgl.101.1583140464141;
        Mon, 02 Mar 2020 01:14:24 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id z19sm3079764pfn.121.2020.03.02.01.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 01:14:23 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:14:20 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 0/3] OpenRISC clone3 support
Message-ID: <20200302091420.GJ7926@lianli.shorne-pla.net>
References: <20200301213851.8096-1-shorne@gmail.com>
 <20200302074411.p56ctghzllrijrqz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302074411.p56ctghzllrijrqz@wittgenstein>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 08:44:11AM +0100, Christian Brauner wrote:
> On Mon, Mar 02, 2020 at 06:38:48AM +0900, Stafford Horne wrote:
> > This series fixes the clone3 not implemented warnings I have been seeing
> > during recent builds.  It was a simple case of implementing copy_thread_tls
> > and turning on clone3 generic support.  Testing shows no issues.
> > 
> > Changes since v1:
> > 
> >  - Fix some comments pointed out in reviews
> >  - Add Acks to 2/3 and 3/3 from Christian Brauner
> 
> Excellent. I acked all individual patches now. But the whole series:
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks a lot for the review.

-Stafford
