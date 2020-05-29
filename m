Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF53CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3558206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Ndvs3U44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgE2Nah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgE2Nag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:30:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A8C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:30:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c75so1504293pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJ7zUBn/1EtMVIsuEd6ucJcE9PEXKgaIH6QKYb6De0c=;
        b=Ndvs3U44bxlo/W4/EUfnTls5W99+nDWMgdjffe3ksAJYIzmh8ocNi0ctdtvi7Hxv0H
         UcaazW8RhKLFeKSMydTBx4QeqzHIAyCG6vDORUxuowY7LsTTjwTEIJDKCTcxwMByf5hH
         gEIHVWsW33Ke5PRFG4S5Yeu5WyXUY9NQ3ebcdJhcmRjrsYjZ87UEerDRp7aZXVSwtGrZ
         bdhJMug1mURMwlMEEuL8fJOxLK6LpXMDOH18W/ut7cQgQFfjqIUjclylM//mKCbniTT5
         Ur67sxka9x931YfnnXPrwNAyMbYyxeNVKIfvzFYCeN4amLNCWHr0x7JtpdbDJeEU+Ufb
         HMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJ7zUBn/1EtMVIsuEd6ucJcE9PEXKgaIH6QKYb6De0c=;
        b=PBzyGkvrEufvO+WswZgmHe2y31fE9bYuHoONJAel0wAH83yX/BZcG77QJA11Hsw5Hr
         xdekcx+w+kFzz4SN2Kex0t4WvlOIeO4XtBI+B0X1mpaaNSBxMUqMGoqFC6anRCqngexJ
         yTg3SJSIG4yQ7xEZa/ZQAVSCS4vUXTGH5WCFcLvGqMpt9h9PDWinAixepT7xAgi8BuYz
         KWnQpvji2WfrNs5voqxfVMuNv6lAMrNBpilYQhgbfFK8Y5wpqAFVRnOlNw93TdgXo+ps
         WzvDJcxMTm2ybipkcNI2Q2rnEHNueY5qJ6hwN3zvbTNVhxiKRm3kZJcfMETJcsoc6NH5
         Y23A==
X-Gm-Message-State: AOAM533hngUclCWxjNI6GgOPN5Z6UyqBVRyktVR6c5t+ZlzX1wwjMqYA
        hN3gEiYuz5AUrQ1PIkVEHoaqJg==
X-Google-Smtp-Source: ABdhPJwYVn+PWn8rGaeYNdC2SlEzfNWzSoCvGSixBPLDNv8MOMfV1sO+viLpCVOJrMxaSgUBOYKhTA==
X-Received: by 2002:a63:9d81:: with SMTP id i123mr8299732pgd.176.1590759035541;
        Fri, 29 May 2020 06:30:35 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1002::476])
        by smtp.gmail.com with ESMTPSA id d2sm7593246pfc.7.2020.05.29.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:30:34 -0700 (PDT)
Date:   Fri, 29 May 2020 07:30:40 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     keescook@chromium.org, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com
Subject: Re: [PATCH v2 0/3]  Add seccomp notifier ioctl that enables adding
 fds
Message-ID: <20200529133040.GE429721@cisco>
References: <20200528110858.3265-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110858.3265-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:08:55AM -0700, Sargun Dhillon wrote:
> This adds the capability for seccomp notifier listeners to add file
> descriptors

Modulo the changes suggested by others, you can consider this series:

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
