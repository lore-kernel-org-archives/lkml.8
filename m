Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAD320767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369968AbgDOMkV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:40:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898155AbgDOMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:39:23 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jOhJq-0004id-9r; Wed, 15 Apr 2020 12:39:06 +0000
Date:   Wed, 15 Apr 2020 14:39:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: add a check for the user struct size if
 CLONE_INTO_CGROUP is set
Message-ID: <20200415123905.subot6cdtvbie4ze@wittgenstein>
References: <20200412203123.GA5869@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412203123.GA5869@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:31:23PM +0200, Eugene Syromiatnikov wrote:
> Passing CLONE_INTO_CGROUP with an under-sized structure (that doesn't
> properly contain cgroup field) seems like garbage input, especially
> considering the fact that fd 0 is a valid descriptor.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
