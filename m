Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4DC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F034E2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCMMz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:55:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:55:57 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCjqy-0003LU-TV; Fri, 13 Mar 2020 12:55:53 +0000
Date:   Fri, 13 Mar 2020 13:55:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     ard.biesheuvel@linaro.org, ardb@kernel.org, arve@android.com,
        gregkh@linuxfoundation.org, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, maco@android.com,
        naresh.kamboju@linaro.org, shuah@kernel.org, tkjos@android.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binderfs: port to new mount api
Message-ID: <20200313125551.hqhoick2vpnecvvx@wittgenstein>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200312212420.4032188-1-christian.brauner@ubuntu.com>
 <202003121655.486AB8E3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003121655.486AB8E3@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:56:11PM -0700, Kees Cook wrote:
> On Thu, Mar 12, 2020 at 10:24:20PM +0100, Christian Brauner wrote:
> > It's time we port binderfs to the new mount api. We can make use of the
> > new option parser, get nicer infrastructure and it will be easiert if we
> > ever add any new mount options.
> > 
> > This survives testing with the binderfs selftests:
> > 
> > for i in `seq 1 1000`; do ./binderfs_test; done
> > 
> > including the new stress tests I sent out for review today:
> > 
> >  [==========] Running 3 tests from 1 test cases.
> >  [ RUN      ] global.binderfs_stress
> >  [       OK ] global.binderfs_stress
> >  [ RUN      ] global.binderfs_test_privileged
> >  # Tests are not run as root. Skipping privileged tests
> >  [       OK ] global.binderfs_test_privileged
> 
> I would use the XFAIL harness infrastructure for these kinds of skips.

Hmyeah, will do.

Christian
