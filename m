Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497E20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgAPIDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:03:43 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48406 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPIDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:03:43 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1is07s-00BWUR-LH; Thu, 16 Jan 2020 09:03:36 +0100
Message-ID: <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     richard@nod.at, jdike@addtoit.com,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        aryabinin@virtuozzo.com, dvyukov@google.com,
        anton.ivanov@cambridgegreys.com
Date:   Thu, 16 Jan 2020 09:03:35 +0100
In-Reply-To: <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
References: <20200115182816.33892-1-trishalfonso@google.com>
         <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
         <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
         (sfid-20200115_235651_948442_0F0A0073) <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-16 at 08:57 +0100, Johannes Berg wrote:
> 
> And if I remember from looking at KASAN, some of the constructors there
> depended on initializing after the KASAN data structures were set up (or
> at least allocated)? It may be that you solved that by allocating the
> shadow so very early though.

Actually, no ... it's still after main(), and the constructors run
before.

So I _think_ with the CONFIG_CONSTRUCTORS revert, this will no longer
work (but happy to be proven wrong!), if so then I guess we do have to
find a way to initialize the KASAN things from another (somehow
earlier?) constructor ...

Or find a way to fix CONFIG_CONSTRUCTORS and not revert, but I looked at
it quite a bit and didn't.

johannes

