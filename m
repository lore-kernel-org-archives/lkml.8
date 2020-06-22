Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A896C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6EC207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SdljT9Jl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VFzQo4w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFVIJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:09:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25235 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgFVIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592813330; x=1624349330;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c5W5ThBfRB6YodS0DDCwKjl0Sy/1OObafQ1uXr0DphQ=;
  b=SdljT9JlcQUV6d2YpDNDY263pGM8fTFz5euXGYmhrpoiJxF8NUD1qTzx
   tV62vBcPWedb6bMY8FrpsWnHweCkipXFQKDyGTj8NiN+tKhwj94cSRkSd
   WiKq9LJjTKMdh+nMWAFQu0GPywUv2GuRiT0CthZGt37/V5l1YmWMfBM0I
   Ww3XMW9sIxeqYzwsDkI2G9Offzm/hzrvx7HGgLf/PF/PZ0TxOTTB3TzMi
   Ax1ULRfvpi6TEItvFVlnV156rrvqepNYdYHuwqQteVmdlBX4BWss9y1X4
   xFWA/ZJGzXMY1gQBlnn0exDoUSziP380kz0l1EpnD4ZutIzTTAUUQcIXb
   w==;
IronPort-SDR: u8ygO29TYXuetq9h3wpUUgi0DQGwz52khjs86EcXc1OIC9UBhhXpEff3qg66PcNlMN/ZAp0481
 BQRRTYvEmOqibXjlVo+ezWX1uCd4PMXeEEQMr1zu5TSh1ov8ChLsg7fvjyif3oDJbWShKjcZhP
 lUnWQ8LBjehLFwFh4MJFi46zQ/O14p/W2e+mWAB4GzmxYwXBRI4a8ZN8xIrh92Mvoq/t6J+Wgy
 QZsoptYd+MnTOyTItYafZs1aymLfSDU+EmO2CMe7zK7Z6qtER/8DDn9SdYk607MnMHZZsLSV4M
 Q18=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="140591212"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 16:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLl+xrRuk/uo4+v81eipRSGbYuC/It3AhzbNUeM00TB2eoonvIZxKVSejuXIegtN8k7WF+ck40cvCQcHLiJ9v2h6TvGxiND2ShAH2ua4UZMBAlNhLx8P7rfUvKJjeU5lMdf5vAwKO0zcOxn8XUoaxvji41SwsolQdDMFYgJcm36tf3Aw+xkfo+npOXkXyDuphRGtuJyjoPqp7BFfgAGmMtbKGCTNcLRwlTm3qggjeR/shOoa5rfa5jJZT2bzB7mTVqCtHAOyeSz/Ul0fyMpmsMxsEKzwxXEdVKPvxBOiWGPt9Q0Ikx9MBiUgeycj0qMUv3F4ApE/wRCjhoIQdVYm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHdcOGZelX397IX2PY3VZHIYmLKr2rN9FoQu6jfmFqo=;
 b=d5DRT5QyCySRRoVHDrvfxfGOG2vvWjKd1Zwx8s8fSbS5i3Why+zjKG0pHseyviVCnJOWD/PXfe/4D7osj9vJmdJc6sJlK3RzMvqXVWZtUqy9cQDoqHeWMPsf2d/rye/KylIquERmHQoIKvUIWIM8VlZrCy4iX6Eck9lCXX0RvySJsj1sJYMLm2rcD/KBh6lYqO+pwaffe3GEDRiaeX/toLTqGoUCki0mjWT1RlQMiDCBipfumWKxI4DI8JYb+MfnoVfqE1xDlOte2ZaAGTwi7pv0d8qCAdvQx7Gq/NtD4RzzRoslFJmYPot/bblzYgOAzP9RiKdy/tb1bTnbZ1o4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHdcOGZelX397IX2PY3VZHIYmLKr2rN9FoQu6jfmFqo=;
 b=VFzQo4w1rsMYLl5fZAj8sKm1NwCmYhhq8y8JxcHsQ0Jc21w9rJDrM9oKkJ7M2vqgoViaW9rwx189pUjCG9gZOZ/uMu/XoK+00sMpPHnt51s9INWx0fcoMKvnRFlbxkAClGyccfWsa+K/AYVeeNqjuhUZQffM4tkcE5O16y4oZEA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 08:08:47 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Mon, 22 Jun 2020
 08:08:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Topic: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Index: AQHWRlqI8D6+Lz65i0Kgr2YROVo4Vg==
Date:   Mon, 22 Jun 2020 08:08:47 +0000
Message-ID: <CY4PR04MB3751563A036A92AD2837E0A8E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CALrw=nFe2q5wn2LTA99yrFhZqGR9ehiqhEQqKFh44KmvTVF5gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59b4313a-c265-49a7-6975-08d816837d74
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB103253C169FDB1B8398BD85CE7970@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DI4SVq0j8KDnq1uaD1dAIftm/cbOjii86igZhagzzUUPdeQPcLjldzL/P1Ty9xSFs/xP0Il3pulJ/dOeHk/ZwTxA+RR2T2si7/JExAJTRq4teBa1LAnStIkvztavc92jz9xXJFk1k7k9zzXXhKG6C0DW5U9CiRcn1t+YEnxOrZSGUDjck9LkzDvg12VsX551Uw7Pd9SWzNriVhU/hC0gAey4fTp+wnwklRL2xkJab7KgbGGM7Nudzh0gXkDZWjDlN56cJhj2Owq9LsKEb4Ai9JxjYv/0xjqXBBPieWcmEFXIhlL4dQ1FAEO3H0drSGtKeMDJsml6Wsb4VkabeMmTJlQDsFbVL6JXRlU4rbhmQDCxLg2BjqFPn/wo6AfeizrS0K/chJqvFKQU8sxxjNNwjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(66556008)(52536014)(71200400001)(64756008)(66446008)(966005)(54906003)(83380400001)(91956017)(8936002)(33656002)(7696005)(66946007)(86362001)(5660300002)(76116006)(6506007)(6916009)(186003)(316002)(4326008)(66476007)(2906002)(26005)(53546011)(55016002)(478600001)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /Qzk28EyK+mayerb/6TKZPk2Aj7glG3xfvXwA2eIFugMeClXpRQUSpZMj2Wt5fOeqYgwWQzu5qBH8lEaIRcTTVDk2ZBhVpbF8+sYH8ArbcTAHjKzxS5Yvmrfs3pZh19cwXnDSg0CEJqR1ZV9I+jUEEmSF0urDCaUtTdyMRwMc0FxHDw7SKaVZ2Z/HpOFrpwPJFBXp3LMHu77n3islI7gDLE1tUBuqsU9WZ3zsNz9/+juaW/Xf5fitnh9vLA6UMakfGD1rl5laLNAp+wD3BQnm/1vjeww/4lHCp2XawPASDTqmJC+zZqWqXsWEi417UWuwQLOeQrVMEHQytpfV2WuFWTPWUoATrpLZrpefZOqasx5VMTMyAHNv1rOIJwZfPl9IKYlOsCcHO2p43MJmUPMX9MNyiIdCfbI8lP9MSN5McOVqk1KPxkh1B71Xo92ePD1jyNHgJ8bwddbH4P7Nn9DQPTcVwUiOLC1J9gjh6xY4OFIcMfPbApAgpHuogcf0JAn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b4313a-c265-49a7-6975-08d816837d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 08:08:47.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWJqJy5oL96rUhnZx/zVo6UD06NYROcN5xL+UVFs0aLR2bQK8hnvGIwxkaE2eG/ztrdEO5mer0r8LOjPtVKt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/22 16:55, Ignat Korchagin wrote:=0A=
> On Mon, Jun 22, 2020 at 1:45 AM Damien Le Moal <Damien.LeMoal@wdc.com> wr=
ote:=0A=
>>=0A=
>> On 2020/06/20 1:56, Mike Snitzer wrote:=0A=
>>> On Fri, Jun 19 2020 at 12:41pm -0400,=0A=
>>> Ignat Korchagin <ignat@cloudflare.com> wrote:=0A=
>>>=0A=
>>>> This is a follow up from the long-forgotten [1], but with some more co=
nvincing=0A=
>>>> evidence. Consider the following script:=0A=
>>>>=0A=
>>>> #!/bin/bash -e=0A=
>>>>=0A=
>>>> # create 4G ramdisk=0A=
>>>> sudo modprobe brd rd_nr=3D1 rd_size=3D4194304=0A=
>>>>=0A=
>>>> # create a dm-crypt device with NULL cipher on top of /dev/ram0=0A=
>>>> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | sudo dm=
setup create eram0=0A=
>>>>=0A=
>>>> # create a dm-crypt device with NULL cipher and custom force_inline fl=
ag=0A=
>>>> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 force_in=
line' | sudo dmsetup create inline-eram0=0A=
>>>>=0A=
>>>> # read all data from /dev/ram0=0A=
>>>> sudo dd if=3D/dev/ram0 bs=3D4k iflag=3Ddirect | sha256sum=0A=
>>>>=0A=
>>>> # read the same data from /dev/mapper/eram0=0A=
>>>> sudo dd if=3D/dev/mapper/eram0 bs=3D4k iflag=3Ddirect | sha256sum=0A=
>>>>=0A=
>>>> # read the same data from /dev/mapper/inline-eram0=0A=
>>>> sudo dd if=3D/dev/mapper/inline-eram0 bs=3D4k iflag=3Ddirect | sha256s=
um=0A=
>>>>=0A=
>>>> This script creates a ramdisk (to eliminate hardware bias in the bench=
mark) and=0A=
>>>> two dm-crypt instances on top. Both dm-crypt instances use the NULL ci=
pher=0A=
>>>> to eliminate potentially expensive crypto bias (the NULL cipher just u=
ses memcpy=0A=
>>>> for "encyption"). The first instance is the current dm-crypt implement=
ation from=0A=
>>>> 5.8-rc1, the second is the dm-crypt instance with a custom new flag en=
abled from=0A=
>>>> the patch attached to this thread. On my VM (Debian in VirtualBox with=
 4 cores=0A=
>>>> on 2.8 GHz Quad-Core Intel Core i7) I get the following output (format=
ted for=0A=
>>>> better readability):=0A=
>>>>=0A=
>>>> # plain ram0=0A=
>>>> 1048576+0 records in=0A=
>>>> 1048576+0 records out=0A=
>>>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.2305 s, 202 MB/s=0A=
>>>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>>>=0A=
>>>> # eram0 (current dm-crypt)=0A=
>>>> 1048576+0 records in=0A=
>>>> 1048576+0 records out=0A=
>>>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.2212 s, 80.7 MB/s=0A=
>>>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>>>=0A=
>>>> # inline-eram0 (patched dm-crypt)=0A=
>>>> 1048576+0 records in=0A=
>>>> 1048576+0 records out=0A=
>>>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.3472 s, 201 MB/s=0A=
>>>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>>>=0A=
>>>> As we can see, current dm-crypt implementation creates a significant I=
O=0A=
>>>> performance overhead (at least on small IO block sizes) for both laten=
cy and=0A=
>>>> throughput. We suspect offloading IO request processing into workqueue=
s and=0A=
>>>> async threads is more harmful these days with the modern fast storage.=
 I also=0A=
>>>> did some digging into the dm-crypt git history and much of this async =
processing=0A=
>>>> is not needed anymore, because the reasons it was added are mostly gon=
e from the=0A=
>>>> kernel. More details can be found in [2] (see "Git archeology" section=
).=0A=
>>>>=0A=
>>>> We have been running the attached patch on different hardware generati=
ons in=0A=
>>>> more than 200 datacentres on both SATA SSDs and NVME SSDs and so far w=
ere very=0A=
>>>> happy with the performance benefits.=0A=
>>>>=0A=
>>>> [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html=0A=
>>>> [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/=0A=
>>>>=0A=
>>>> Ignat Korchagin (1):=0A=
>>>>   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target=0A=
>>>>=0A=
>>>>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++---------=
-=0A=
>>>>  1 file changed, 43 insertions(+), 12 deletions(-)=0A=
>>>>=0A=
>>>> --=0A=
>>>> 2.20.1=0A=
>>>>=0A=
>>>=0A=
>>> Hi,=0A=
>>>=0A=
>>> I saw [2] and have been expecting something from cloudflare ever since.=
=0A=
>>> Nice to see this submission.=0A=
>>>=0A=
>>> There is useful context in your 0th patch header.  I'll likely merge=0A=
>>> parts of this patch header with the more terse 1/1 header (reality is=
=0A=
>>> there only needed to be a single patch submission).=0A=
>>>=0A=
>>> Will review and stage accordingly if all looks fine to me.  Mikulas,=0A=
>>> please have a look too.=0A=
>>=0A=
>> Very timely: I was about to send a couple of patches to add zoned block =
device=0A=
>> support to dm-crypt :)=0A=
>>=0A=
>> I used [1] work as a base to have all _write_ requests be processed inli=
ne in=0A=
>> the submitter context so that the submission order is preserved, avoidin=
g the=0A=
>> potential reordering of sequential writes that the normal workqueue base=
d=0A=
>> processing can generate. This inline processing is done only for writes.=
 Reads=0A=
>> are unaffected.=0A=
>>=0A=
>> To do this, I added a "inline_io" flag to struct convert_context which i=
s=0A=
>> initialized in crypt_io_init() based on the BIO op.=0A=
>> kcryptd_crypt_write_io_submit() then uses this flag to call directly=0A=
>> generic_make_request() if inline_io is true.=0A=
>>=0A=
>> This simplifies things compared to [1] since reads can still be processe=
d as is,=0A=
>> so there are no issued with irq context and no need for a tasklet.=0A=
> =0A=
> In one of our major IO workflows (CDN cache) using dm-crypt created=0A=
> high and spiky p99 response times, which actually prompted this=0A=
> investigation. So, of all the things we do prefer the read path to be=0A=
> inlined even more than the write path.=0A=
=0A=
Yes, I understand. Zoned block device support requires at the very least th=
at=0A=
writes be inline to preserve order. For reads, inline or not are both fine.=
 The=0A=
choice can be made by the user here using or not using the force inline fla=
g you=0A=
are proposing. These works are definitely not incompatible. Doing everythin=
g=0A=
inline with a zoned block device backend is perfectly fine.=0A=
=0A=
I mentioned my work because half of it is very similar to your patches. So =
we=0A=
could combine the patches, or as mentioned, one will have to rebase on top =
of=0A=
the other as clearly we will have conflicts :)=0A=
=0A=
> =0A=
>> Should I send these patches as RFC to see what can be merged ? Or I can =
wait for=0A=
>> these patches and rebase on top.=0A=
>>=0A=
>>>=0A=
>>> Thanks,=0A=
>>> Mike=0A=
>>>=0A=
>>> --=0A=
>>> dm-devel mailing list=0A=
>>> dm-devel@redhat.com=0A=
>>> https://www.redhat.com/mailman/listinfo/dm-devel=0A=
>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
>> --=0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
