Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D777B20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgDGQRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:17:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55885 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgDGQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:17:10 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jLquR-00072E-P5; Tue, 07 Apr 2020 16:17:07 +0000
Date:   Tue, 7 Apr 2020 18:17:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/3] exec: Make unlocking exec_update_mutex explict
Message-ID: <20200407161706.l5zfgghwr3p4vz2c@wittgenstein>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
 <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:31:52PM -0500, Eric W. Biederman wrote:
> 
> With install_exec_creds updated to follow immediately after
> setup_new_exec, the failure of unshare_sighand is the only
> code path where exec_update_mutex is held but not explicitly
> unlocked.
> 
> Update that code path to explicitly unlock exec_update_mutex.
> 
> Remove the unlocking of exec_update_mutex from free_bprm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yeah, assuming that I didn't miss any subtleties just now.
By "explicit" I assume you mean not conditionally unlocked, i.e. we
don't need to check any condition in free_binprm().

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
