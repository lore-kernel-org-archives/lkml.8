Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A571C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D790A2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wj7uIHi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgFHQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbgFHQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:08:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68000C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 09:08:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so10573220lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClSQBWTNKy6QM/u0O+83mkKXa/fUb2mZhnsBDib3FXU=;
        b=Wj7uIHi3iVob7U2MnpWEYNidthbOPgWUvDSYkULGV6+X5T7T2QDw4sHvTkrkAIv0Ab
         6Fg0K6exQtytZPQKO34LagmdPRaq460ZHKWIsEukUVc/6/emrmYy/9IVYBXfE7+n142s
         THP8lUfiXgV4DF0FjAkuCp2x97R1OfEHEVP/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClSQBWTNKy6QM/u0O+83mkKXa/fUb2mZhnsBDib3FXU=;
        b=hfwyiNdK0xGqKs7n9m1c2JPj1m2LSSjCKzxCnw2ZjfQYAtT27HHll+jLqHYO48R3tB
         PqpDRm0zdS3LBgcT1441iKrox0q/nuneBGPGyltHyOGvIgJKphm0sQ5gETyqwXUH0y2s
         WCfKFRkRL4Q+GLMCHnYBJ9C+vRMEtYo+EgyCd1EFBOnMiIQ3NKNfa9Lh1oDcaWW2hMMc
         oo7xrbXQajKY2VbZO/kvsXT7ur63OkFS/1Vds0e0Po8frUJEbprhiGh+NRmBMCxJImAW
         eCt4gJF20htyCZcBLZ1u4nb8/IZ+jVfpR8MIwWgfdwIdvlxNDdeF0/rEp9geUc2E1eBj
         CRjQ==
X-Gm-Message-State: AOAM532JeaG4esm7gkx5yrs3Mv6+QTtxsnxGhPy7Qlya6evzA+zd9HF5
        EjlnYiiGwRwdkyhfUc/oURDgJYZ7zjg=
X-Google-Smtp-Source: ABdhPJw5G51dncV86jKEBCiNV+rMofKAsFOZtOsSASRz1l0Ul5Z3Q03XwWBml8s5C78/OUftCwzJaQ==
X-Received: by 2002:ac2:4a87:: with SMTP id l7mr12835020lfp.171.1591632483401;
        Mon, 08 Jun 2020 09:08:03 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o16sm2838958ljg.90.2020.06.08.09.08.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:08:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id i27so10253936ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:08:01 -0700 (PDT)
X-Received: by 2002:a2e:b4c1:: with SMTP id r1mr6601345ljm.370.1591632480876;
 Mon, 08 Jun 2020 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200604105901.1.I5b8b0c7ee0d3e51a73248975a9da61401b8f3900@changeid>
 <87v9k1iy7w.fsf@codeaurora.org>
In-Reply-To: <87v9k1iy7w.fsf@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 8 Jun 2020 09:07:24 -0700
X-Gmail-Original-Message-ID: <CAE=gft76Nqo93QvvXU9xU-6sY-Q88H4RezMx8G6MWSBE7vJDKA@mail.gmail.com>
Message-ID: <CAE=gft76Nqo93QvvXU9xU-6sY-Q88H4RezMx8G6MWSBE7vJDKA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Acquire tx_lock in tx error paths
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@qti.qualcomm.com>, sujitka@chromium.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Michal Kazior <michal.kazior@tieto.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:39 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Evan Green <evgreen@chromium.org> writes:
>
> > ath10k_htt_tx_free_msdu_id() has a lockdep assertion that htt->tx_lock
> > is held. Acquire the lock in a couple of error paths when calling that
> > function to ensure this condition is met.
> >
> > Fixes: 6421969f248fd ("ath10k: refactor tx pending management")
> > Fixes: e62ee5c381c59 ("ath10k: Add support for htt_data_tx_desc_64
> > descriptor")
>
> Fixes tag should be in one line, I fixed that in the pending branch.

Ah, got it. Thanks Kalle!
-Evan
