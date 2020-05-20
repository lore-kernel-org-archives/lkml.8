Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6C9204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e502Vz9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETLni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:43:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89623C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:43:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so1147495pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5rgVD30/IvjSSuSq2BSdiB5zKP2Ip7hue7FGx+nhtU=;
        b=e502Vz9cApfCA3oRCURdTu8x1OsrxXvqsP7otu5jGIcxiApypnlpIfS15TB9MF2EL0
         MFx9lATKWky2WReWHg+ZW46dhOeVFDYzDM/2fVp4hncMkmBVyA6RttzbkJ8PLbSarg78
         dTzdX0ECJUA3w90FRm8LmVeBGJUWzhraWd03PUHGEv7gTWhJJXVA6bJTjZcrLy9Wcbpc
         nHiMD+n/yI2o9QZhhbDFMLFuvz6KMnMXWaJO8dfXBcSIMvJ9Y6Zj48RnJMmoIAswsGn7
         j+rjXOUAIKbW9FijRZ6u8yYnpT+BrcvoDx7/bFpkFDGbYixKPgDNgur9sCsInq8snTi+
         LaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5rgVD30/IvjSSuSq2BSdiB5zKP2Ip7hue7FGx+nhtU=;
        b=RXhU5Pm4N22BwsabY4HqjhRmuZ02L+SWQOroR9qT+DBA5qLL7BpZ53VjYGEdc5YZe8
         57SD+YKK+VvH05GNONGdmgJ2Mg0xL6PEV60TrUeEZnZL2xS6odvWgyIVKfz34X1DRN2G
         PPsP1UNV+pEDptNoQ/NPCELjERIR92JhUNOvCY8jCABFtm2Hkso+olxUSwolR4tWgDxn
         RVKCKybu9sSivARJGco/Z2mMsCjmcLQLK6fNnSXMp7wPecdjwsI8jzmrqut6GmMBkhFV
         UzecwlhBpUTmyMCNjul9d5tFpr0ZsSSDxHC0mfUeiJFTXHSwdCwa3nH9xnnY3c8Ylbjr
         5p4w==
X-Gm-Message-State: AOAM533dAYh9oIeItcXMAzgggPleL9WO34UyIuKZ0K9L7KUIKcj/8/iP
        c0Fx98ElOCaRdffU1/MDT4g=
X-Google-Smtp-Source: ABdhPJyHc/B2kO9p2mkQVtKQM1jvqKhllF9x5VZ3cWrsrWL/0VvUAcEpJpYBR7ncHguxjT1T1dL2wQ==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr4345514ply.122.1589975016031;
        Wed, 20 May 2020 04:43:36 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y5sm2041137pff.150.2020.05.20.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:43:35 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 20:43:33 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Message-ID: <20200520114333.GC520@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200515160245.GW17734@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515160245.GW17734@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/15 18:02), Petr Mladek wrote:
> On Wed 2020-04-15 20:00:43, Andy Shevchenko wrote:
> > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > We have few users of time64_t that would like to print it.
> 
> It seems that everything was explained and the patches look good to
> me. If we allowed %ptR then it makes sense to allow %ptT as well.
> 
> For all three patches:
> 
> Rewieved-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
