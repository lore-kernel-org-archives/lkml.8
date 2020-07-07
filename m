Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4652C2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGGNw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:52:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgGGNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:52:59 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jso1q-0000YF-ES; Tue, 07 Jul 2020 13:52:58 +0000
Date:   Tue, 7 Jul 2020 15:52:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        christian@brauner.io, shuah@kernel.org
Subject: Re: [PATCH v3 0/2] selftests: pidfd: prefer ksft_test_result_skip to
 ksft_exit_*
Message-ID: <20200707135257.u65ggyr2hcgjfgyh@wittgenstein>
References: <20200707101936.12052-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707101936.12052-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:19:34AM -0400, Paolo Bonzini wrote:
> Calling ksft_exit_* results in executing fewer tests than planned, which
> is wrong for ksft_exit_skip or suboptimal (because it results in a bail
> out) for ksft_exit_fail_msg.
> 
> Using ksft_test_result_skip instead skips only one test and lets the
> test plan proceed as promised by ksft_set_plan.
> 
> Paolo

Thanks for fixing this, Paolo!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Shuah, want me to take it or do you want to take it?
