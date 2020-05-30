Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A8207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="mhLNh75T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgE3HSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:18:06 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:34790 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgE3HSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:18:05 -0400
Received: from halation.net.flygoat.com (unknown [IPv6:240e:390:496:b320::d68])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 9020420E8D;
        Sat, 30 May 2020 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590823084; bh=FokPmXVAmxcnVPTY1hKOBLr9DbGlwiipDcqx7CnsyLs=;
        h=Date:From:To:Cc:Subject:From;
        b=mhLNh75TUpn2Ry6HuI0nCWnGDcXsCtjZvU9iJwuuP3hwMpgEJgb8m/EmIGLKwHaN7
         c1bgvQ87OxVojzF80t3wt41pou3sWnoUdc3twFKwGWedF0oBmL1wv8CJ3WwNS0KEze
         kYILkyIaH9hwcLAsMKpGqCMBuC6EqJJSIT/zeiD3zOG1pw9NqFFMoZC/kEJsP8CNsV
         REjf+NFhvCr6qHuSxoyVr4uEK1hm+skhNe1Q+nq+YerLF9U1mxGd583VcfDnEW3Jo5
         b3x4sgysP/pQ6H/hbnMrkopI8QbimuCYbVb1OAxXh1DuTfpFjmYbrFDr4Oz75gssuo
         X2++150GGBReA==
Date:   Sat, 30 May 2020 15:17:52 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     robh@kernel.org
Cc:     apw@canonical.com, joe@perches.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: checkpatch warnings with PCI DT compatible string
Message-ID: <20200530151752.2f40fb08@halation.net.flygoat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

When I was trying to create dts for my platform that need PCI
DeviceTree sub node to express interrupt of children devices under the
bridge, like this:

pci@1a000000 {
    compatible = "loongson,ls7a-pci";
    device_type = "pci";
    #address-cells = <3>;
    #size-cells = <2>;
    #interrupt-cells = <2>;
    msi-parent = <&msi>;

    reg = <0 0x1a000000 0 0x02000000>,
        <0xefe 0x00000000 0 0x20000000>;

    ranges = <0x01000000 0x0 0x00020000 0x0 0x00020000 0x0 0x00020000>,
            <0x02000000 0x0 0x40000000 0x0 0x40000000 0x0 0x40000000>;

    ohci@4,0 {
        compatible = "pci0014,7a24.0",
                    "pci0014,7a24",
                    "pciclass0c0310",
                    "pciclass0c03";

        reg = <0x2000 0x0 0x0 0x0 0x0>;
        interrupts = <49 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-parent = <&pic>;
    };
};

I got such checkpatch warnings:

WARNING: DT compatible string "pci0014,7a24.0" appears un-documented --
check ./Documentation/devicetree/bindings/ #206: FILE:
arch/mips/boot/dts/loongson/ls7a-pch.dtsi:38:
+                               compatible = "pci0014,7a24.0",

WARNING: DT compatible string vendor "pci0014" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml #206:
FILE: arch/mips/boot/dts/loongson/ls7a-pch.dtsi:38:
+                               compatible = "pci0014,7a24.0",

Just wonder if using such compatible string is allowed?

I've saw some some usages like mine in the tree, such as
arch/x86/platform/ce4100/falconfalls.dts, and
arch/mips/boot/dts/img/boston.dts.

If that's allowed, should we surpress these warnings in checkpatch
script?

Thanks.

--
Jiaxun Yang 
