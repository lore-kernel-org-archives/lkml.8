Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58024C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2008A206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hpYomOBB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sOy/4ggT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgF3CvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:51:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19282 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgF3CvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593485484; x=1625021484;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FHcfa+lzHXNCnsPTqpxUVKPygkRwkj8v//4s674lhZc=;
  b=hpYomOBBA4bPHeiCYP+pLuNZuzZZ71yJLABh7DZ4JcS0OElGGhBNOAxq
   C4GmACwHs1KCehVNEiPiTUiBg8H7aDHMEle96VesIaL2R8/W8lw+jPILG
   KVryodhW3ZaG8DT6yw6WOnQjuxB3Z9u5ozAe8bUP9VCqrlUDF2q7tYYWh
   eqGl1DCfQLAwgQoncC7xFZ+s2H/EP3+pilxwVJcryrsHi+UMefeqkXTKZ
   znGOtMTFXAbPNJcOU1vf5ko/QQaagInUaJP86LLao1vsxVcY3rV85qJ1X
   Hwkq871UGBSo5U9py++QJT3e/8vpNTBxTk3QpXXgcQwooh0xkE1job0wV
   A==;
IronPort-SDR: 4ZskCVDfo3z6xhWA6PRwangD7rG7NEbNXou7VQaDVlVwaJWOEK9/Rvl9rDKCoLl9xdfk/WHOnu
 yD5iMwBVttHrBF74vmjLZ5P6HuAH1zeK/vEt0/BRUdz727jQP/JbJUvXjafuy7pyPODB7XHQD+
 0Y2PR1AGegXFP3/IPOS1dBOta1Y4pAmSbiHl0eUFzqYrD+hpPQYaEEWqBG3wmKlcNiFWTbKZGX
 wyTzei15weSAulX5jyyzTEYdfHawM4RrE2zeGVdyLIMJ7nJQsPa89u6bR6m24T5ESQi9MllbSa
 glI=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="244255622"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 10:51:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esHcWirXBWYw84OGXKK+4v6VbqGyGd7BOwfCSVhDL/bWSi2wgCmMI0ILyn+ds6NYaXqmxvOQmhtO9WcEu/ZVK6dPDwTW8aCNsxQ2CKUrHE2Hgi2WidFl4gl51dxO+3BiOZN+Pv1wnPq3ZMJ0xFWcMCdRzoX0Y2wfJ+Tg0fDv3bMzLVub1pm7XLPpoKSUMvTZlXVaayZeSA6T+EPxThCvA3ewNnVzwQSLQskwWf9nxJe6hsGcMeGp5LzvXvWcwDks4whgv96XqQ1WyR61MrYA6839Xv8tOe0XR/d1GSHDA+EAvsF8pRLqKx8VC7GtwGMTrFP6+UT4NMJ6lne1Mmpi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXf1PxTaQW30IbjYGHpawK+arALHx+JtIREgsEGKpZ8=;
 b=G4MMjqVUoVJn983TsIbJrUkjbPWZPacsBArz+iqtyMbGsobaD8sof48RvZEexRkn0bWjs7sze/Lge0YK+wdPapPZFDUBMpnxF2yaLwtpJhN2EOHLJpLYVRHgOzs50DH4VcLDFJRKSDYf7cXv5FMnKdWQVIq/VJfGJAhMN2jZC923HncgnUx3uws8kJpNLgjLqXCYnWstFGdErK/XJqXXiy+L4nGt42aSP4Xw/EqnqB6q+tEV/wm1CczGpayMF+3O02Ee7PV34FUgnpcfpXLCXq9yHGtz+KvG2BSW0fq3OwpSWtOhOFJdarj8hJkoiGzhWrZ4PCUt5MpVF74FV9PT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXf1PxTaQW30IbjYGHpawK+arALHx+JtIREgsEGKpZ8=;
 b=sOy/4ggTS4usXK+oBPm9KO1fx35EtVpG41EuCTUL6lLgSJHJh4XxXLjEdbbLMW3FRvtFV+JXZK73Fp8F+quaiW3Kyqkk784yOZtgiTFJi5KfXIkcrkzm0IPx9O3f2lX4B8WBMI1TxffgkIKpShv2y9y7lijhc1I5QrdFqnCm28Q=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0344.namprd04.prod.outlook.com (2603:10b6:903:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 02:51:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Tue, 30 Jun 2020
 02:51:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Topic: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Index: AQHWS/06zZqSdIYp0k2e+HMuy61K4w==
Date:   Tue, 30 Jun 2020 02:51:17 +0000
Message-ID: <CY4PR04MB375127DC313F70875CAAC841E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200626210302.1813-1-ignat@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e80392c4-baf8-4c0a-d942-08d81ca0767d
x-ms-traffictypediagnostic: CY4PR04MB0344:
x-microsoft-antispam-prvs: <CY4PR04MB034426204230AC8005A5F9F9E76F0@CY4PR04MB0344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjF2FTE9UXSX4z4I1Lpkysn3fakMekWB9+Yb0Fb7m3OIjffDYtdzfKqkq5ZtZJKELaThfMn/CEr0YmhX09m5c1+o41u1JesyfCW1/jrCpnEARGZGfP3WOhAuh3s5rigFOfOTqJoOqwEe9GhuUlCsgKuBZvLuGzfoQII6s1VUsnvmszFULPTj64aI8TulOShJdgbbE7etuWaf1L+ga9Yd6u6ywqDxJWT0GLAAFIk8FEkx3RO5QRRrl4FEob7hd+6ZS9bn12seW87Qn9ygpbfMhfN11pTSz3jAlBD9b/U53AU5aR2uzYonorVNmb0L+ztJQG7w/fAPlULM7d/BpKcbkmbCPOK9Gep1mgHhJ3Yohyhu9B5sI0dcFzvc02oW1TRs3jLSG2wUxoKgn4yxyHch1lz74Hw93W0ohV6fm4yZB8G+lZOZHTaxdV+oAvZY4wp+WUv+BUikO4fjmoiDzmTMfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(7696005)(71200400001)(2906002)(8936002)(316002)(30864003)(8676002)(83380400001)(186003)(19627235002)(91956017)(478600001)(33656002)(76116006)(9686003)(966005)(55016002)(66446008)(66476007)(64756008)(66556008)(54906003)(110136005)(7416002)(26005)(86362001)(53546011)(5660300002)(66946007)(52536014)(4326008)(6506007)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zpY7hNsdspqcvoHSjphPepW0KLq00ihTyXs3DozZIoxEGZr6OihadCS/dw+ObFatQQq3nOKE2bX7IhMPlJuFnkz9D/w4a46agkkh+qRKjjJjUmRsb2cA08FINBcJJUzGT4+QYToVGyY4iMLZ5vhXFJOxbYLaa9BtLtAuXibsYChWq6K/dn7mH+rTxZRoUpqtoi3gF6M95FSlBXWYD39IJT4iwlnN0TlbVbEiTXie4zXX0D7o8l9W1CzhOUlNVQygnuGSFWgsC4xwZH9j1j44jTYxn8fF8nJvf2+qWoavqn8YU3RQJ9LUATwfkPPTJa9iFSdVcXyAJpAQjVA4vbG+VScoEdq4+F0CBcIh5y+HPYNWa8uKPWee3gAZNgPladXqzhaDQzrAAsFJKGzB8r5mmfNh3pYo2MIo7eooNkqgiiMTXPdxy9zlPwdE/ozOz739eXKmq7WfRYgxcNVf4XnR1RMBjQ+5JFP0QWHI1fhTT94=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80392c4-baf8-4c0a-d942-08d81ca0767d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 02:51:17.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDjtYWMUdCWgMVGSDLQyVGNY7doRZMbulOLZyNC/X/uwk6HY2BFWQbwkcaKnFD45xXoE94jScwserLmEugq9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/27 6:03, Ignat Korchagin wrote:=0A=
> This is a follow up from [1]. Consider the following script:=0A=
> =0A=
> sudo modprobe brd rd_nr=3D1 rd_size=3D4194304=0A=
> =0A=
> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | \=0A=
> sudo dmsetup create eram0=0A=
> =0A=
> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_write_wo=
rkqueue' | \=0A=
> sudo dmsetup create eram0-inline-write=0A=
> =0A=
> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_read_wor=
kqueue' | \=0A=
> sudo dmsetup create eram0-inline-read=0A=
> =0A=
> devices=3D"/dev/ram0 /dev/mapper/eram0 /dev/mapper/eram0-inline-read "=0A=
> devices+=3D"/dev/mapper/eram0-inline-write"=0A=
> =0A=
> for dev in $devices; do=0A=
>   echo "reading from $dev"=0A=
>   sudo fio --filename=3D$dev --readwrite=3Dread --bs=3D4k --direct=3D1 \=
=0A=
>   --loops=3D1000000 --runtime=3D3m --name=3Dplain | grep READ=0A=
> done=0A=
> =0A=
> for dev in $devices; do=0A=
>   echo "writing to $dev"=0A=
>   sudo fio --filename=3D$dev --readwrite=3Dwrite --bs=3D4k --direct=3D1 \=
=0A=
>   --loops=3D1000000 --runtime=3D3m --name=3Dplain | grep WRITE=0A=
> done=0A=
> =0A=
> This script creates a ramdisk (to eliminate hardware bias in the benchmar=
k) and=0A=
> three dm-crypt instances on top. All dm-crypt instances use the NULL ciph=
er=0A=
> to eliminate potentially expensive crypto bias (the NULL cipher just uses=
 memcpy=0A=
> for "encyption"). The first instance is the current dm-crypt implementati=
on from=0A=
> 5.8-rc2, the two others have new optional flags enabled, which bypass kcr=
yptd=0A=
> workqueues for reads and writes respectively and write sorting for writes=
. On=0A=
> my VM (Debian in VirtualBox with 4 cores on 2.8 GHz Quad-Core Intel Core =
i7) I=0A=
> get the following output (formatted for better readability):=0A=
> =0A=
> reading from /dev/ram0=0A=
>    READ: bw=3D508MiB/s (533MB/s), 508MiB/s-508MiB/s (533MB/s-533MB/s), io=
=3D89.3GiB (95.9GB), run=3D180000-180000msec=0A=
> =0A=
> reading from /dev/mapper/eram0=0A=
>    READ: bw=3D80.6MiB/s (84.5MB/s), 80.6MiB/s-80.6MiB/s (84.5MB/s-84.5MB/=
s), io=3D14.2GiB (15.2GB), run=3D180000-180000msec=0A=
> =0A=
> reading from /dev/mapper/eram0-inline-read=0A=
>    READ: bw=3D295MiB/s (309MB/s), 295MiB/s-295MiB/s (309MB/s-309MB/s), io=
=3D51.8GiB (55.6GB), run=3D180000-180000msec=0A=
> =0A=
> reading from /dev/mapper/eram0-inline-write=0A=
>    READ: bw=3D114MiB/s (120MB/s), 114MiB/s-114MiB/s (120MB/s-120MB/s), io=
=3D20.1GiB (21.5GB), run=3D180000-180000msec=0A=
> =0A=
> writing to /dev/ram0=0A=
>   WRITE: bw=3D516MiB/s (541MB/s), 516MiB/s-516MiB/s (541MB/s-541MB/s), io=
=3D90.7GiB (97.4GB), run=3D180001-180001msec=0A=
> =0A=
> writing to /dev/mapper/eram0=0A=
>   WRITE: bw=3D40.4MiB/s (42.4MB/s), 40.4MiB/s-40.4MiB/s (42.4MB/s-42.4MB/=
s), io=3D7271MiB (7624MB), run=3D180001-180001msec=0A=
> =0A=
> writing to /dev/mapper/eram0-inline-read=0A=
>   WRITE: bw=3D38.9MiB/s (40.8MB/s), 38.9MiB/s-38.9MiB/s (40.8MB/s-40.8MB/=
s), io=3D7000MiB (7340MB), run=3D180001-180001msec=0A=
> =0A=
> writing to /dev/mapper/eram0-inline-write=0A=
>   WRITE: bw=3D277MiB/s (290MB/s), 277MiB/s-277MiB/s (290MB/s-290MB/s), io=
=3D48.6GiB (52.2GB), run=3D180000-180000msec=0A=
> =0A=
> Current dm-crypt implementation creates a significant IO performance over=
head=0A=
> (at least on small IO block sizes) for both latency and throughput. We su=
spect=0A=
> offloading IO request processing into workqueues and async threads is mor=
e=0A=
> harmful these days with the modern fast storage. I also did some digging =
into=0A=
> the dm-crypt git history and much of this async processing is not needed=
=0A=
> anymore, because the reasons it was added are mostly gone from the kernel=
. More=0A=
> details can be found in [2] (see "Git archeology" section).=0A=
> =0A=
> This change adds no_(read|write)_workqueue flags separately for read and =
write=0A=
> BIOs, which direct dm-crypt not to offload crypto operations into kcryptd=
=0A=
> workqueues and process everything inline. In addition, writes are not buf=
fered=0A=
> to be sorted in the dm-crypt red-black tree, but dispatched immediately. =
For=0A=
> cases, where crypto operations cannot happen inline (hard interrupt conte=
xt,=0A=
> for example the read path of some NVME drivers), we offload the work to a=
=0A=
> tasklet rather than a workqueue.=0A=
> =0A=
> These flags ensure inline BIO processing in the dm-crypt module only. It =
is=0A=
> worth noting that some Crypto API implementations may offload encryption =
into=0A=
> their own workqueues, which are independent of the dm-crypt and its=0A=
> configuration. However upon enabling no_(read|write)_workqueue flags dm-c=
rypt=0A=
> will instruct Crypto API not to backlog crypto requests.=0A=
> =0A=
> [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html=0A=
> [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/=0A=
> =0A=
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>=0A=
> ---=0A=
>  drivers/md/dm-crypt.c | 68 +++++++++++++++++++++++++++++++++----------=
=0A=
>  1 file changed, 52 insertions(+), 16 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c=0A=
> index 000ddfab5ba0..6924eb49b1df 100644=0A=
> --- a/drivers/md/dm-crypt.c=0A=
> +++ b/drivers/md/dm-crypt.c=0A=
> @@ -69,6 +69,7 @@ struct dm_crypt_io {=0A=
>  	u8 *integrity_metadata;=0A=
>  	bool integrity_metadata_from_pool;=0A=
>  	struct work_struct work;=0A=
> +	struct tasklet_struct tasklet;=0A=
>  =0A=
>  	struct convert_context ctx;=0A=
>  =0A=
> @@ -127,7 +128,8 @@ struct iv_elephant_private {=0A=
>   * and encrypts / decrypts at the same time.=0A=
>   */=0A=
>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,=0A=
> -	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };=0A=
> +	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD,=0A=
> +	     DM_CRYPT_NO_READ_WORKQUEUE, DM_CRYPT_NO_WRITE_WORKQUEUE };=0A=
=0A=
I liked the "INLINE" naming. What about DM_CRYPT_READ_INLINE and=0A=
DM_CRYPT_WRITE_INLINE ? Shorter too :)=0A=
=0A=
But from the changes below, it looks like your change is now less about bei=
ng=0A=
purely inline or synchronous but about bypassing the workqueue.=0A=
Is this correct ?=0A=
=0A=
>  =0A=
>  enum cipher_flags {=0A=
>  	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */=0A=
> @@ -1449,7 +1451,7 @@ static void kcryptd_async_done(struct crypto_async_=
request *async_req,=0A=
>  			       int error);=0A=
>  =0A=
>  static void crypt_alloc_req_skcipher(struct crypt_config *cc,=0A=
> -				     struct convert_context *ctx)=0A=
> +				     struct convert_context *ctx, bool nobacklog)=0A=
>  {=0A=
>  	unsigned key_index =3D ctx->cc_sector & (cc->tfms_count - 1);=0A=
>  =0A=
> @@ -1463,12 +1465,12 @@ static void crypt_alloc_req_skcipher(struct crypt=
_config *cc,=0A=
>  	 * requests if driver request queue is full.=0A=
>  	 */=0A=
>  	skcipher_request_set_callback(ctx->r.req,=0A=
> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
> +	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>  	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
=0A=
Will not specifying CRYPTO_TFM_REQ_MAY_BACKLOG always cause the crypto API =
to=0A=
return -EBUSY ? From the comment above the skcipher_request_set_callback(),=
 it=0A=
seems that this will be the case only if the skcipher diver queue is full. =
So in=0A=
other word, keeping the kcryptd_async_done() callback and executing the skc=
ipher=0A=
request through crypt_convert() and crypt_convert_block_skcipher() may stil=
l end=0A=
up being an asynchronous operation. Can you confirm this and is it what you=
=0A=
intended to implement ?=0A=
=0A=
From my understanding of the crypto API, and from what Eric commented, a tr=
uly=0A=
synchronous/inline execution of the skcypher needs a call like:=0A=
=0A=
crypto_wait_req(crypto_skcipher_encrypt(req), &wait);=0A=
=0A=
For SMR use case were we must absolutely preserve the write requests order,=
 the=0A=
above change will probably be needed. Will check again.=0A=
=0A=
>  }=0A=
>  =0A=
>  static void crypt_alloc_req_aead(struct crypt_config *cc,=0A=
> -				 struct convert_context *ctx)=0A=
> +				 struct convert_context *ctx, bool nobacklog)=0A=
>  {=0A=
>  	if (!ctx->r.req_aead)=0A=
>  		ctx->r.req_aead =3D mempool_alloc(&cc->req_pool, GFP_NOIO);=0A=
> @@ -1480,17 +1482,17 @@ static void crypt_alloc_req_aead(struct crypt_con=
fig *cc,=0A=
>  	 * requests if driver request queue is full.=0A=
>  	 */=0A=
>  	aead_request_set_callback(ctx->r.req_aead,=0A=
> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
> +	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>  	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req_aead));=0A=
>  }=0A=
>  =0A=
>  static void crypt_alloc_req(struct crypt_config *cc,=0A=
> -			    struct convert_context *ctx)=0A=
> +			    struct convert_context *ctx, bool nobacklog)=0A=
>  {=0A=
>  	if (crypt_integrity_aead(cc))=0A=
> -		crypt_alloc_req_aead(cc, ctx);=0A=
> +		crypt_alloc_req_aead(cc, ctx, nobacklog);=0A=
>  	else=0A=
> -		crypt_alloc_req_skcipher(cc, ctx);=0A=
> +		crypt_alloc_req_skcipher(cc, ctx, nobacklog);=0A=
>  }=0A=
>  =0A=
>  static void crypt_free_req_skcipher(struct crypt_config *cc,=0A=
> @@ -1523,7 +1525,7 @@ static void crypt_free_req(struct crypt_config *cc,=
 void *req, struct bio *base_=0A=
>   * Encrypt / decrypt data from one bio to another one (can be the same o=
ne)=0A=
>   */=0A=
>  static blk_status_t crypt_convert(struct crypt_config *cc,=0A=
> -			 struct convert_context *ctx)=0A=
> +			 struct convert_context *ctx, bool noresched)=0A=
=0A=
"noresched" is named after what will happen, not after the reason for it. S=
o to=0A=
clarify, why not rename this as "convert_inline" or "do_inline" ?=0A=
=0A=
>  {=0A=
>  	unsigned int tag_offset =3D 0;=0A=
>  	unsigned int sector_step =3D cc->sector_size >> SECTOR_SHIFT;=0A=
> @@ -1533,7 +1535,7 @@ static blk_status_t crypt_convert(struct crypt_conf=
ig *cc,=0A=
>  =0A=
>  	while (ctx->iter_in.bi_size && ctx->iter_out.bi_size) {=0A=
>  =0A=
> -		crypt_alloc_req(cc, ctx);=0A=
> +		crypt_alloc_req(cc, ctx, noresched);=0A=
>  		atomic_inc(&ctx->cc_pending);=0A=
>  =0A=
>  		if (crypt_integrity_aead(cc))=0A=
> @@ -1566,7 +1568,8 @@ static blk_status_t crypt_convert(struct crypt_conf=
ig *cc,=0A=
>  			atomic_dec(&ctx->cc_pending);=0A=
>  			ctx->cc_sector +=3D sector_step;=0A=
>  			tag_offset++;=0A=
> -			cond_resched();=0A=
> +			if (!noresched)=0A=
> +				cond_resched();=0A=
>  			continue;=0A=
>  		/*=0A=
>  		 * There was a data integrity error.=0A=
> @@ -1879,6 +1882,9 @@ static void kcryptd_crypt_write_io_submit(struct dm=
_crypt_io *io, int async)=0A=
>  	unsigned long flags;=0A=
>  	sector_t sector;=0A=
>  	struct rb_node **rbp, *parent;=0A=
> +	bool nosort =3D=0A=
> +			(likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||=0A=
> +			test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);=0A=
=0A=
"nosort" is a little obscure as a name. Why not just "do_inline" ? In any c=
ase,=0A=
since this bool is used only in the if below, you could just write the cond=
ition=0A=
directly there.=0A=
=0A=
>  =0A=
>  	if (unlikely(io->error)) {=0A=
>  		crypt_free_buffer_pages(cc, clone);=0A=
> @@ -1892,7 +1898,7 @@ static void kcryptd_crypt_write_io_submit(struct dm=
_crypt_io *io, int async)=0A=
>  =0A=
>  	clone->bi_iter.bi_sector =3D cc->start + io->sector;=0A=
>  =0A=
> -	if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) {=0A=
> +	if (nosort) {=0A=
>  		generic_make_request(clone);=0A=
>  		return;=0A=
>  	}=0A=
> @@ -1941,7 +1947,7 @@ static void kcryptd_crypt_write_convert(struct dm_c=
rypt_io *io)=0A=
>  	sector +=3D bio_sectors(clone);=0A=
>  =0A=
>  	crypt_inc_pending(io);=0A=
> -	r =3D crypt_convert(cc, &io->ctx);=0A=
> +	r =3D crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE,=
 &cc->flags));=0A=
>  	if (r)=0A=
>  		io->error =3D r;=0A=
>  	crypt_finished =3D atomic_dec_and_test(&io->ctx.cc_pending);=0A=
> @@ -1971,7 +1977,7 @@ static void kcryptd_crypt_read_convert(struct dm_cr=
ypt_io *io)=0A=
>  	crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,=0A=
>  			   io->sector);=0A=
>  =0A=
> -	r =3D crypt_convert(cc, &io->ctx);=0A=
> +	r =3D crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_READ_WORKQUEUE, =
&cc->flags));=0A=
>  	if (r)=0A=
>  		io->error =3D r;=0A=
>  =0A=
> @@ -2031,9 +2037,29 @@ static void kcryptd_crypt(struct work_struct *work=
)=0A=
>  		kcryptd_crypt_write_convert(io);=0A=
>  }=0A=
>  =0A=
> +static void kcryptd_crypt_tasklet(unsigned long work)=0A=
> +{=0A=
> +	kcryptd_crypt((struct work_struct *)work);=0A=
> +}=0A=
> +=0A=
>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)=0A=
>  {=0A=
>  	struct crypt_config *cc =3D io->cc;=0A=
> +	bool noworkqueue =3D=0A=
> +			(bio_data_dir(io->base_bio) =3D=3D READ && test_bit(DM_CRYPT_NO_READ_=
WORKQUEUE, &cc->flags)) ||=0A=
> +			(bio_data_dir(io->base_bio) =3D=3D WRITE && test_bit(DM_CRYPT_NO_WRIT=
E_WORKQUEUE, &cc->flags));=0A=
=0A=
Since this variable is used only in the if statement bleow, why not used th=
e=0A=
condition directly in that statement ?=0A=
=0A=
> +=0A=
> +	if (noworkqueue) {=0A=
> +		if (in_irq()) {=0A=
> +			/* Crypto API's "skcipher_walk_first() refuses to work in hard IRQ co=
ntext */=0A=
> +			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io-=
>work);=0A=
> +			tasklet_schedule(&io->tasklet);=0A=
> +			return;=0A=
> +		}=0A=
> +=0A=
> +		kcryptd_crypt(&io->work);=0A=
> +		return;=0A=
> +	}=0A=
>  =0A=
>  	INIT_WORK(&io->work, kcryptd_crypt);=0A=
>  	queue_work(cc->crypt_queue, &io->work);=0A=
> @@ -2838,7 +2864,7 @@ static int crypt_ctr_optional(struct dm_target *ti,=
 unsigned int argc, char **ar=0A=
>  	struct crypt_config *cc =3D ti->private;=0A=
>  	struct dm_arg_set as;=0A=
>  	static const struct dm_arg _args[] =3D {=0A=
> -		{0, 6, "Invalid number of feature args"},=0A=
> +		{0, 8, "Invalid number of feature args"},=0A=
>  	};=0A=
>  	unsigned int opt_params, val;=0A=
>  	const char *opt_string, *sval;=0A=
> @@ -2868,6 +2894,10 @@ static int crypt_ctr_optional(struct dm_target *ti=
, unsigned int argc, char **ar=0A=
>  =0A=
>  		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))=0A=
>  			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);=0A=
> +		else if (!strcasecmp(opt_string, "no_read_workqueue"))=0A=
> +			set_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);=0A=
> +		else if (!strcasecmp(opt_string, "no_write_workqueue"))=0A=
> +			set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);=0A=
>  		else if (sscanf(opt_string, "integrity:%u:", &val) =3D=3D 1) {=0A=
>  			if (val =3D=3D 0 || val > MAX_TAG_SIZE) {=0A=
>  				ti->error =3D "Invalid integrity arguments";=0A=
> @@ -3196,6 +3226,8 @@ static void crypt_status(struct dm_target *ti, stat=
us_type_t type,=0A=
>  		num_feature_args +=3D !!ti->num_discard_bios;=0A=
>  		num_feature_args +=3D test_bit(DM_CRYPT_SAME_CPU, &cc->flags);=0A=
>  		num_feature_args +=3D test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);=0A=
> +		num_feature_args +=3D test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)=
;=0A=
> +		num_feature_args +=3D test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags=
);=0A=
>  		num_feature_args +=3D cc->sector_size !=3D (1 << SECTOR_SHIFT);=0A=
>  		num_feature_args +=3D test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_fla=
gs);=0A=
>  		if (cc->on_disk_tag_size)=0A=
> @@ -3208,6 +3240,10 @@ static void crypt_status(struct dm_target *ti, sta=
tus_type_t type,=0A=
>  				DMEMIT(" same_cpu_crypt");=0A=
>  			if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))=0A=
>  				DMEMIT(" submit_from_crypt_cpus");=0A=
> +			if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags))=0A=
> +				DMEMIT(" no_read_workqueue");=0A=
> +			if (test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))=0A=
> +				DMEMIT(" no_write_workqueue");=0A=
>  			if (cc->on_disk_tag_size)=0A=
>  				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);=
=0A=
>  			if (cc->sector_size !=3D (1 << SECTOR_SHIFT))=0A=
> @@ -3320,7 +3356,7 @@ static void crypt_io_hints(struct dm_target *ti, st=
ruct queue_limits *limits)=0A=
>  =0A=
>  static struct target_type crypt_target =3D {=0A=
>  	.name   =3D "crypt",=0A=
> -	.version =3D {1, 21, 0},=0A=
> +	.version =3D {1, 22, 0},=0A=
>  	.module =3D THIS_MODULE,=0A=
>  	.ctr    =3D crypt_ctr,=0A=
>  	.dtr    =3D crypt_dtr,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
