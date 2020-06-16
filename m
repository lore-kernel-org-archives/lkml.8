Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BAC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="2Nn79lSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgFPO4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgFPO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:56:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CEC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:56:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so7088431pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnCI6Qv7+IJER3rGrCY9+2jrUGOKDGHwsURMSAUBf30=;
        b=2Nn79lSquFwICQJRqIMMK+xr/58INWQsjDmqryVedp1mYDiDc5HMvY4jcTvmMSb3F/
         qriu6QU67kEmAXX53ohM6mhtQonmUooyBbM/TamrrXJn8uXJggIukIfC9Fx3l9UjeHx/
         5p+IY9jdpnzEIE+PpYo6KzoHjY7Fmm4jcuuxkUF+8G+WDCnb1F0UC1jEuT+BML8EUdOs
         CXB0FqQQ4h9OEVrKvPxMBL0ewEc7aYAmeaJ6H7v7WE6jEUteFdgqnUuTV3UltIb+PzuD
         hE9afK0Xl6dGiYTI6af2ZTo5u3Ty4QZJP9dDTEPYlFDAwKTL/zKpxX9sd4k4W+M1zML+
         DcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnCI6Qv7+IJER3rGrCY9+2jrUGOKDGHwsURMSAUBf30=;
        b=nPjOXDDOSF5Ww0EaGJId2g1HEQKHOXWfauQi1MpVNm6mHsSMk2Hhf2Gd8b4+77RS+q
         uJbtiDAvrH95uo99VdeCUjMrqIXq2j9pYJGOaVPcGUBNvgqE9W0hXbsVEezhENz4pL3G
         luvEM7DUAYkD85w0DAb9E39pFGpd8tDF2ulsZM0tj2DvwvgP34lPNWaXgvn4xlbqZd4s
         ETDu6KMOxHwFSvwp+PzlhA5rXLHfWIxV9vRsnsG3Jm/SmHASTWE8c3de6lhYhpY3MQnz
         fQDoIRFkVvjOCXRPCF+tDs6eS8Zg6nm5lrwRVAxXZNLDJI9LRll1MUbU44ZLuF78G2Dp
         j3vw==
X-Gm-Message-State: AOAM531dwgW6foXWALLkl1mdplV6gbYOu5xHBmMhP6Mgas+D//nei8dU
        pdcobRePtHFHF3SiLjCcH87fOw==
X-Google-Smtp-Source: ABdhPJzwtMfg9WuanFes0lWc4seh4QKWDBNW6g8QcQTednFNS4EGBck4rz2WMETIblhdcQl0IKQHaQ==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr2352269pgm.172.1592319382567;
        Tue, 16 Jun 2020 07:56:22 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1007::16e])
        by smtp.gmail.com with ESMTPSA id p16sm14674640pgj.53.2020.06.16.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:56:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:56:14 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/11] selftests/seccomp: Rename user_trap_syscall()
 to user_notif_syscall()
Message-ID: <20200616145614.GI2893648@cisco>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616032524.460144-10-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:25:22PM -0700, Kees Cook wrote:
> The user_trap_syscall() helper creates a filter with
> SECCOMP_RET_USER_NOTIF. To avoid confusion with SECCOMP_RET_TRAP, rename
> the helper to user_notif_syscall().
> 
> Additionally fix a redundant "return" after XFAIL.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
