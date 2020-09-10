Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D5C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7302206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIJQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:45:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:42212 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgIJQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:43:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F08F4FA;
        Thu, 10 Sep 2020 16:42:51 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:42:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gross <agross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Joerg Reuter <jreuter@yaina.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jyri Sarha <jsarha@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/30] docs: fix documentation build parsing errors
Message-ID: <20200910104250.63281185@lwn.net>
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Sep 2020 16:10:31 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, there are several warnings/errors produced when building
> the documentation with "make htmldocs".
> 
> This series fixes almost all such errors. It is produced against
> linux-next, branch next-20200909.
> 
> Some of the patches here were already sent individually, but nobody
> picked them. So, I'm re-sending the full series.

I'd sure love to just apply the whole series and clean up a lot of this
stuff, but (1) I'm not entirely comfortable taking a few through
docs-next, and (2) some of them don't apply even if I catch up to -rc4.
So I'm going to pass through them individually and snag as many as I can...

Thanks,

jon
