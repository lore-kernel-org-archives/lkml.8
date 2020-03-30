Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F3C2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A570420732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgC3ItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:49:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgC3ItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:49:02 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jIq6A-0004sb-Ks; Mon, 30 Mar 2020 08:48:46 +0000
Date:   Mon, 30 Mar 2020 10:48:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org,
        akpm@linux-foundation.org, guro@fb.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
Message-ID: <20200330084845.o5jdrg44pm3uiydh@wittgenstein>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:44:43AM +0800, Zhiqiang Liu wrote:
> 
> signal.c provides kill_proc_info, we can use it instead of kill_pid_info
> in kill_something_info func gracefully.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Thanks! I'll shorten the commit message header a little when picking
this up otherwise:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
