Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAF5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BE42075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHBNfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:35:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHBNfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMSz4l3Vz9sTK; Sun,  2 Aug 2020 23:34:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
In-Reply-To: <20200728155039.401445-1-cascardo@canonical.com>
References: <20200728155039.401445-1-cascardo@canonical.com>
Subject: Re: [PATCH] selftests/powerpc: return skip code for spectre_v2
Message-Id: <159637523453.42190.2614653860464292630.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:34:59 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 12:50:39 -0300, Thadeu Lima de Souza Cascardo wrote:
> When running under older versions of qemu of under newer versions with old
> machine types, some security features will not be reported to the guest.
> This will lead the guest OS to consider itself Vulnerable to spectre_v2.
> 
> So, spectre_v2 test fails in such cases when the host is mitigated and miss
> predictions cannot be detected as expected by the test.
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Return skip code for spectre_v2
      https://git.kernel.org/powerpc/c/f3054ffd71b5afd44832b2207e6e90267e1cd2d1

cheers
