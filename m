Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1836C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27F720759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="E9Wm+Qxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEUTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:00:59 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:42377
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729555AbgEUTA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhusIt3Qa0aKzLBzpchVOpDdr1DCjHRpI9BqgdUfgSQJ8uLXNfJDAZKWh4ugP/nj+E/hldk10hm0cz4EoQU89UU2glc9T+mL9bF69+h6mTkwVa2sOOhT3N6xYn+UPx26LbP1QPetoPbb2CGNhvtzcD37cUrvreIoH/68sxZlIxFNMzWJoDXyK4MilpaTs1yAcOrcdREWrBCPS6opjiP4LXHaAGkztOalTlEkfr+CweoZ8ThqD+MCyJMhJ4raTKUljdjGMQBuzBdSneE4ou6f+RokpkSgwr6E81A/Z68SQ5hq8RvqhYlCJ8MmfXmCnj+Iwva+M3IZPVrlQNzfCW1+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRLtwmin+uBFv2bxyaJfMP+kahYQbfoQh/G8D985aiM=;
 b=msdTjbeRgx35YHsNbUSW3QzUM4fIhLk3CL68ubhbY9iPq6GPrtsV6c6WC/X6FiW1U3gRPCGyApGQrx2y3WfqYXbMBVxjDu/cap9LKuATQ2AT3ZnXpTUYaBoz1zfwBAlETIz7HaNlQ76Qb/od6SaHOkztQYyFBtiNzw28kIQhU6kb81hdTnsJmUmun6uF3MqlEEeL8peB9hPwEDCYe7Wj0tF6fsJJffh6TeZTZeZw8SN3QBrddP1XIRHtc9x/Gx2FP42RIhl+MYKaLNQthdJsUV6GCHy0oTfdXsfVvIV4DQg8dioCrYhZ8Ho62h40G2V5N00kcU78uWr9b3biu2vG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRLtwmin+uBFv2bxyaJfMP+kahYQbfoQh/G8D985aiM=;
 b=E9Wm+QxbaJNk280aR/JVHpSL6+IkwyVv72igG7hvfJR3lr/T5K4Tqv2rykc//4MKsqw5HkDPDaBGEFC4C7CFoDXAXq0D/1WvkGJPebgv0PrE0OIuUsUIcBu/I3vPS3xbzPoxyGpDo3r1LhYSftCnkvFhY0leHcpPbshuCx09DI4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4359.namprd05.prod.outlook.com (2603:10b6:a02:f8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8; Thu, 21 May
 2020 19:00:55 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a959:4324:5f38:eae4]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a959:4324:5f38:eae4%7]) with mapi id 15.20.3021.019; Thu, 21 May 2020
 19:00:55 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Wojciech Kudla <wk.kernel@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: generic ipi_raise tracepoint
Thread-Topic: [PATCH] smp: generic ipi_raise tracepoint
Thread-Index: AQHWLqkBg6gS/Xqm0EWDcGi7mvQlq6iy5vwA
Date:   Thu, 21 May 2020 19:00:54 +0000
Message-ID: <40AA62E7-3AFB-44DC-B4A6-F89E5C914620@vmware.com>
References: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
In-Reply-To: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [2601:647:4700:9b2:514a:23f:4185:cd44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c3fda8a-d5b7-4056-f873-08d7fdb94a18
x-ms-traffictypediagnostic: BYAPR05MB4359:
x-microsoft-antispam-prvs: <BYAPR05MB43594924B99BF1ED01754014D0B70@BYAPR05MB4359.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHfbq8IdbPLHphM2Vb1Vxt/i/uPGQto5S4SHkG8K3FXiMG+igA5JDIpyxzGGLsrivPR3tcyfP6RdQ+KaDF8mY8YCFW6LS+aqZFfDNNiWU+xzc/LKe3Ot0TLrAq4XfoVx3x9MygHvtiaMDUtwcbBfEWrnnD8vNBW9YTAOZRF/9EwwMJ0aJSuFyfHRqoyaQIXsv4eHweKOVc16/Oe84rc3NWRBv7wbKdUAqBvhSmvtOMHzQqZSvNzirV3oYEpghYyv9EK2KH0qNLxw4Fet3kIeajUUFm+UirO9W5AvuG/ENLIahu1VqSvcVH9ps3XmysYVYegtQJnoG5gmXdu71hOLijI/A7Oy3bVOWASgONW3VmwcuqlEnTGiEXRWcYZgrcQhTR1pqRwn6lvznEssFPOVK4WnlZzSLtiqMp6TCv86+MrmFZ8yhNkD/OmuRrStVhWyoS1eMcjCWwBvIis0fl7vCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(6506007)(45080400002)(53546011)(186003)(71200400001)(478600001)(966005)(54906003)(316002)(36756003)(5660300002)(86362001)(6486002)(2616005)(8676002)(8936002)(66446008)(6512007)(33656002)(6916009)(2906002)(66946007)(64756008)(66556008)(76116006)(66476007)(4326008)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AuP6/Jq1j+TMGfncWK9L9Vm02dJWiVa1x1QVN1+PK6xZiUlxg5rASwmt7GoArUcFY88LmvAi0sULCi2dIKIBbx6AnoZfeT6zgf2kH9ug7c1Qu/NDQdHP3P6vJjeVdcxdnu1AEKq7hsTCt5Rw6Lzh1FqJujTfrNoIc9rS4tlfclCZfQMnxno5k9uibAzBMGj3pAWtc1vch5Lg122dQRc7HkbPHYWZvwiuhs4eh9PHPsQadVcIjpORID6RNXjXFycp2vkZTwu/GXPxLSSqe6GjEWedxiboNZ/wjt4R+t5ywKc3LpOPmiinBkHKJfYOLGB5ZJnwxa8S17VBhK+b6HaqMPJuE8l8G2wreoKOIleJm+F96Xa6IXpOr079kQqoo0YyO5QRPijHombdcO2EUMDuhTrp8UJuRcentE5V7bsWL2kiXIitraTqy94SzI+cm1hD1Ff3+4LDECgU9Z0WPdOr0F7mMdVv05UdJFiRNVlQVwotEj9aCCI/W1Ufmml5MTP6M98JJiv4pEB+NhdvTHG+X8j4T7pjtzWFPLb9igTxQxE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13294C349E627240ADE15EA93B85823F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3fda8a-d5b7-4056-f873-08d7fdb94a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 19:00:54.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRwRsBE5QSMaNIxvY5ivCpv2FuW7hJY3F6SNYsuTU/1RUTMlAl6Um7RcN7Dz6SK2Q/IO2h4oUC8o6JzErMWT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 20, 2020, at 6:17 AM, Wojciech Kudla <wk.kernel@gmail.com> wrote:
>=20
> Preliminary discussion: https://nam04.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Flkml.org%2Flkml%2F2020%2F5%2F13%2F1327&amp;data=3D02%7C0=
1%7Cnamit%40vmware.com%7Ceb1fce63ca4644ab29ad08d7fcc022df%7Cb39138ca3cee4b4=
aa4d6cd83d9dd62f0%7C0%7C0%7C637255774462316114&amp;sdata=3DeKrYH1vLDaEk4QyN=
4ZLQQRCk%2BtVdGLq7K6xYn1s%2BjJo%3D&amp;reserved=3D0
> This patch avoids introducing arch-specific trace points by leveraging
> existing definition for ipi_raise.
>=20
> Issues to address in potential future work:
> - make ipi reason available on generic smp code level (possible?)
> - addition of ipi_entry/ipi_exit tracepoints in generic smp code
>=20
> Signed-off-by: Wojciech Kudla <wk.kernel@gmail.com>
> ---
> kernel/smp.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 7dbcb402c2fc..df6982a1d3f2 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -23,6 +23,11 @@
>=20
> #include "smpboot.h"
>=20
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/ipi.h>
> +
> +static const char *ipi_reason_missing __tracepoint_string =3D "";
> +
> enum {
> 	CSD_FLAG_LOCK		=3D 0x01,
> 	CSD_FLAG_SYNCHRONOUS	=3D 0x02,
> @@ -34,6 +39,7 @@ struct call_function_data {
> 	cpumask_var_t		cpumask_ipi;
> };
>=20
> +

Unneeded redundant new line.

> static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
>=20
> static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue=
);
> @@ -176,8 +182,12 @@ static int generic_exec_single(int cpu, call_single_=
data_t *csd,
> 	 * locking and barrier primitives. Generic code isn't really
> 	 * equipped to do the right thing...
> 	 */
> -	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
> +	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
> +		if (trace_ipi_raise_enabled())

Why do you need this check? trace_ipi_raise() will do the same check before
actual tracing:

	if (static_key_false(&__tracepoint_##name.key)

I guess you do it in order to avoid evaluation of cpumask_of() if tracing i=
s
disabled, but it seems to me that the macro would only evaluate/call
cpumask_of() if tracing is indeed enabled.

> +			trace_ipi_raise(cpumask_of(cpu), ipi_reason_missing);
> +
> 		arch_send_call_function_single_ipi(cpu);
> +	}

In general, I think there are too many trace-points. They look benign(i.e.,
free), but can cause worse code to be generated as they behave as a memory
clobber. Many times the same result can be achieved with a probe.

