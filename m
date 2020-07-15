Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F8EC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC8206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="LJvkg8GG";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="FqIxAzTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgGONc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:32:59 -0400
Received: from djelibeybi.uuid.uk ([45.91.101.70]:50160 "EHLO
        djelibeybi.uuid.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbgGONc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NMFdGnynEXqfWa9Heq3oIWzpS++cOfT6IC0BYKcqnB8=; b=LJvkg8GG26kYf7nLFxn57N1DzL
        PlTpMD18CPHkz4hfqo3o0OLueNlA6RuRhH1pjQetkNbKayc05A6RLSnX9XN+GalweM2anXwPhaftS
        +SdLHl6FPmS206vHE+uBtWI8OFBjwqVl3unmBkxKm+Nnq4EU4Koigv8EaqJ8FYWnXqu6L35LUtTnx
        JrQGv+tkM94YC2YiB6FClqAGNID5Vaubdbu8T7tGC5Q1mI4V/A45GhlxuoGLnZYwGDTLPndbSmGmb
        r+034be/9YtIlRAmq4kW3op+Ln2AXPpvBFguc/srSSdOn688ii+UZxbMBshLRNTEMkFSi9Ex40Vhb
        +qpLJldg==;
Received: by djelibeybi.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <simon@octiron.net>)
        id 1jvhWa-0005kE-5N; Wed, 15 Jul 2020 14:32:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version;
        bh=NMFdGnynEXqfWa9Heq3oIWzpS++cOfT6IC0BYKcqnB8=; b=FqIxAzTo7U3PEEnnrfUuc2hWhz
        TQf/NGL/p2kMjsohUM0SekrhQmKQvLrysSL43r1faa5OCwHnqSiBqeDetwCKQmQ904UhYUW8YeARy
        9pdNLlkgNnWIhverb815U9nTpCWZP3kp3CF2YroOkwPWtIcg6BIaoHTRphdOPjhaY97mJhckTiZ2I
        TzaQeq7iHksbG/WX+iaCbc8fh1+7kOuvwXwCl2+QWQmWDGTntYkPWLFDUBXLTe7NbruY+4dJy4oFP
        Z/uDPv86lUomAgtK/4/m3ju08eURTWu9aFmSnLrysr6G+7HPIuLUTnMmQIxakxkk95u2af7tY/n3g
        kSEpqcyQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvhWL-0000pJ-4o; Wed, 15 Jul 2020 14:32:36 +0100
Received: from localhost ([::1]:45596)
        by skund.uuid.uk with esmtp (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvhWK-0004hS-8Q; Wed, 15 Jul 2020 14:32:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 15 Jul 2020 14:32:24 +0100
From:   Simon Arlott <simon@octiron.net>
To:     =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc:     jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
In-Reply-To: <20200715131803.1762064-3-noltari@gmail.com>
References: <20200715131803.1762064-1-noltari@gmail.com>
 <20200715131803.1762064-3-noltari@gmail.com>
Message-ID: <2e28eed25955385ab2513f8b617829f3@arlott.org>
X-Sender: simon@octiron.net
User-Agent: Roundcube Webmail/1.2-beta
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15 14:18, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
> ...
> +MODULE_DESCRIPTION("BCM63xx USBH PHY driver");
> +MODULE_AUTHOR("Álvaro Fernández Rojas <noltari@gmail.com>");
> +MODULE_AUTHOR("Simon Arlott <simon@fire.lp0.eu>");
> +MODULE_LICENSE("GPL");

I'm not the author of this.

Nacked-by: Simon Arlott <simon@octiron.net>

-- 
Simon Arlott
