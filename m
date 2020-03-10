Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A492C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F283208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HRuCOVZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCJSZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:25:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:53105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgCJSZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583864741;
        bh=bFNqpua+YkzWFVc3UHXXvzS3AdF4ncGup9hQJF7JgsM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HRuCOVZZtfp+KcUwATt3A57HJU3nd/6Gt3AGzr8fVOQ26mh/cYH8AvkJDaxla7LrH
         WTHAoWtV6HOELVnR0phT97MYCOHjJ4dF08SpizBl2jgwiDyCSCsw0LT97S8OzR8//y
         ZTjtvv+/hCleFNMOElJQ1mYObS/pvkipnTZiGdtA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom ([188.223.33.120]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1j2h0v3fpx-009C8y; Tue, 10
 Mar 2020 19:25:41 +0100
Received: by zoom (Postfix, from userid 2000)
        id 33D2119C87C9; Tue, 10 Mar 2020 18:25:39 +0000 (GMT)
From:   nick.hudson@gmx.co.uk
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nick Hudson <nick.hudson@gmx.co.uk>, Nick Hudson <skrll@netbsd.org>
Subject: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
Date:   Tue, 10 Mar 2020 18:25:37 +0000
Message-Id: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:3/Rt0YeR7CTtZzR1Fqp91cdaAaSx69K/t/4zI3jdBuV2UhzC3n4
 MmdrwDddFGb8jLk2u+lcAMOmgNAeNjmwa/lg/1z7eoVYBNlrndFDsOo/rolirFwofzX0Xs3
 RdIe3l8fONwTn+qW19f4sOCCoWTZzTvJVybor7qfgr3Dcf1ym5LAEQm+f+uXWLvoQ0iJpAG
 k2bQo6mSBNTu2p3vK70Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gG3GKwolD78=:s7UQlNhpF4wArl+OpyY9rX
 YE2f5jIYCHVmzWKuayMb7Q1H5k441i+Z0RmUEJETKfGzl5KrzR6u8boufYIwY2bG/NqhaXJxr
 BoLcoABo1rlpj+sUJoDJ72SIjPNKgEjdPpD7xRuT91Zk4S0yMZMuhe2qPkqkP6c056JNIzKaL
 h7tJWQsK0co+oE55lpBRzz/bVJ9H92+Il1pbzUSpQPu6BaH4d7OxN51G17AZUUQhGFOiDqame
 1NOqVklyU2bqm1elS6OVzKxlAJz/mp+QTmwkmPB8EQOOv/3D02Tlvjvh6DcxuxDmsmhvgIZOU
 To8eesWE8heEzGOXhM8w2XbFSf2z9vKUJUmn1zWsH/LC05iRVDNi/tlOLVP6BiJusJ1EhmYv9
 70ICsPqYVo+Glc2OrbvUKrU9pfqLcjkuBNVQgUmtM94K1M1ZEglarxO1zJJLkjyLW83ml+Jew
 3XW57bDRfct6k0Y2fgfOq+xKtlzCn6uRD4KTjhuurNxdxE8Qxii3BDsmB0VteM/CgxT9NRS/o
 v++5alr6LXvAtA4BjIjZzQb1lJsbfqr3t+AuXjMWMQDyJOWf71tGkRObBixwTBMNCV9rYBZfU
 ilA6pK0oHPNjFn+kM0t95opLSBc0J7Ze5fEFdLDzFtbHOGcMGT3chtHN2CnDFhvhzWfqEZ+3p
 qgZV6uiXviDBPZjqw58lJ++/ht/UNlWitM5zpFoOeW3GFwbu4Vb5WfOFdAdqDf0NOeefqHbJ0
 yrNh/+p4KWBTWTp8DR4MtpG+YkOps5qp0RBlYiWdEkbwaDrVW9FdbOp/4lrftyGNNGiuiblVa
 b9nDznXG+UNDApsO+oWH3g8iQyD88hcQt/XaDn4YupsPTe7A46aAZUPF7f/nP3BWJDTTe5kL0
 YGrcwSHB4Of3mhKmAFWKDr+mGbANqcHGfKhXn58w2RD7WVBvTbb8vBInhiz7knJw1IFTXzBFL
 ZiVxLKkYdXl0M8stLzYqKZeRX73rUIm6VHFpxiNB7rr19FS0UmRf36FXX6FKBL6xd+pykwjG2
 IEP9j8w3px+E2nRzvhV7MWTXJUeWj/8dKMQ16bwR97GcHum2CkZw3yfelfRRCRJcd+43vig70
 dmJkTJwwvTsddA/DTpJLLGXs8PIpsO+2K5HN07diWVo9vLjmaRFXNcMNhGQSfME50BzZL+dIG
 TNTn2xgnr+BApp6+9BhIRHk/MGJIKMKL8EZ8bOWtg/U5hPnqESVru8G7V74L3l+JxgQ6XFoi7
 q2JTZfQneUOsuPraT
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hudson <nick.hudson@gmx.co.uk>

Define the sdhci pinctrl state as "default" so it gets applied
correctly and to match all other RPis.

Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/=
bcm2835-rpi-zero-w.dts
index b75af21069f9..4c3f606e5b8d 100644
=2D-- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -112,6 +112,7 @@
 &sdhci {
 	#address-cells =3D <1>;
 	#size-cells =3D <0>;
+	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&emmc_gpio34 &gpclk2_gpio43>;
 	bus-width =3D <4>;
 	mmc-pwrseq =3D <&wifi_pwrseq>;
=2D-
2.17.1

