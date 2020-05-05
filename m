Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE4C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A62206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmZ9jsa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgEELoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEELod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:44:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6253C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:44:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k81so1884971qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxpRMUz7r+VKuhTIBnKWdXDGSF1e7FCzSUJRToo9aic=;
        b=LmZ9jsa15+rCyfBkuB9neScByYMU8I0MKqFaveqAeBcz6j8BaCxz+Hbs7S/36mq4yO
         2kKGM/rqZLIymPlNfkdASGix0pm2vepMs/dlAiJQNmJzqDIFk3th93xGOoAQc9OPCYOa
         AHE8P1mGPs2VFBo/tL4KJH1WCABMY9QwY0Wx9S1JSCl2zoKnbuyZ827FnHEfWVyQsu6U
         cZsVaFERy0ha6DC9MFORkx6zHopf6lb61dCThPB0voH09gxm/PpPtygElSrH3AeMuY+S
         e1oQ/WFgzR5/tC8gJ5V5RW7rBEOgtvpt8MH/B+TTWGhv+Cv+dbnAG7LjQCsRQDF/5R96
         rdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxpRMUz7r+VKuhTIBnKWdXDGSF1e7FCzSUJRToo9aic=;
        b=BaWSUEiqQcv/UtFVrzzkbtb43koana6Xy48YI0ClO5QbeaZAC6J6mJafSGJBG636uG
         Pp2Bv2TZWzIb9nNwj9DWk5V3B2cgbXOhLQ6Rw2Pc+3pxA8FWMW1cCrov80PwOYd9HasC
         UkT04axp3b43wAmxKXX+n713m+9uk5sGRbqVCcG5+FguQBXD1rdR1XTVmBO1eXyxRFUV
         kqp80StEboH+Z0HUzuHK+eRf1Ybqipd+k0vwBW34QO0vf+NHb2lnx0EzSuQmLyz0NEPK
         wlv21Dd7ckd8xOHEUrFJi7QJRyw/IaMEZe+dq6RMBp6xAm54D5WI41ggAb5RyvGfBZ3k
         /T1w==
X-Gm-Message-State: AGi0PuZdHgOlYxObgxH4SxY2cVBas37UKpMYmr4i+coOUnUNHq2cL5Lb
        TWuPA7szxEiQjPENskQjNJk=
X-Google-Smtp-Source: APiQypLeOX56yyJZU3jEOl4pDrxNk7oD4sN90vfTtzYOtzfWPYjWtTMiEs4yeU1NCFBm81wUz/WA6A==
X-Received: by 2002:a37:c8b:: with SMTP id 133mr2929293qkm.418.1588679072996;
        Tue, 05 May 2020 04:44:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y4sm1470883qti.33.2020.05.05.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 04:44:32 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3539F409A3; Tue,  5 May 2020 08:44:30 -0300 (-03)
Date:   Tue, 5 May 2020 08:44:30 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH v2] perf: cs-etm: Update to build with latest opencsd
 version.
Message-ID: <20200505114430.GR30487@kernel.org>
References: <20200501143615.1180-1-mike.leach@linaro.org>
 <20200504170618.GA517@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504170618.GA517@xps15>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 04, 2020 at 11:06:18AM -0600, Mathieu Poirier escreveu:
> On Fri, May 01, 2020 at 03:36:15PM +0100, Mike Leach wrote:
> > OpenCSD version v0.14.0 adds in a new output element. This is represented
> > by a new value in the generic element type enum, which must be added to
> > the handling code in perf cs-etm-decoder to prevent build errors due to
> > build options on the perf project.
> > 
> > This element is not currently used by the perf decoder.
> > 
> > Perf build feature test updated to require a minimum of 0.14.0
> > 
> > Tested on Linux 5.7-rc3.
> > 
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied with both your and Leo's R-by tags.

- Arnaldo
