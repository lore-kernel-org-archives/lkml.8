Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A96CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311C92075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="bQJO4WQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGJTK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:10:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212EBC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:10:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so4955261otq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=582VRj/VJwwb7prbjaxkyll1K6MbDwCmO8P8dCgcGHc=;
        b=bQJO4WQEKPqHrwFpYLeO5L7XONJQ3KUqs0G4Ot2TTtpdaEsCc4wVPrntpu7OuemSk0
         eDeaWvMLEAk2tUVuyf3Rz3BZpl8lAbohLHulkSzwRNdyLU9FIUOkBsOI9laZFBV4QGJg
         FydYJdwXx5lPNUTI8BIqUAF69MGUX1Kh9/Y1QedNWc+T20JRkwRRBgtCiELvllbU+1pV
         HR9K9myJtZFfLWOjikHe/xbXSKT7O7JaEDV+II3YBC8jvC0D4Xe1Wn3c9+ZkKK9LdScq
         lpbGdcl46l06TkTCOnWbJ2MwHW93Lsh9Lq7rFs0OFCsFM2nx6ez7JGfmr5cYASOJIHFp
         alsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=582VRj/VJwwb7prbjaxkyll1K6MbDwCmO8P8dCgcGHc=;
        b=EWNKmIGXKVDt4XJ1MzqWdOVZc3XrZ2vnLniWD6mHIx0eCsvPok7hZMkz09Y4BlNRuW
         ruTfw10osd6yKBJO95sVDTenioncnIKP1uRkj+/G/4gahHOhcQ8mG/UINrUCzb+5YLdY
         qUF+rSC6ebuf6OZB5N3CQZelaHNuy8Cs7ALazh4DbbdTIzPFRka2/RQDLJae6/yxproy
         lkhSykJfxsYtK3N9Vy/iv4//Ony6SAO9eW3UGWLcHwZgbU9fpAwp5BTkafZJ1ydkUYmg
         4d2UJu88tSle9dLfm/PCbXTkFR1DM9lYbbNTFrVa0ulXkiql0rtndfwSEW4VnQwbv7I/
         4oqA==
X-Gm-Message-State: AOAM531wQiS1CUKjZwufVP1Z3ARGedgT4RuQBElWbHrSnCGWRBmI+5au
        q8p/0xcBew+otaIjEz4rM5YhmzI4hto=
X-Google-Smtp-Source: ABdhPJzb+u+7Aqgas4ui2CrbiQNbmXbnsYxw/Uuj5nQ+Y2QdqO9tdn4UwufdGsTqafS9qKiCnDt9Tg==
X-Received: by 2002:a05:6830:1acb:: with SMTP id r11mr17224349otc.311.1594408225394;
        Fri, 10 Jul 2020 12:10:25 -0700 (PDT)
Received: from cisco ([2601:282:902:b340:dd70:9e19:5b5e:7f32])
        by smtp.gmail.com with ESMTPSA id t10sm1234852otd.78.2020.07.10.12.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:10:24 -0700 (PDT)
Date:   Fri, 10 Jul 2020 13:10:23 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp 1/2] selftests/seccomp: Add SKIPs for
 failed unshare()
Message-ID: <20200710191023.GA2700617@cisco>
References: <20200710185156.2437687-1-keescook@chromium.org>
 <20200710185156.2437687-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710185156.2437687-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:51:55AM -0700, Kees Cook wrote:
> Running the seccomp tests as a regular user shouldn't just fail tests
> that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
> detect those cases and SKIP them.

But if we unshare NEWUSER at the same time as NEWPID, shouldn't we
always be ns_capable(CAP_SYS_ADMIN)?

Tycho
