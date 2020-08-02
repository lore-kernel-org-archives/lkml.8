Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EC3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6612520759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGrbhJWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHBOdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHBOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:33:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4EC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 07:33:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so31838308wrj.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9PypgIJJvqCkuITTRt+jUQNytQ0pFV6e29FYNAjaOQI=;
        b=qGrbhJWXHWHX18WDV/YUY5AHxTIU7XH/26nLWUu4CvISbkjD+qlu3aUGdtlEFxajNR
         S+0nrYR0fJ6fM9KTK+W024dHbJ6jECNtG/EGVZechrvd8FNg135fG3oPbGtX5qLIdQXE
         bS1vDIXDJUTOGPZWjoJ0fjCi45CWQFIgKRv2ApBhqk+1FZxKXLX2UeX9EdKa1oVPJiHl
         uobnJflc5WCVHBv201zj+MjCDK18WYeMm70w0ZgcihptLzGhn3bB0hS5qtXDpR0wtFXP
         R5yFDBbJH1O3lkg5ozs4A4ZRVIlMg8CmKDL62qlvXpTFfKhKsfIGvil42QZleVeivg4N
         7tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9PypgIJJvqCkuITTRt+jUQNytQ0pFV6e29FYNAjaOQI=;
        b=Tuj2iNPNR5aclTQsdJ2m58R92fo0T+gDCdcB4pNJCIMQTikUYF72k9pYIIH++arZH+
         RyTBXIdnA2qWDyBsYpiOce0OcfSMDd50DC+shdAF+uz9SQ0nUOWCvAXdHTKoM28XhvkV
         aWTsRApNJ9kIpFf5pzqvwbHR0vPwv55XmsB5+nhMLXrW/48Gdd/Ywp+m8aEnLR4RjlLw
         axlI0xF+bnM2UHKUtExX1bsM3fG5LiGZ335hmLcTypnJ1S9fDmQc4RPvcGonRj0XTQts
         /Ow8Xnzk607o1hvVsZcEFnaPP1/ivHeT4ogaTQpPPtC+ILIcQP1TZrosY/dMOFSLRiYG
         lqvg==
X-Gm-Message-State: AOAM533SvfJ0RVcZJry6Y8o+c6tftFCT9exAgOA3qaz8ChAJZ7E5jPFj
        L6q/bSLLI99rPGPhukw4iw==
X-Google-Smtp-Source: ABdhPJxkyEK4zEDcm+4mNuuJfAt3gDqkJE2+5x+uhhWY3j7yLicvVYKcHNXsNx3cJ/2grxK4gGR3yw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr11961751wrs.132.1596378828966;
        Sun, 02 Aug 2020 07:33:48 -0700 (PDT)
Received: from localhost.localdomain (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id v67sm21189228wma.46.2020.08.02.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:33:48 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules@gmail.com>
Date:   Sun, 2 Aug 2020 15:32:08 +0100 (BST)
X-X-Sender: jules@localhost
To:     Joe Perches <joe@perches.com>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Subject: Re: [PATCH 2/4] audit: uninitialize global variable audit_sig_sid
In-Reply-To: <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
Message-ID: <alpine.LFD.2.23.451.2008021356020.85114@localhost>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com> <20200801184603.310769-3-jbi.octave@gmail.com> <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Aug 2020, Joe Perches wrote:

> On Sat, 2020-08-01 at 19:46 +0100, Jules Irenge wrote:
> > Checkpatch tool reports an error at variable audit_sig_sid declaration
> []
> > diff --git a/kernel/audit.c b/kernel/audit.c
> []
> > @@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
> >  /* The identity of the user shutting down the audit system. */
> >  kuid_t		audit_sig_uid = INVALID_UID;
> >  pid_t		audit_sig_pid = -1;
> > -u32		audit_sig_sid = 0;
> > +u32		audit_sig_sid;
> 
> All of these are unused outside of audit.c and might as
> well be static and removed from the .h file.
> 

Thanks for reply, I will resend a second version with the recommendation,  
namely make the above static and remove them from the .h file.

Jules
