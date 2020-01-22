Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5723FC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E52467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579731387;
	bh=gMznlkKlnEraQs6bi8mMvqUTxahZxYtFxguxpkQyvME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w88rpvQjyPD/UbOABlqfvYuyjZp+H6/+w1EvBPUNjQ5DKe4KcGDlUo8sG3uTDYI7B
	 ZC6frn1YodeWQ4ykaUA/OcI/qDishF0VPpG1zsjBimIwhtSoNcX/1fJ1B6pOYTekh7
	 OcUD5Y5MndyH2+Z3hVt9vqLEfM2nepYKapI5Kuo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAVWQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:16:26 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFFC24673;
        Wed, 22 Jan 2020 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579731385;
        bh=gMznlkKlnEraQs6bi8mMvqUTxahZxYtFxguxpkQyvME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x2h5LFBGzqwNyC19r6IFIehFx3ZQHjUiNkA+MOUKFhxmozAO3DH5DTue+2IJ+i14Q
         6yXcy6MhsJ5u4hkZSyLY0HaWNTU9U79d0kitNpzd1AY4rwzTkxtUNyMAJ4krzXPZlW
         jRAQHCOSGRM3Mfm28GKPELbGJYirLtB+THd56wec=
Received: by mail-qk1-f173.google.com with SMTP id d10so1452321qke.1;
        Wed, 22 Jan 2020 14:16:25 -0800 (PST)
X-Gm-Message-State: APjAAAVeIU39PaUIgvplwrhoGbfzxKdrtWZ5vI7Wikie78Fn7uzP4fMq
        OK0YKN5av1s9VKVKjPK5meARHQHdIUnCqXMqpQ==
X-Google-Smtp-Source: APXvYqzkmuC5aqfg3tJZ3GIJ9N4BfBcSOeRzz/S5dStACI0FD4XIBdfQfwykY16cFmXykRB/+2sC0MDi6Qjmab6Gl60=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr12816454qkg.152.1579731384778;
 Wed, 22 Jan 2020 14:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20200122174005.17257-1-sravanhome@gmail.com>
In-Reply-To: <20200122174005.17257-1-sravanhome@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Jan 2020 16:16:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
Message-ID: <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
Subject: Re: [PATCH v8] dt-bindings: regulator: add document bindings for mpq7920
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:40 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Changes on v8 :
>       - fixed error reported by dt_binding_check

Still broken. :(

Rob
