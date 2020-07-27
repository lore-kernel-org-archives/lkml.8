Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABADDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAD020719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="goLiuJ7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgG0Rrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgG0Rrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:47:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753BC061794;
        Mon, 27 Jul 2020 10:47:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so17915082eje.7;
        Mon, 27 Jul 2020 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijZvlgHQ+v2BWZ6VMCXnmgIYM9lqeQKC/Q58LwpkS18=;
        b=goLiuJ7DPYB9oXd4K0FnBTft52vRIoaP8HHEoIjYGrc+tPTm98AuJdQQocC0tZrdIO
         ISnBrkYunC/SuXetp8LVr0AUf/okLJ7rrydaj2DlRa14m/mvYjy2MO9Rvx0uPp+A8RyR
         ymBD+HZEaA5cJTq65kSojT0vwfQ4HSr8m4XWE/Xzs+yGcAoqpMhdWdDComye4rXmIyNH
         1mMPIkOzJGlzCzIIULku257QIFw6Zzwpm0koPrP4cP4qc+XHaUVgWdwTt7t3gSy+4oyy
         m7HHgCRC9ms0IxORbtyaQdhlzBR/Pv7QY3qA5NofrhA7hDTOz7MJv713hvGuzUJiqbpc
         bzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijZvlgHQ+v2BWZ6VMCXnmgIYM9lqeQKC/Q58LwpkS18=;
        b=P8gocLr8pJH5qrOnoY0C4CUxh/G0zra+psMbip1xmnwTP/wkrFFkUphCIYEv/8mc8/
         A9UBkAJdpXykiRyAhOXe+mtE6KbGFV2JON5STiSEaoenrSTCnlWCh6knHt45LqO55Pz1
         HOWoszn/HP8tdcTXD/TkX3SWGMNk1nd3n7wGcAlUHbz79W8VeGh4sYVExZHgubu8Bxci
         P3tNy1oSs7RurdP2BJZBS9OucUb1urTZ0OrABagrkelN/v7KwVWlG+46rfT0abnYRi6U
         zBM+B49py1pEmBQH/1rrw4jg+oLbqhXaS/7g+jikgPTxNZRbZkUO1Zv+8/N6WBR2NJCc
         caRA==
X-Gm-Message-State: AOAM532De5d4j0PtlZ41XTLMxcq94779MnFY1BOPrfjhJCMd8yQTnO5N
        7OhPowTDvwTYUVUKpjNhSUvf7E43KHEqFMu39tbd5gKGd9U=
X-Google-Smtp-Source: ABdhPJyWjX1lCFQR4mrrLCa3z5egBfKg89MlfQ1v3c4dfSsnCgXyu7fZcZo4LE8I8xaNaz1PFPPa723qH/VZge8XLSU=
X-Received: by 2002:a17:906:743:: with SMTP id z3mr21889697ejb.216.1595872066116;
 Mon, 27 Jul 2020 10:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200727092346.19780-1-amelie.delaunay@st.com> <20200727092346.19780-2-amelie.delaunay@st.com>
In-Reply-To: <20200727092346.19780-2-amelie.delaunay@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jul 2020 19:47:35 +0200
Message-ID: <CAFBinCA_GzdWC+L3Wj_PesRmNFP2rhpZ6jWhhNJP03O5AHc5Kw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: dwc2: add optional
 usb-role-switch property
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Amelie,

thank you for adding this patch!

On Mon, Jul 27, 2020 at 11:23 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
>
> This patch documents the usb-role-switch property in dwc2 bindings, now
> that usb-role-switch support is available in dwc2 driver.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
please add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin
