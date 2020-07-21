Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF112073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUDwy5R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgGULrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGULrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:47:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB438C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:47:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so21062769iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRq8ucCfmuFJvcTFkc3tS7Wj/uLZA8Spf3C0id9cxrY=;
        b=RUDwy5R2+a5FcDCg5Cq7hkluN+M5R+bUbQi2wWTIXT/XzGtTdqGuKd7TkRNE6aS+yC
         ibSbJ3fOYtsswQJmU0k2GbpqFSf3yFp1m2wLGDdPA7oJ8dukiXKrxBgj47D/ozvGCFKf
         3ZXxHx1KYIAq8f4yp97OhZkSp9qfyD6cQ335kfeomWXnQnVTi9RLMhpSE6LhVm3PHbbY
         lcc/Bws6wFqAfy8n4vYBWy4QGR+N7XKXprisTQJ5XllRn8f7TjZgR3ZN8gAW167n16rF
         Ukai0FGxz8zAeBmXroqOjqeUfcxhGiTOxRZjW11MMB5kQlBa5CQ9g/C5UK0tc0A1a7W7
         Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRq8ucCfmuFJvcTFkc3tS7Wj/uLZA8Spf3C0id9cxrY=;
        b=UTO1hrruM7SWmq5jOyT/I3NIl5iLWhH8cmgw67vhJc0kZS/e3+F9WoLKOC9LihOi6d
         cdlyLqUr9SZNW7mzhNFq14rMGTy/pHBXbEMGxKaplNbclqNTfGocYdaDu+IDuUDxPfen
         vhkGFvkvAXyHYG9OH5xiET1mN0FFb/D10IwFQ7Ldb+sMVU8PLsMRfCAuMWfmDkmPjPsq
         Cm7cLRevCbAdvKKGgI5HshfAQYTskDZN//USNP5mrDabqV5MTrLUDjf7g0ybURDHAR5L
         wIdCSpHyWtb0Ht6MGFHeX9dhNwWaIxBnY6UeMBQEWz7VwCaZ64ZlTX9Dw4xmdkQwzb45
         aDKA==
X-Gm-Message-State: AOAM5302Y71TOi7PYL3Xby+peRdMmhwvNdQv78GmpR0NliL2zO0/cAhE
        tgN31gwcOTfK210ApGcXn7twrcYjRfUzkmV+TxX7vA==
X-Google-Smtp-Source: ABdhPJye8qmq76v2qG18buCf5XgXAaN7ZfKIQ217WAXoEp+aVmjEUDMteAbXQB+XN1Y95WqgmvGJC/9JsLyBwYAuZUM=
X-Received: by 2002:a05:6638:11c1:: with SMTP id g1mr31491011jas.34.1595332027045;
 Tue, 21 Jul 2020 04:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
 <CA+Px+wU1S1EqtW-yZH9z9aCF3ggSriBqy73SRYy8q61x0GkdQQ@mail.gmail.com> <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
In-Reply-To: <846feea6-e2b6-3a0e-b05f-d70e898f9ea5@gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 21 Jul 2020 19:46:56 +0800
Message-ID: <CA+Px+wUhAHAx-qmAEWy_8Jy40NDTAHH-TNYtPtMfwocMHQ=AbA@mail.gmail.com>
Subject: Re: Speaker pops with max98357a on rk3399-gru-kevin since v5.7
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:40 AM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> On 17/07/2020 05:27, Tzung-Bi Shih wrote:
> > I am not convinced the pop comes from 128f825aeab7.
>
> Maybe some pre-existing defect in rk3399_gru_sound got exposed by
> 128f825aeab7 or the machine driver needs some changes to complement
> that commit?

Hi, I got a rk3399-gru-kevin and can reproduce the issue.

Could you take a try on the proposed patch here
https://patchwork.kernel.org/patch/11675533/ to see if it fixes?
