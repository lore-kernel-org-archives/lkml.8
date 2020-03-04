Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B65F215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583338230;
	bh=HV1k+UuV+bDXQzId5WwKuGvBGn5dDTBSjXxwhqXriaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PQzVhZ4PcE+M413APOfpntQe5w0js5cJ72rx8TrUdhdOc1vbF8Yp/EjTLN6qTROK7
	 aSohuzmnX73epL5BqSOBH1kPa8EaECAjH/jpGxOIT543svl8hBsmFE1qIndiWPR//j
	 b5x/TZUC8nqRMSjpPoG7lr37pf4g+8ovOKJkjVn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgCDQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:10:28 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB2F215A4;
        Wed,  4 Mar 2020 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583338228;
        bh=HV1k+UuV+bDXQzId5WwKuGvBGn5dDTBSjXxwhqXriaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wq/gLwDBl189a6sIBnQ9062LI4MxpZW7iIh4HaQV4YdFdHeyTXqPG9k/v8Qo+KvEl
         D+Jc6XtOcB7BznfLvO3wTcv9BZEcACnDml0SQ0D214gPCuDl7iu5shyghv7UVLyc1D
         17FBBYszg6+BOsXYHk0wprExjY98oaF/imfzndy0=
Received: by mail-qk1-f177.google.com with SMTP id e11so2121458qkg.9;
        Wed, 04 Mar 2020 08:10:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ3gZcdYiG3EY+MB2kFA/sFXD6SI1P/7vRzDOoBmr3+CvtBUo/YZ
        i5SSYXuz+gv5O5WmSb/4yngdk3h6iyT0cUJB0g==
X-Google-Smtp-Source: ADFU+vsFWy5BtFwqt6beGig/xn6nSLKSdhRCTGjxy84zCHhWecCpustVSn/BpiBgEtLg8viFjCvcaTRW/Kurrn1//kU=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr3690948qkg.152.1583338227056;
 Wed, 04 Mar 2020 08:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20200304032038.14424-1-masahiroy@kernel.org> <20200304032038.14424-3-masahiroy@kernel.org>
In-Reply-To: <20200304032038.14424-3-masahiroy@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Mar 2020 10:10:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrdC7B_8TfbgESq1ZR3TVxR9bGvpxUDVVmMxi6tceQ=A@mail.gmail.com>
Message-ID: <CAL_JsqKrdC7B_8TfbgESq1ZR3TVxR9bGvpxUDVVmMxi6tceQ=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: allow to run dt_binding_check and dtbs_check
 in a single command
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 9:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit 93512dad334d ("dt-bindings: Improve validation build error
> handling"), 'make dtbs_check' does not validate the schema fully.
>
> If you want to check everything, you need to run two commands.
>
>   $ make ARCH=arm dt_binding_check
>   $ make ARCH=arm dtbs_check
>
> They are exclusive each other, so you cannot do like this:
>
>   $ make ARCH=arm dt_binding_check dtbs_check
>
> In this case, dt-doc-validate and dt-extract-example are skipped
> because CHECK_DTBS is set.
>
> Let's make it possible to run those two targets simultaneously.
> It will be useful for schema writers.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Documentation/devicetree/bindings/Makefile  | 8 +++-----
>  Documentation/devicetree/writing-schema.rst | 4 ++++
>  Makefile                                    | 6 +++++-
>  3 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
