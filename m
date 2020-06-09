Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CB0207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgFIF2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgFIF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730CC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:28:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDm3Vqgz9sTN; Tue,  9 Jun 2020 15:28:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <154a99399317b096ac1f04827b9f8d7a9179ddc1.1586962586.git.christophe.leroy@c-s.fr>
References: <154a99399317b096ac1f04827b9f8d7a9179ddc1.1586962586.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/uaccess: Don't set KUAP by default on book3s/32
Message-Id: <159168035057.1381411.13783600194244224122.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 14:57:09 +0000 (UTC), Christophe Leroy wrote:
> On book3s/32, KUAP is an heavy process as it requires to
> determine which segments are impacted and unlock/lock
> each of them.
> 
> And since the implementation of user_access_begin/end, it
> is even worth for the time being because unlike __get_user(),
> user_access_begin doesn't make difference between read and write
> and unlocks access also for read allthought that's unneeded
> on book3s/32.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/uaccess: Don't set KUAP by default on book3s/32
      https://git.kernel.org/powerpc/c/547e687b2981a115814962506068873d24983af7

cheers
