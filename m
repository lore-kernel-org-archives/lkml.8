Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BCAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37492070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQLMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:12:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:12:08 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jwOHc-0006o2-8g; Fri, 17 Jul 2020 11:12:04 +0000
Date:   Fri, 17 Jul 2020 13:12:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200717111203.f32s7r5vdvdn535u@wittgenstein>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:04:38PM +0200, Jiri Slaby wrote:
> On 17. 07. 20, 12:45, Jiri Slaby wrote:
> > Hi,
> > 
> > the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
> > and i586:
> 
> make check needs -jsomething, running is sequentially (-j1) doesn't
> trigger it. After the error, I cannot run anything. Like ps to find out
> what test caused the crash...
> 
> 5.7 was fine.

Can you try and reproduce with

commit e91b48162332480f5840902268108bb7fb7a44c7
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Tue Jun 30 17:32:54 2020 +0200

    task_work: teach task_work_add() to do signal_wake_up()

reverted, please?

Thanks!
Christian
