Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC911C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E36620674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="uJNzDuDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBDKen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:34:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgBDKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:34:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so2911635wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XCYQuXOsEa3amwBAE0MdHl+l7HQHKrgjj6YtdNoNSCY=;
        b=uJNzDuDIBrxfkrSMoIF8sumQ1Qk6Enzo0YYveDFEAa6Z1fgvL13kO1yspfNxThxdg7
         izToQLfRBthR+BDUqqkzJWGU+nerMVYQzmuHflz4CUJhpoCYNApxnf95zi1NZDxzpHFl
         WSRIT+748Xo4IcErvr82swBreWIxuH1j6V0TvnQBVlMAxyMgIEpesjx4OHhnH7TWuKe8
         3TUqbbih80Xim00tZVFYDzR7g+FVM/rRzyeeGZjaWCQU7+4lxqdt9NXLkiCtrVuhmuco
         M0Aaz0CV7mUV2DEKatMqyNyPiP+8mt2Hm31/PKJKcaW4C58X5tslvoxUlso/2Dhoi+BD
         R44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XCYQuXOsEa3amwBAE0MdHl+l7HQHKrgjj6YtdNoNSCY=;
        b=WcEoW7OzvtBLAhRIwT1m/bG8wS3BTdzeDRqiaG3vKTqhEeePhW48goRhNrG4zOlzuT
         zu7FcLQ+SuLoXvliHDB5l2X56rZZmiJ4dMQmMufHhYm2W7p65Bk4Ux3K9RqSZ87WniGB
         0e3S3NvgiGuwNgcBpP7hzwLxaDaFfa50R7MEJvCNPdGWL/bICQHPepW6zufOPfWEUjvh
         mV8snwDZGk5NxpnrOV8TbKpSChOsZGhjdYf+xpiQZS6K1F/pDFqVjC/g8h7j8RHBSDOc
         NSFmP0bava1wuJPB27EbYe5G5No9ftIPhrJVG3H302vHxsQ6WNzYzTwFaGZW0G92X7vC
         sUvQ==
X-Gm-Message-State: APjAAAUGO4+SAHo7xuM2bjXf5Sl5kyVudI57iFXwvxkETEji1eZmWVV8
        MSmzLZ9fUcj02X+S+UaY7VXNzP2FIsL2kev1w/5j5mqpsrM=
X-Google-Smtp-Source: APXvYqw30Zpxp1GzfYbp2HCXTP5cBsAU08r2WRTyVJA0GxeahQPIBFj7Rt9k6RqafFje+FcD8phmoFweXi3ywf4tQfo=
X-Received: by 2002:a1c:7919:: with SMTP id l25mr4912195wme.135.1580812481717;
 Tue, 04 Feb 2020 02:34:41 -0800 (PST)
MIME-Version: 1.0
References: <5e56ec0090bceb711dbab145ffffa52f60c23d87.1579009444.git.michal.simek@xilinx.com>
In-Reply-To: <5e56ec0090bceb711dbab145ffffa52f60c23d87.1579009444.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:34:30 +0100
Message-ID: <CAHTX3dK2DwzjC=7VhVsso_d-mjF1S=ifDNgEoZqDJDfGar3L3g@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Add ID for Microblaze v11
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 14. 1. 2020 v 14:44 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> List Microblaze v11 from PVR.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/cpu/cpuinfo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/microblaze/kernel/cpu/cpuinfo.c b/arch/microblaze/kerne=
l/cpu/cpuinfo.c
> index ef2f49471a2a..cd9b4450763b 100644
> --- a/arch/microblaze/kernel/cpu/cpuinfo.c
> +++ b/arch/microblaze/kernel/cpu/cpuinfo.c
> @@ -51,6 +51,7 @@ const struct cpu_ver_key cpu_ver_lookup[] =3D {
>         {"9.5", 0x22},
>         {"9.6", 0x23},
>         {"10.0", 0x24},
> +       {"11.0", 0x25},
>         {NULL, 0},
>  };
>
> --
> 2.24.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
