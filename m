Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5882084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="NHpb4gsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgE1CWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:22:46 -0400
Received: from mail-eopbgr1320087.outbound.protection.outlook.com ([40.107.132.87]:30240
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbgE1CWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ6Q5CLWwQ5xDU/FqXtPMYBYkVNtHLs1H1FveqpzWiAOVG7QXWZ4YW2MAyvc51hyDMbaEDxStKPKwigEc3aDKyD9iPVNT+lhPtZPuZVyDFu3PMQyvf6vMaDVMRSJr6Vh0jZNzFo5Nyc88/Mvnzg7XF3TJ2vScmqgVytzeyQ4R+SoUTUrGtjDSzBZd+ryWY3feegf32VQBT+kmaZjKRKsgjF09XWnLPeTyRQhTt1KgwSG1Hsodi0INXYHglkiqVmLSF8dPeNBDQEK6D1soAFgaGHgEjNWX0aazE5u0ZJPAZfLr9npd7vvx1TSzUN0rqCVToOZ/uYvJRez6JijV1UXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEXZfCtKdG6SRgdbv53AVOUFwCl9310zucWtXy3TWcU=;
 b=QfGNDe4WMjhDVVbS65p8mOGm24aczESnCpTyCdetO/w+VVTclw8IrKFiJCUdfiSEK78AJYLgFldbhAtuBG59/lCJ9bSSxAd0cJSdGgOUK0TTmprRdAOfkruuHwAKkHnaglH6J3Y+Bj7piROCvPE2ea8MU1kQF6PSNkW+G1FEBKlCtUYmztcX0hfCI4nxTocpdrqGQZh4pX09n289gPrWzpKJu3ohFXCl+6VM9WnWeW6rcztbBUWyBbOM6WLqBf00YCmkZboFXXlKVljc3ofi5j478UP8yuwv8M6oqE+ze3j3BrHfSDkqtyevxlFOh4nmO2yhD+9DoWmKMXkw6K/tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEXZfCtKdG6SRgdbv53AVOUFwCl9310zucWtXy3TWcU=;
 b=NHpb4gsH8IyjSad4FHZfKU9CWAMnlT2ZA46E2ntZUHLiVEjS/F6bw3a0j1SEXI4hJL8WGn6swLa9Pi9Gv0ejkA3B+Kj/Kt4+0aZfcyyiHJPBV/ilW+DCoi435DkO9wIY8bNHKrADAtUpjPKy+3vwl5iL+qb4UeEEIMrmf0jFIoo=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB5193.jpnprd01.prod.outlook.com (2603:1096:404:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 02:22:41 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 02:22:41 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Wetp Zhang <wetp.zy@linux.alibaba.com>
CC:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to early-kill
 process
Thread-Topic: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to
 early-kill process
Thread-Index: AQHWMyxBK5FsG+fd5ka/mAnJKqbKvKi8x2GA
Date:   Thu, 28 May 2020 02:22:41 +0000
Message-ID: <20200528022241.GA1401@hori.linux.bs1.fc.nec.co.jp>
References: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
In-Reply-To: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef84e051-6c78-48a6-3115-08d802adfff0
x-ms-traffictypediagnostic: TY2PR01MB5193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB51938CA89DF3860CB7DDB348E78E0@TY2PR01MB5193.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8D6NCK4mqjnGNNPLFu3Z4SqR4kgpACjw9HfXscTGuHafFxlmUfE3PwotdGjgDm1Z2dMz59P5k2osW9i+JCcu+q5JMYFPe0/PL2fLdbnvyRil/1h08NAdu6G+1uQkv92ZnURKPDXp9LcyWYu3FevhhK3kcsALCqqo5CJ74VoiXiHGWpQLlmDLxnrUpUfUdkZCzPsauksUt4YaqIuPDFTusmTIQ4xS2fCLWT0lpitaB/ZwPc/0QB7ERGV6UexEF4deZQTnafwby1MNPqBYyw85/23q1oAN03MK7+81OuOfcIah0JLal0geqWsmE+E6xw9z0fc8jlF5qFHafK3WNslNfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(71200400001)(478600001)(316002)(66946007)(1076003)(2906002)(66446008)(66476007)(6916009)(66556008)(76116006)(6486002)(5660300002)(54906003)(64756008)(85182001)(86362001)(186003)(4326008)(83380400001)(6512007)(26005)(9686003)(8676002)(33656002)(55236004)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iFrLsNiLiDylT07eovu0xzl980f8clkywc3KjL2fk8ISXOf5KLxZUrnUmivInBh46SGSq2MwIFHtkfVD3uv02B0tvo2dlfchI+t1TvEwOrlYlqA4xeWAyYEgQTb7cRlEU+8l4O89H9/fo4nENmwzlw/ods1b+VdVUB7BMj52oUwTpuHzr68HerJkQPu2RcoW6MEmgs3ps0mt3M5WPdcxp7+n4kQaOhp2VSSUOBTb7TUarLHT+sEzqGjM1Lbc8Z0HQxLktK4OKOJ/6+77sGMo1kaAIZKYfWb5pj1onqUZpoYUrlluZgPMUlUZFUqBxTEcf+/EJfDI0CHpB0vS4+P13MIdxpTSqmee4LJGrWaZ8jDhxsrPtQmf5CRqfKfB3y6H81fG+xp8XiEb9xPR31YlHMHCp3lBuI2dwnep15SGgrxAoUmaNdbdAUqzPjh/gfHdnkZWfONIBGF51CKJpU2pinur8DbQ5RF3Vf/y7fjBSFK6Clo7kDSfjG/ajZvYgZi+
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <282999A19F659F46A6062BCC6F7B5B68@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef84e051-6c78-48a6-3115-08d802adfff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 02:22:41.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03C8e3RzrA/yi0gxHTAG2SiedZ6y39fDFf1UgGMocvlGxqypNYGkN++ex+lp1jSa+O2QE5TJiwQZFd/1xBJKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

Sorry for my late response.

On Tue, May 26, 2020 at 03:06:41PM +0800, Wetp Zhang wrote:
> From: Zhang Yi <wetpzy@gmail.com>
>
> If a process don't need early-kill, it may not care the BUS_MCEERR_AO.
> Let the process to be killed when it really access the corrupted memory.
>
> Signed-off-by: Zhang Yi <wetpzy@gmail.com>

Thank you for pointing this. This looks to me a bug (per-process flag
is ignored when system-wide flag is set).

> ---
>  mm/memory-failure.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a96364be8ab4..2db13d48865c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -210,7 +210,7 @@ static int kill_proc(struct to_kill *tk, unsigned lon=
g pfn, int flags)
>  {
>  	struct task_struct *t =3D tk->tsk;
>  	short addr_lsb =3D tk->size_shift;
> -	int ret;
> +	int ret =3D 0;
>
>  	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware m=
emory corruption\n",
>  		pfn, t->comm, t->pid);
> @@ -225,8 +225,9 @@ static int kill_proc(struct to_kill *tk, unsigned lon=
g pfn, int flags)
>  		 * This could cause a loop when the user sets SIGBUS
>  		 * to SIG_IGN, but hopefully no one will do that?
>  		 */
> -		ret =3D send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
> -				      addr_lsb, t);  /* synchronous? */
> +		if ((t->flags & PF_MCE_PROCESS) && (t->flags & PF_MCE_EARLY))
> +			ret =3D send_sig_mceerr(BUS_MCEERR_AO,
> +				(void __user *)tk->addr, addr_lsb, t);

kill_proc() could be called only for processes that are selected by
collect_procs() with task_early_kill().  So I think that we should fix
task_early_kill(), maybe by reordering sysctl_memory_failure_early_kill
check and find_early_kill_thread() check.

    static struct task_struct *task_early_kill(struct task_struct *tsk,
                                               int force_early)
    {
            struct task_struct *t;
            if (!tsk->mm)
                    return NULL;
            if (force_early)
                    return tsk;
            t =3D find_early_kill_thread(tsk);
            if (t)
                    return t;
            if (sysctl_memory_failure_early_kill)
                    return tsk;
            return NULL;
    }

One subtleness is to make sure that find_early_kill_thread() should disting=
uish
default value and explicitly set value, so we might need some modification
on find_early_kill_thread().

Can you try that?

Thanks,
Naoya Horiguchi=
