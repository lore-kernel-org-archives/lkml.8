Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D70EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0CC22CAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BH/zrsl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHCTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:00:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B8AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:00:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s15so8999529pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2bQwe2K0XwzuOlpiqVHsdZ/mH76OOHNTt78eXB94PDA=;
        b=BH/zrsl7HzNzpTlN+nMwokcT3MWMfuojbLn05mlyEULmbsnBhqj4VAFvCzgrU3AhOq
         AAPbj5DaS06efsVQIW+JpTH153H2gSJ3+rhhTTphBEVearFVbJG6wRh+fk1ppaci8sd1
         oP5DaU5vBan2xV1jC/yq38a0U/2ZO3nHas3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2bQwe2K0XwzuOlpiqVHsdZ/mH76OOHNTt78eXB94PDA=;
        b=oHtim/GZjZ1Yt5XnsSKivbH7LSd/k0VzBrHe1CmdTojMNQAHAl/vjoWoN7DkRcvvxn
         Xz1zWjXArI6Ihx3Uos5oRlAsEQXUWqPJfE1tFvxeFSSHVbmF02h5oD6UUBmCp8YE9qc7
         USp5UiOqiZ/Z27JNgo6GwK1q448SdbgB7yI0cK951P0XSt8bhxd8I4Eg5p9SXxzjraus
         WWrKIuTKmn9YUjQC0DlC7mBXPKuw1yPXK1wJDGrOfenu6gOSJDRAyn1wATbx78h95lrd
         +h8h/jNUpXh7QNQQ7Rm1PvhG3k1K3JRvhErLrqCI0tzZbavhXbzqe1xZLsSbD2RupOnN
         d0/g==
X-Gm-Message-State: AOAM531tuxIt2tRgnvk85ogLLjLN/fRtP29Ae+OH5IxzWkuEIrrg0noV
        wjTrxR4kcNWAlXFu5R8EE3dQwg==
X-Google-Smtp-Source: ABdhPJyAnvPLb+WX6KXXnGh4DTEpK7hgx9NQhChy0h95gy8dWIheKWnC0JPY4Et2iYOSVZLMlstGDQ==
X-Received: by 2002:a65:6205:: with SMTP id d5mr15445995pgv.432.1596481226804;
        Mon, 03 Aug 2020 12:00:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p19sm19668907pgj.74.2020.08.03.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:00:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200801160639.1410944e@archlinux>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid> <20200801160639.1410944e@archlinux>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 03 Aug 2020 12:00:23 -0700
Message-ID: <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2020-08-01 08:06:39)
> On Fri, 31 Jul 2020 10:48:38 -0600
> Daniel Campello <campello@chromium.org> wrote:
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx=
9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.=
yaml
> > new file mode 100644
> > index 00000000000000..5739074d3592fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> > @@ -0,0 +1,65 @@
[...]
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#io-channel-cells"
>=20
> Missed this in earlier review (only noticed when I saw whilst santity
> checking earlier versions.
>=20
> Fairly sure we should only need #io-channel-cells if we have
> a consumer of a channel somewhere else in DT.  So it's not
> required as far as I can see.
>=20

This is mostly a decision for Rob to make, but I would make it required
because the device is always an io channel provider. It may be that it
isn't providing anything in the DT to something else in the DT but it is
providing this information somewhere so always having to spell that out
is simple and doesn't hurt.
