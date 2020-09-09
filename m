Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2312087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgIIQyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgIIP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC776C0617BB;
        Wed,  9 Sep 2020 06:39:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkQ2FV7z9sVM; Wed,  9 Sep 2020 23:37:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     oprofile-list@lists.sf.net, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Colin King <colin.king@canonical.com>,
        Robert Richter <rric@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200804174316.402425-1-colin.king@canonical.com>
References: <20200804174316.402425-1-colin.king@canonical.com>
Subject: Re: [PATCH] powerpc/oprofile: fix spelling mistake "contex" -> "context"
Message-Id: <159965824316.811679.2643424244803475085.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 18:43:16 +0100, Colin King wrote:
> There is a spelling mistake in a pr_debug message. Fix it.

Applied to powerpc/next.

[1/1] powerpc/oprofile: fix spelling mistake "contex" -> "context"
      https://git.kernel.org/powerpc/c/346427e668163e85cbbe14e4d9a2ddd49df1536c

cheers
