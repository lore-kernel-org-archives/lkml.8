Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF1BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFF204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="atmc1jXB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="thYoNFiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgFVApY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:45:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45902 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgFVApX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592786723; x=1624322723;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RjxLhLiF6Cq3mTdeFi0jAYXWQnRdhIje1UzxuMjL6Fc=;
  b=atmc1jXBhFmcW0QfCJkR5XoAnJyDsUzef4Ohr59evMm2hyYyfshBzKX6
   FG2p1pYhhaZqpeYGTJjNc/LyF82RmMWpbX82ceVzCGOcWqLQTTeiN4NCh
   dB/JMMuOpeQ9DsKnnrNK9i7FWp/u8jgMbMe0XZsrbrKkehrseIJHzVP2l
   aoptaiInS+BeCry015hP1io9EpX+xTNGJhSbr4k2OTdXcJSKEweLUEvUk
   xXY2vcORJ3o5jX/bQ4gQHckqqGT+3L8kyT8UL1ci7loONUryEqEzfORl2
   IcHt5Jw6nG7rEW3TW++K13l3X698GERNV3+Ua39nbSUXapz5zbXH9FRDO
   A==;
IronPort-SDR: bCgRgX+QSTQ+62T4/nysA6ugivx51aE3ugRBQXyH2bt8BZneYoZA6oPupuu84OIFI2UolaAwjd
 ytZwP1usk5kbW3+n4M6b/2X6+WTKBFDJihmNOKX0GD7g33wtH/p4KOiDSY8geAdPAl2y6kBk5j
 18j3QN0XwvaemCsU/DRGCwLQAJ6RJ4jXPmb2NPgmw3mzxUsL1I0OtgeQiIMh5xZGphLnM2CsAC
 KFsRENSOyJi5AhGxV5KbfTGtw8Hp1Jf0n8iogofYG+e+blckTAmR7O8oER6e4FbwO/RFAkOCTO
 r5k=
X-IronPort-AV: E=Sophos;i="5.75,265,1589212800"; 
   d="scan'208";a="144884352"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 08:45:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kav1oUVZtAas5F0dl4EmOdgPENo8XSqQ2++r8cNhArqH2zPCw6nbXN97R0d4/s2maaYbIe79A51ZtE0FbiqXKnEaseR74goN8Pvq/Gbal16iXpl1AGkwj1+64+ub2hPyzlFrDegqvg3vXNxPtmU4XAVrB3WJ8DJkSiO6YfqJG1FiLTXALkA/MaRPrfUgk+4My/ReaGJzrhPtOSsqXf6FdmVvewAnrurmW6c+SvwaxDyAXPc9k8//C5kxFCd/mcQoAbrE+vimVIjQXQ4mQ3G5e1obEOGYyp0XYKUsNBYgCFy0MYriHgrhzqHcCcDk5obeFpEdht8M8YxViFDu4CvcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lul1KxOHm1vohi/lJ3u8NTWCVmu7W7YUyhApVGN+qac=;
 b=gXTtpl7qqJyVpDFdNAsburABkE6qktzvGgWIaUCCWl4br0GLh417c0jv8zQpGl2ZYK5hn1jZwqb0HieSNYMEs71D22f2V7D6dlV0h3Cq+SAoJmCYA6KUYJadCXY1yU7ePfUSv+WdlBoJMKAJSgwFpRNfkyP+PnR96qD07G2FhqjeVq3do6OJA/9H/hAaXlHxBav6CHzz5ni8oWtetWnvh3wO7wZlkCeRXR47GHdy8L2vA4gducwWZM9DcHfLbfrMB+79BmhPY2V186Fb1R7IZnVCJjjEiBsQeGgWlztnOxEihOQwc8SgjscgihM9oEA+GXF9DYmo9rAHcRpg0u7tQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lul1KxOHm1vohi/lJ3u8NTWCVmu7W7YUyhApVGN+qac=;
 b=thYoNFiE5MUjY6aFlHF2elIS3yi5dKQJ3hPzcRPfmHiFmuiSoHpVjTswex6jgXi+uASu2HIHL+vH/azdzp0VxLgrlM9wn9RHJDizSYosUfiiOs8RfnrUQnQZRo2vDVcWlkUua/5q9C0B5gR53vEDIzapRsL2b2kKZbHhbb8eAjo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0247.namprd04.prod.outlook.com (2603:10b6:903:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 00:45:20 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Mon, 22 Jun 2020
 00:45:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Topic: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Index: AQHWRlqI8D6+Lz65i0Kgr2YROVo4Vg==
Date:   Mon, 22 Jun 2020 00:45:19 +0000
Message-ID: <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94d66db1-d208-498a-01a5-08d816458a33
x-ms-traffictypediagnostic: CY4PR04MB0247:
x-microsoft-antispam-prvs: <CY4PR04MB02472A510210A0B562E5290BE7970@CY4PR04MB0247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsUQoB8bYs1kBoEyIMHmZ3KO3lkeeyAVxN2PIKnBP5FPHjBptDpXU9XgLBlFlhYeIOsnMY8q4EJF+kSW1hIQxffsL+ALnHmfYlphDy7qLRpNmUMRrHfy2Dd+UdPFWJfDxvsx1J+1LxOCwxP14MxItn7NTQxGyZEePq9MaeIHoopM3hQZ5Muib3mxGkrhfhm2fD8MU/88sNCcExJFhSafQnbPNkyJbK101ZZ2O74sa89xbb/DpD21h/fYQFGN/NhkiQaK6Hw88N/F9GApe+oxOZJ46V9euyKj3lI8mdm29lHHMm7hAl/zA8H6NWTtYgFtFnGOGvMbhEoDr1SfHahumSVs+4xYQFILlImndPi7WGVU/u53hJ3aNyXZGdtWhHoCdkfLFMOzGmWrVk9ibqUreA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39850400004)(366004)(376002)(346002)(396003)(33656002)(186003)(66946007)(26005)(76116006)(53546011)(966005)(66556008)(91956017)(7696005)(478600001)(64756008)(6506007)(66446008)(66476007)(5660300002)(8936002)(316002)(52536014)(4326008)(9686003)(8676002)(71200400001)(83380400001)(54906003)(55016002)(110136005)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IRj5EIQxXrB1s3uVwFUqKZu2uq2iDQpooSImvgBQ5wQhylPHmgHbxhPyVCl8tjkJIrJt6Tu+s1gLGg5TUu/guzHiD7jQqo/PbIzYFQ219vwBgjZLICNV4qPbwWizPxW2UTYT6OxYuQhhpqnJgw30nhvvGfwY8WXKi2aUVDz1IUjvtxyi8L0uIHY7zQXm9WfZ281s4uLjUdDECl/i3lgqhbR7aLVd6LfITCnihHVm0/PHAHaYs6jUceYo4nHAXxzMOEiMAxaJMfrxgl3gE/IqzRNIjgRkayt+sfUXysHawKgJrnSlF5GgWJyQWLQTRGYgpmJi1ZTCP+lj66SUeKuJu/5ZUwSRjBWBIPCUABdTDCxhSbwaz6TGJ0O0avK+LPdKUPJ1ahDgK4Hq9P82d0ym2rXJLLrLk1DThxqqM9RdVc3k+HtGijMi2DZ8Z/LKNsGIdMPhEEmVbC82b0keoQdREs5RI6QhLA86O7LOmUN5FMRnaZLr/ZU+wjNr126noiw/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d66db1-d208-498a-01a5-08d816458a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 00:45:19.8678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COXKeBtfoIR8e0DxhufqWiAZ6Em+VLFiySL/uqzcooQrzFrQPwFIj3SCrJHMJBsGX/5zh4qsAKj/qgqnRZ7gww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/20 1:56, Mike Snitzer wrote:=0A=
> On Fri, Jun 19 2020 at 12:41pm -0400,=0A=
> Ignat Korchagin <ignat@cloudflare.com> wrote:=0A=
> =0A=
>> This is a follow up from the long-forgotten [1], but with some more conv=
incing=0A=
>> evidence. Consider the following script:=0A=
>>=0A=
>> #!/bin/bash -e=0A=
>>=0A=
>> # create 4G ramdisk=0A=
>> sudo modprobe brd rd_nr=3D1 rd_size=3D4194304=0A=
>>=0A=
>> # create a dm-crypt device with NULL cipher on top of /dev/ram0=0A=
>> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | sudo dmse=
tup create eram0=0A=
>>=0A=
>> # create a dm-crypt device with NULL cipher and custom force_inline flag=
=0A=
>> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 force_inli=
ne' | sudo dmsetup create inline-eram0=0A=
>>=0A=
>> # read all data from /dev/ram0=0A=
>> sudo dd if=3D/dev/ram0 bs=3D4k iflag=3Ddirect | sha256sum=0A=
>>=0A=
>> # read the same data from /dev/mapper/eram0=0A=
>> sudo dd if=3D/dev/mapper/eram0 bs=3D4k iflag=3Ddirect | sha256sum=0A=
>>=0A=
>> # read the same data from /dev/mapper/inline-eram0=0A=
>> sudo dd if=3D/dev/mapper/inline-eram0 bs=3D4k iflag=3Ddirect | sha256sum=
=0A=
>>=0A=
>> This script creates a ramdisk (to eliminate hardware bias in the benchma=
rk) and=0A=
>> two dm-crypt instances on top. Both dm-crypt instances use the NULL ciph=
er=0A=
>> to eliminate potentially expensive crypto bias (the NULL cipher just use=
s memcpy=0A=
>> for "encyption"). The first instance is the current dm-crypt implementat=
ion from=0A=
>> 5.8-rc1, the second is the dm-crypt instance with a custom new flag enab=
led from=0A=
>> the patch attached to this thread. On my VM (Debian in VirtualBox with 4=
 cores=0A=
>> on 2.8 GHz Quad-Core Intel Core i7) I get the following output (formatte=
d for=0A=
>> better readability):=0A=
>>=0A=
>> # plain ram0=0A=
>> 1048576+0 records in=0A=
>> 1048576+0 records out=0A=
>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.2305 s, 202 MB/s=0A=
>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>=0A=
>> # eram0 (current dm-crypt)=0A=
>> 1048576+0 records in=0A=
>> 1048576+0 records out=0A=
>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.2212 s, 80.7 MB/s=0A=
>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>=0A=
>> # inline-eram0 (patched dm-crypt)=0A=
>> 1048576+0 records in=0A=
>> 1048576+0 records out=0A=
>> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.3472 s, 201 MB/s=0A=
>> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -=0A=
>>=0A=
>> As we can see, current dm-crypt implementation creates a significant IO=
=0A=
>> performance overhead (at least on small IO block sizes) for both latency=
 and=0A=
>> throughput. We suspect offloading IO request processing into workqueues =
and=0A=
>> async threads is more harmful these days with the modern fast storage. I=
 also=0A=
>> did some digging into the dm-crypt git history and much of this async pr=
ocessing=0A=
>> is not needed anymore, because the reasons it was added are mostly gone =
from the=0A=
>> kernel. More details can be found in [2] (see "Git archeology" section).=
=0A=
>>=0A=
>> We have been running the attached patch on different hardware generation=
s in=0A=
>> more than 200 datacentres on both SATA SSDs and NVME SSDs and so far wer=
e very=0A=
>> happy with the performance benefits.=0A=
>>=0A=
>> [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html=0A=
>> [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/=0A=
>>=0A=
>> Ignat Korchagin (1):=0A=
>>   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target=0A=
>>=0A=
>>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------=
=0A=
>>  1 file changed, 43 insertions(+), 12 deletions(-)=0A=
>>=0A=
>> -- =0A=
>> 2.20.1=0A=
>>=0A=
> =0A=
> Hi,=0A=
> =0A=
> I saw [2] and have been expecting something from cloudflare ever since.=
=0A=
> Nice to see this submission.=0A=
> =0A=
> There is useful context in your 0th patch header.  I'll likely merge=0A=
> parts of this patch header with the more terse 1/1 header (reality is=0A=
> there only needed to be a single patch submission).=0A=
> =0A=
> Will review and stage accordingly if all looks fine to me.  Mikulas,=0A=
> please have a look too.=0A=
=0A=
Very timely: I was about to send a couple of patches to add zoned block dev=
ice=0A=
support to dm-crypt :)=0A=
=0A=
I used [1] work as a base to have all _write_ requests be processed inline =
in=0A=
the submitter context so that the submission order is preserved, avoiding t=
he=0A=
potential reordering of sequential writes that the normal workqueue based=
=0A=
processing can generate. This inline processing is done only for writes. Re=
ads=0A=
are unaffected.=0A=
=0A=
To do this, I added a "inline_io" flag to struct convert_context which is=
=0A=
initialized in crypt_io_init() based on the BIO op.=0A=
kcryptd_crypt_write_io_submit() then uses this flag to call directly=0A=
generic_make_request() if inline_io is true.=0A=
=0A=
This simplifies things compared to [1] since reads can still be processed a=
s is,=0A=
so there are no issued with irq context and no need for a tasklet.=0A=
=0A=
Should I send these patches as RFC to see what can be merged ? Or I can wai=
t for=0A=
these patches and rebase on top.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Mike=0A=
> =0A=
> --=0A=
> dm-devel mailing list=0A=
> dm-devel@redhat.com=0A=
> https://www.redhat.com/mailman/listinfo/dm-devel=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
