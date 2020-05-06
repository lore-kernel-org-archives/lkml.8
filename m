Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82D720836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.polimi.it header.i=@mail.polimi.it header.b="GLaS/zHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEFPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:16:47 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:6185
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728936AbgEFPQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGn8opfUZhKtzXKdci47ccAbRNbbS+1qoV4zNt/XA6EmI2LhMBZn4/XkuPniO2saiUHHm2AYBMrQ9XsPhYOEWW8AunTzdEDcpoO0Z74DrV99S2g0sOjagUXxyEmkSmgKE+NeOjPEvu6sRydUadDbsDF4I7SM6yT1MCX+43c0EA432IMo4VM6WGS9gOBMJ/PUVwmLMXGLPdKhfft6grJSkX8JBp5vvy4Fpb8X1z1qid8vZJU0dkqrMW/leRw4S2HwED6ZAGlnFyjq/QsH7YQg04N+qZmq1US5UHk2VOCEF40Pnz2AIbfNozyxp93Y2MSgDFI3WUjB2UYR+vJpV+zR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUrjSC1Cu6W2i2A3p59eHBJEAatCZgxGtOLwc3S5tE4=;
 b=cnOem7yH1ik2wVKjdqCkqkPjEGLGNK4hWuHGlMfZK6g8ZrKTfWH/0gJv9c/O6b3JucKQsvFbvTmDsr+YlshGg/KNvkyCeh+ToEiYAz9T+v2JlwrRee55N3mjxK7rwD5tE+EGHAHzDbOIK5shRicYGlo638f1z2RUhCpNio4nKqNUYz9DD40uQGa0EESdYyw32eujFA61OQLiAkGsHTlViymgqtkNh8k8dG4ty0wb8AvUxP6C6thdiaVAbRYnIiEGgM8xxuBCoMo2fFgOkyx19K+1NBqsI9L044FJ2vNXmaxi7I6pcp1zhHUYP5m4cE/sglL/5AntRA8Bz6IlVsdMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUrjSC1Cu6W2i2A3p59eHBJEAatCZgxGtOLwc3S5tE4=;
 b=GLaS/zHJty3mJ4vVQDxWK/QB03xiynsOoQlK2YtauLKtluqWF2crvY1j4I1rS/lKlOTuZ/tbgbM2Mxhb4I7eY5brEmIfdrtlCJBd+zjoRIJ5u4sclgMvUVFpyp6WP2qo5FzRD7IxSMlYeuk/iwnTCT/BjssoWmolzQ1M5kr8hzu+ph4i274Gneofvubvyqn+k9nL72gzKAEvQH9v1DRKSa/JR3yaaHkxqTmvUTKJG7a4w4LCNlf7BM9cnfkiQlz9dpHrwkIX90rfuVs+1eNHPAWtVdAjO+B2AcIYeYbqNUKyZKkXoxwP3L/ZWsbCsiaJdwHo6QPzYUuysPZKZSt1Og==
Received: from HE1PR0602MB3355.eurprd06.prod.outlook.com (2603:10a6:7:88::18)
 by HE1PR0602MB2874.eurprd06.prod.outlook.com (2603:10a6:3:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 15:16:41 +0000
Received: from HE1PR0602MB3355.eurprd06.prod.outlook.com
 ([fe80::c8f9:b9dc:df6d:aac5]) by HE1PR0602MB3355.eurprd06.prod.outlook.com
 ([fe80::c8f9:b9dc:df6d:aac5%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 15:16:40 +0000
From:   Fabio Comolli <fabio.comolli@mail.polimi.it>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "luzmaximilian@gmail.com" <luzmaximilian@gmail.com>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rik.kaneda@intel.com" <rik.kaneda@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: [Regression] [Bisected] Commit
 6d232b29cfce65961db4a668c2c6c6987cd24d45 breaks some of the Fn-keys on my old
 Sony Vaio VPCM13M1E.
Thread-Topic: [Regression] [Bisected] Commit
 6d232b29cfce65961db4a668c2c6c6987cd24d45 breaks some of the Fn-keys on my old
 Sony Vaio VPCM13M1E.
Thread-Index: AQHWI7lXSJY5XR+OjUu+NwBW4MqUwA==
Date:   Wed, 6 May 2020 15:16:40 +0000
Message-ID: <HE1PR0602MB335553397CB175052E00EF70DAA40@HE1PR0602MB3355.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mail.polimi.it;
x-originating-ip: [2.36.136.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3597324-018e-45ed-3a9b-08d7f1d07aa4
x-ms-traffictypediagnostic: HE1PR0602MB2874:
x-microsoft-antispam-prvs: <HE1PR0602MB28745372B719F57016E14462DAA40@HE1PR0602MB2874.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o81SjMLMwQOTQsnxUyobXrDfQUsX2NnYgJieWgNaLvZrde+ToXGQMhrr2U3XfVdz5cFVH9YEk3E0SjAIw1gVlmERVDeHGUdOLrBPW06FMsNpWMhHPuVX5UD2l+jZSeMm6EYaSmXJ0qrR37LoUGsMypXEzdhZ7sLyDjhvrw3jZjMYM2SIVZRi5FZW5P5J8S+PkdTHhqy6zwyfWxljRRDoNSc67ih8/aYADnS8O0mR7HG9PJpmU63x2f/ycNuf6g+9f9P3AUtwiW8jmowjnQIjlUwmMIqdVXXRSjsjLuCgtaFRbA4Z8czczWOX0gLpxj8eON6K18+53IoPw+f4Ksl6W3ZYIdKl18B//d4EakM5vBUZbn5FBraeB7lgzGs7N/p/Vl4LhmkNfJZZrZ/yjnPtmUDr5B05gKrUmEB0+VPYMVgzUGOTVGMagGSmlDy5rb1+Ho0qULHHfk1Qip+xUskeWzwufPMoW+zJ4hvaBNgrVl4XIPF3tlYPtovZLYOTg6JqpuStLN9n3/nBJ2TL6KKoeeYIZw2yDEiM/IhZZARE7+CPOYYMJM52FN4cBEPaEYz/NFX7sJpf/QhYCl34fsTHMom5zqQRgfKULsxDQP9SvKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3355.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(396003)(136003)(366004)(33430700001)(478600001)(45080400002)(55016002)(7696005)(44832011)(186003)(66446008)(66556008)(66476007)(66946007)(26005)(8676002)(6506007)(64756008)(76116006)(91956017)(86362001)(71200400001)(8936002)(30864003)(9686003)(966005)(786003)(316002)(2906002)(5660300002)(52536014)(33656002)(54906003)(4326008)(6916009)(33440700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SYa+C/00C4k52NvNOzApNbX60MTGJekuJWhLwnqEub+f6/t/tRaLf+CGFqAEmEEaVpKF8W3OPc3ZtkubBH24FR6C46TzhaBYhAUe4QL0fyzrqHAK0qj1ZxkpT5Vy8sH+ZyJICxYCry5k0nhcbkgui+86e1LkMBNdV8aou32gxSFkGo7/zg3RfaAt41dR2czoLHqTFHNY0NaxaMVDVylmSC7rKFz1o8WUkqdLE7u+QybxJruq5YtYoaf/8E3O2p9/C0+chBU8OnCBpw+eobn5p+vPKOItX+tYzklwZ4WwoWDUokO5svirSBstXrTq6Wd7x25GxdEDNxQ7Cq7hOYq/NBfyap7CU9WjiGw37xymuUzYyAKMCeFHOULELQxihHqSzBaKQKakM8VAObSapsvPXmhz/aFHluZMbeNvSvu/tX06gozMQZuELuDK5wSbsH5NmS2ryIlaR6tXNb/85KMLLS1xJWg/9civCP5crTxZ5vm1r6bnNBeYL16RmMsjLWWbReznh1oBCwV5ZSLbFuSo9Y1w9RzddH3ceAzvnyBpeS+l5GMj6MmWUX3cndd8jiYmJD05XTAiyP/JwRPbRlN7bgMx8+r1Sy5cx3eHxguvbBvKBjBPw5ZGr3k9mlkPJ7evexZD0FKwtXZ/Yg3b8P+EqMeVfdJkLUrm+TRliEPh/Uw6kRXVdzwBd5bOwePoeSPjBP/4QN3sW4obSU0MSqF05D1hYONJHCEqT8RCKVcxeeHRe754/MN/8YUe7fyW9wXT4vZ4lrs+t1YtgqtCLZBQff1WHBZx90kVA2iJZU7W0Zw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: f3597324-018e-45ed-3a9b-08d7f1d07aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 15:16:40.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jvygq3UleH4K4o1Ivld02a/yHdWq6Tj/rMMjKU2HLYLhLFERaSuuYuwiZT1d/88s8r9qXj58bix+Ql4UKC5KIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB2874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated my old Sony Vaio a few days ago and discovered that a few Fn-keys=
 on my old Sony Vaio had stopped working.=20
The bisection points at the commit in the subject and reverting it makes ev=
erything work again even with current
Linus' git.

Full bug report below. Please CC: me as I'm not subscribed to lkml.

Regards,
Fabio


-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

BIOS table is:

[    0.000000] DMI: Sony Corporation VPCM13M1E/VAIO, BIOS R0120Z4 05/12/201=
0
[    0.014701] ACPI: RSDP 0x00000000000F0410 000024 (v03 Sony  )
[    0.014709] ACPI: XSDT 0x000000007F4DB078 00004C (v01 Sony   VAIO     20=
100512 AMI  00010013)
[    0.014724] ACPI: FACP 0x000000007F4E1388 0000F4 (v04 Sony   VAIO     20=
100512 AMI  00010013)
[    0.014740] ACPI: DSDT 0x000000007F4DB150 006231 (v02 Sony   VAIO     20=
100512 INTL 20051117)
[    0.014751] ACPI: FACS 0x000000007F509F40 000040
[    0.014758] ACPI: FACS 0x000000007F509F80 000040
[    0.014766] ACPI: APIC 0x000000007F4E1480 000072 (v01 Sony   VAIO     20=
100512 AMI  00010013)
[    0.014777] ACPI: MCFG 0x000000007F4E14F8 00003C (v01 Sony   VAIO     20=
100512 MSFT 00000097)
[    0.014787] ACPI: SLIC 0x000000007F4E1538 000176 (v01 Sony   VAIO     20=
100512 Sony 01000000)
[    0.014797] ACPI: HPET 0x000000007F4E16B0 000038 (v01 Sony   VAIO     20=
100512 AMI. 00000003)

There are 7 Fn-keys available on this model:

Mute
Volume Down
Volume Up
Brightness Down
Brightness Up
External Video Output Switch
Hibernate

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

Working versions write this in the messages log at boot time:

[   20.175244] input: Sony Vaio Keys as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0A08:00/device:01/SNY5001:00/input/input5
[   20.186497] input: Sony Vaio Jogdial as /devices/LNXSYSTM:00/LNXSYBUS:00=
/PNP0A08:00/device:01/SNY5001:00/input/input6
[   20.217724] sony_laptop: SNC setup done.

The acpi_listen output is:

button/mute MUTE 00000080 00000000 K
button/volumedown VOLDN 00000080 00000000 K
button/volumeup VOLUP 00000080 00000000 K
video/brightnessdown BRTDN 00000087 00000000 K
sony/hotkey SNY5001:00 00000001 00000010
sony/hotkey SNY5001:00 00000001 0000003b
video/brightnessup BRTUP 00000086 00000000 K
sony/hotkey SNY5001:00 00000001 00000011
sony/hotkey SNY5001:00 00000001 0000003b
video/switchmode VMOD 00000080 00000000 K
sony/hotkey SNY5001:00 00000001 00000012
sony/hotkey SNY5001:00 00000001 0000003b

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

Broken versions write this in the messages log at boot time:

[   19.143613] input: Sony Vaio Keys as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0A08:00/device:01/SNY5001:00/input/input6
[   19.158941] input: Sony Vaio Jogdial as /devices/LNXSYSTM:00/LNXSYBUS:00=
/PNP0A08:00/device:01/SNY5001:00/input/input7
[   19.180118] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
[   19.184342] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
[   19.186183] sony_laptop: Invalid acpi_object: expected 0x1 got 0x3
[   19.188688] sony_laptop: SNC setup done.

The acpi_listen output is:

button/mute MUTE 00000080 00000000 K
button/volumedown VOLDN 00000080 00000000 K
button/volumeup VOLUP 00000080 00000000 K
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092
sony/hotkey SNY5001:00 00000001 00000092

i.e. the brightness keys, the external output toggle and the hibernate butt=
on are not recognised anymore. Every keypress generates two identical "sony=
/hotkey SNY5001:00 00000001 00000092" in the acpi_listen output and the fol=
lowing lines in the messages log:

May  4 20:09:34 vaio kernel: sony_laptop: Invalid acpi_object: expected 0x1=
 got 0x3
May  4 20:09:34 vaio fcomolli[17675]: ACPI group/action undefined: sony/hot=
key / SNY5001:00.

The volume and mute button always work.

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

Bisection output:

[fcomolli@vaio linux]$ git bisect good
6d232b29cfce65961db4a668c2c6c6987cd24d45 is the first bad commit
commit 6d232b29cfce65961db4a668c2c6c6987cd24d45
Author: Maximilian Luz <luzmaximilian@gmail.com>
Date:   Tue Dec 17 11:35:22 2019 -0800

    ACPICA: Dispatcher: always generate buffer objects for ASL create_field=
() operator
   =20
    ACPICA commit 79a466b64e6af36cc83102f05915e56cb7dd89ab
   =20
    According to table 19-419 of the ACPI 6.3 specification, buffer_fields
    created using the ASL create_field() Operator have been treated as
    integers if the buffer_field is small enough to fit inside of an ASL
    integer (32-bits or 64-bits depending on the definition block
    revision). If they are larger, buffer fields are treated as ASL
    Buffer objects. However, this is not true for other AML interpreter
    implementations.
   =20
    It has been discovered that other AML interpreters always treat
    buffer fields created by create_field() as a buffer regardless of the
    length of the buffer field.
   =20
    More specifically, the Microsoft AML interpreter always treats buffer
    fields created by the create_field() operator as buffer. ACPICA
    currently does this only when the field size is larger than the
    maximum integer width. This causes problems with AML code shipped in
    Microsoft Surface devices.
   =20
    More details:
   =20
    The control methods in these devices determine the success of an ASL
    control method execution by examining the type resulting from storing
    a buffer field created by a create_field() operator. On success, a
    Buffer object is expected, on failure an Integer containing an error
    code. This buffer object is created with a dynamic size via the
    create_field() operator. Due to the difference in behavior, Buffer
    values of small size are however converted to Integers and thus
    interpreted by the control method as having failed, whereas in
    reality it succeeded. Below is an example of a control method called
    TEST that illustrates this behavior.
   =20
    Method (CBUF) // Create a Buffer field
    {
        /*
         * Depending on the value of RAND, ACPICA interpreter will treat
         * BF00 as an integer or buffer.
         */
        create_field (BUFF, 0, RAND, BF00)
        return (BF00)
    }
   =20
    Method (TEST)
    {
        /*
         * Storing the value returned by CBUF to local0 will result in
         * implicit type conversion outlined in the ACPI specification.
         *
         * ACPICA will treat local0 like an ASL integer if RAND is less
         * than or equal to 64 or 32 (depending on the definition_block
         * revision). If RAND is greater, it will be treated like an ASL
         * buffer. Other implementations treat local0 like an ASL buffer
         * regardless of the value of RAND.
         */
        local0 =3D CBUF()
   =20
        /*
         * object_type of 0x03 represents an ASL Buffer
         */
        if (object_type (Local0) !=3D 0x03)
        {
            // Error on ACPICA if RAND is small enough
        }
        else
        {
            /*
             * Success on APICA if RAND is large enough
             * Other implementations always take this path because local0
             * is always treated as a buffer.
             */
        }
    }
   =20
    This change prohibits the previously mentioned integer conversion to
    match other AML interpreter implementations (Microsoft) that do not
    conform to the ACPI specification.
   =20
    Link: https://github.com/acpica/acpica/commit/79a466b6
    Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

 drivers/acpi/acpica/acobject.h |  3 ++-
 drivers/acpi/acpica/dsopcode.c |  2 ++
 drivers/acpi/acpica/exfield.c  | 10 ++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

[fcomolli@vaio linux]$ git bisect log
git bisect start
# bad: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
git bisect bad 7111951b8d4973bda27ff663f2cf18b663d15b48
# good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
git bisect good 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
# good: [ee7dd7733b201c6201174f384a92dbadc9f3129c] sis900: remove TxIDLE
git bisect good ee7dd7733b201c6201174f384a92dbadc9f3129c
# good: [44bf67f32a6803339ac1ba721b158c3e2272cabe] Merge drm/drm-next into =
drm-misc-next
git bisect good 44bf67f32a6803339ac1ba721b158c3e2272cabe
# good: [7214618c60e947b8cea12b47d8279bd4220f21bc] Merge tag 'riscv/for-v5.=
5-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect good 7214618c60e947b8cea12b47d8279bd4220f21bc
# bad: [4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb] Merge tag 'for-v5.6' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
git bisect bad 4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb
# bad: [a78208e2436963d0b2c7d186277d6e1a9755029a] Merge branch 'linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad a78208e2436963d0b2c7d186277d6e1a9755029a
# good: [9e1af7567b266dc6c3c8fd434ea807b3206bfdc1] Merge tag 'mmc-v5.6' of =
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 9e1af7567b266dc6c3c8fd434ea807b3206bfdc1
# bad: [d99391ec2b42d827d92003dcdcb96fadac9d862b] Merge branch 'core-rcu-fo=
r-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad d99391ec2b42d827d92003dcdcb96fadac9d862b
# good: [6d277aca488fdf0a1e67cd14b5a58869f66197c9] Merge tag 'pm-5.6-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 6d277aca488fdf0a1e67cd14b5a58869f66197c9
# bad: [534b0a8b677443c0aa8c4c71ff7887f08a2b9b41] Merge tag 'core-debugobje=
cts-2020-01-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 534b0a8b677443c0aa8c4c71ff7887f08a2b9b41
# bad: [22a8f39c520fc577c02b4e5c99f8bb3b6017680b] Merge tag 'for-5.6/driver=
s-2020-01-27' of git://git.kernel.dk/linux-block
git bisect bad 22a8f39c520fc577c02b4e5c99f8bb3b6017680b
# bad: [34dabd81160f7bfb18b67c1161b3c4d7ca6cab83] Merge tag 'pnp-5.6-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 34dabd81160f7bfb18b67c1161b3c4d7ca6cab83
# bad: [3dd855147feff375dfa6737331628ea919e9da59] Merge branches 'acpi-batt=
ery', 'acpi-video', 'acpi-fan' and 'acpi-drivers'
git bisect bad 3dd855147feff375dfa6737331628ea919e9da59
# bad: [ff7a672f83b355365478a1fdfb60933ef34d8d02] Merge branch 'acpica'
git bisect bad ff7a672f83b355365478a1fdfb60933ef34d8d02
# bad: [ae6252d8dfeb21f5067a09a8f4a6dd30851d70c1] ACPICA: Update version to=
 20191213
git bisect bad ae6252d8dfeb21f5067a09a8f4a6dd30851d70c1
# good: [5ddbd77181dfca61b16d2e2222382ea65637f1b9] ACPICA: Disassembler: cr=
eate buffer fields in ACPI_PARSE_LOAD_PASS1
git bisect good 5ddbd77181dfca61b16d2e2222382ea65637f1b9
# bad: [6d232b29cfce65961db4a668c2c6c6987cd24d45] ACPICA: Dispatcher: alway=
s generate buffer objects for ASL create_field() operator
git bisect bad 6d232b29cfce65961db4a668c2c6c6987cd24d45
# good: [69e86e59ad2a2518704a31c35530e6e99963c358] ACPICA: acpisrc: add uni=
x line ending support for non-windows build
git bisect good 69e86e59ad2a2518704a31c35530e6e99963c358
# first bad commit: [6d232b29cfce65961db4a668c2c6c6987cd24d45] ACPICA: Disp=
atcher: always generate buffer objects for ASL create_field() operator
