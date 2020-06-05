Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56CC20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8v0ke1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFEI2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:28:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgFEI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591345683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYpkxStnfZ66XOBjO2aZKWdxDJeGvoZauHZhn66WLNE=;
        b=c8v0ke1rUbqeTnwGeU3h2YcbG4vVBFZNHv8CXZ8bnPplA2n2K152e1qBhy7WyyoytPsYrK
        ZPF0+E2+yeY2WsoaLpB8nX6lTgfkUrZhq0OoBq+LIV7Bo5dL3+Vl4zmX7QHV0bwHqTZUEZ
        zGwH/US09fEt1WfyTkk9srCWGxorKME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-to5q0RB2N2iPxRnn0gQmMg-1; Fri, 05 Jun 2020 04:27:59 -0400
X-MC-Unique: to5q0RB2N2iPxRnn0gQmMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B00B3801503;
        Fri,  5 Jun 2020 08:27:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8DA7B605;
        Fri,  5 Jun 2020 08:27:57 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0CA0318095FF;
        Fri,  5 Jun 2020 08:27:57 +0000 (UTC)
Date:   Fri, 5 Jun 2020 04:27:56 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        maco@android.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        lkft-triage@lists.linaro.org
Message-ID: <203212099.14886500.1591345676708.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
References: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
Subject: Re: LTP: syscalls: regression on mainline - ioctl_loop01 mknod07
 setns01
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.25, 10.4.195.24]
Thread-Topic: syscalls: regression on mainline - ioctl_loop01 mknod07 setns01
Thread-Index: h8xjKV6yHmjuKbXhHe5kzYYXrqSt/g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> Following three test cases reported as regression on Linux mainline kernel
> on x86_64, arm64, arm and i386
> 
>   ltp-syscalls-tests:
>     * ioctl_loop01
>     * mknod07

Test updated:
  https://github.com/linux-test-project/ltp/commit/13fcfa2d6bdd1fb71c4528b47170e8e8fb3a8a32

>     * setns01

commit 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
changed errno that is returned for regular file from EINVAL to EBADF.
This appears to fit more current man page, so I think we need to fix
test to accept both. (I'm looking into that)

