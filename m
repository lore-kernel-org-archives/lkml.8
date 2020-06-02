Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DD5206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niGr0710"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBVcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:32:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2409C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:32:23 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a68so146878vsd.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlyPlUpzi8PxJ6au1VoYObkQsvt6RuFDhAnnzvz4bv0=;
        b=niGr0710a1CzJTTkAC1MviQRrhfyFb98xSRE+/esFIW4I7LWXcyfTIt2O9SmXR/yRZ
         RngJF2TxDpa6TPzdMv8y4O47Suo9Ujr1Op5mpSmlfbIGHJ5ASnRe+epOmQS1ieDhYz9V
         1zbBa+UdRxiiMIY5+1aNGrSDsITPGnZnfQS94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlyPlUpzi8PxJ6au1VoYObkQsvt6RuFDhAnnzvz4bv0=;
        b=cY0/JO4+98lUCyV/PA0bO/EiPNA0eCwXg1+RwNwtqrhYIsvvSvi4aE4FIekN8SunW2
         NZ1wD2OocqZVF4Ab2eDQwt8slUiOtM2ZuPyWt8md158xGfWDA29+y8fLyzbV4D4btPlR
         oBgu/om5mPRPEaGgEHECja+DGR9xDcLBg/7n2AXQzzyixayZn0DE90vVPuuOX2zh36sl
         pQZR4Js91pU63luvlE0FHR95QvpAzjUZscE7trpE+Hr3Es8cxBRWYWK0i9wzNOMqX64l
         ZzJyBO4rUkTvwX/1s1UqGIvBphXxbulkFBEHHFXbBtazw50HLlBuanY1zcJ/78SaU9nB
         9jtQ==
X-Gm-Message-State: AOAM532x8GMbid75z8weoCOl9T2WWTRWzcxW4JG7emKZRgQhqnimDBio
        hITMXQv/LRjzXnyW6xhOqX44ujB2q2I=
X-Google-Smtp-Source: ABdhPJwylHohO3o0Voo/KHRxChan0bZ4RHOypLqZy1iXTpHATXOrQtU30t34Due5nCu+8h64azrncQ==
X-Received: by 2002:a67:6582:: with SMTP id z124mr3411727vsb.24.1591133542729;
        Tue, 02 Jun 2020 14:32:22 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id h3sm10759vsp.2.2020.06.02.14.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:32:22 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id m18so1265825vkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:22 -0700 (PDT)
X-Received: by 2002:ac5:c305:: with SMTP id j5mr1333596vkk.92.1591133541729;
 Tue, 02 Jun 2020 14:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org> <1590751607-29676-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1590751607-29676-3-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jun 2020 14:32:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBVQnviPQJU-h46XQrGyz3PtTr-MsORS5W6EBh6n+9Dg@mail.gmail.com>
Message-ID: <CAD=FV=XBVQnviPQJU-h46XQrGyz3PtTr-MsORS5W6EBh6n+9Dg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kdb: Check status of console prior to invoking handlers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 29, 2020 at 4:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Check if a console is enabled prior to invoking corresponding write
> handler.
>
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
