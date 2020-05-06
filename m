Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF6C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E29D20753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="isFjy5tF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pnuHXWGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEFJ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:56:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49568 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbgEFJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:56:22 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 08134439D6;
        Wed,  6 May 2020 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588758981; bh=E47aFDuc7L8n2VBZxNocmI2DrDPzdNN/m1cy/aSpy4I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=isFjy5tFIyxswYzQtBPKj9m81e8kz5Blu9JEFXTr799CI6AdGu4XSZt18970YKuiY
         Xhk8nM/LXb8zp7q8spkKROPFQ9JWEo0ZJHtAE1vjrqCJ3pb/pu5rPWqqKw75WU7N3+
         qeRvowOgkAOt/JLt6f0RCSnvxzLm7FRnOccnp09oKBRI11fGmrJNvsd/VgWtwzEa6u
         ti9A7NDEkLyUWvY8XXEhsy7RrE7twM+fdpJOCeE7tT4DSyTQOst0T1s4nty/s209c7
         unr/yrwLDiVFAphD2kKBWwx5HzEipKLch02cdtpDY/D786QxGEM0BLkx05D0rYGB9a
         zrcxEX0/WB6ow==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 86C51A006E;
        Wed,  6 May 2020 09:56:19 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 May 2020 02:56:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 6 May 2020 02:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1ECMK3UO0okm27y5u9DvrUrwqG5MCesZWhlXkI/kRBtdcjsM6Kw6fAyCEr6coatyQvSBitjfYFtbIpqPIn2K45i3IwCG+hPnZ3pIZdoWT7Awx+gLk5BsBAGDLEQjJt5HfNJcJXfhQi3ZKSN8BrbF6JEsj+fXbCtaPcqu9+oJ/yXToR899lOZxY8rI9o77Zb60yksioN/+HfJjGkBWyA4rVVX1yod0igauskgEzSoTQNRqPsRA6R6G+qBtYBu1cjfH4uPmU/Ury36RjK/oZBEYKovMC40qY3jiKzxCNEgEIgIL5HEITcIWwOjNK0zblDhHdKjYEqSSD9fBKXfLmbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnhfA8bSdZo2l3G55by2sSnWjUHg3Yjv1D5R0jkm09Y=;
 b=e01L/J9npy60aMzdj0nshTEQsAXS5pl617+C8PGpGpUTJeLphuDRPW1SD9T1id0zPNcKBjZVwQh9AEkMFGhkfI5sLUp5Hgm2sKPawCGuotkGsUCciL4HrOMMMhUDElVkwk6FZHUrnphitTz17fBvjcRlaZmtC8ahFchT6IIMxTSUBF+3UcwmHcnWFu7FZKMdiLixGoxZTeVdV905Z3+hucZtrc6CJtYi/igSggnPFvYmFR9s5cXakXS6GYv94OYcywNKQg7iLtc7Itfn3Lmq3LGtahvpxWwiUeJfwlm0Ylv4Solx9wM842Mtf0T+tSnZTA2T+5dRiKAgPO9Nw94QnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnhfA8bSdZo2l3G55by2sSnWjUHg3Yjv1D5R0jkm09Y=;
 b=pnuHXWGgHxixMCMX8Sduv5K633hYwvpYYAbkZLxtHuknvAo2iOqgDrENxo5O2+qHTwMvYqySeJrDcBceN+i82rEGbmk1C40KQi5o6Fy7siO9uJ9f5NI7ggpOwI7OtFwPdCNGCo6RlFgKxlWyLOVOPBBBsOWMk9ZaQCB/cs/Hbvo=
Received: from CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 09:56:17 +0000
Received: from CH2PR12MB3782.namprd12.prod.outlook.com
 ([fe80::c8ba:1b80:f234:e1c2]) by CH2PR12MB3782.namprd12.prod.outlook.com
 ([fe80::c8ba:1b80:f234:e1c2%2]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 09:56:17 +0000
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v3 3/4] drm: ipk: Add extensions for DW MIPI DSI Host
 driver
Thread-Topic: [PATCH v3 3/4] drm: ipk: Add extensions for DW MIPI DSI Host
 driver
Thread-Index: AQHWHJYPw9IJM5JmgkGGf0JPX2lmYKiOqhmAgAwS5VA=
Date:   Wed, 6 May 2020 09:56:16 +0000
Message-ID: <CH2PR12MB37820AC44267DE4AF80142DFCBA40@CH2PR12MB3782.namprd12.prod.outlook.com>
References: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
 <24372475c0afe1e88f323efec16300903d1c6294.1587992776.git.angelo.ribeiro@synopsys.com>
 <20200428152815.GX3456981@phenom.ffwll.local>
In-Reply-To: <20200428152815.GX3456981@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW5nZWxvclxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQxYTdkN2YxLThmN2YtMTFlYS05ZDczLWZjNzc3?=
 =?us-ascii?Q?NGVlZGMyZVxhbWUtdGVzdFxkMWE3ZDdmMi04ZjdmLTExZWEtOWQ3My1mYzc3?=
 =?us-ascii?Q?NzRlZWRjMmVib2R5LnR4dCIgc3o9IjIyNjIwIiB0PSIxMzIzMzIzMjU3NDc3?=
 =?us-ascii?Q?NjQ2MjMiIGg9ImU0bi9ZTGVwMFptZVpDaHBjOS9ZWGNHQVBOND0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?Q1BMWCtVakNQV0FmODBKVy9jYUx0YS96UWxiOXhvdTFvT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBSGFXeU5BQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [95.136.124.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffc68daf-8a54-44f3-1e02-08d7f1a3b864
x-ms-traffictypediagnostic: CH2PR12MB4102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4102438CA614DD79DA073BC5CBA40@CH2PR12MB4102.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZPRcTdFE0NCfplSIL+aN0BmWuPVBEAV10B4ARkRHDI83nzsJHYbE8X3BjU0BsR5fkGToeUDUC0CzBZXgQZwuIk7nNVhmSsMrBNL1wlvoMmOwmjV/CoKdDO82v2bhgaudqOmVYK7iIx+IsJUsfviyB2Vya9HedBeX5kjgd0LB8HjX/BcfSL/lBFBiKrYmkKNNCW1JmqZTGU8SNn9Efzs5eMS1O4vCnj9lmFwXhLTrEI9fMYtA/Kqp665UYXAJfwvOu5RvsRne8TPfIZY3yL2r7pyjy9T4XA07KuDnz/qi80h9sMmgR4gd0gpenKR2AzYIQqE3EpS/WZ4mKRrCKCcJ3HM8Ila03UzJOx7LNNtZBACgbM32pMEaVMraix06ZvLw8XURr3SEwrOZQiLCq9h+LpdO5zNhXQtp4WOBKvjLBdQiES+YalA/NxYZgHDvIfhSw65MwOOrpjUFMimlkn6UbDYucS5P/WYBeOEWS6AWlHh8W1GedbceoxwFxETC6D5Z0jLPDQLqQyAtrmVal8avhHGIUwS7N33+oV+hl3Mf9uDz6hHnMtavmcVlmWfL4edId2Aro4UiWLyFuzs+urXkUsrO2uRD68qI6U6EJDNZBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(33430700001)(8676002)(86362001)(6916009)(107886003)(8936002)(30864003)(186003)(26005)(76116006)(316002)(4326008)(54906003)(66476007)(66556008)(71200400001)(66946007)(66446008)(52536014)(7696005)(6506007)(33656002)(966005)(33440700001)(478600001)(2906002)(64756008)(5660300002)(83080400001)(55016002)(9686003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UTSJPiM+oxk9ucOQj/uMiLcOkAqcepXcGX/yjKhafa/Dy2ylgm7VYjIOr6hON+ByNDAq5R9uiG73dQFy5r7GiDDeptDs2Vpvgbkf8ASuX++qYu7n039dWJJD0/EvodO0cJwwfbSrwDPz9z5rD1eddBp52BqoSeSYz5cBcVh2ukEkDm/CjgLHv9oBMa7kMRu2UqVxxGv4YqeogdrLNxruDAt/sgvcgbxIAun511NbjkajjyYaMLGzCRDwVl4Tlh8te76UlbiopxNK0kX4FNMR+9OWstiIc18Pdb+cqh/sMzEz3VpfArJ9ttA4O8ADfcL4sL2TxA6iDUbDdXiJzYxCOli//zM8DT/ZDwfctRJRsDeSzeSsJRCeT80b7Jb2p47Naa6Qt+Rg49CfgCNTq4+XFSs1G2/6qEmqxj5DjwvH6DdfbKyzne1o1KcwFY3aAcuJ/xqPCui0l/5Oav8IivG29BZrlClpbNhW8Og+Fs+FTUrnw/T4hh2f+OUDv0JiWXPz9tgwdej+ByJW1v8fTLnb5I/8M2CHo8vwuHdglT+CEkqFy61yLhDgaDvN7R80AQchTJDp7Uf4+uPkYtv9Y8WDCzfAJlj49Q71ROQOBHMqpROswOFQyEXzMWSXJ9sQWi7wAAX1VuZYpI8iBdb2p7XAAwfUwpniSZYwVl17TSifdCYJ6VEa0md5glt7eOMbG8NXZT9/Ej2BQoA+cMzzMxjy8n6ltIIsTadSDW6JVqv1NniHhVgxMo829Qt/BSLs6xXCGoNBd47f7+XlEMcHam80lzI12DeWYT2Gu2bzPW13qms=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc68daf-8a54-44f3-1e02-08d7f1a3b864
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 09:56:17.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29e9d+mVtj40Gq7er+PSAyfWizqF7ZmQ0S5Qcctc32lNlxE5HVinZFqPYNJmSalD8Uvq1s/Py5ROEUSxwQgBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, Apr 28, 2020 at 16:28:15

> On Mon, Apr 27, 2020 at 04:00:35PM +0200, Angelo Ribeiro wrote:
> > Add Synopsys DesignWare IPK specific extensions for Synopsys DesignWare
> > MIPI DSI Host driver.
> >=20
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
>=20
> I've dumped this on a pile of bridge drivers by now, but I don't think th=
e
> dw-mipi-dsi organization makes much sense.
>=20
> I think what we'd need is:
>=20
> - drm_encoder is handled by the drm_device driver, not by dw-mipi-dsi
>   drm_bridge driver
>=20
> - the glue code for the various soc specific implementations (like ipk
>   here) should be put behind the drm_bridge abstraction. Otherwise I'm no=
t
>   really seeing why exactly dw-mipi-dsi is a bridge driver if it doesn't
>   work like a bridge driver
>=20
> - Probably we should put all these files into drm/bridge/dw-mipi-dsi/
>=20
> - drm_device drivers should get at their bridges with one of the standard
>   of helpers we have in drm_bridge, not by directly calling into a bridge
>   drivers.
>=20
> I know that dw-hdmi is using the exact same code pattern, but we got to
> stop this eventually or it becomes an unfixable mess.
> -Daniel

Hi Daniel,

Sorry for the late answer.

I understand what you stated and the conversion of
this driver in a help library could be a good solution since
you can use the DSI as bridge or as encoder, as your pipeline
requires.

Also most of the code implemented by each glue is essential PHY related,
the development of a PHY driver could make this more clear.

However, this needs a lot of work and consensus. Do you think that we
can go ahead with this driver and do the rework later?
I'm available and interested to help on this rework.

Thanks,
Angelo=20

>=20
> > ---
> > Changes since v3:
> >   - Rearranged headers.
> > ---
> >  drivers/gpu/drm/ipk/Kconfig           |   9 +
> >  drivers/gpu/drm/ipk/Makefile          |   2 +
> >  drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c | 557 ++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 568 insertions(+)
> >  create mode 100644 drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c
> >=20
> > diff --git a/drivers/gpu/drm/ipk/Kconfig b/drivers/gpu/drm/ipk/Kconfig
> > index 1f87444..49819e5 100644
> > --- a/drivers/gpu/drm/ipk/Kconfig
> > +++ b/drivers/gpu/drm/ipk/Kconfig
> > @@ -11,3 +11,12 @@ config DRM_IPK
> >  	  Enable support for the Synopsys DesignWare DRM DSI.
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called ipk-drm.
> > +
> > +config DRM_IPK_DSI
> > +	tristate "Synopsys DesignWare IPK specific extensions for MIPI DSI"
> > +	depends on DRM_IPK
> > +	select DRM_DW_MIPI_DSI
> > +	help
> > +	  Choose this option for Synopsys DesignWare IPK MIPI DSI support.
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called dw-mipi-dsi-ipk.
> > diff --git a/drivers/gpu/drm/ipk/Makefile b/drivers/gpu/drm/ipk/Makefil=
e
> > index 6a1a911..f22d590 100644
> > --- a/drivers/gpu/drm/ipk/Makefile
> > +++ b/drivers/gpu/drm/ipk/Makefile
> > @@ -2,3 +2,5 @@
> >  ipk-drm-y :=3D dw-drv.o dw-vpg.o
> > =20
> >  obj-$(CONFIG_DRM_IPK) +=3D ipk-drm.o
> > +
> > +obj-$(CONFIG_DRM_IPK_DSI) +=3D dw-mipi-dsi-ipk.o
> > diff --git a/drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c b/drivers/gpu/drm/ip=
k/dw-mipi-dsi-ipk.c
> > new file mode 100644
> > index 0000000..f8ac4ca
> > --- /dev/null
> > +++ b/drivers/gpu/drm/ipk/dw-mipi-dsi-ipk.c
> > @@ -0,0 +1,557 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019-2020 Synopsys, Inc. and/or its affiliates.
> > + * Synopsys DesignWare MIPI DSI solution driver
> > + *
> > + * Author: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> > + * Author: Luis Oliveira <luis.oliveira@synopsys.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +#include <drm/bridge/dw_mipi_dsi.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_device.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_print.h>
> > +
> > +#define DW_DPHY_LPCLK_CTRL	0x94
> > +#define DW_DPHY_RSTZ		0xA0
> > +#define DW_DPHY_IF_CFG		0xA4
> > +#define DW_DPHY_ULPS_CTRL	0xA8
> > +#define DW_DPHY_TX_TRIGGERS	0xAC
> > +#define DW_DPHY_STATUS		0xB0
> > +#define DW_DPHY_TST_CTRL0	0xB4
> > +#define DW_DPHY_TST_CTRL1	0xB8
> > +#define DW_GEN3_IF_TESTER	0x3c
> > +#define DW_GEN3_IF_SOC_PLL	0x48
> > +#define DW_GEN3_IF_SOC_PLL_EN	0x4C
> > +
> > +#define DW_12BITS_DPHY_RDY_L0	0x507
> > +#define DW_12BITS_DPHY_RDY_L1	0x707
> > +#define DW_12BITS_DPHY_RDY_L2	0x907
> > +#define DW_12BITS_DPHY_RDY_L3	0xB07
> > +
> > +#define DW_LANE_MIN_KBPS	80000
> > +#define DW_LANE_MAX_KBPS	2500000000
> > +#define DW_DPHY_DIV_UPPER_LIMIT	8000
> > +#define DW_DPHY_DIV_LOWER_LIMIT	2000
> > +#define DW_MIN_OUTPUT_FREQ	80
> > +#define DW_LPHS_TIM_TRANSIONS	0x40
> > +
> > +enum dw_glueiftester {
> > +	GLUE_LOGIC =3D 0x4,
> > +	RX_PHY =3D 0x2,
> > +	TX_PHY =3D 0x1,
> > +	RESET =3D 0x0,
> > +};
> > +
> > +struct dw_range_dphy {
> > +	u32 freq;
> > +	u8 hs_freq_range;
> > +	u32 osc_freq_target;
> > +} dw_range_gen3[] =3D {
> > +	{ 80, 0x00, 0x3f }, { 90, 0x10, 0x3f }, { 100, 0x20, 0x3f },
> > +	{ 110, 0x30, 0x39 }, { 120, 0x01, 0x39 }, { 130, 0x11, 0x39 },
> > +	{ 140, 0x21, 0x39 }, { 150, 0x31, 0x39 }, { 160, 0x02, 0x39 },
> > +	{ 170, 0x12, 0x2f }, { 180, 0x22, 0x2f }, { 190, 0x32, 0x2f },
> > +	{ 205, 0x03, 0x2f }, { 220, 0x13, 0x29 }, { 235, 0x23, 0x29 },
> > +	{ 250, 0x33, 0x29 }, { 275, 0x04, 0x29 }, { 300, 0x14, 0x29 },
> > +	{ 325, 0x25, 0x29 }, { 350, 0x35, 0x1f }, { 400, 0x05, 0x1f },
> > +	{ 450, 0x16, 0x19 }, { 500, 0x26, 0x19 }, { 550, 0x37, 0x19 },
> > +	{ 600, 0x07, 0x19 }, { 650, 0x18, 0x19 }, { 700, 0x28, 0x0f },
> > +	{ 750, 0x39, 0x0f }, { 800, 0x09, 0x0f }, { 850, 0x19, 0x0f },
> > +	{ 900, 0x29, 0x09 }, { 950, 0x3a, 0x09 }, { 1000, 0x0a, 0x09 },
> > +	{ 1050, 0x1a, 0x09 }, { 1100, 0x2a, 0x09 }, { 1150, 0x3b, 0x09 },
> > +	{ 1200, 0x0b, 0x09 }, { 1250, 0x1b, 0x09 }, { 1300, 0x2b, 0x09 },
> > +	{ 1350, 0x3c, 0x03 }, { 1400, 0x0c, 0x03 }, { 1450, 0x1c, 0x03 },
> > +	{ 1500, 0x2c, 0x03 }, { 1550, 0x3d, 0x03 }, { 1600, 0x0d, 0x03 },
> > +	{ 1650, 0x1d, 0x03 }, { 1700, 0x2e, 0x03 }, { 1750, 0x3e, 0x03 },
> > +	{ 1800, 0x0e, 0x03 }, { 1850, 0x1e, 0x03 }, { 1900, 0x2f, 0x03 },
> > +	{ 1950, 0x3f, 0x03 }, { 2000, 0x0f, 0x03 }, { 2050, 0x40, 0x03 },
> > +	{ 2100, 0x41, 0x03 }, { 2150, 0x42, 0x03 }, { 2200, 0x43, 0x03 },
> > +	{ 2250, 0x44, 0x03 }, {  2300, 0x45, 0x01 }, { 2350, 0x46, 0x01 },
> > +	{ 2400, 0x47, 0x01 }, {  2450, 0x48, 0x01 }, { 2500, 0x49, 0x01 }
> > +};
> > +
> > +struct dw_dsi_ipk {
> > +	void __iomem *base;
> > +	void __iomem *base_phy;
> > +	struct clk *pllref_clk;
> > +	struct dw_mipi_dsi *dsi;
> > +	u32 lane_min_kbps;
> > +	u32 lane_max_kbps;
> > +	int range;
> > +	int in_div;
> > +	int loop_div;
> > +};
> > +
> > +#define dw_mipi_dsi_to_dw_dsi_ipk(target) \
> > +	container_of(target, struct dw_dsi_ipk, dsi)
> > +
> > +static void dw_dsi_write(struct dw_dsi_ipk *dsi, u32 reg, u32 val)
> > +{
> > +	writel(val, dsi->base + reg);
> > +}
> > +
> > +static u32 dw_dsi_read(struct dw_dsi_ipk *dsi, u32 reg)
> > +{
> > +	return readl(dsi->base + reg);
> > +}
> > +
> > +static void dw_phy_write(struct dw_dsi_ipk *dsi, u32 reg, u32 val)
> > +{
> > +	writel(val, dsi->base_phy + reg);
> > +}
> > +
> > +static void dw_dsi_phy_write_part(struct dw_dsi_ipk *dsi, u32 reg_addr=
ess,
> > +				  u32 data, u8 shift, u8 width)
> > +{
> > +	u32 temp =3D dw_dsi_read(dsi, reg_address);
> > +	u32 mask =3D (1 << width) - 1;
> > +
> > +	temp &=3D ~(mask << shift);
> > +	temp |=3D (data & mask) << shift;
> > +	dw_dsi_write(dsi, reg_address, temp);
> > +}
> > +
> > +static void dw_dsi_phy_test_data_in(struct dw_dsi_ipk *dsi, u8 test_da=
ta)
> > +{
> > +	dw_dsi_phy_write_part(dsi, DW_DPHY_TST_CTRL1, test_data, 0, 8);
> > +}
> > +
> > +static void dw_dsi_phy_test_clock(struct dw_dsi_ipk *dsi, int value)
> > +{
> > +	dw_dsi_phy_write_part(dsi, DW_DPHY_TST_CTRL0, value, 1, 1);
> > +}
> > +
> > +static void dw_dsi_phy_test_en(struct dw_dsi_ipk *dsi, u8 on_falling_e=
dge)
> > +{
> > +	dw_dsi_phy_write_part(dsi, DW_DPHY_TST_CTRL1, on_falling_edge, 16, 1)=
;
> > +}
> > +
> > +static void dw_dsi_phy_test_clear(struct dw_dsi_ipk *dsi, int value)
> > +{
> > +	dw_dsi_phy_write_part(dsi, DW_DPHY_TST_CTRL0, value, 0, 1);
> > +}
> > +
> > +static void dw_dsi_phy_write(struct dw_dsi_ipk *dsi, u16 address,
> > +			     u32 value, u8 data_length)
> > +{
> > +	u8 data[4];
> > +	int i;
> > +
> > +	data[0] =3D value;
> > +
> > +	dw_dsi_write(dsi, DW_DPHY_TST_CTRL0, 0);
> > +	dw_dsi_write(dsi, DW_DPHY_TST_CTRL1, 0);
> > +
> > +	dw_dsi_phy_test_en(dsi, 1);
> > +	dw_dsi_phy_test_clock(dsi, 1);
> > +	dw_dsi_phy_test_data_in(dsi, 0x00);
> > +	dw_dsi_phy_test_clock(dsi, 0);
> > +	dw_dsi_write(dsi, DW_DPHY_TST_CTRL1, 0);
> > +	dw_dsi_write(dsi, DW_DPHY_TST_CTRL1, (u8)(address >> 8));
> > +	dw_dsi_phy_test_clock(dsi, 1);
> > +	dw_dsi_phy_test_clock(dsi, 0);
> > +	dw_dsi_phy_test_en(dsi, 1);
> > +	dw_dsi_phy_test_clock(dsi, 1);
> > +	dw_dsi_phy_test_data_in(dsi, ((u8)address));
> > +	dw_dsi_phy_test_clock(dsi, 0);
> > +	dw_dsi_phy_test_en(dsi, 0);
> > +
> > +	for (i =3D data_length; i > 0; i--) {
> > +		dw_dsi_phy_test_data_in(dsi, ((u8)data[i - 1]));
> > +		dw_dsi_phy_test_clock(dsi, 1);
> > +		dw_dsi_phy_test_clock(dsi, 0);
> > +	}
> > +}
> > +
> > +static void dw_dsi_phy_delay(struct dw_dsi_ipk *dsi, int value)
> > +{
> > +	u32 data =3D value << 2;
> > +
> > +	dw_dsi_phy_write(dsi, DW_12BITS_DPHY_RDY_L0, data, 1);
> > +	dw_dsi_phy_write(dsi, DW_12BITS_DPHY_RDY_L1, data, 1);
> > +	dw_dsi_phy_write(dsi, DW_12BITS_DPHY_RDY_L2, data, 1);
> > +	dw_dsi_phy_write(dsi, DW_12BITS_DPHY_RDY_L3, data, 1);
> > +}
> > +
> > +static int dsi_pll_get_clkout_khz(int clkin_khz, int idf, int ndiv, in=
t odf)
> > +{
> > +	int divisor =3D idf * odf;
> > +
> > +	/* prevent from division by 0 */
> > +	if (!divisor)
> > +		return 0;
> > +
> > +	return DIV_ROUND_CLOSEST(clkin_khz * ndiv, divisor);
> > +}
> > +
> > +static int dsi_pll_get_params(struct dw_dsi_ipk *dsi, int in_freq,
> > +			      int out_freq, int *idf, int *ndiv, int *odf)
> > +{
> > +	int range, tmp_loop_div, tmp_in_freq, delta, step =3D 0, flag =3D 0;
> > +	int out_data_rate =3D out_freq * 2;
> > +	int loop_div =3D 0; /* M */
> > +	int out_div; /* VCO */
> > +	int in_div; /* N */
> > +
> > +	/* Find ranges */
> > +	for (range =3D 0; ARRAY_SIZE(dw_range_gen3) &&
> > +	     (out_data_rate / 1000) > dw_range_gen3[range].freq; range++)
> > +		;
> > +
> > +	if (range >=3D ARRAY_SIZE(dw_range_gen3))
> > +		return -EINVAL;
> > +
> > +	if ((dw_range_gen3[range].osc_freq_target >> 4) =3D=3D 3)
> > +		out_div =3D 8;
> > +	else if ((dw_range_gen3[range].osc_freq_target >> 4) =3D=3D 2)
> > +		out_div =3D 4;
> > +	else
> > +		out_div =3D 2;
> > +
> > +	if (dw_range_gen3[range].freq > 640)
> > +		out_div =3D 1;
> > +
> > +	out_freq =3D out_freq * out_div;
> > +
> > +	loop_div =3D (out_freq * (in_freq / DW_DPHY_DIV_LOWER_LIMIT)) / in_fr=
eq;
> > +
> > +	/* here delta will account for the rounding */
> > +	delta =3D (loop_div * in_freq) / (in_freq / DW_DPHY_DIV_LOWER_LIMIT) =
-
> > +		out_freq;
> > +
> > +	for (in_div =3D 1 + in_freq / DW_DPHY_DIV_UPPER_LIMIT;
> > +	     (in_freq / in_div >=3D DW_DPHY_DIV_LOWER_LIMIT) && !flag; in_div=
++) {
> > +		tmp_loop_div =3D out_freq * in_div / in_freq;
> > +		tmp_in_freq =3D in_freq / in_div;
> > +		if (tmp_loop_div % 2) {
> > +			tmp_loop_div +=3D 1;
> > +			if (out_freq =3D=3D tmp_loop_div * tmp_in_freq) {
> > +				/* Exact values found */
> > +				flag =3D 1;
> > +				loop_div =3D tmp_loop_div;
> > +				delta =3D tmp_loop_div * tmp_in_freq - out_freq;
> > +				in_div--;
> > +			} else if (tmp_loop_div * tmp_in_freq - out_freq <
> > +				   delta) {
> > +				/* Values found with smaller delta */
> > +				loop_div =3D tmp_loop_div;
> > +				delta =3D tmp_loop_div * tmp_in_freq - out_freq;
> > +				step =3D 0;
> > +			}
> > +		} else if (out_freq =3D=3D tmp_loop_div * tmp_in_freq) {
> > +			/* Exact values found */
> > +			flag =3D 1;
> > +			loop_div =3D tmp_loop_div;
> > +			delta =3D out_freq - tmp_loop_div * tmp_in_freq;
> > +			in_div--;
> > +		} else if (out_freq - tmp_loop_div * tmp_in_freq < delta) {
> > +			/* Values found with smaller delta */
> > +			loop_div =3D tmp_loop_div;
> > +			delta =3D out_freq - tmp_loop_div * tmp_in_freq;
> > +			step =3D 1;
> > +		}
> > +	}
> > +
> > +	if (!flag)
> > +		in_div =3D step + loop_div * in_freq / out_freq;
> > +
> > +	*idf =3D in_div;
> > +	*ndiv =3D loop_div;
> > +	*odf =3D out_div;
> > +
> > +	dsi->range =3D range;
> > +	dsi->in_div =3D in_div;
> > +	dsi->loop_div =3D loop_div;
> > +
> > +	return 0;
> > +}
> > +
> > +/* DPHY GEN 3 12 bits */
> > +static void dw_phy_init_gen3_128(void *priv_data)
> > +{
> > +	struct dw_dsi_ipk *dsi =3D priv_data;
> > +	int loop_div =3D dsi->loop_div;
> > +	int in_div =3D dsi->in_div;
> > +	int range =3D dsi->range;
> > +	u32 data;
> > +
> > +	/* hs frequency range [6:0] */
> > +	data =3D dw_range_gen3[range].hs_freq_range;
> > +	dw_dsi_phy_write(dsi, 0x02, data, 1);
> > +
> > +	/* [7:6] reserved | [5] hsfreqrange_ovr_en_rw |
> > +	 * [4:1] target_state_rw | [0] force_state_rw
> > +	 */
> > +	dw_dsi_phy_write(dsi, 0x01, 0x20, 1);
> > +
> > +	/* PLL Lock Configurations */
> > +	dw_dsi_phy_write(dsi, 0x173, 0x02, 1);
> > +	dw_dsi_phy_write(dsi, 0x174, 0x00, 1);
> > +	dw_dsi_phy_write(dsi, 0x175, 0x60, 1);
> > +	dw_dsi_phy_write(dsi, 0x176, 0x03, 1);
> > +	dw_dsi_phy_write(dsi, 0x166, 0x01, 1);
> > +
> > +	/* Charge-pump Programmability */
> > +	/* [7] pll_vco_cntrl_ovr_en |
> > +	 * [6:1] pll_vco_cntrl_ovr | [0] pll_m_ovr_en
> > +	 */
> > +	if (dw_range_gen3[range].freq > 640)
> > +		data =3D 1 | (dw_range_gen3[range].osc_freq_target << 1);
> > +	else
> > +		data =3D 1 | (1 << 7) |
> > +			  (dw_range_gen3[range].osc_freq_target << 1);
> > +
> > +	dw_dsi_phy_write(dsi, 0x17b, data, 1);
> > +	dw_dsi_phy_write(dsi, 0x15e, 0x10, 1);
> > +	dw_dsi_phy_write(dsi, 0x162, 0x04, 1);
> > +	dw_dsi_phy_write(dsi, 0x16e, 0x0c, 1);
> > +
> > +	/* Slew-Rate */
> > +	dw_dsi_phy_write(dsi, 0x26b, 0x04, 1);
> > +
> > +	/* pll_n_ovr_en_rw | PLL input divider ratio [6:3] |
> > +	 * pll_tstplldig_rw
> > +	 */
> > +	data =3D (1 << 7) | (in_div - 1) << 3;
> > +	dw_dsi_phy_write(dsi, 0x178, data, 1);
> > +
> > +	/* PLL loop divider ratio [7:0] */
> > +	data =3D loop_div - 2;
> > +	dw_dsi_phy_write(dsi, 0x179, data, 1);
> > +
> > +	/* PLL loop divider ratio [9:8] */
> > +	data =3D (loop_div - 2) >> 8;
> > +	dw_dsi_phy_write(dsi, 0x17a, data, 1);
> > +
> > +	if (dw_range_gen3[range].freq < 450)
> > +		dw_dsi_phy_write(dsi, 0x1ac, 0x1b, 1);
> > +	else
> > +		dw_dsi_phy_write(dsi, 0x1ac, 0x0b, 1);
> > +}
> > +
> > +static int dw_mipi_dsi_phy_init(void *priv_data)
> > +{
> > +	struct dw_dsi_ipk *dsi =3D priv_data;
> > +	int range =3D dsi->range;
> > +	unsigned int in_freq;
> > +	u32 data;
> > +
> > +	in_freq =3D (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
> > +
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, RESET);
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, GLUE_LOGIC);
> > +	dw_dsi_phy_test_clear(dsi, 1);
> > +	dw_dsi_phy_test_clear(dsi, 0);
> > +
> > +	dw_dsi_phy_write(dsi, 0x30, 0x0f, 1);
> > +
> > +	data =3D ((in_freq / 1000) - 17) * 4;
> > +	dw_dsi_phy_write(dsi, 0x02, data, 1);
> > +
> > +	dw_dsi_phy_write(dsi, 0x20, 0x3f, 1);
> > +
> > +	/* RESET RX */
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, RESET);
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, RX_PHY);
> > +	dw_dsi_phy_test_clear(dsi, 1);
> > +	dw_dsi_phy_test_clear(dsi, 0);
> > +
> > +	/* RESET TX */
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, RESET);
> > +	dw_phy_write(dsi, DW_GEN3_IF_TESTER, TX_PHY);
> > +	dw_dsi_phy_test_clear(dsi, 1);
> > +	dw_dsi_phy_test_clear(dsi, 0);
> > +
> > +	dw_phy_init_gen3_128(priv_data);
> > +
> > +	if (dw_range_gen3[range].freq > 648)
> > +		dw_dsi_phy_delay(dsi, 5);
> > +	else
> > +		dw_dsi_phy_delay(dsi, 4);
> > +
> > +	DRM_DEBUG_DRIVER("Phy configured\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mo=
de *mode,
> > +			  unsigned long mode_flags, u32 lanes, u32 format,
> > +			  unsigned int *lane_mbps)
> > +{
> > +	int idf =3D 0, ndiv =3D 0, odf =3D 0, pll_in_khz, pll_out_khz, ret, b=
pp;
> > +	struct dw_dsi_ipk *dsi =3D priv_data;
> > +
> > +	DRM_DEBUG_DRIVER("\n");
> > +
> > +	dsi->lane_min_kbps =3D (unsigned int)DW_LANE_MIN_KBPS;
> > +	dsi->lane_max_kbps =3D (unsigned int)DW_LANE_MAX_KBPS;
> > +
> > +	pll_in_khz =3D (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
> > +
> > +	/* Compute requested pll out */
> > +	bpp =3D mipi_dsi_pixel_format_to_bpp((enum mipi_dsi_pixel_format)form=
at);
> > +	pll_out_khz =3D ((mode->clock * bpp) / lanes) / 2;
> > +
> > +	if (pll_out_khz > dsi->lane_max_kbps) {
> > +		pll_out_khz =3D dsi->lane_max_kbps;
> > +		DRM_WARN("Warning max phy mbps is used\n");
> > +	}
> > +
> > +	if (pll_out_khz < dsi->lane_min_kbps) {
> > +		pll_out_khz =3D dsi->lane_min_kbps;
> > +		DRM_WARN("Warning min phy mbps is used\n");
> > +	}
> > +
> > +	ret =3D dsi_pll_get_params(dsi, pll_in_khz, pll_out_khz,
> > +				 &idf, &ndiv, &odf);
> > +	if (ret)
> > +		DRM_WARN("Warning dsi_pll_get_params(): bad params\n");
> > +
> > +	/* Get the adjusted pll out value */
> > +	pll_out_khz =3D dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
> > +
> > +	*lane_mbps =3D (pll_out_khz / 1000) * 2;
> > +
> > +	DRM_DEBUG_DRIVER("pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
> > +			 pll_in_khz, pll_out_khz, *lane_mbps);
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> > +			   struct dw_mipi_dsi_dphy_timing *timing)
> > +{
> > +	timing->clk_hs2lp =3D DW_LPHS_TIM_TRANSIONS;
> > +	timing->clk_lp2hs =3D DW_LPHS_TIM_TRANSIONS;
> > +	timing->data_hs2lp =3D DW_LPHS_TIM_TRANSIONS;
> > +	timing->data_lp2hs =3D DW_LPHS_TIM_TRANSIONS;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_mipi_dsi_phy_ops dw_dsi_ipk_phy_ops =3D {
> > +	.init =3D dw_mipi_dsi_phy_init,
> > +	.get_lane_mbps =3D dw_mipi_dsi_get_lane_mbps,
> > +	.get_timing =3D dw_mipi_dsi_phy_get_timing,
> > +};
> > +
> > +static struct dw_mipi_dsi_plat_data dw_dsi_ipk_plat_data =3D {
> > +	.max_data_lanes =3D 4,
> > +	.phy_ops =3D &dw_dsi_ipk_phy_ops,
> > +};
> > +
> > +static const struct of_device_id dw_ipk_dt_ids[] =3D {
> > +	{.compatible =3D "snps,dw-ipk-dsi",
> > +	 .data =3D &dw_dsi_ipk_plat_data,},
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, dw_ipk_dt_ids);
> > +
> > +static int dw_dsi_ipk_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct dw_dsi_ipk *dsi;
> > +	struct resource *res;
> > +	struct clk *pclk;
> > +	int ret;
> > +
> > +	DRM_DEBUG_DRIVER("\n");
> > +
> > +	dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> > +	if (!dsi)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dsi");
> > +	dsi->base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(dsi->base)) {
> > +		ret =3D PTR_ERR(dsi->base);
> > +		DRM_ERROR("Unable to get dsi registers %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> > +	dsi->base_phy =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(dsi->base_phy)) {
> > +		ret =3D PTR_ERR(dsi->base_phy);
> > +		DRM_ERROR("Unable to get PHY registers %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	pclk =3D devm_clk_get(dev, "pclk");
> > +	if (IS_ERR(pclk)) {
> > +		ret =3D PTR_ERR(pclk);
> > +		DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
> > +		goto err_dsi_probe;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(pclk);
> > +	if (ret)
> > +		goto err_dsi_probe;
> > +
> > +	dsi->pllref_clk =3D devm_clk_get(dev, "ref");
> > +	if (IS_ERR(dsi->pllref_clk)) {
> > +		ret =3D PTR_ERR(dsi->pllref_clk);
> > +		DRM_ERROR("Unable to get pll reference clock: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(dsi->pllref_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dw_dsi_ipk_plat_data.base =3D dsi->base;
> > +	dw_dsi_ipk_plat_data.priv_data =3D dsi;
> > +
> > +	platform_set_drvdata(pdev, dsi);
> > +
> > +	dsi->dsi =3D dw_mipi_dsi_probe(pdev, &dw_dsi_ipk_plat_data);
> > +	if (IS_ERR(dsi->dsi)) {
> > +		ret =3D PTR_ERR(dsi->dsi);
> > +		DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret);
> > +		goto err_dsi_probe;
> > +	}
> > +
> > +	return ret;
> > +
> > +err_dsi_probe:
> > +	clk_disable_unprepare(dsi->pllref_clk);
> > +	return ret;
> > +}
> > +
> > +static int dw_dsi_ipk_remove(struct platform_device *pdev)
> > +{
> > +	struct dw_dsi_ipk *dsi =3D platform_get_drvdata(pdev);
> > +
> > +	dw_mipi_dsi_remove(dsi->dsi);
> > +
> > +	return 0;
> > +}
> > +
> > +struct platform_driver dw_mipi_dsi_ipk_driver =3D {
> > +	.probe		=3D dw_dsi_ipk_probe,
> > +	.remove		=3D dw_dsi_ipk_remove,
> > +	.driver		=3D {
> > +		.name	=3D "ipk-dw-mipi-dsi",
> > +		.of_match_table =3D dw_ipk_dt_ids,
> > +	},
> > +};
> > +
> > +module_platform_driver(dw_mipi_dsi_ipk_driver);
> > +
> > +MODULE_AUTHOR("Angelo Ribeiro <angelo.ribeiro@synopsys.com>");
> > +MODULE_AUTHOR("Luis Oliveira <luis.oliveira@synopsys.com>");
> > +MODULE_DESCRIPTION("Synopsys IPK DW MIPI DSI host controller driver");
> > +MODULE_LICENSE("GPL v2");
> > --=20
> > 2.7.4
> >=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> https://urldefense.com/v3/__http://blog.ffwll.ch__;!!A4F2R9G_pg!Oe5QZPns5=
hZvX0GBstRz9Z4N97n6VR1TRkC51lVae1b5HxhrNe8W9QtqzyYCv2JaM5-vjQ$=20


