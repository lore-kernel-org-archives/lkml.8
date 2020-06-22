Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE975C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912A42070E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpeSo4v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgFVNCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:02:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbgFVNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592830927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dszT79NgiiYmLxEO+86hQusN0IhnJ9bqFLtWEsnu6g8=;
        b=KpeSo4v1GOSlHcq5qwkj8e51mX8Oh+6dx2iPku8NhHhUJ/rEMlSfdCI5Dtk97+Evzx4XiQ
        H6UQ+zCLbkCop0uEHhWh4Xbyx4URWgYn07c153hGI+4XC1xILXEtanwYKgmt22qsjEvS/m
        3/A0cMLeulTRAnK6CW/mtdtugDasnAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318--SFhCDsyMk-SGmLQ_Bm6Zw-1; Mon, 22 Jun 2020 09:02:04 -0400
X-MC-Unique: -SFhCDsyMk-SGmLQ_Bm6Zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E7F019200D0;
        Mon, 22 Jun 2020 13:01:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB9B76FDD1;
        Mon, 22 Jun 2020 13:01:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Jun 2020 15:01:59 +0200 (CEST)
Date:   Mon, 22 Jun 2020 15:01:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622130155.GE6516@redhat.com>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
 <20200622113610.okzntx7jmnk6n7au@wittgenstein>
 <20200622120259.GD6516@redhat.com>
 <20200622122925.khcilncycuzb4xki@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622122925.khcilncycuzb4xki@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Christian Brauner wrote:
>
> It is a supported case however unlikely. I just tried to answer
> Dominique's specific question pointing out that even in that unlikely
> case sighand_struct is stable.

I too tried to say this, but apparently just added more confusion ;)

> Just as an fyi, CLONE_SIGHAND with CLONE_VM but without CLONE_THREAD is
> actually used quite a bit, e.g. in newlib, in stress-ng, and in criu.

OK,

> you'd want CLONE_VM which enforces
> CLONE_SIGHAND so that would be another use-case afaict.

Cough no ;) CLONE_SIGHAND requires CLONE_VM, not vice versa.

> > But this doesn't really matter. I mean, even if you race with another
> > thread doing exec/exit/whatever, current->sighand is stable. Unless, again,
> > current has already exited (called exit_notify()).

Oleg.

