Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073CD207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgGKQB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:01:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54025 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:01:56 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1juHwn-00008h-RL; Sat, 11 Jul 2020 16:01:53 +0000
Date:   Sat, 11 Jul 2020 18:01:53 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, stable@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp v2 2/2] selftests/seccomp: Set NNP for
 TSYNC ESRCH flag test
Message-ID: <20200711160153.33bypdolunefsdlw@wittgenstein>
References: <20200710230107.2528890-1-keescook@chromium.org>
 <20200710230107.2528890-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710230107.2528890-3-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:01:07PM -0700, Kees Cook wrote:
> The TSYNC ESRCH flag test will fail for regular users because NNP was
> not set yet. Add NNP setting.
> 
> Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
