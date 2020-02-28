Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05B246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgB1EWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:22:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57303 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730815AbgB1EWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:22:43 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01S4MOBC030696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 23:22:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ACC8C421A71; Thu, 27 Feb 2020 23:22:23 -0500 (EST)
Date:   Thu, 27 Feb 2020 23:22:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, catalin.marinas@arm.com,
        richard.henderson@linaro.org, will@kernel.org
Subject: Re: [PATCH 0/4] random/arm64: enable RANDOM_TRUST_CPU for arm64
Message-ID: <20200228042223.GD101220@mit.edu>
References: <20200210130015.17664-1-mark.rutland@arm.com>
 <20200226102422.GA21484@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226102422.GA21484@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:24:22AM +0000, Mark Rutland wrote:
> Ted, sorry to ping, but do you have any thoughts on this series?
> 
> I'm happy to rework this, or drop it if you think it's completely wrong,
> but if you're not too concerned it would be nice to be able to queue
> this soon.

Thanks, I've applied it to the random git tree.

						- Ted
