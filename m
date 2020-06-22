Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB52620706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFVIkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:40:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFVIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:40:01 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnHzj-0005fp-CR; Mon, 22 Jun 2020 08:39:59 +0000
Date:   Mon, 22 Jun 2020 10:39:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        liuzhiqiang26@huawei.com, joel@joelfernandes.org,
        paulmck@linux.vnet.ibm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622083957.lfgz4j2dop5ryiz6@wittgenstein>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200621135437.GA18092@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200621135437.GA18092@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 03:54:37PM +0200, Dominique Martinet wrote:
> Alexander Kapshuk wrote on Sun, Jun 21, 2020:
> > Export symbol __lock_task_sighand, so it is accessible from code compiled
> > as modules.
> > This fixes the following modpost error:
> > ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!
> 
> This can't fix something that's not broken (yet)! :)
> 
> I think it'd make more sense to describe why you think we should export
> it, rather than describe a precise usecase e.g. justify why this would
> be interesting to use from modules (e.g. it would help modules like 9p
> take a lock on the current signal handler safely and cleanly through
> lock_task_sighand())
> 
> 
> 
> Christian, Andrew - assuming this passes reviews from someone else I'm
> not sure how to go forward with this; it'd be simpler for me if I could
> take it in the 9p tree as I need it for the patch Alexander pointed at,
> but I'm not normally touching any file outside of the 9p tree.
> Is it better to let either of you take it normally (I think it'd be
> you?) and wait for that to land, or can I take it in my tree for the
> next merge window?

Hm, I don't think the patch is really needed though; see my other mail. :)

Christian
