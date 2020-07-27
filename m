Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831E42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IyqtPWAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0H0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0H0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6894C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:26:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so14379006qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcQMkiC6JyOAC4Lv4CWi0++I1XNF82/fz8tqn1+E1Hw=;
        b=IyqtPWAaKhAh+DaxDQ4DPb3PUihUUHg8FyCmLNkaMd01kCj5NBl4KCGQa/PWeiKjvy
         lYiDgQlerDSKik78BIzs/K0+t9zjJEXiGFWlYKsGkciLp+jsot0ilKwAfdPe7YGjRNbf
         OR/xYOR5VD5tJTttqVfi3tZ1SpLAtqmyRi3zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcQMkiC6JyOAC4Lv4CWi0++I1XNF82/fz8tqn1+E1Hw=;
        b=dj9hWZPzh1b6QtZvgRAd8CmlM2SHDAF66sxMkaLOCRhqAiJWD8nzrMcb1GzkMk0ZU+
         WXdWK1g4Oegm/V2uqWy3feVJ4Dj0QUXQ88oc4lp3u03/cC9SWFIMKySrTmVClVs8tFIf
         PFLhw12oAD6q+AX30sbUWE/na/f9FmNgtjpSrfU6Ae942nDip/mxvuWkWMpAoXxXRY50
         8In/LaYGFqRXYac6rQ2zyiXJXAMUokE6yvv0Rhe73Y0DzzoGfdG8wNGuVn8uBhwsAwwS
         kcVFe4QcYFOVtzTsSaAd00pv798t9E14IDmIF4266g7B16cWAaUslc0YcsiwR/i0o4Df
         0eYg==
X-Gm-Message-State: AOAM532CdeauKWumiqucvKHPBAdUbaiUB8ZNN+EM3ZfaIyPGLCGC7fDQ
        U5lsilB2oD9XH9IgsmKqo+TjPlyf1ss+Fe96u08cSQ==
X-Google-Smtp-Source: ABdhPJx7sIx/y5po184X2+GWLwV1Q6wkqZEsbr9KeZ2FcprUla1gV50XWsaJXbGbAAZ1t3jNlIzBsu1Wfo+Q1W6K+cg=
X-Received: by 2002:a05:620a:209b:: with SMTP id e27mr21265347qka.431.1595834793706;
 Mon, 27 Jul 2020 00:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200615190119.382589-1-drc@linux.vnet.ibm.com>
 <20200617185117.732849-1-drc@linux.vnet.ibm.com> <4bb07889-063f-c12d-28e0-11de9766c774@linux.vnet.ibm.com>
In-Reply-To: <4bb07889-063f-c12d-28e0-11de9766c774@linux.vnet.ibm.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 27 Jul 2020 00:26:22 -0700
Message-ID: <CACKFLimJTiRx1L+FFOZfR3-yrR9u+TY_Fdy3OSgH49v9QLKGwg@mail.gmail.com>
Subject: Re: [PATCH v2] tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freezes
To:     David Christensen <drc@linux.vnet.ibm.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 5:19 PM David Christensen
<drc@linux.vnet.ibm.com> wrote:

> In the working case, tg3_init_hw() returns successfully, resulting in
> every instance of napi_disable() being followed by an instance of
> napi_enable().
>
> In the failing case, tg3_hw_init() returns an error. (This is not
> surprising since the system is now preventing the adapter from accessing
> its MMIO registers.  I'm curious why it doesn't always fail.)  When
> tg3_hw_init() fails, tg3_netif_start() is not called, and we end up with
> two sequential calls to napi_disable(), resulting in multiple hung task
> messages.
>

If the driver fails to initialize the chip completely, the tg3_flags
should indicate we are in this failed state.  We already have
TG3_FLAG_INIT_COMPLETE.  Perhaps, we can expand the use of this flag
to cover the scenario that you described above.  We can clear
TG3_FLAG_INIT_COMPLETE before calling tg3_halt() and only set it back
when tg3_hw_init() completes successfully.  This is the rough idea,
but a more detailed analysis on how this flag is used needs to be done
first.

Assuming this works, the EEH handler can check TG3_FLAG_INIT_COMPLETE
to see if we should call tg3_netif_stop().

Another way to fix it is to call dev_close() if tg3_reset_task() fails
to re-initialize the device.
