Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F79C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA35208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Je5GRTng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgGUAkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgGUAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:40:17 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94AC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:40:17 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p25so9493445vsg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUpZU63I2MCt+5BOqBJ02njfQEvWd4lvpWLlUaHC6oM=;
        b=Je5GRTngISqvkNcRVRnSxEc/NHnORLZ9Whhu5UnqKBL1gzWAbPHubryeggAL9Fst5h
         Tsc0XoyxZpZ/Kg7n19zdROeh98yk3ZMi+lMhzXGLunb7wjETZaPln3PCaDYsI1F9k617
         S9ghiVLdL2R9PI5AmhvAlpjlRyJi+Ex0BmD6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUpZU63I2MCt+5BOqBJ02njfQEvWd4lvpWLlUaHC6oM=;
        b=ilgS/+If/HjhZ5JSn5/6/yN8FxeoB3sB920V33eQ/OezdE6W4VE8VQbw5Pj9ZyXUxn
         /PhTI4QXDPSUdCx/iQp2iBtEOPEQP1kXGVjG06du9DfB94q6xl/eMCyrO37MLGDvrzYW
         rBBY7aoaQ7PlnIM67ts9smgv19uvaiYP2r3go76rAMbCXSBzFiDyfi6yP/oCI5Vh1PHW
         RdVF/cTOsoIgJcFiB8Zj3prpKtXGymSny1qsaJ7krtNFlgAS2W4GI+0zK5LAWZc1Bqsl
         Yjv4Gg5/q7FU7TJZmGK5Gitm+vo14XEyIoYEeTZNxaGYxbcf2v9x62+9h9dkxYhnoGr0
         bbXQ==
X-Gm-Message-State: AOAM532T0FnfMHoYpdGrToTNp2B3z3cCTDvknPMcGAhfLDRj3PuRmtNn
        +tlOKQROl0svGveDtAPev4fJP00jrY8=
X-Google-Smtp-Source: ABdhPJx6Ux4hkoCKua+b1wW2ZmQbWc7vP+0RqcvJ9+vu6D4ibYGUXaOwTpJQ0kBMMlAl1n7+Dq74nw==
X-Received: by 2002:a05:6102:232f:: with SMTP id b15mr17736256vsa.233.1595292015819;
        Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a24sm2347662uap.1.2020.07.20.17.40.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id j21so5640236ual.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr18950969uaj.104.1595292014631;
 Mon, 20 Jul 2020 17:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
 <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
 <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
 <871rlcx8uv.fsf@codeaurora.org> <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
In-Reply-To: <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Jul 2020 17:40:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUpwVoxNPELFfWnKRYFornTFMvtgFaOgD7ij-fQNEvmQ@mail.gmail.com>
Message-ID: <CAD=FV=XUpwVoxNPELFfWnKRYFornTFMvtgFaOgD7ij-fQNEvmQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Peter Oh <peter.oh@eero.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 5:33 PM Peter Oh <peter.oh@eero.com> wrote:
>
> I'm getting this panic on IPQ4019 system after cherry-picked this
> single patch on top of working system.
>
> [   14.226184] ath10k_ahb a000000.wifi: failed to receive initialized
> event from target: 80000000

A bit of a shot in the dark, but any chance you could try this atop it
and see if it helps?

https://lore.kernel.org/r/20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid/

...most of this patch is gutted by that one.

-Doug
