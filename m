Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7652E20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETK77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:59:59 -0400
Received: from ozlabs.org ([203.11.71.1]:37389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgETK74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:59:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqXB3T3fz9sTC; Wed, 20 May 2020 20:59:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9fd0f9a827ebbeae64ad7a6f6c595d242f4dd5fc.1588747860.git.christophe.leroy@csgroup.eu>
References: <9fd0f9a827ebbeae64ad7a6f6c595d242f4dd5fc.1588747860.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Update email address in MAINTAINERS
Message-Id: <158997212671.943180.6637276774386432310.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 20:59:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 06:51:59 +0000 (UTC), Christophe Leroy wrote:
> Since 01 May 2020, our email adresses have changed to @csgroup.eu
> 
> Update MAINTAINERS accordingly.

Applied to powerpc/next.

[1/1] powerpc/8xx: Update email address in MAINTAINERS
      https://git.kernel.org/powerpc/c/679d74abc4e14cb369e46f080d90f4dc8c143e65

cheers
