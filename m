Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670FBC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D51422527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="Pwe9wDFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgATT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:59:21 -0500
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21128 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1579550348;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Subject:From:To:Cc:Message-Id;
        bh=zGEdNMOLYUYRRFqkqQsKe15wlZAeAg0gSQKMVkqOP1g=;
        b=Pwe9wDFD2vVddbh4roqz2VZ+YSXzOhU7ZRLVdYZHQNQ4wDVmXyadx67RG0G5iEob
        Cl7YPIGzVqy1fqpo08WLBkZEVb7ytHY1ooWF4rfqvPuNcrOXAQ/YHRk+dt96FxDd3Nt
        LqisxORP7jbEwJheB7gfR5YRBhv8aQaFNCIC9WxM=
Received: from localhost (195.173.24.136.in-addr.arpa [136.24.173.195]) by mx.zohomail.com
        with SMTPS id 1579550343636345.40512828000374; Mon, 20 Jan 2020 11:59:03 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Mon Jan 20, 2020 at 12:03 PM
Originalfrom: "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Original: =?utf-8?q?Hi_Stephen,
 =0D=0A=0D=0AOn_Sun,_2020-01-19_at_20:17_-0800,_Steph?=
 =?utf-8?q?en_Brennan_wrote:=0D=0A>_When_booting_Raspberry_Pi_4B_using_a_m?=
 =?utf-8?q?icro_SDHC_UHS_class_1_card,_the_SD=0D=0A>_card_partitions_never?=
 =?utf-8?q?_appear_in_/dev.__According_to_the_device_tree=0D=0A>_bindings_?=
 =?utf-8?q?for_Broadcom_IPROC_SDHCI_controller,_we_should_use=0D=0A>_"brcm?=
 =?utf-8?q?,bcm2711-emmc2"_compatible_string_on_BCM2711._Set_this_compatib?=
 =?utf-8?q?le=0D=0A>_string,_which_allows_these_cards_to_be_mounted.=0D=0A?=
 =?utf-8?q?>=3D20=0D=0A>_Signed-off-by:_Stephen_Brennan_<stephen@brennan.i?=
 =?utf-8?q?o>=0D=0A=0D=0AYour_UHS_class_1_card_should_work_out_of_the_box_?=
 =?utf-8?q?using_the_current_kernel=0D=0Aversion._Note_that_the_device_nod?=
 =?utf-8?q?e_is_defined_here:=0D=0A=0D=0Ahttps://git.kernel.org/pub/scm/li?=
 =?utf-8?q?nux/kernel/git/torvalds/linux.git/tree/arc=3D=0D=0Ah/arm/boot/d?=
 =?utf-8?q?ts/bcm2711.dtsi=3Fh=3D3Dv5.5-rc7#n255=0D=0A=0D=0Aand_enabled_he?=
 =?utf-8?q?re:=0D=0A=0D=0Ahttps://git.kernel.org/pub/scm/linux/kernel/git/?=
 =?utf-8?q?torvalds/linux.git/tree/arc=3D=0D=0Ah/arm/boot/dts/bcm2711-rpi-?=
 =?utf-8?q?4-b.dts=3Fh=3D3Dv5.5-rc7#n98=0D=0A=0D=0ARegards,=0D=0ANicolas?=
 =?utf-8?q?=0D=0A=0D=0A?=
In-Reply-To: <936f10bbeca467ea8ebc669280a50c688730689d.camel@suse.de>
Date:   Mon, 20 Jan 2020 11:59:00 -0800
Subject: Re: [PATCH] ARM: dts: bcm2711: Use bcm2711 compatible for sdhci
From:   "Stephen Brennan" <stephen@brennan.io>
To:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>
Message-Id: <C00VV4QDHC2Q.20QYUR6KOPB8G@pride>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

You're right, this patch doesn't work (it doesn't even touch the correct=20
device tree node). My bad.

> Your UHS class 1 card should work out of the box using the current
> kernel version.

I've been debugging an issue (reproduced on today's linux-next) in which my=
=20
UHS class 1 card's partitions don't show up in `/dev`. For example, if I do=
=20
`ls /dev | grep mmc`, I get just one result, "mmcblk1". I thought my patch=
=20
fixed the issue, but it turns out that the issue is sporadic: on some=20
boots, the issue manifests. On others, the partitions appear in /dev as=20
normal. When I tested this patch, the issue had sporadically disappeared,=
=20
leading me to believe the patch was effective.

Sorry for the noise! If you have any suggestions on debugging this, I'd=20
appreciate it. As far as I know it could be anything - the particular card,=
=20
the particular Pi, etc.

Thanks,
Stephen

