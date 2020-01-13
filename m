Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870ABC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520962075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578935693;
	bh=DMJ6Zq27zpzSm4Mi1M5x6uTbU67ONvjUrJ3NP3l7Om0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=odZbUjnsnw6iHJYcHlCNG2KoxbYS130+xRdAtrTipNdUVd3Y7zuUA5hOZ0GZ/1lIR
	 vW7G91oHJWAmmf2tgF0uot9WxNen9uq4I6qa8nsXhVGx89c5U6wgX0wxL5PTy1JcVg
	 V6vXR0lvA/azJo4Er3vfqumS97rwEvpbp9eQE7ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAMROw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgAMROw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:14:52 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4170222C3;
        Mon, 13 Jan 2020 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578935691;
        bh=DMJ6Zq27zpzSm4Mi1M5x6uTbU67ONvjUrJ3NP3l7Om0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LvxlCKw3pC4QKJetABRtahNWVA5s87E5YYScPrs9R7CcXYYMvqMYynyeYY4V6onFy
         3WiQmHep7MEtht5ivDmMi9Z5u7G0upm31uQ4H5qAdU2pIWnbUD/1kQ4/EeqHSnEZOR
         Qp/OWjt1Thk6CCC+YT3D4e7pYgmnnn27G9LKCuI8=
Received: by mail-qk1-f178.google.com with SMTP id a203so9213733qkc.3;
        Mon, 13 Jan 2020 09:14:51 -0800 (PST)
X-Gm-Message-State: APjAAAUj4bXltB6LlVreS/D9x6iq6iYIuxbMHuQQA6hg7hmxjsNoh/o/
        VXtx3tv40GbervWGbfE4ik7dPV1EAl4OD9GWcQ==
X-Google-Smtp-Source: APXvYqwN4sTBk+vJ3V15LYm87C3y9ukdHYO8O+NVnBJCfv7nbyBBoVpSkWtMeaLDnNN4L8QnBhsvo3WG9LnUdMiHeX4=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr17549341qkd.223.1578935690761;
 Mon, 13 Jan 2020 09:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20200109112548.23914-1-sravanhome@gmail.com> <20200109112548.23914-2-sravanhome@gmail.com>
In-Reply-To: <20200109112548.23914-2-sravanhome@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jan 2020 11:14:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jyVzSfXr1txMUm7VTk-LFunaukQQ-LoQj4OMHgyzRHQ@mail.gmail.com>
Message-ID: <CAL_Jsq+jyVzSfXr1txMUm7VTk-LFunaukQQ-LoQj4OMHgyzRHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: Add an entry for Monolithic Power
 System, MPS
To:     Saravanan Sekar <sravanhome@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:25 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add an entry for Monolithic Power System, MPS
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Mark, And revert this too. It's a duplicate of what I already have in
my tree and this one is not alphabetized correctly.

Rob
