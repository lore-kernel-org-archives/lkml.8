Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD368C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFED2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R+KkxJEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:45:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:28902 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgHCIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1596444339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/D6bP3NPg1Ji79EWGkAsYS3c9iY06iT6eVlY3sY/X8=;
        b=R+KkxJEW1Nqtpmag0VvGryVcDpqN+COz7Xgn7uvY6e5T7+3NbwIqk08iotMfFN7mM6F1xv
        TVoWo+s2mGwW+MHDd0EIPNHGxWbgQTNGjir4GJc7P2Y6uUrCpaXeCK6DDJs3Mtt7NQD39m
        iT4h57M0Y39qnJtvFQvCOdpK3zPIzXA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-2JgScXkrOiSXp_JRpZMBLg-1; Mon, 03 Aug 2020 10:45:37 +0200
X-MC-Unique: 2JgScXkrOiSXp_JRpZMBLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZvbIRmHwEjVVtU1Bx6MMOB0G456k8GdXVOEqZcslEPMjwQ31zI6UuU6vH7oRyT6U5DVtFETTMTEsflfeY/nT7W53Gn/+WttDMw2xNwOlGAwxC1qisIJUF+LOcG1xlLb5AXCU8fd2Jq8sHURIEZW+Ntqnc9AW57m2hYWtAoR0vps41Y8oIvjQQ7Uy+Qo0B87SWROcQi/d/0I4WqfGR6SUJ1s5nIvAGzPJgxA5Z4uYnMX3k1fOYUGC6cquWE4bSaymDlPE8IhtCZ+P01OrK7T0TXvWoYQzGq0h7w4B1ws2HuF0PCjd4ItaxuuRBrzPNwYK/akf+UvP3RCdoaUNuRxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSlm/sSY3VKzmBVSszuMPHgBHVCMb6cu5DrLX8MbfxE=;
 b=TyM6XSZWWYttF4Lh91JpLjmyjjlNq+I8AtAhrTLeESb/k1gaSht+HvjjP2Swl113lMmNTdIf0/dvATy8b+DCpVydhoEl7GxoojnVahIxzsbInOzbQwNUH6/xCKnu3d3790Gl6An+tLav+Nk6lfaYlWr1tgV3oQ/0P/JN/aVAaCZSTH9ZXzb5yE50aZAjkrjVSQKw1ofa96lloYZ4BKpiPZ5Ax6Dv1bACXfa++l2DFdpv0+3Ufqqd7NGR9CKvrikZ1C/rTBIddGbipVBZ9T9Ydbt4hlirDNS8ivhS8xyl5RpH9tjpZy7DlhC+VyfzbzuUY1YgwWB7bE9utaTieQFVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7283.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 08:45:36 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 08:45:36 +0000
Subject: Re: [PATCH v2] kobject: Restore old behaviour of kobject_del(NULL)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <1b37c9c6-989e-6aae-81f5-a58ae3ab3f11@suse.com>
Date:   Mon, 3 Aug 2020 16:45:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYAPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:404::18)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:404::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 08:45:33 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c344296-7e74-4be9-8f0e-08d837899736
X-MS-TrafficTypeDiagnostic: AM8PR04MB7283:
X-Microsoft-Antispam-PRVS: <AM8PR04MB7283FA7D98E236C89EBFC98DD64D0@AM8PR04MB7283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aCbr/7A+qjBcY/BZdR5mY7zDUP7n1HBAIdiHuLVTPMEcd37ka2hj9PvQzizYzPZY2SqBvx5j4rAxZCR0gRzbhW9hej5Z8GPk9OcwxOZd5z57PUOlgPkuJBSXipZSJHlxuNbgfOeCbuBXZzazBYX3+oC5z+MsGoHExpKJem4U6c9+t+Q5+92qo4QnsQi8xNPenrhuTMiTVdEM+40DXUkNfLk20Xda01VydNvcjyfewguGF7d3vGjALplXdeNvghlytTe7udZI8FqCwjm7aIaBX0YN9AU7xEODkVmH7SLQ31bXk1UkukNOcdheSR9SkWNMM+zUN+2wDXa4ATmZgqLPPU2yn/PyoLWUW1xIFP/gZKN0rM7wQAsxPJw3MNbznt9MPK+nQpkaSo+nvyV0IshNTsbL/ZU6CqNPxUaQ88kWaaQj0IxXQNjvycCgnLXb9Gi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(6666004)(2616005)(956004)(55236004)(6486002)(26005)(31686004)(16526019)(16576012)(186003)(316002)(36756003)(110136005)(6706004)(4326008)(478600001)(5660300002)(31696002)(8676002)(66946007)(66476007)(66556008)(2906002)(8936002)(86362001)(83380400001)(52116002)(78286006)(518174003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GBDMuUt96wxaBwysaVWkas/64RSNqGk+3oRbupafz7D5JrR3pakt+HiIyD+LXAjwyavlJBLuheFkgebnKFKAa9qq48/+Hk0ghMS26vXLb0z4yHTQtOLn6KlQ/X9CCabYmBxkKTJJ74MkM4a9J8hQd1WLJZ3lrI6PfKJEam90a4E5h7bR7HO8SmW05ppeHHSX70j95OM95EzFKGALvLJDl5jfYtd1iy8jOqjUgmD+mhF3X5P6OaIfbAjG1nvX3733Zr7OUxE4Sl87ng6EwYSXXW4gc7G5vJBZnKP+o6duFeznFx2HKgAuBMZJIZEgfqFKLy8aSsGnfG7o9mapC1ymXnvEm7xlfVPdTD4/J1I+NufLh4WFGNdo3YfCOPePAo7eqc3Od3e7GkjF6LNlbmAE+r/vgCn3C4j4iRCuOrb9/zdyHHFkFcuazdy3XxDiarkV4zl2tNBzEbnwX0Oro76jqQT6JiQBwiWiOjrCs4R/Urgp6xqaTYdS4KDQ1QRVU+Y7FGj6mm+b373OLDR5SLxEnnJc6g6hFi3tkMfqkHAYD8srmCx4st5q7xSTgW+Um3aelM6EOvPMg3pb9NdbQbmhiNE9iY1CIxSN4biE29fY88C8TCDTPimHtwr3NJlPcTTrwWpJz0pIqQaY9YnDDgwCTQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c344296-7e74-4be9-8f0e-08d837899736
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 08:45:36.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYxe5HiI2RNGpCKW3xc9gA8aOy395PI2Wb9+ZEwfRgnDPzTCM8yQwcF6UGU5yxoD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/3 =E4=B8=8B=E5=8D=884:27, Andy Shevchenko wrote:
> The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing =
in
> kobject_cleanup()") inadvertently dropped a possibility to call kobject_d=
el()
> with NULL pointer. Restore the old behaviour.
>=20
> Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in k=
object_cleanup()")
> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>

Sorry, I should use my suse mailbox for that.

> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v2: replaced ?: with plain conditional (Greg)
>  lib/kobject.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 3afb939f2a1c..9dce68c378e6 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -637,8 +637,12 @@ static void __kobject_del(struct kobject *kobj)
>   */
>  void kobject_del(struct kobject *kobj)
>  {
> -	struct kobject *parent =3D kobj->parent;
> +	struct kobject *parent;
> +
> +	if (!kobj)
> +		return;
> =20
> +	parent =3D kobj->parent;
>  	__kobject_del(kobj);
>  	kobject_put(parent);
>  }
>=20

