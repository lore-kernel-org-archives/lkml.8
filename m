Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA912085B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RH7JQBps";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eUocR2Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgFXE2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:28:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54871 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgFXE2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592972897; x=1624508897;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j0A9b6pA5aoN7IsKslNpmH0nlFI2JOVVaek8F6ltZcs=;
  b=RH7JQBpsjnAZsH3/m5Pa+76P98PpomfwMhCs+nD1bUor0jz74oWc5A0k
   kHPrC5+0APg0e42rXWzS52wZdNC9Ll9fBQgIJMdwNWyOSOOFRs7NZKZy0
   TvdHZkkvzWFCRUFY82ku9qC7ZPTQGa4YrnpWUveViKYKkeVBSMVkDlqKZ
   qjWNKdvzUXJqfZSBtN4SrUd8QDc+rE0sRmQ/XFCzWBL1kVbVFN0cQR/Uy
   CYZzZclHaGfgVfIgyh+1cAucIq/zYKXvPDanGH8zE92vhKtqAGACCaam7
   FHKEUaSwcaHebm1t63ohZw0rqckqTXComDKzKTJs5sVFNGR9wSrOwRU5i
   Q==;
IronPort-SDR: 4/oVBLUMc8h6cN6JBXIY/nYQEYUn0k5abQHP+G7asWb07d2kapCxzNyiiJi74FT8dIUNpgZ8T+
 lc0rhyjZKjaBVgquVZHpR6lRV+N71q/aNS810fwVtuhDoqxLr44Oi/aQkEGyDTRM2klXTHY9TJ
 PdWNAteyG+qYX0kj7VlSDFiKP7O1Sevd4ENgA9wj2o8t8S35vUsIlbMNbXJQbBsPGhREyvaB7D
 xNIzu3yBCYyJtWtPgorl513umxVPy4cpIANuhSQ1EI/GTcytosV2waimqwsqg4C1Uwyu58G04Z
 03Q=
X-IronPort-AV: E=Sophos;i="5.75,273,1589212800"; 
   d="scan'208";a="142138058"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 12:28:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWhA430ieEqXELz/QkF0i8vFUSFeQODCPYIbfgI53A4dn7B1cbGvh1H6N7kdjnKaAAJiBpSkoue+jVT7A8ThCpAguRBu5M08dT7X/lVu862LkC637mYWenCosvBxVtwEIqrId8RvYJXtm6CxpE6AWTeb6O1tS92g+Wn7LJ7e7BiDhaNkklHXG+x/2AeirxBcwKNHBbXHbrkpIigLCkcqfAUZKoyucArBRQelfhMm1sSuoKznFSCoO448eUl5c8yBZ9NWMaq84q8UaYJV+Ud04nr9eGia7W2iVYJRg9l29HhPUfrbVVPWsESONvkuwnc9RGg94PvLWbAdjETSDKKWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pboe0lOvJ4bfFOO1NKgl9zfMqPCO7/Hwl/vwpd2dDgE=;
 b=DjUQQFZtVLplHfMoIpadlE+h/yz7qATZkYBUHxQpigJYjLN+kM20Be2CDncVkzDdCJViIt9vxcf0NrF//O6wo0xrNDEnhcXEjkKzF56tuPfSDaGSijBJYWD4RoDl/X2Zgr7MEbeahc+VAHAzduQ5hfxV8TShuJuRpwIR693rqiSsfd6tX5hnJlwnrpnu5FkzNMt2Fm0Krdir3MxPoo/smC67eiCvvQWrit63x7qzL+Ttwtx2iJtTYfXboZZaSTBD+kvlxj6/vyPwWFo9Yz0esGzbHpa44sbm2P19fiQgoit582hSUhZOOvQJW/t6EZTDku4LKNp3/eXkjEIbJDv7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pboe0lOvJ4bfFOO1NKgl9zfMqPCO7/Hwl/vwpd2dDgE=;
 b=eUocR2Q+mS4a3aIdgl6geJCfrcpwZe0ftj4tGHufYnp7R40EbIxjxe37hQk82WxerpJEsflFkp560ysGE6wOJWbHhJNz0+PCfakH7AVxqyZUI6hzxNoT3FS+T8gq4G9JCjlDF0q+NAzySZ4CpG1YBBr2Uppm/1vCsse81zjTKSU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 04:28:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 04:28:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     Ignat Korchagin <ignat@cloudflare.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Topic: [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Index: AQHWSW85EuQz0D2EUU26/bqk/44H8Q==
Date:   Wed, 24 Jun 2020 04:28:14 +0000
Message-ID: <CY4PR04MB37511A1673A58A2D66B4D6C0E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 504bbfcc-c7ed-402b-256a-08d817f702cb
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-microsoft-antispam-prvs: <CY4PR04MB10302435E8970154717297B8E7950@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3SseFRvk5fbYApAj8eUzgpucZTB5/oXLPAJfIDE/KfawWSWuyZSJoEezZJ77vgbYhG6X7F6Ko+6f+Bkuzx7M2xqa/ihx73p/r/yk9uurxc8ByTBYNGFmOmroMc/bIYmRzcf4NgMwiCXiM3yrT4dyoPiiIRv1FCcqzNsO/gs1dhRoimOgMlAnwZHBbfDb+JRWPgrXBQ3YWZOlgbVCGzLllxVmSFYMi/oDvFIIvQHZIDaxsyVJKXC8ei8e+Q1zr78i5tsTTie0CJNldgbZkgZcgZfLWQs2b8gBO/kbUIRfmqiInEZPzttM/PqGkFvxymr3er/S8/XHgIXosoYREQz8Qv7B99cYevx6bSrFJbD/zXjXax7+q+/eY6mpLB172pgw5VtCzA8a8M7PvB62il1ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(71200400001)(55016002)(2906002)(26005)(83380400001)(8936002)(33656002)(54906003)(9686003)(186003)(4326008)(8676002)(86362001)(52536014)(478600001)(7696005)(5660300002)(53546011)(66446008)(316002)(66556008)(64756008)(6506007)(66476007)(6916009)(966005)(76116006)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VizTVj+oubBL1/gB3kkSECdh5Or756TGRp8BTliUmmbs5U5h5e3y9nMJYjXzyL17U4gX+3crsUEZxQ2wQpJRY2nj6n1pr0+S2+FBpeaH3Ip8oCsrK4dTHddT6vHze7aQPj4MUxRolBsei2K+sz6HVgYsn3Yj8XQb+T8evQh0azo9XBbrR1tITb4LuYUb5VTUajSTgnIVxm2eZNTqY9Er1B9SMkzzx/a65nEFGhU3aWL1iac8MdEGCXHNQlJgIwBR+Nn22BKZtSuvU+2RiJz4fbutAhLBbzXiF27aSUzhb2scEdUah3TfnwROvPfpA87xatTOagFdOwlUGy1iHX6J0ZKDRFI583TJCcdgf8c1SnaSCXsDTmKxek+5bQnnlun+o1QY7Y6vdPkoiewsza9JSYXNOP3hjTjs3TfhQw+YTacLxnldcS4QN8BsxbNrUyRh02vIL8su+wmKeLPG0xVJ4jYwHnAKWUPjNQ2Ge0ynmWBJFF9+jg62M9vozSZAXg3D
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504bbfcc-c7ed-402b-256a-08d817f702cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 04:28:14.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SemFxYQceaJNNGEw+77b/vnbomVZT0V2O69dgksKjl7jqn2h8BWtyN/MpNQdaDdomxprVeGNas48MVP28G+LIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/24 0:01, Mike Snitzer wrote:=0A=
> On Sun, Jun 21 2020 at  8:45pm -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
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
>>>> -- =0A=
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
>>=0A=
>> Should I send these patches as RFC to see what can be merged ? Or I can =
wait for=0A=
>> these patches and rebase on top.=0A=
> =0A=
> It'd be ideal for this inline capability to address both Ignat's and=0A=
> your needs.  Given Ignat's changes _should_ enable yours (and Ignat=0A=
> clarified that having reads inline is actually important) then I think it=
=0A=
> best if you review Ignat's patch closely, rebase on it and test that it=
=0A=
> meets your needs.=0A=
=0A=
We did a lot of testing of the Cloudflare inline crypto patch to understand=
=0A=
implications on performance when using a server with a large population of=
=0A=
drives. These tests used regular drives, but we already understood while go=
ing=0A=
through this exercise that inline writes are an easy way to support SMR dri=
ves.=0A=
Point is: all the testing went well, no problem whatsoever detected. I will=
=0A=
review Ignat's patch.=0A=
=0A=
> I'll wait for you to do this work so that I can get your feedback on=0A=
> whether Ignat's changes look good for you too.  We have some time before=
=0A=
> the 5.9 merge window opens, lets just keep the communication going and=0A=
> make sure what we send upstream addresses everyone's needs and concerns.=
=0A=
=0A=
I based my work on the Ignat patch that was available on github. While that=
=0A=
patch was initially developped for 4.x kernels, it was easy to apply onto 5=
.8-rc=0A=
and I used this as a base. I ended up changing a lot of things because:=0A=
1) I did not needed the inline reads, but they can be if the user want them=
 to=0A=
be for performance  reasons.=0A=
2) I micro-optimized writes to conventional zones, allowing those to not be=
=0A=
inline, inlining only writes targetting sequential zones. The benefits of t=
his=0A=
optimization are rather dubious though (read: hard to measure) as conventio=
nal=0A=
zones represent generally about 1% of the drive total capacity, and the ten=
dency=0A=
is to move toward SMR drives that only have sequential zones. Dropping this=
=0A=
optimization is fine. It simplifies things and adding SMR support is basica=
lly=0A=
reduced to adding the report zones method and marking dm-crypt features wit=
h=0A=
DM_TARGET_ZONED_HM. All on top of Ignat's patch.=0A=
=0A=
Please see my following reply to Ignat's idea of separating read & write=0A=
inlining with 2 flags.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Mike=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
