Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE82320812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgFIF3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:29:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgFIF24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzF05V9sz9sTG; Tue,  9 Jun 2020 15:28:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191002214854.GA114387@dtor-ws>
References: <20191002214854.GA114387@dtor-ws>
Subject: Re: [PATCH] macintosh/ams-input: switch to using input device polling mode
Message-Id: <159168032756.1381411.13851424138846895037.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 14:48:54 -0700, Dmitry Torokhov wrote:
> Now that instances of input_dev support polling mode natively,
> we no longer need to create input_polled_dev instance.

Applied to powerpc/next.

[1/1] macintosh/ams-input: switch to using input device polling mode
      https://git.kernel.org/powerpc/c/0c444d98efad89e2a189d1a5a188e0385edac647

cheers
