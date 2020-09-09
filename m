Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6CC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B5206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgIIQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184ECC0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:28:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjW04ZHsz9sVk; Wed,  9 Sep 2020 23:27:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c27bc4e598daf3bbb225de7a1f5c52121cf1e279.1597235091.git.christophe.leroy@csgroup.eu>
References: <c27bc4e598daf3bbb225de7a1f5c52121cf1e279.1597235091.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-Id: <159965717070.808686.8733357237820602435.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 12:25:16 +0000 (UTC), Christophe Leroy wrote:
> At the time being, __put_user()/__get_user() and friends only use
> D-form addressing, with 0 offset. Ex:
> 
> 	lwz	reg1, 0(reg2)
> 
> Give the compiler the opportunity to use other adressing modes
> whenever possible, to get more optimised code.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
      https://git.kernel.org/powerpc/c/c20beffeec3cb6f6f52d9aef27f91a3f453a91f4
[2/2] powerpc/uaccess: Add pre-update addressing to __get_user_asm() and __put_user_asm()
      https://git.kernel.org/powerpc/c/2f279eeb68b8eda43a95255db701b4faaeedbe0f

cheers
