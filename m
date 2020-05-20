Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4A8207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgETLAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgETLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:00:15 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32CC061A0E;
        Wed, 20 May 2020 04:00:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqXX5Y9Xz9sV6; Wed, 20 May 2020 21:00:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
In-Reply-To: <20200502142642.18979-1-wsa@kernel.org>
References: <20200502142642.18979-1-wsa@kernel.org>
Subject: Re: [PATCH] powerpc/5200: update contact email
Message-Id: <158997212609.943180.3159699505964491700.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 21:00:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 May 2020 16:26:42 +0200, Wolfram Sang wrote:
> My 'pengutronix' address is defunct for years. Merge the entries and use
> the proper contact address.

Applied to powerpc/next.

[1/1] powerpc/5200: update contact email
      https://git.kernel.org/powerpc/c/ad0f522df1b2f4fe5d4ae6418e1ea216154a0662

cheers
