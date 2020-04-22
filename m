Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC4C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F1020575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587514942;
	bh=c+XFPyiH5BeEGClHqseQljbOxUU8e9tNUBpvWAMh/7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P9E1chKD9MZ7fM/jtQ04rpctD+bz4t5ZstmXBhNzlasIFZQA1Tei9rJC9FkO8BYxr
	 qyTX2rW9613mKFk3aY+eDxU1G5DkeevnT3hcgIGI8TBy5WFIblMoZU7Ga0S7jhOLxK
	 QgwxrZXk6d78lvYYmNo2ruNsgzKH1WsPtfvWbDSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDVAWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:22:20 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931D720575;
        Wed, 22 Apr 2020 00:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587514939;
        bh=c+XFPyiH5BeEGClHqseQljbOxUU8e9tNUBpvWAMh/7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ht1cZBtsU4ZzklSV5cRr5Qx6XaFQ4W5lxRDq0/8EF2vd2jglMQT6aeg5HlTr+Y+cg
         GvXxh4r2LskTeGgpwJ5Sx07ICokd+2snluTxFrmyUsyvTzXD+4Xjj4ugclehyDp9OU
         Ueeuh3pweyX12GUi3BhHMzulqdR1JtYelrt3Dkgg=
Received: by mail-qk1-f174.google.com with SMTP id j4so697888qkc.11;
        Tue, 21 Apr 2020 17:22:19 -0700 (PDT)
X-Gm-Message-State: AGi0Pua5yrPq8jSWRo1KeGkfpSOGnjx4TtwIm4z9ri/o474X0y7HKmFs
        RaoNBRKDqPSXQNk/1utSSxW1XrAa7To8eXnEUw==
X-Google-Smtp-Source: APiQypJMvsjKJFcDSNI66nc6nxJLAcqRUC9yc5h1UoxDLBk/UtHLjSXOOVV0+6UfjqW5zRZ3zD4bGr0zEi0q5AN+k1A=
X-Received: by 2002:a37:c43:: with SMTP id 64mr22162895qkm.119.1587514938757;
 Tue, 21 Apr 2020 17:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200421212004.6146-1-robh@kernel.org> <20200421233737.GH5983@pendragon.ideasonboard.com>
In-Reply-To: <20200421233737.GH5983@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Apr 2020 19:22:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkp3hQFVJRHCix_oEP=ukPgL1Ykci7E4cScrz7x1m85g@mail.gmail.com>
Message-ID: <CAL_JsqJkp3hQFVJRHCix_oEP=ukPgL1Ykci7E4cScrz7x1m85g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Fix command line length limit calling dt-mk-schema
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 6:37 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Tue, Apr 21, 2020 at 04:20:03PM -0500, Rob Herring wrote:
> > As the number of schemas has increased, we're starting to hit the error
> > "execvp: /bin/sh: Argument list too long". This is due to passing all the
> > schema files on the command line to dt-mk-schema. It currently is only
> > with out of tree builds and is intermittent depending on the file path
> > lengths.
> >
> > Commit 2ba06cd8565b ("kbuild: Always validate DT binding examples") made
> > hitting this proplem more likely since the example validation now always
> > gets the full list of schemas.
> >
> > Fix this by putting the schema file list into a temp file and using xargs.
> >
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Quite a bit slower than v5.6 when passing DT_SCHEMA_FILES, but
> reasonable, and working now :-)

That's expected. It's validating with ~700 vs. 1 schema. The problem
was folks only checking with DT_SCHEMA_FILES set, but a new schema can
affect another example or existing schemas (including core schema) may
fail on the new example.

Rob
