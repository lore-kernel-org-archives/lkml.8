Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5B42070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="adUoi3ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGYARj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:17:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9A4C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:17:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so11601995ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+Khyx7k9UOvsWviHkgBl07QUgeTKR6vK8nRDrh7xTU=;
        b=adUoi3lyM0wk7wJv1lUjSJ5JUtOA11ausxEEkI1YK/ueraqEIdmpoMmo62pZpBrtbj
         55VP3Xe6fjSNc/bMBhA8gey0pISp6LZC3TS4BrOtO8ExLGvUuAgybg3g1T/VpVrpzpoD
         U0P1WS35S/zYd+Ju56PXVOXNlb83a52fdVD/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+Khyx7k9UOvsWviHkgBl07QUgeTKR6vK8nRDrh7xTU=;
        b=eQLo6eP9ODo5n1Gox56YQgCLXxZ9Trgo3zhyUuKZ1U9SZj9AWcB+CJnm0SmhN7XiAe
         vNnnPysDDGr1gqwQ3M5ngE0AozEstB5HE6fb5b0RMcSplj//6eQMUpNXwa6Xnn2UtbPi
         MXnkWhDK/NaPxJhDcCaJyMxUdUNPLuUX9NLmI5EQt7r+kYiygUZPJEst6cVzmn1qm88h
         WI8QGb9ow5FZGJIH0MDXBswaXjZvmjzj8LjDIgT+vej2UtcJKuQA6Wagz+6xRuT1EX5B
         TDXCdT5hV4cPvsTZYPoA1NCYrzkXIQaEi8li0IFQWdrdaiDOLV/6ZBdqy61BSXybWjWF
         kUSg==
X-Gm-Message-State: AOAM5305TA50h6K7skMUsAzzIEuzeX/bUopRKhp2p5QjRlF2Adbg+tz/
        rwwBSGRAy4FEtCJyAJePGYxFepg3lTw=
X-Google-Smtp-Source: ABdhPJx/l8DzZPf8touAxtxBEl2+1sMm4Pf3jv5rCxz4SfE0oBVHqGhgEks2mkFLsC0uZwecj3D6/g==
X-Received: by 2002:a17:906:17c1:: with SMTP id u1mr7495053eje.536.1595636257225;
        Fri, 24 Jul 2020 17:17:37 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a1sm1644502ejk.125.2020.07.24.17.17.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id t142so3258393wmt.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr10508784wmf.103.1595636256044;
 Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-5-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-5-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 18:17:00 -0600
X-Gmail-Original-Message-ID: <CAHcu+VbPbpqzc1xVqWZ9Uq0NRigpNDiNbkWupedOpOXVO6SN3Q@mail.gmail.com>
Message-ID: <CAHcu+VbPbpqzc1xVqWZ9Uq0NRigpNDiNbkWupedOpOXVO6SN3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: sx9310: Drop channel_users[]
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 3:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This struct member isn't used. Drop it.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
