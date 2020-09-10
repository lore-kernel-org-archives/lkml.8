Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0149DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01E42076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599740038;
	bh=xfinSNc0Rk06xPtfQRWYjBtz2AOXa7N9s9orv6qw3pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaHLQgdhRZCxrP14fnUXpB2n/lJAQ9vvJqqogfPzro3xq7DJxnvogimW03EofMwZ/
	 zZsz4MIKBUghxFdJ8Wvy0Poo9X1PjQUGdVSq5HqArIfEocB1OJthckkAhYCsLh+hes
	 JIY+YMu5VNonagC9+vtjtUwai1LqAJhbUlekTwUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgIJMNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbgIJMKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:10:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B114F20672;
        Thu, 10 Sep 2020 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599739831;
        bh=xfinSNc0Rk06xPtfQRWYjBtz2AOXa7N9s9orv6qw3pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKkrDluJms68RxWu1I4Mws1SowUefhzGlVOZYbx3EJDJW0xbY306SgYwX3SYCBzmb
         yi9sSgVpJNMEC+VNAU38Zp5WGvOnRKwgEgbETYqdwh4E9W/5sBQrBXlEniwr0qDI0E
         7GH3ldV4ldY3voMsnIDqyU3g2uLCVKHjmXUeR8hQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE95A40D3D; Thu, 10 Sep 2020 09:10:29 -0300 (-03)
Date:   Thu, 10 Sep 2020 09:10:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] perf test: Introduce script for Arm CoreSight testing
Message-ID: <20200910121029.GC4018363@kernel.org>
References: <20200907130154.9601-1-leo.yan@linaro.org>
 <20200908191207.GB506647@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908191207.GB506647@xps15>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 08, 2020 at 01:12:07PM -0600, Mathieu Poirier escreveu:
> On Mon, Sep 07, 2020 at 09:01:54PM +0800, Leo Yan wrote:
> > We need a simple method to test Perf with Arm CoreSight drivers, this
> > could be used for smoke testing when new patch is coming for perf or
> > CoreSight drivers, and we also can use the test to confirm if the
> > CoreSight has been enabled successfully on new platforms.
> > 
> > This patch introduces the shell script test_arm_coresight.sh which is
> > under the 'pert test' framework.  This script provides three testing
> > scenarios:

<SNIP>

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
