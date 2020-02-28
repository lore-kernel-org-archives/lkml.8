Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D485246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkaWDpUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgB1Cz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:55:59 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:14865
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbgB1Cz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:55:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHlrdQJvGtGTocsh4lZo7IGSf+YAHLnb9nVJcaSIYt9CD+WEspYP1G3QOQ8uE+UCR+MZy+D9Gwf/a/dVR/6xwMpde33VZqxWdPHaPRkeQFt3/FZtkItWj/pBTD1Uhl/C5i57p9vQcRFehKUAr/P9pjFSWiJuZfcgf+VieDbWisaFEoQ/Sl/0VUmCJXBZAPvoyOyxg8fQ5wCqf0CeBDWOTYizn2zLkeMcBaxHHBe5IxT56xk1WGEvaYFaFZwYqhqZO9Vn38rdneAonLfarvpSylzCfKLmkAJ84BWCNxf1AYLeTD/218w5+fCi5KyivJTW21OZ7qME8SQQWrNoLiGIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A+7HfbfNdLwq1uGHetYNPdwTJm2Jtlc9HuVSn+5EO4=;
 b=kOT5dDZ6zrrFr0GcuzF5+s1e3mLNGxmoVVdFayZ/lYVgifuDiqgJZQpZnOkYK/sz0xBnnS1MdFrfTb1S2fT9ULcni3T5GhPEVyud33l/mfhXOUntE4ARYNiCXxSHXQfnnvJc8TX9W7MKqGXIuwStwRpy6FJMGDiryqaWVYLY2GTeTUrNkI7oy0cncfvOfQACYuNsNIvp+f3zobFiqq13lVEnUUwqTrLgZUN3mcMUaQRL8JAcHC4su0RdmBr3jEFopoQrVnf5rJGrDfE/gGyrNK8xz37K28qbpnmtNCXjse8EG90/KnwRo0oj8OYJqcJgAZVrQl03gdxSdSkvSeU5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A+7HfbfNdLwq1uGHetYNPdwTJm2Jtlc9HuVSn+5EO4=;
 b=HkaWDpUkN8afSxhHMVHd7u8yXGr4lhGsO4zLJJRuP1hbfUuRNR+vpUjGTjKYJJtddo7eZ+gk1/LvHlV+ykcPXmzcaCUONuin9CAPOFbbW9NLbVKGBkTSp1P7mjlXBI4AsZdRar1z4qgC0Gc59PjMP2xIIR7P3pgzoecNNhLr8lc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.52.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Fri, 28 Feb 2020 02:55:51 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 02:55:51 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "harry.pan@intel.com" <harry.pan@intel.com>,
        "nobuta.keiya@fujitsu.com" <nobuta.keiya@fujitsu.com>,
        "malat@debian.org" <malat@debian.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "chiasheng.lee@intel.com" <chiasheng.lee@intel.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "heinzelmann.david@gmail.com" <heinzelmann.david@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        kbuild test robot <lkp@intel.com>
Subject: RE: [RFC PATCH v2] USB: hub: fix port suspend/resume
Thread-Topic: [RFC PATCH v2] USB: hub: fix port suspend/resume
Thread-Index: AQHV7XXifloh2j1eeUmVEpjTsUeGzKgvODqAgAAGbgCAAC7nAIAAe+NQ
Date:   Fri, 28 Feb 2020 02:55:51 +0000
Message-ID: <VI1PR04MB53275BFFED120FCA4717469C8BE80@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20200227164142.dsnbrxtk747tnvma@pengutronix.de>
 <Pine.LNX.4.44L0.2002271353300.1307-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2002271353300.1307-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [222.65.251.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13ac9a06-e88e-4e43-24d0-08d7bbf9b8d5
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-microsoft-antispam-prvs: <VI1PR04MB48304A88C5547CC7DDD8F4CD8BE80@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(7416002)(54906003)(110136005)(33656002)(45080400002)(64756008)(2906002)(4326008)(66556008)(66946007)(76116006)(44832011)(8676002)(66476007)(52536014)(186003)(5660300002)(26005)(81166006)(55016002)(966005)(86362001)(71200400001)(478600001)(7696005)(66446008)(15650500001)(6506007)(316002)(81156014)(9686003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZlP0NKJTLpmRLNayvUWiB7JnGOTc7IXVKKjMQ7gl1UWl1YxAmCwb8nPWFq+vg/+PE4u73HbdpOfHULCeZo/3fAGJX9jXhNPEVjeEtOFk50EhtUeQmtpcqC8sanThe5bV6aKZlXvB2d9fLg0jCwyPJPOPTm4n/Rc6ylpX1Dotj1VCmqhpBpJuwbkjnrgG5XqDcuuoLaZn/WiayG0JY73BDtEV7+CAggq2VsSCDYJEQOjACUIXHT2LQRgOpM6WDghNbFxnlLUq5zSpcWtzP+NFyflNcnljv2/f/U92KxZh1LNyV54Ef/OElr2ylUvzldo1fe932zc3tzigTy2HZmjgGsdQQdTfonOCzhe5mmbCvWdgcLbDEQvXGWGIlvpMAECPWGnE5slC5b2DdJo94kKRZqy5Bna2r743hvtLIDFnxB4XTy0qEzgXXn/bIlikyhJyhiN7xkBHvV4JVRExIthTUz6mYJSfHUbgvaybXgDrU9B6/PAFE2yOu+n+Dh4juLyn4IGO2rxu5fQkvy8PvycsQ==
x-ms-exchange-antispam-messagedata: zfpJztqR0hXrnxieyr9pRVT70HqwG9vMiazAWQp0mUpxCKlC8HnodydMfhi0m9CSRvSB8TlqLQnJNIIo6MTVRTVfOKWYxSKDJ2pJAuZVkYtkvevR59xgnyv69oOmZha0OrUBg5TYPHGTbJeCGV18pA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ac9a06-e88e-4e43-24d0-08d7bbf9b8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 02:55:51.8071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K46iMjwEzFCI+ThE+RyTefPXMVM8lp3WTgGYMc7SamV+OrdLaHAGvwGlVPa0L03/PoTy5VBleLapGzZODPorpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > > Hi,
> > > >
> > > > this v2 contains the fixes
> > > >
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > Everything below the "---" line, except the patch itself, gets ignore=
d.
> > > You need to move this Reported-by: up higher.
> >
> > I know, I put it here because the patch isn't part of the kernel. IMHO
> > a
> >
> > Signed-off-by:
> > Reported-by:
> >
> > looks a bit strange.
>=20
> Not at all.  That sort of thing occurs all the time; just look at a few c=
ommits in the
> kernel or patches on the mailing lists.  Especially ones that are bug fix=
es.
>=20
> > > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
> > > > 3405b146edc9..c294484e478d 100644
> > > > --- a/drivers/usb/core/hub.c
> > > > +++ b/drivers/usb/core/hub.c
> > > > @@ -3323,10 +3323,6 @@ int usb_port_suspend(struct usb_device *udev=
,
> pm_message_t msg)
> > > >  		usb_set_device_state(udev, USB_STATE_SUSPENDED);
> > > >  	}
> > > >
> > > > -	if (status =3D=3D 0 && !udev->do_remote_wakeup && udev->persist_e=
nabled
> > > > -			&& test_and_clear_bit(port1, hub->child_usage_bits))
> > > > -		pm_runtime_put_sync(&port_dev->dev);
> > > > -
> > > >  	usb_mark_last_busy(hub->hdev);
> > > >
> > > >  	usb_unlock_port(port_dev);
> > > > @@ -3514,15 +3510,6 @@ int usb_port_resume(struct usb_device *udev,
> pm_message_t msg)
> > > >  	int		status;
> > > >  	u16		portchange, portstatus;
> > > >
> > > > -	if (!test_and_set_bit(port1, hub->child_usage_bits)) {
> > > > -		status =3D pm_runtime_get_sync(&port_dev->dev);
> > > > -		if (status < 0) {
> > > > -			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
> > > > -					status);
> > > > -			return status;
> > > > -		}
> > > > -	}
> > > > -
> > >
> > > Why do you get rid of these two sections of code?  Won't that cause
> > > runtime PM to stop working properly?
> >
> > Both runtime_pm calls are part of the suspend/resume logic so this
> > code isn't called during runtime PM.
>=20
> I'm not quite sure what you mean by that.  In any case, it would be compl=
etely
> wrong to think that usb_port_suspend isn't involved in runtime PM.
>=20
> In fact, usb_port_suspend is _more_ important for runtime suspend than fo=
r system
> sleep.  The reason is simple: If you want to put a USB device into runtim=
e suspend,
> you have to tell its upstream hub's port to enable the suspend feature (i=
.e., call
> usb_port_suspend).  But if you want to put an entire bus of USB devices t=
o sleep
> for a system suspend, all you have to do is tell the host controller to s=
top sending
> packets; the ports don't need any notification.
>=20
> (Actually the situation is more complicated for USB 3.  But you get the
> idea.)
>=20
> > As far as I understood it correctly the purpose of those section was
> > to trigger port poweroff if the device supports it upon a
> > system-suspend.
>=20
> No, the purpose of the sections you removed is to trigger port poweroff w=
hen the
> device goes into any type of suspend, either system or runtime.  Of cours=
e, as you
> discovered, during system sleep the code doesn't actually turn off the po=
rt power --
> that's a bug.  But during runtime PM it does.
>=20
> > Therefore I came up with my question:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s=
pinics.
> net%2Flists%2Flinux-
> usb%2Fmsg190537.html&amp;data=3D02%7C01%7Cpeter.chen%40nxp.com%7Ce2
> 47403d3a8c420ef66d08d7bbbb63a5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637184285813366300&amp;sdata=3DMviQpc4vhyVu496wyNQ%2Bb3T
> hNE7Gh6hpenjzxn6%2FLwE%3D&amp;reserved=3D0.
>=20
> > > Also, try to find better names.  Maybe usb_port_sleep and
> > > usb_port_wake, or usb_port_system_suspend and usb_port_system_resume.
> >
> > IMHO usb_port_suspend/resume should be the best ;)
>=20
> Okay, so long as they are static and won't conflict with the functions in=
 hub.c.
>=20
> Alan Stern
>=20
> PS: There's one more thing you need to know -- I completely forgot about =
it until
> just now.  During system sleep, we have to make sure that the child devic=
e gets
> suspended _before_ and resumed _after_ the port.  If it happened the othe=
r way,
> we'd be in trouble.
>=20
> (The proper ordering would be automatic if the child USB device was regis=
tered
> under the port device, but for historical reasons it isn't; it gets regis=
tered directly
> under the parent hub.)
>=20
> This means you'll have to call device_pm_wait_for_dev() at the appropriat=
e places
> in the suspend and resume pathways.

Hi Alan & Marco,

I tried this VBUS off feature at one chipidea controller board with USB mou=
se, it works
well, at least with my expectation. See below log:

// There is a USB mouse at USB2 port

root@imx6ul7d:~# ./uclk.sh=20
    pll_usb_main_clk                  1        1        0   480000000      =
    0     0  50000
       usb_phy2_clk                   1        1        0   480000000      =
    0     0  50000
    pll_usb1_main_clk                 0        0        0   480000000      =
    0     0  50000
       usb_phy1_clk                   0        0        0   480000000      =
    0     0  50000
             usb_hsic_src             0        0        0   480000000      =
    0     0  50000
                usb_hsic_cg           0        0        0   480000000      =
    0     0  50000
                   usb_hsic_pre_div       0        0        0   480000000  =
        0     0  50000
                      usb_hsic_post_div       0        0        0   4800000=
00          0     0  50000
                         usb_hsic_root_clk       0        0        0   4800=
00000          0     0  50000
                            usb_ctrl_clk       1        1        0   135000=
000          0     0  50000
// clock is on

root@imx6ul7d:~# echo auto > /sys/bus/usb/devices/1-1/power/control=20
root@imx6ul7d:~# ./uclk.sh=20
    pll_usb_main_clk                  0        0        0   480000000      =
    0     0  50000
       usb_phy2_clk                   0        0        0   480000000      =
    0     0  50000
    pll_usb1_main_clk                 0        0        0   480000000      =
    0     0  50000
       usb_phy1_clk                   0        0        0   480000000      =
    0     0  50000
             usb_hsic_src             0        0        0   480000000      =
    0     0  50000
                usb_hsic_cg           0        0        0   480000000      =
    0     0  50000
                   usb_hsic_pre_div       0        0        0   480000000  =
        0     0  50000
                      usb_hsic_post_div       0        0        0   4800000=
00          0     0  50000
                         usb_hsic_root_clk       0        0        0   4800=
00000          0     0  50000
                            usb_ctrl_clk       0        0        0   135000=
000          0     0  50000

//clock is off after enable mouse's autosuspend

root@imx6ul7d:~# echo 0 > //sys/bus/usb/devices/1-0\:1.0/usb1-port1/power/
autosuspend_delay_ms    pm_qos_no_power_off     runtime_status
control                 runtime_active_time     runtime_suspended_time
_no_power_off ~# echo 0 > //sys/bus/usb/devices/1-0\:1.0/usb1-port1/power/p=
m_qos_
root@imx6ul7d:~# [  250.865933] ci_hdrc ci_hdrc.1: at: ehci_ci_portpower, d=
isable vbus regulator

//VBUS is off after set pm_qos_no_power_off 0. It stands for pm_qos_no_powe=
r_off works
well for runtime suspend.

root@imx6ul7d:~# echo enabled > /sys/class/tty/ttymxc0/power/wakeup
root@imx6ul7d:~# echo mem > /sys/power/state

// Enable tty wakeup, and suspend system.

[  292.530680] PM: suspend entry (s2idle)
[  292.547108] Filesystems sync: 0.012 seconds
[  292.575311] Freezing user space processes ... (elapsed 0.003 seconds) do=
ne.
[  292.586275] OOM killer disabled.
[  292.589726] Freezing remaining freezable tasks ... (elapsed 0.002 second=
s) done.
[  292.599891] printk: Suspending console(s) (use no_console_suspend to deb=
ug)

[  292.674257] fec 30be0000.ethernet eth0: Link is Down
[  292.677564] PM: suspend devices took 0.070 seconds
[  295.690990] imx6q-pcie 33800000.pcie: Phy link never came up
[  295.691012] imx6q-pcie 33800000.pcie: pcie link is down after resume.
[  295.715262] ci_hdrc ci_hdrc.1: at: ehci_ci_portpower, enable vbus regula=
tor

// The VBUS is only on after resume, but not during the system suspend rout=
ine.

[  296.321299] usb 1-1: reset low-speed USB device number 2 using ci_hdrc
[  296.680700] PM: resume devices took 0.990 seconds
[  296.721685] OOM killer enabled.
[  296.724847] Restarting tasks ... done.
[  296.750136] PM: suspend exit
root@imx6ul7d:~#=20
root@imx6ul7d:~# [  298.811004] fec 30be0000.ethernet eth0: Link is Up - 10=
0Mbps/Full - flow control rx/tx
[  299.169794] ci_hdrc ci_hdrc.1: at: ehci_ci_portpower, disable vbus regul=
ator

root@imx6ul7d:~# ./uclk.sh=20
    pll_usb_main_clk                  0        0        0   480000000      =
    0     0  50000
       usb_phy2_clk                   0        0        0   480000000      =
    0     0  50000
    pll_usb1_main_clk                 0        0        0   480000000      =
    0     0  50000
       usb_phy1_clk                   0        0        0   480000000      =
    0     0  50000
             usb_hsic_src             0        0        0   480000000      =
    0     0  50000
                usb_hsic_cg           0        0        0   480000000      =
    0     0  50000
                   usb_hsic_pre_div       0        0        0   480000000  =
        0     0  50000
                      usb_hsic_post_div       0        0        0   4800000=
00          0     0  50000
                         usb_hsic_root_clk       0        0        0   4800=
00000          0     0  50000
                            usb_ctrl_clk       0        0        0   135000=
000          0     0  50000

// As USB mouse is auto-suspend, and pm_qos_no_power_off is 0. The clock is=
 off, and VBUS is off after autosuspend
timeout.

Linux version 5.6.0-rc1-00027-g2671f46409d5-dirty (b29397@b29397-desktop) (=
gcc version 6.2.0 (GCC)) #7 SMP Fri Feb 28=20
10:20:18 CST 2020

// I use the usb-next tree, it is the new upstream kernel

Peter

