Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40081C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B79E206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRLQRF1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEEQRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgEEQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:17:00 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:17:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so2865461qkm.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5NuZrtutcWX6qnizWL5DbGPbI5A1Ov0cQJXdgkL+iQ=;
        b=gRLQRF1d30dgNFpNe4sy1fA10iuVEpMohwdGbCkseyfqvXQFKkNHnQB6b9UN90amBB
         RPVXpW9JWrtqvgSJB5Bxv2H+F2TZkynI1f6nutKRrWshUxp8sXAoYXSG0G5lOG+WeXEy
         czhLvnOrOBf4KGhxcltUxu8+K5RYtidiIXs1Ig/a2Ie53P0bV1vs6Jmq69NMDlKXu6gy
         6404t+BzUxVciNz4CA94wuqHaFgV86yD0699HeV1guCc3zGTQvM+l10+/SiVzVAe2MYH
         JU2lEh5IAibzUR9m0TWr06djBGiqr3SBdaD77MRMQrNGw0ktBCP3WQLt78f8vmyp7fOq
         Iyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5NuZrtutcWX6qnizWL5DbGPbI5A1Ov0cQJXdgkL+iQ=;
        b=azDOSKBdWQ/Ok+HyiVhoJmvwMhcZqMdvl94yjFU9adxSJshB+mrF2KWQUz/kG1k3qK
         PGwO4O4xR6Gkb0301091FKUH7c4my9aEumvVcRd6ov2B2r4iV8ByHAmWQXCR5ICmTnML
         TXQeh9lyHufdlecJtM44/xdsO3QIYcNRjJMiPDS3spZzDDjtacd1ZFOrEMlkW47AKiq7
         NrpfC5kDuHMlBuW9qt5GFh9cAYzkriniZ3AcOT/cWK+Q+TJTchbtaXPnIEszzXsr7xZu
         /dYysqN2MvZL+iw8Kjwzw0YRGrxjM3p46J5Fy5mGIwonIO8OHkfbSX5Tx08tjdPn+5Ul
         ItJQ==
X-Gm-Message-State: AGi0PubR0t8DMpCm/xXAuDweeDAUDfvshR0eMPrkkvqZ40RlMc7SMCeQ
        IebSsItGGq0GfQpdXJ7JQ4hDjkHEljc=
X-Google-Smtp-Source: APiQypKZendWXoAgrqPKwefRESuKvR41K/hiVaZmPsjTlqc9jb2EB5l+DHcm5LmfRoMXtm98XJzPeA==
X-Received: by 2002:a37:82c1:: with SMTP id e184mr4451787qkd.186.1588695419963;
        Tue, 05 May 2020 09:16:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c26sm2108494qkm.98.2020.05.05.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:16:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACB03409A3; Tue,  5 May 2020 13:16:56 -0300 (-03)
Date:   Tue, 5 May 2020 13:16:56 -0300
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
        Tor Jeremiassen <tor@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf cs-etm: Move defined of traceid_list
Message-ID: <20200505161656.GX30487@kernel.org>
References: <20200505133642.4756-1-leo.yan@linaro.org>
 <CANLsYkwfiQjYCq1htu8ry02zhFXB5S9Hk0W39aRpUz+W3gUvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwfiQjYCq1htu8ry02zhFXB5S9Hk0W39aRpUz+W3gUvig@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 05, 2020 at 08:52:18AM -0600, Mathieu Poirier escreveu:
> On Tue, 5 May 2020 at 07:37, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The variable 'traceid_list' is defined in the header file cs-etm.h,
> > if multiple C files include cs-etm.h the compiler might complaint for
> > multiple definition of 'traceid_list'.
> >
> > To fix multiple definition error, move the definition of 'traceid_list'
> > into cs-etm.c.
> >
> > Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> > Reported-by: Thomas Backlund <tmb@mageia.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > Tested-by: Mike Leach <mike.leach@linaro.org>
> >  };
> >
> > -/* RB tree for quick conversion between traceID and metadata pointers */
> > -struct intlist *traceid_list;
> > -
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 


Thanks, applied,

- Arnaldo
