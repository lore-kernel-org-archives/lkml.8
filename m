Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DFCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEDD20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAAGbc+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFBOQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgFBOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:16:29 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F7C08C5C0;
        Tue,  2 Jun 2020 07:16:29 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m23so934740vko.2;
        Tue, 02 Jun 2020 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6a0t6+7th0CQZpcLX9FSsj+5y1OPdbod01fcXwFCW0=;
        b=sAAGbc+hD14yma5Er/rT2CCXst65zCjTzv3RNPwbAeZqS0/qsLDQWFjHQjoTuGAeC1
         +ipXKm1ZoDdcONOTRhvidUfFwpVg9ZsOpg2F9JImpLXgIqY0vPmq3ISAC7ehqsaJyMmq
         ZIFnQiTa33xomn0HYM9RDwIFwF1icxNzbRDDq6u6o9Q1UGOmrT87cYXWR/pujy6Ekztp
         2UuzBjskR5IeOYFERkM/ERIzFsjrdlN3XM2XasDzmANJrlRl4hlq3+XNUK4ornQQazI2
         FWhzgAb1osiFDN4tgCYp2/JcYCQqPDD7ObSfnTlXAS7/7NHk0s+GDr6H2eP6sns6ZMVy
         FruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6a0t6+7th0CQZpcLX9FSsj+5y1OPdbod01fcXwFCW0=;
        b=cw2uiQCQqzGrryIYX+dwc2NbVo70djoCgzqvG8HegzeDDnIQBkkRhg0IdM6KX99qT+
         lfJmZOrYHF0C5qSc17g/ze2Nu3qAf7Aee4SjP0enOnL9rbZH2UDjkBDh3x6oSyxO83Kx
         B1G/0Y37WaxjWSj1iood6s/h5uWy4ONX/lfMZeyNbUgD/Xt6hRZdlC7YoQfVqzeH+4zP
         5RrKDH3l9aKqlmGI2LY7v1y+zqecJnEeV7w4vzCAl2pzlfdGeWDC8PIrKADToCmDzav8
         iOcVNpUee8DuUiyepIje19/yoqu/tPP3SlxH8W18tjXmu4C0AE5H7wdS90vQoTOIQlqi
         2i1g==
X-Gm-Message-State: AOAM532qxK0+R96Txb/8B4c5+VLXuD6eEDsmRfMOnbn+aGbMLgKUdU2g
        jLbhtSoMWHQYQGeO7KeY6qo4G0MIPDCTIl7b3/cbbqKB
X-Google-Smtp-Source: ABdhPJwsUlpy33FnIB6m4RAYn6vpQrhwYECjwYK+Cfnuf/EDhnqFeqzbq/cAlJV6cbDMbQlGYt6WBz8NxB2C5SttY3Q=
X-Received: by 2002:a1f:2ac6:: with SMTP id q189mr9360992vkq.28.1591107388620;
 Tue, 02 Jun 2020 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
In-Reply-To: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 15:13:10 +0100
Message-ID: <CACvgo50eb5_jp_6B5tkV9cX_X2_y2Xnavu+wvUUhHN5FsV9hiw@mail.gmail.com>
Subject: Re: [v2] drm/msm: add shutdown support for display platform_driver
To:     Krishna Manikandan <mkrishn@codeaurora.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, kalyan_t@codeaurora.org,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Tue, 2 Jun 2020 at 08:17, Krishna Manikandan <mkrishn@codeaurora.org> wrote:
>
> Define shutdown callback for display drm driver,
> so as to disable all the CRTCS when shutdown
> notification is received by the driver.
>
> This change will turn off the timing engine so
> that no display transactions are requested
> while mmu translations are getting disabled
> during reboot sequence.
>
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
>
AFAICT atomics is setup in msm_drm_ops::bind and shutdown in
msm_drm_ops::unbind.

Are you saying that unbind never triggers? If so, then we should
really fix that instead, since this patch seems more like a
workaround.

-Emil
