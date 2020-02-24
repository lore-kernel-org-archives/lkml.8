Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA791C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DD72080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="IdepHxc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBXQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:26:31 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:34202 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:26:31 -0500
Received: by mail-pf1-f175.google.com with SMTP id i6so5622187pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2SYjv+WSIEyCd9YYi/1aawcHK0IZwr//QTPDichDN0=;
        b=IdepHxc6KkcyTk8ncFDkh5MXIGnZ/47N3RqgZ0sd8tuKKO9B8glAf9z2NKCH30gRkw
         ZqQCm+kELeNc7VR7B2uKTrTTHWazMdrBrp5gdRh8UK+mW9kOuwTpmWlyqID/wG3dxsZd
         wIL5kof/O4t5+x8WtjaMRFEw0F/udp/D43ah/OeAJFiRLwROHo7ODPGjS4E5Xtwcrku4
         bLueJRXUC8WAKCJkumnDTB3TnJBBlBYqh72xwUjMThPTGnhEpbZFbhRuyvHvgNszJzkv
         4QZhZIxxug87/FXM9arlkD8Axb9TNGd1vqXkDAowPf8rVr6jKFu/iAxFVww2Se95c+PO
         fM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2SYjv+WSIEyCd9YYi/1aawcHK0IZwr//QTPDichDN0=;
        b=fO38s8QPIfb7OkmrauJgbO7avtux66QETLsGtSjoruhSk5SdTWKBxU8/xYXPMW+LQ2
         UJs54z3Yv2BfKOEbnUQBX4dv8+QJ5hGuJsQAxQEzFVHPS8z2ioz5/tRyNCLI1oChh0ai
         hzgxVndQWmTfJmsySsggCCRCB6ZM1jZaBKUGSXowXEi82zDA91nuSIVSl6yzinh0j78J
         pObevvKTeRNGveZ5Ct1EbxV02RHDosFMVxQSpPEw41b4Dvg7Ti625rLXigGf2d4TMDGR
         Tj9qWaQ9gj/WIkElBJEPYHGFy+M0OXMN3NRGZZG39pilfl1NFoZVeDQ9+EA1kmEfStaV
         dy6A==
X-Gm-Message-State: APjAAAVRdpIojbMg7sr+2d9UeDJWquoSl0nSOYxUeovsYVrYp9J9+GSx
        V760uVGkN6/I15FuphMe7nYuVQ==
X-Google-Smtp-Source: APXvYqy2QAxSH9ctP0UdJ+fs8W2TMLmCqGTbi8rEuL1kdzOsyFTeq3R31E6PiTreju3ez36x0mrg0A==
X-Received: by 2002:a62:7b93:: with SMTP id w141mr53773935pfc.226.1582561587654;
        Mon, 24 Feb 2020 08:26:27 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id y3sm14025292pff.52.2020.02.24.08.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 08:26:27 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 24 Feb 2020 21:56:21 +0530
To:     Joe Perches <joe@perches.com>, jerome.pouiller@silabs.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wfx: data_tx.c: match parentheses alignment
Message-ID: <20200224162621.GA6611@kaaira-HP-Pavilion-Notebook>
References: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
 <8c458c189abb45fb3021f7882a40d28a24cc662d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c458c189abb45fb3021f7882a40d28a24cc662d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:13:32AM -0800, Joe Perches wrote:
> On Mon, 2020-02-24 at 01:02 +0530, Kaaira Gupta wrote:
> > Match next line with open parentheses by giving appropriate tabs.

Changed the first word to caps. Will keep this in mind from now on.
Thanks!

> 
> This patch is only for data_tx.c
> 
> There are many more parentheses that are not aligned
> in staging/wfx in other files.
> 
> Realistically, either change the subject to show
> that it's only for data_tx or do them all.

I have made the changes in the subject line and will submit a separate
patch with clean-ups in all the other files

> 
> (but not traces.h, those use a different style)
> 
> $ ./scripts/checkpatch.pl -f --terse --nosummary --types=parenthesis_alignment drivers/staging/wfx/*.[ch]
> drivers/staging/wfx/data_tx.c:303: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/data_tx.c:371: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/debug.c:35: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:35: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:45: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:55: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:72: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:97: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:106: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:118: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:133: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/key.c:147: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/queue.c:393: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/queue.c:408: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/queue.c:433: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/sta.c:123: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/sta.c:235: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/sta.c:291: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/sta.c:340: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/sta.c:717: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:156: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:194: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:206: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:211: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:234: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:257: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:265: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:271: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:278: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:296: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:302: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:307: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:313: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:324: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:329: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:334: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:351: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:362: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:416: CHECK: Alignment should match open parenthesis
> drivers/staging/wfx/traces.h:418: CHECK: Alignment should match open parenthesis
> 
> 
> 
> 
