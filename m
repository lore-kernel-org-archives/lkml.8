Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937AA206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TjF4RIOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHPOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHPOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:51:24 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC1C061786;
        Sun, 16 Aug 2020 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NoN57z0LnBJygmJee85tVg4DqzTUK5uFjGWNnvay0aQ=; b=TjF4RIOtBO1h+2uQWgmd45eINO
        itEdfM6ctmaMutKhqrRG/hOVjWBzXK6xWlyOrylVV44aIU/DHYxH7Mf2+Gfob67Jz8sCiVFqGQGV4
        lCplVaU4fsd3IDZQSxZ3mnHF8E8EmilLTQskTeeV3sbzn7/roqlLIBNlf8Rc4PcgO9E0=;
Received: from p200300ccff18ab001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff18:ab00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k7Jzv-0003bv-Pk; Sun, 16 Aug 2020 16:51:00 +0200
Date:   Sun, 16 Aug 2020 16:50:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, rjones@gateworks.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine
 2 HD
Message-ID: <20200816165058.3a17d97a@aktux>
In-Reply-To: <20200816125247.GA103070@latitude>
References: <20200815193336.21598-1-andreas@kemnade.info>
        <20200815193336.21598-3-andreas@kemnade.info>
        <20200816125247.GA103070@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems that we have different hardware, so the first question is
first the most interesting thing: how much does the hw actually differ,
especially do they require different device trees?

Can you provide me a photo of your hardware?
Or is it a Shine 3?

Mine is at https://misc.andi.de1.cc/tolino2.jpg

On Sun, 16 Aug 2020 14:54:41 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

[...]
> > +
> > +&usdhc3 {
> > +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> > +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> > +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > +	pinctrl-3 =3D <&pinctrl_usdhc3_sleep>;
> > +	vmmc-supply =3D <&reg_wifi>;
> > +	mmc-pwrseq =3D <&wifi_pwrseq>;
> > +	cap-power-off-card;
> > +	non-removable;
> > +	status =3D "okay";
> > +
> > +	/* CyberTan WC121 SDIO WiFi */
> > +}; =20
>=20
> The HWCONFIG block from my Shine2HD reports RTL8189 as the Wifi chip
> (value 8 at offset 4), and kernel logs from the vendor kernel appear to
> agree that it's a realtek chip, at least (lines prefixed RTL871X).
>=20
Just for the readers with IMX knowledge but without knowledge of the
vendor kernel hacks used here: That block is on a hidden partition of
the boot medium (uSD or eMMC) describing the hardware, the kernel gets
it from the bootloader and it is used e.g. in the board file.

My hwconfig is:
{m_hdr =3D {cMagicNameA =3D "HW CONFIG "
 cVersionNameA =3D "v2.6"
 bHWConfigSize =3D 62 '>'}
 m_val =3D {bPCB =3D 50 '2'
 bKeyPad =3D 13 '\r'
 bAudioCodec =3D 0 '\000'
=20
    bAudioAmp =3D 0 '\000'
 bWifi =3D 7 '\a'
 bBT =3D 0 '\000'
 bMobile =3D 0 '\000'
 bTouchCtrl =3D 11 '\v'
 bTouchType =3D 4 '\004'
 bDisplayCtrl =3D 7 '\a'
=20
    bDisplayPanel =3D 6 '\006'
 bRSensor =3D 0 '\000'
 bMicroP =3D 0 '\000'
 bCustomer =3D 0 '\000'
 bBattery =3D 1 '\001'
 bLed =3D 4 '\004'
 bRamSize =3D 3 '\003'
=20
    bIFlash =3D 0 '\000'
 bExternalMem =3D 0 '\000'
 bRootFsType =3D 2 '\002'
 bSysPartType =3D 11 '\v'
 bProgressXHiByte =3D 1 '\001'
 bProgressXLoByte =3D 104 'h'
=20
    bProgressYHiByte =3D 2 '\002'
 bProgressYLoByte =3D 228 '\344'
 bProgressCnts =3D 0 '\000'
 bContentType =3D 0 '\000'
 bCPU =3D 5 '\005'
 bUIStyle =3D 2 '\002'
=20
    bRamType =3D 5 '\005'
 bUIConfig =3D 0 '\000'
 bDisplayResolution =3D 5 '\005'
 bFrontLight =3D 13 '\r'
 bCPUFreq =3D 0 '\000'
 bHallSensor =3D 1 '\001'
=20
    bDisplayBusWidth =3D 0 '\000'
 bFrontLight_Flags =3D 4 '\004'
 bPCB_Flags =3D 17 '\021'
 bFrontLight_LED_Driver =3D 3 '\003'
 bVCOM_10mV_HiByte =3D 0 '\000'
=20
    bVCOM_10mV_LoByte =3D 0 '\000'
 bPCB_REV =3D 0 '\000'
 bPCB_LVL =3D 0 '\000'
 bHOME_LED_PWM =3D 0 '\000'
 bPMIC =3D 1 '\001'
 bFL_PWM =3D 0 '\000'
 bRTC =3D 1 '\001'
=20
    bBootOpt =3D 0 '\000'
 bTouch2Ctrl =3D 0 '\000'
 bTouch2Type =3D 0 '\000'
 bGPS =3D 0 '\000'
 bFM =3D 0 '\000'
 bRSensor2 =3D 0 '\000'
 bLightSensor =3D 0 '\000'
=20
    bTPFWIDByte0 =3D 0 '\000'
 bTPFWIDByte1 =3D 0 '\000'
 bTPFWIDByte2 =3D 0 '\000'
 bTPFWIDByte3 =3D 0 '\000'
 bTPFWIDByte4 =3D 0 '\000'
 bTPFWIDByte5 =3D 0 '\000'
=20
    bTPFWIDByte6 =3D 0 '\000'
 bTPFWIDByte7 =3D 0 '\000'
 bGPU =3D 0 '\000'
 bPCB_Flags2 =3D 0 '\000'
 bEPD_Flags =3D 0 '\000'
 bLAN =3D 0 '\000'
 bMobileIF =3D 0 '\000'
=20
    bPIR =3D 0 '\000'
 bPanelLaminationSrc =3D 0 '\000'}
 m_bReserveA =3D '\000' <repeats 24 times>}


> From my experience with the CyberTan WC121, it has a Broadcom fullmac
> chip inside. Now I wonder where this discrepancy or variability comes
> from.
>=20
correct. It uses the brcmfmac driver on mainline and the .
bcmdhd in the vendor kernel

Output on the vendor kernel:
bcmsdh_register: Linux Kernel SDIO/MMC Driver
[bcm_wlan_get_oob_irq-43] gpio 127, irq 383
dhd_conf_set_hw_oob_intr: Enable HW OOB for 43362
F1 signature OK, socitype:0x1 chip:0xa962 rev:0x1 pkg:0x9
DHD: dongle ram size is set to 245760(orig 245760) at 0x0
dhdsdio_probe: Disable prop_txstatus
dhd_conf_set_fw_name_by_chip: firmware_path=3D/system/lib/firmware/wc121/fw=
_bcm40181a2.bin
wl_create_event_handler(): thread:wl_event_handler:92d started
tsk Enter, tsk =3D 0xdb501304
p2p0: P2P Interface Registered
dhd_attach(): thread:dhd_watchdog_thread:932 started
dhd_attach(): thread:dhd_dpc:933 started
dhd_attach(): thread:dhd_sysioc:934 started

On mainline:
[   11.686469] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43362-s=
dio for chip BCM43362/1
[   12.282783] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43362-s=
dio for chip BCM43362/1
[   12.387000] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (e=
rr=3D-11), device may have limited channels available
[   12.479403] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43362/1 wl0: M=
ay 16 2018 23:42:49 version 5.90.244 FWID 01-0


> I guess the SDIO setup can deal with different chips (like Broadcom vs.
> Realtek) as long as the board has been designed to always use the same
> reset/power/etc. lines. I don't see any branching based on the 'Wifi'
> HWCONFIG entry in the vendor kernel, so I guess that's the case.
>=20
as long as these chips do not use oob interrupts, just sdio,
it should be no problem. The question is just how much our devices
differ.

Regards,
Andreas
