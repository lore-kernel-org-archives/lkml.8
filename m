Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C3A20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFVNEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:04:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37718 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgFVNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:04:08 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnM7G-0006pW-OC; Mon, 22 Jun 2020 13:04:02 +0000
Date:   Mon, 22 Jun 2020 15:04:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622130401.obopyfdqpdnc5ydt@wittgenstein>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
 <20200622113610.okzntx7jmnk6n7au@wittgenstein>
 <20200622120259.GD6516@redhat.com>
 <20200622122925.khcilncycuzb4xki@wittgenstein>
 <20200622130155.GE6516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622130155.GE6516@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:01:55PM +0200, Oleg Nesterov wrote:
> On 06/22, Christian Brauner wrote:
> >
> > It is a supported case however unlikely. I just tried to answer
> > Dominique's specific question pointing out that even in that unlikely
> > case sighand_struct is stable.
> 
> I too tried to say this, but apparently just added more confusion ;)
> 
> > Just as an fyi, CLONE_SIGHAND with CLONE_VM but without CLONE_THREAD is
> > actually used quite a bit, e.g. in newlib, in stress-ng, and in criu.
> 
> OK,
> 
> > you'd want CLONE_VM which enforces
> > CLONE_SIGHAND so that would be another use-case afaict.
> 
> Cough no ;) CLONE_SIGHAND requires CLONE_VM, not vice versa.

Oh, you're right. I was thinking of ksys_unshare() here. :)

	/*
	 * If unsharing vm, must also unshare signal handlers.
	 */
	if (unshare_flags & CLONE_VM)
		unshare_flags |= CLONE_SIGHAND;

Thanks!
Christian
