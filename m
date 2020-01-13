Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8252BC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7wNaU9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAMTFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:05:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44706 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAMTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:05:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so9540302qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05/r1uoo6hivI2yxFGMarKb30fMqhSdQqFht9r494DU=;
        b=G7wNaU9m/AMUsbs+yr9TA4nTqsnTHbAZf2P0+HMpnBYhT/1vFUBRdrku0imAk+yvuC
         JpDH+udqg7CQtOnxuYDTbo7CiIRqsIm9mUJxcAT9vA9Qi/plCBXhPsoyTk3SgaUPhY0o
         l8fsKDsdkSk3AIlfxfAd3Anxg1Q/T7XP7lLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05/r1uoo6hivI2yxFGMarKb30fMqhSdQqFht9r494DU=;
        b=p2RHjbnEE2XeIB/qcmJre6mxALDuMdd1Mrv5XGgc8AV+a9KlNa0rmWjelajkJcm2us
         gLWdd+7vTvUf6LwvsCXJ2En9ak1nV4RelT3AQzH3S4XTXXtG/h7vuwxMK8j7cvAuKy3k
         F/Hy98d4SXvFzwS4hH85FFlQ1nDmLYHFIxV86sulDJ0l501lCWuZOk3RpyReH2ZnyOcR
         zl22HS8zI/uWSAqX/4iJQK+GtWf63Jw0baKepiWNlcWkej9eu+y2mZvbM06Vvq4HWylJ
         +jmb+FHycXPLNpUdyFsNCClOXhvVRvkr8AiSoxaWC4JCc4olrH4WJISPtkgbNIHEXpyz
         jf7w==
X-Gm-Message-State: APjAAAWZ0SopUMOoPGuUhfSdSMrBoEzOE1alyEDoGUODKjqivKZXlOEw
        kfka1zNi5JkRSq4ZXyEcaX8AVmncQD4=
X-Google-Smtp-Source: APXvYqxPaYBDJWyklr6LtqN3Tc5Za9EkWg/5gNMw4ZMejB9FqUjQ1M4MTj9WyocJ/3SvO2Nal9qsmA==
X-Received: by 2002:a37:ad0e:: with SMTP id f14mr17575446qkm.213.1578942351023;
        Mon, 13 Jan 2020 11:05:51 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id b191sm5457990qkg.43.2020.01.13.11.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:05:48 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z76so9598650qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:05:48 -0800 (PST)
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr13205757qka.279.1578942347632;
 Mon, 13 Jan 2020 11:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20191206194535.150179-1-briannorris@chromium.org> <0101016eea4fa7f5-e04b23cd-17a0-4306-8100-7761f1161da3-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eea4fa7f5-e04b23cd-17a0-4306-8100-7761f1161da3-000000@us-west-2.amazonses.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 13 Jan 2020 11:05:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
Message-ID: <CA+ASDXNCzyRfZs0D6_+j0Tyqai4PaFk50HpF_LqC-GuOTYJCmA@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>,
        qize wang <wangqize888888888@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Brian Norris <briannorris@chromium.org> writes:
>
> > AFAICT, the existing commit (1e58252e334d) isn't wrong, per se -- just
> > very poorly styled -- so this probably doesn't need to go to -stable.
> > Not sure if it's a candidate for wireless-drivers (where the original
> > commit currently sites) vs. wireless-drivers-next.
>
> I'll try to do so that I'll put this patch to "Awaiting Upstream" state
> and apply it to w-d-next once 1e58252e334d is merged to w-d-next. Feel
> free to remind me then that happens :)

It's that time!

Brian
