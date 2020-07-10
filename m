Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8462C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C277220748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gcBOHDl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSBM4Gbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGJMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:33:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42433 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbgGJMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:33:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EEE94B31;
        Fri, 10 Jul 2020 08:33:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Jul 2020 08:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cXcXOII33t0RHxaHh5tz3TF76Jp
        tmJCIWZfBKpY8k2M=; b=gcBOHDl04o+KVw5sM6aGWs77ait0TB+mmfH3bPwZb5z
        aI4ABSXm0gxtNT58bY+R+2kM8HwfJecYZLz5rktZhhsfL8fDDHC/d76vBJtJcoxB
        6dl6Ixb48qINjLZBtmJSdhXCdzt1vKr5yortFL+rSlbDy2U7geGbNeWGsCk33hl3
        Ll/GB4JxUAxQ9BxqRP6XdIt5jxfcQe/ffJEo1zS0BncYY7Y5vHk9iHvC5vLvwN08
        /V/gAy20E4kg//wYbLO591bHSxrkdVGNGrwHXjLZf0tfQo1vgbg2X0Nt/87r34zj
        AI0wJ731rH9BxE1eAoTPhgUhMNYxcckVyaa9kA8o8mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cXcXOI
        I33t0RHxaHh5tz3TF76JptmJCIWZfBKpY8k2M=; b=pSBM4Gbw3PUgUogMJT16bH
        uuovdxH+QN44GVykCE4fEBL72cme6tjSNNcvdFIH+Fx1QFo7ssrKEJqJkid9gQ+Z
        thrkKKxBd3sOYD5VK0Bvujd3gsQK6csqRwzxZV61FqnJfzRgICOZJgF1dtnTxkcu
        ir/ciaA8wJ0VWVWOvpiPZJOnnlHtvW1A3PaiR8DhFVpO+6r9pVqoqGElT6YJlnhP
        cRW5djiVuck1L7Bs4n0bsKhAwYtcgS3Cm2iKZKueNTV1UoN2e/SXSHA11pgh3ZTf
        NXNGk2rHCp56AVS4/nRoM49VKZmSBXCOQGNw+QND3CPE+Q4Pew2wshIw8zmzIZhg
        ==
X-ME-Sender: <xms:BGAIX0PlJvTUImgwcSCGgsC3r_8_T5k7H4jn-8SBA5mmVKSrIRHN2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeujefgiedvgfeifeeuveegjeehtddtheegleeghedvgefhtddvgfdvjeekvdef
    ueenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:BGAIX6_rQ6IB2qYC8k7rIdHyJvIGkxudjcsDBCqH7HdYGiHQAkgarA>
    <xmx:BGAIX7TrXhtCnYqC8guhUoY55lURVNqanTSbl3VoucRQgNz8Nh02PQ>
    <xmx:BGAIX8t_AZYsQKiZw31ZGOKJzJWl2scyyp7Znnu__tEfv7yBQv5NMQ>
    <xmx:BmAIXxHXHUSW0BlrCXIaf0OSWsAyhNWYcwQMY2u0CIomBsuHgtKxdg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B1983280059;
        Fri, 10 Jul 2020 08:33:08 -0400 (EDT)
Date:   Fri, 10 Jul 2020 14:33:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v3 14/16] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
Message-ID: <20200710123306.wlqadpz4tuy2r3jc@gilmour.lan>
References: <20200708082505.28910-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708082505.28910-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for sending a new series

On Wed, Jul 08, 2020 at 04:25:05PM +0800, Frank Lee wrote:
> +	thermal-zones {
> +		cpu_thermal_zone {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 0>;
> +		};
> +
> +		gpu_thermal_zone {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 1>;
> +		};
> +
> +		ddr_thermal_zone {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 2>;
> +		};
> +	};
> +};

The node names shouldn't have any underscore, otherwise it will generate a DTC warning.

Maxime
