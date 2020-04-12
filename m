Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C97C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8965520673
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8965520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgDLVYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgDLVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:24:24 -0400
Received: from youngberry.canonical.com (youngberry.canonical.com [91.189.89.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F4C0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:24:24 -0700 (PDT)
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNk5X-0006Ne-8M; Sun, 12 Apr 2020 21:24:23 +0000
Date:   Sun, 12 Apr 2020 23:24:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: add build-time CLONE_ARGS_SIZE_VER* validity
 checks
Message-ID: <20200412212422.2a4endxiqfavf2cr@wittgenstein>
References: <20200412202658.GA31499@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412202658.GA31499@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:26:58PM +0200, Eugene Syromiatnikov wrote:
> CLONE_ARGS_SIZE_VER* macros are defined explicitly and not via
> the offsets of the relevant struct clone_args fields, which makes
> it rather error-prone, so it probably makes sense to add some
> compile-time checks for them (including the one that breaks
> on struct clone_args extension as a reminder to add a relevant
> size macro and a similar check).  Function copy_clone_args_from_user
> seems to be a good place for such checks.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Yeah, that seems like a good idea to me.
Thanks, will queue for rc2 unless I hear objections.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
