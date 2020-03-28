Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10447C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CCB2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="l1mm2gYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgC1M03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:26:29 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:28527 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC1M01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585398385;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Message-Id:Cc:Date:From:Subject:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=RRAAjZ7ibcbK3nazLeHJkueAnEPgXuK0f3ZKyFebqYw=;
        b=l1mm2gYYE4tZVc3EqsoJzlNPnB9wcBUnzmsc8RDTw6+QgEuJdZ6A9sAk86QYnqjXYg
        T/xn2fKVsU5mjqCZmGU+0lxhl9p7Zsso5UGqQJrcaoDgDu7u05c3mpFFx5zzAnySI0MF
        U6+lKt4C46OCxaKoVr19jQ2x8o8GYPRINq0FjR52TUMaPK/PlOfHLaJa6A7hVlPKfUKZ
        89ySalSilms06UzcPTllWb/wkPvMj5bHPWaScICB3tzHVGmGtdmMy1vgw8WXr6Dx9Rom
        /kKdP8e7DT2bx5iUvhx4SiUKOQ81KNlKraqVqnsi0nNim7ywSmGsk6yVXRzGdZe7zH1a
        8Cjw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWcXA4N8z4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id m02241w2SCQP8yj
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sat, 28 Mar 2020 13:26:25 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: CHKDT error by f95cad74acdb ("dt-bindings: clocks: Convert Allwinner legacy clocks to schemas")
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Sat, 28 Mar 2020 13:26:24 +0100
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A65A26D8-9F66-4D46-B1E1-84ECECF079E3@goldelico.com>
To:     Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
I am trying to check my new bindings with v5.6-rc7 but get this before
the process tries mine:

make dt_binding_check dtbs_check
...

  CHKDT   Documentation/devicetree/bindings/bus/renesas,bsc.yaml - due =
to target missing
  CHKDT   Documentation/devicetree/bindings/bus/simple-pm-bus.yaml - due =
to target missing
  CHKDT   =
Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml =
- due to target missing
=
/Volumes/CaseSensitive/master/Documentation/devicetree/bindings/clock/allw=
inner,sun4i-a10-ahb-clk.yaml: Additional properties are not allowed =
('deprecated' was unexpected)
make[2]: *** =
[Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.examp=
le.dts] Error 1
make[1]: *** [dt_binding_check] Error 2
make: *** [sub-make] Error 2

What am I doing wrong?
Is there an option to skip such errors and continue?
Is there an option to just test my bindings and yaml file?

BR and thanks,
Nikolaus Schaller

