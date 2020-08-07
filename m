Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BBDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A932224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHGOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:06:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgHGOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:06:29 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k430o-0007uZ-AT; Fri, 07 Aug 2020 14:06:22 +0000
Date:   Fri, 7 Aug 2020 16:06:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Remove bogus warning on failed same-process
 transaction
Message-ID: <20200807140621.lrruiojgsax42hze@wittgenstein>
References: <20200806165359.2381483-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806165359.2381483-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:53:59PM +0200, Jann Horn wrote:
> While binder transactions with the same binder_proc as sender and recipient
> are forbidden, transactions with the same task_struct as sender and
> recipient are possible (even though currently there is a weird check in
> binder_transaction() that rejects them in the target==0 case).
> Therefore, task_struct identities can't be used to distinguish whether
> the caller is running in the context of the sender or the recipient.
> 
> Since I see no easy way to make this WARN_ON() useful and correct, let's
> just remove it.
> 
> Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
> Reported-by: syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian
