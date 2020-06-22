Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECDB206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFVIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:39:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59250 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFVIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:39:11 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnHys-0005eB-CX; Mon, 22 Jun 2020 08:39:06 +0000
Date:   Mon, 22 Jun 2020 10:39:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        asmadeus@codewreck.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622062527.GA6516@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:25:28AM +0200, Oleg Nesterov wrote:
> On 06/21, Alexander Kapshuk wrote:
> >
> > Export symbol __lock_task_sighand, so it is accessible from code compiled
> > as modules.
> > This fixes the following modpost error:
> > ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!
> >
> > Where __lock_task_sighand is called via lock_task_sighand in net/9p/client.c
> > See https://lore.kernel.org/lkml/20200620201456.14304-1-alexander.kapshuk@gmail.com/.
> 
> Why?
> 
> current->sighand is stable and can't go away. Unless "current" is exiting and
> has already passed exit_notify(). So I don't think net/9p needs this helper.

From what I can gather from the thread (cf. [1]) that is linked in the
commit message the main motivation for all of this is sparse not being
happy and not some bug. (Maybe I'm not seeing something though.)

The patch itself linked here doesn't seem to buy anything. I agree with
Oleg. Afaict, lock_task_sighand() would only be needed here if the task
wouldn't be current. So maybe it should just be dropped from the series.

[1]: https://lore.kernel.org/lkml/20200620201456.14304-1-alexander.kapshuk@gmail.com/

Christian
