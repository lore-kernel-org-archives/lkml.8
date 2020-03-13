Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6958C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B98206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCMMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:54:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCMMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:54:10 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCjpF-0003Gu-EH; Fri, 13 Mar 2020 12:54:05 +0000
Date:   Fri, 13 Mar 2020 13:54:04 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>, ard.biesheuvel@linaro.org,
        ardb@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, hridya@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] binderfs: add stress test for binderfs binder devices
Message-ID: <20200313125404.fnsktenn5crufkxr@wittgenstein>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-2-christian.brauner@ubuntu.com>
 <202003121652.00BBA1D98@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003121652.00BBA1D98@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:53:17PM -0700, Kees Cook wrote:
> On Thu, Mar 12, 2020 at 02:15:30PM +0100, Christian Brauner wrote:
> > This adds a stress test that should hopefully help us catch regressions
> > for [1], [2], and [3].
> > 
> > [1]: 2669b8b0c798 ("binder: prevent UAF for binderfs devices")
> > [2]: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > [3]: 211b64e4b5b6 ("binderfs: use refcount for binder control devices too")
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Do you care about 80-char line limits? (Or does the selftest tree? There
> are a few in here...)

They should mostly all be calls to kselftest print functions. I usually
never wrap them in tests so it's easy to do:

git grep "Find me this error string"

which becames annoying when you wrap them. :)
