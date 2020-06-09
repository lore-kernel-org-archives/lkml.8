Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A220820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgFIF2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgFIF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:44 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F62C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:28:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDn4DqFz9sTV; Tue,  9 Jun 2020 15:28:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1492bb150c1aaa53d99a604b49992e60ea20cd5f.1586962582.git.christophe.leroy@c-s.fr>
References: <1492bb150c1aaa53d99a604b49992e60ea20cd5f.1586962582.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/uaccess: Don't set KUEP by default on book3s/32
Message-Id: <159168035085.1381411.2229684027587649281.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:41 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 14:57:11 +0000 (UTC), Christophe Leroy wrote:
> On book3s/32, KUEP is an heavy process as it requires to
> set/unset the NX bit in each of the 12 user segments
> everytime the kernel is entered/exited from/to user space.
> 
> Don't select KUEP by default on book3s/32.

Applied to powerpc/next.

[1/1] powerpc/uaccess: Don't set KUEP by default on book3s/32
      https://git.kernel.org/powerpc/c/c3ba4dbbd1d05b49ec01efe098e0a78857d3ce22

cheers
