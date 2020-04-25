Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F705C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9C12074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwn2nxga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYAYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgDYAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:24:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F29C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:24:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j26so15711605ots.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DtbY+hrvIraJrx4Nh9U+69i+KyeK5TrEPRbni5wx1U=;
        b=Cwn2nxgafnzJF/zCWg2DNC9ZfZrTBn7wZMWmYaeOXMf+TZo60c2RS1u9xDCyfl5VaF
         JlUzgkkfZgLZjzcza5nL29ZhDfNruiABWTxH+GQX/GXDu+wOtzrGJpdH+Sr0Oiax9D/x
         aUVwJ9OfflXHPZDAVmcqpBU+oxLXWGFMcf6pJicEa0Ukr9VBeJmxKWINQrzys0LpzFQn
         nVdEN+5aq5aWQnCGxJx2rqfRwg4M40812PmwbopQOYfi/hTrAq8qnd5XA57iSiONl53o
         Z4oeQijaD111i8OLac4kXu7FiHhNatFqjM4CR3XkD9mpF49PZUTW+4kC+HsO3uSBdaUO
         l6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DtbY+hrvIraJrx4Nh9U+69i+KyeK5TrEPRbni5wx1U=;
        b=WOmfMZgjaZN+MtxgAGC3fIRnmNOmY5ohTYJfS+B/AdFhGXQYWuJhcK4x98TZt/4u3z
         7pu9crzApeh6m8B7x/6RGEkdQBGjdZPgOW3gkDcXvIoUOg6lO284D9StufyBE78UnaLp
         TW+sDiscis42zozdXz45dBCtYIWjrGKrTMveOzpcsqmrej6Uy9QzBUswavdR5iLnwIG7
         FHAVtp2U4pYn2A78VwlbDkDxpJwohUmN3nffDhP8l27nlSYMDyxD1CYlmxlxS6fY/iln
         BoGlG7A+TtnKHjkeTl/r6vFSeNVN5EZRQ/jBvyd1vM/Zo0+6OQCcWOoSAlevQP59DP1U
         hKaQ==
X-Gm-Message-State: AGi0PubbMCwlMUyviAwYtDzgi5HeRV62uzvpiQRFr+ssFFXhmuF0VOKu
        x6qLdoq8F+nKZNMg2z8Nq1WeNZZIWZG6/X86lY38/Q==
X-Google-Smtp-Source: APiQypI/oJ4eCDe/btPQXd2AND4zdGuWptjwylIaEjXOjM6KEi0hiu1hDHJSpsf2xW+KNi6jMm70KD4ysHR+K4zMdK4=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr9388729otb.352.1587774242725;
 Fri, 24 Apr 2020 17:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200424221758.15984-1-afd@ti.com>
In-Reply-To: <20200424221758.15984-1-afd@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Apr 2020 17:23:50 -0700
Message-ID: <CALAqxLUHYUkyCR7cFoLH89X_yrC3BMqc64iQoUiPyN5UqnYnvA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Initialize during core instead of subsys
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 3:18 PM Andrew F. Davis <afd@ti.com> wrote:
>
> Some clients of DMA-Heaps probe earlier than subsys_initcall(), this
> can cause issues when these clients call dma_heap_add() before the
> core DMA-Heaps framework has initialized. DMA-Heaps should initialize
> during core startup to get ahead of all users.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

No objection from me right off.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
