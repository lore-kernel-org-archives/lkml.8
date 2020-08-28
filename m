Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B0020665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="p7CvZlXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgH1IMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:12:07 -0400
Received: from mail-eopbgr1310048.outbound.protection.outlook.com ([40.107.131.48]:27328
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbgH1IMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCBjBHz4z6c97dd1/jGf90S172Uh6Nag59chitr7uzQ3W/CzaCD+JFrpkR3QWwwl8HxEFYaBFZGfH/aLE1gRx0oUco0m2QM5t8pvVCciNWkiqZVm4AnHGLVMo4kq2cPGcN/cdtw623O66CHxIj59EKKHaQkq1jihSphYpwS9tgC+Q2QVy/jq3ernI8oSnV3hsxtx0cOBi5YHzAT58IGD473cNsRjRK3VmbxfcXZx2Lp1YNFEtvkF8ga39ZGscSTL8MhROsTdv+1pVSkBRtliWt6skLqNpcQcTd7TaVtrENol6NNTyrQXeGYdfqO1EYSbPnNDWWleyIo31NIc4rmy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmD+6OQYL6aLzCPylJU6tqIg3DtlTDw33hBWda1s8T4=;
 b=RHHeLmhL14bFZX45MYlxbb2rhoijS5xKWvPt5C+2bcdt71ZNPCAsXvZeV1VpwYlDVJOXUi8qfVGmncsvtwSV9zAocxdKr88IeBOhCFElI6+UdGBvS24wBnuQsGzhXNvXGUTYYRXTUXqwAm16JdK9VdcLk4EAeB9x+KPhZ2l8EBbZiH9nfjTL9qGwfAlSMSn6NyAp8jUa0eDNAwb+tYSx3Vs9bMZu6Vzy5/7kbjqT7YqzEyIz1nPucLpdg2DxjjJYGBV81dkoI4wibhC5psXrVCIZOgfo2f/EnKg47IjVcVyQHOs26+r3UVC4xklrbtVx+LOZDGQUYku3UWVxFeRnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmD+6OQYL6aLzCPylJU6tqIg3DtlTDw33hBWda1s8T4=;
 b=p7CvZlXRL6TvczrHnyGTYZdI5FJI2tn+XbnhvJ/vB+opIK9Ct4JX6XHIZ1qpvK5kKqd7ifQ2MHLFIPhgAxgd//glXcBYydmtUcp7oRhsPt2KYw1EV0IfHi6O1Yiw1V1xHzKIyRK26lS+GyJSg4eGCzh/8Q8cPCMc9Ui8LmPRqr4=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB2252.jpnprd01.prod.outlook.com (2603:1096:404:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 08:11:57 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3305.026; Fri, 28 Aug 2020
 08:11:57 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Youquan Song <youquan.song@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing
 the race to poison a page
Thread-Topic: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing
 the race to poison a page
Thread-Index: AQHWfI+iFPfYAYTdCEO35uV4adkml6lNLKoA
Date:   Fri, 28 Aug 2020 08:11:57 +0000
Message-ID: <20200828081156.GA19455@hori.linux.bs1.fc.nec.co.jp>
References: <20200827163205.23096-1-tony.luck@intel.com>
In-Reply-To: <20200827163205.23096-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166a7e2e-1ac6-42a0-c1b5-08d84b2a083f
x-ms-traffictypediagnostic: TY2PR01MB2252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB225288C612BFBBF00960C891E7520@TY2PR01MB2252.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tx9ELa7s+YHjgp4JFIn26NW5DUhtLuFFmVeh6mPLNUq234avnvy8DDGdPAPRlxg6w9VzL2Ua6FGpi3ztuAMCYTBoKR22AcOX0eWT3LyCIEWhniA6pT0jdpxLoc/oCpRL5y2eqruwe3H5CMH5TxA+7HbiJ8rj2J1N9Pqh4WpNR9LQ6GlBnxgE6byNKyyf7h5pl6j2NiiCEHQYYev/oG1nD5wCqS2UNEsasSr3UMOGjrFUcRA24IwAycTRqEWpGEtlpU0uRZ6xlD8wBey+3DlxTpAhisSLaEf4vntJGGXskx5MPm1g5hpHfh18eNe37Tyz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(54906003)(6512007)(9686003)(85182001)(1076003)(6916009)(498600001)(71200400001)(5660300002)(64756008)(2906002)(66556008)(66476007)(66946007)(6486002)(66446008)(76116006)(83380400001)(6506007)(4326008)(26005)(33656002)(55236004)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MQ+xHHQRd5UR7UczJozRQifgfbF7/v0VdxHCFetwIsNIaPB3rklBXc92lAGtBEMNG6fuFR0AWg+7bYR8OwA/oqD43AOeQaFuHPsE/vNIKr6AugybCz5zFB/QzbcrTXXnrzhJonDoOXIdmPkgZ5Z7iKEm4ydBX8QMGTi6xsbjvRKmvHxJB90Wjcga+RbGq/r+X+UOpBTaYKAI4pzg1avb9FNA3Ou4dK7O06nbU+HXKc1L15lTn6ym9G54ZNrDBLR3gHagBktpPHronXZlHLQJnMMViw1EtVcvyFjdPcuOkgLygEmcjxnAzJwKuIGxjUkFXj+3zh40hXku//schjFcvM9WZehxzYLy0y7h8+x1V9p/hKO3kDprBiioo9eeo/Mnj1MvcArpcvtErRzwdkCkoSk9phL7YvG+gPe0XEqgSTqPPh1pJP6Tv/QN8PsVqKdsEKMe1MONXFW2p+3CqndYK6ItPyxwzBYiqwomjKl/L9yIQ5WEnaHrd4cavPgnzr17IfMtBqfuhExR3oRAILaJwKu4sCNaAgAyNnGouHNY9Zb+3S3UppdWyG68RqXgyAByP+JQry75WRFz5u6TiLenIqeMhCMQfSFQ8WR7LrVQsGom8n06Frn1Vxm1z/csnCDDC7tHKFQ0Rmoz1YDdp+uVkQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D9128DABC50C1F419C4FC729DFC93114@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166a7e2e-1ac6-42a0-c1b5-08d84b2a083f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 08:11:57.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjtMQXeSVZBGMzR7EoOWpQmgoxmG2ntLKHYs6Y8fT4jsT98LD3bKaLgpx28AWhqBmNpt5MlYIAc5lbFpyKNBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 27, 2020 at 09:32:05AM -0700, Tony Luck wrote:
> For discussion ... I'm 100% sure the patch below is the wrong way to
> fix this ... for one thing it doesn't provide the virtual address of
> the error to the user signal handler. For another it just looks like
> a hack.  I'm just not sure whether to delve deep into the
> memory_failure() path to make sure the signal is sent to the current
> process in the SRAR case. Or just to do a better job at an error return
> value and make the X86 specific code send the signal with the address.

I think that both options could work. memory_failure() now sends SIGBUS
only to current process for SRAR. Or relying on kill_me_now() is fine.

>
> I've also got a feeling that this issue has been discussed before, but
> can't remember how that turned out.
>=20
> First few paragraphs describe the problem (and I think are OK). Things
> go off the rails with the fix.
>=20
> -Tony
>=20
> X86 hardware may provide two indications that a page has poison. First
> the memory controller that detects the failed ECC check may log a UCNA
> (uncorrected no action) signature in one machine check bank and signal
> the OS with a CMCI (corrected machine check interrupt ... historical name
> did not get updated for this case). Next the processor core may log a
> SRAR (software recoverable action required) signature in another bank
> and signal with #MC.
>=20
> The #MC used to win that race and the page was taken offline and SIGBUS
> sent to the task.
>=20
> Changes to how Linux processes machine checks now mean that:
> a) Linux will offline the page based on the UCNA siganture in the
>    CMCI handler.
> b) The machine check handler defers processing using task_work_add() whic=
h
>    can happen after the CMCI is processed.
>=20
> memory_failure() avoids races with multiple callers reporting the same
> page with an atomic test and set operation to mark the page as poisoned.
>=20
> The net result of all of the above is that when a task consumes poison
> the page is taken offline by the UCNA/CMCI path, and the SRAR/#MC path
> takes an early return without sending a SIGBUS.

Yes, in this case with the above changes we will fail to send SIGBUS for
SRAR, which is not good. We should always send SIGBUS for SRAR whether the
page is already poisoned or not.

>=20
> Fix by changing memory_failure() to return -EEXIST in the case where
> the page is already poisoned and make the machine check code path check
> for this error and force a SIGBUS.

Simply returning -EEXIST maybe breaks the behavior for SRAO, so could
you add checking MF_ACTION_REQUIRED in this path?

Thanks,
Naoya Horiguchi

>=20
> Note that -EBUSY might have been a more logical error code, but that is
> already used for many other error cases from memory_failure().
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>

> ---
>  arch/x86/kernel/cpu/mce/core.c | 7 +++++--
>  mm/memory-failure.c            | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index fb6b5f64f7e6..8515809e0472 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1182,18 +1182,21 @@ static void kill_me_maybe(struct callback_head *c=
b)
>  {
>  	struct task_struct *p =3D container_of(cb, struct task_struct, mce_kill=
_me);
>  	int flags =3D MF_ACTION_REQUIRED;
> +	int ret;
> =20
>  	pr_err("Uncorrected hardware memory error in user-access at %llx", p->m=
ce_addr);
> =20
>  	if (!p->mce_ripv)
>  		flags |=3D MF_MUST_KILL;
> =20
> -	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
> +	ret =3D memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
> +	if (!ret) {
>  		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
>  		return;
>  	}
> =20
> -	pr_err("Memory error not recovered");
> +	if (ret !=3D -EEXIST)
> +		pr_err("Memory error not recovered");
>  	kill_me_now(cb);
>  }
> =20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f1aa6433f404..e0486c4e0130 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1298,7 +1298,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (TestSetPageHWPoison(p)) {
>  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>  			pfn);
> -		return 0;
> +		return -EEXIST;
>  	}
> =20
>  	orig_head =3D hpage =3D compound_head(p);
> --=20
> 2.21.1
> =
