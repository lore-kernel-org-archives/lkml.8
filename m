Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB49C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4CB20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594835642;
	bh=9g8aeLK9REP1cLVWsPlMudE6ohkuFFjl/Cs+LGSZ6P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Duhg/ErzWbRA8NUmgPknDAKSe8+uR6kxU0gNHZi10LuN/sdOc+Aqr9Geile5Ri0y9
	 tJPD2sv6ySZqIZPlG3i7XHcukmn0IAEAXlI6WlA/660rGnJ2K0hMHdSh+fEny9Fk8A
	 /ol9x2EQgoi5qaj1NAkwO5mRCtc46FsfCYO9QS6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGORyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:54:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44995 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:53:59 -0400
Received: by mail-io1-f65.google.com with SMTP id i4so3151758iov.11;
        Wed, 15 Jul 2020 10:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3B3mLxesRLNcERsb3dRLB4kBnpbANKyx7xmsh9Ksh8=;
        b=eIHWUOiOdzmrIHnDI3VVZSZz2bhwv1NFQW8JvRL2mO3yq6dc5W9vzYRALFK8k3py9Q
         VkW150/UUelWqKB8wL7jJGxFS6rk4rT0bYlC3L5pQoc5yNdKxzhMOEqFCke6ACNhxJuq
         9UW+tGi6ZllWZma9xMNy0nhvVOQkviFks/Z/88AU3cgKS/bcLg9XgV/uhi+WA+JBTIkm
         1mTSZFJZoIcyBzh76dNnDqTCKVuScAX3OrNagao+WfmgSvQ5rJFEgwKrV6SH8byIJXal
         Fde6OAOutJ1EfJAurr4/xlHiLk/LUhPV+6rr/vvCYDpgbjH/6GsCSms+/AvPvQJ2vqGw
         6HwQ==
X-Gm-Message-State: AOAM531o1lfeANz/Ise03RmeVctS0pWnvjfOennE5Vt8GWlULYBKOops
        mNWHNVaVKjIOrVxyVeRJnFL+0dTOyg==
X-Google-Smtp-Source: ABdhPJx5JOOO2YSgNc4SGZxFHsxJyNx/SGb0yWUOzjfTsY5cWxBY1ZnqpvTk5wIBElTlc0mSwwxtEA==
X-Received: by 2002:a6b:b74e:: with SMTP id h75mr428154iof.79.1594835638606;
        Wed, 15 Jul 2020 10:53:58 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u6sm1359427ilg.32.2020.07.15.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:53:57 -0700 (PDT)
Received: (nullmailer pid 504090 invoked by uid 1000);
        Wed, 15 Jul 2020 17:53:56 -0000
Date:   Wed, 15 Jul 2020 11:53:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vigneshr@ti.com, heiko@sntech.de, robh+dt@kernel.org,
        richard@nod.at, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20200715175356.GA502928@bogus>
References: <20200715090342.28339-1-yifeng.zhao@rock-chips.com>
 <20200715090342.28339-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715090342.28339-2-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 17:03:39 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v7:
> - Fix some wrong define
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> 
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> 
> Changes in v3:
> - Change the title for the dt-bindings.
> 
> Changes in v2: None
> 
>  .../mtd/rockchip,nand-controller.yaml         | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.example.dt.yaml: example-0: nand-controller@ff4b0000:reg:0: [0, 4283105280, 0, 16384] is too long


See https://patchwork.ozlabs.org/patch/1329325

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

