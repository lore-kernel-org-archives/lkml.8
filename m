Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C4C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C9421D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599803447;
	bh=Enf40G3nXdsYBSg35s1m+9KO6zvmUjLuwr15Qo8gH/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DYNHLHmWEeY3S/VaT/tBPRFl00xjB+JrEvBe3pUGQrl2Ey/m3j9R18PtSAJsO5IGZ
	 8QPmwioxJvZsrahJZBqVA5n67ucd7Fi4Ssdn7IQMLIY6DnWlT3xY/D5GcNNQ1vbpNg
	 20CFmkmTvzUQhxusirGtdymIHig6UBI4U4CFOxOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgIKFup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgIKFuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:50:44 -0400
Received: from coco.lan (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4D720735;
        Fri, 11 Sep 2020 05:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599803443;
        bh=Enf40G3nXdsYBSg35s1m+9KO6zvmUjLuwr15Qo8gH/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=unL7RCFy4TD+7swYitNSYZa54qUUl7zKv+FkgmH6UKCf82ab+HbhhtsFcp5OIcLxJ
         GColgJ3PzzUFBXDFptd9yXXlIdERrA2R1SUZfw+xN1g206NMdeHIWAbolD2zbg9oNe
         wtRzawShPbz1P2vsrqnhJES9Xp3g+o58yMwSq1Lg=
Date:   Fri, 11 Sep 2020 07:50:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
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
Message-ID: <20200911075035.326f91b3@coco.lan>
In-Reply-To: <20200910104250.63281185@lwn.net>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
        <20200910104250.63281185@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 Sep 2020 10:42:50 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed,  9 Sep 2020 16:10:31 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Currently, there are several warnings/errors produced when building
> > the documentation with "make htmldocs".
> > 
> > This series fixes almost all such errors. It is produced against
> > linux-next, branch next-20200909.
> > 
> > Some of the patches here were already sent individually, but nobody
> > picked them. So, I'm re-sending the full series.  
> 
> I'd sure love to just apply the whole series and clean up a lot of this
> stuff, but (1) I'm not entirely comfortable taking a few through
> docs-next, and (2) some of them don't apply even if I catch up to -rc4.
> So I'm going to pass through them individually and snag as many as I can...

Yeah. As I commented on the other series, as warnings reach upstream
from different trees, the only sane way to fix them is by using linux-next.

I'll keep rebase those. This way, if something ends being lost, we could
submit upstream by the end of the merge window.

Btw, as Andrii gently submitted a fix for the two remaining litmus doc
warnings, once everything gets merged, htmldocs should now produce
zero doc warnings.

I'll keep track on this. Hopefully, we can make 5.10 free of doc warnings,
and build robots can start warning about newly introduced ones.

Thanks,
Mauro
