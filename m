Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A993EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B982076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X27ymCnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgHDAJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHDAJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:09:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:09:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so30653343wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCZ+5x7cB7c4WhsNxv/e9ztS6zkZQToI8WVyuWUJDWU=;
        b=X27ymCnIOv0b6FdxM9BdsZd26TrYzCdPFtnhbqdK02j03BD4J9D3W3DSRFI1VE2jrC
         jT/HE+WPmdeoC7/XSdeCvTQKU9oSg6L69peeo5/hzQ1yKAIutplAZ3CfXSXKIA4UdBpR
         0ld4yWbKU8wJJNQGhlSco8B+zsfVXuizVj1/K+/8v3YJ2RIQkGjzXpv9sOp5qJb5DJl2
         uMLvA+Q7eJa8rjN/G6yP3Fu24WMW+8fZUhx1p7iiEr6oiuvBDouIoiBrJtVDTTlWc5MG
         JWwymluXbmY6l2xQLswtcqDANaNnsMcfdc07zvqKPkUQD8MQskWLNOPWiXmmLMsGdafY
         VhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCZ+5x7cB7c4WhsNxv/e9ztS6zkZQToI8WVyuWUJDWU=;
        b=VwjWGvEUiug/Hb8NL+kha/LyigiJ/5+Es7pH2mjrcAflJm/NRGKNevff9un9h2v5kt
         kPOyutgC+D1E1IcztuBmT+kxxrHw07nOU+ca2A4p43Psc2ml07+ItTr4TjvDfo/W+zvY
         Sq2SJm1imy3bi1jKoFJCDH4MHq4CyN8c6/hAsPd8jQPDnKToOYILxMZ9kDalpXEvIFMI
         bEVsg7smZd3XKgOyMId4vz15I3aJ9sFqXps3rQYj7/9TOWLIklE1c+HSXeDX4xvnYYru
         4z+eAlReqPuluBh4HgX6/lHS+6ba4yMYkbZ5xZdOnBBub3eHVpMhPfl8go1tk+4Dd3va
         4z/Q==
X-Gm-Message-State: AOAM530C0N9iPlRnM96HDwWpaOpq5XfQ272769RAdIhkPVkKJslEc4i7
        Y/CA9FitTuL4W+SAHaKlf45dhEwAMReQTYZxIVacIgQv
X-Google-Smtp-Source: ABdhPJwQlM1BfcZeKWWwUe2H4R8bCGWBydmxPdn9zvn3P8xVMtLmNGIDMk9Nt5U7/xQnUUpgPEyxw1S3VMycKaGbNFo=
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr17290686wrv.104.1596499749013;
 Mon, 03 Aug 2020 17:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <202007150718.6LcA4qZN%lkp@intel.com> <C4A103AM9MUU.13PG525K6BK54@atris>
In-Reply-To: <C4A103AM9MUU.13PG525K6BK54@atris>
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Mon, 3 Aug 2020 20:08:52 -0400
Message-ID: <CAKm4OoV-DhWS7ajj_xa412E19FQ5EExjYKPRGEu2K9=-7uUFrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
To:     kishon@ti.com, Vinod Koul <vkoul@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Sat, Jul 18, 2020 at 4:18 PM Liam Beguin <liambeguin@gmail.com> wrote:
>
>
> Hi,
>
> I sent another patch[1] to try to address this.
>
> The issue seems to come from the fact that the parisc architecture
> doesn't support cmpxchg on u8 pointers. cmpxchg is called by
> set_mask_bits.
>

This patch has been merged.

> Thanks,
> Liam
>
> [1] https://lore.kernel.org/patchwork/patch/1272617/
>
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Did you get a change to look at the initial tusb1210 patch?

Thanks,
Liam
