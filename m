Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBA420721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbgE1NdI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:33:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43498 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390303AbgE1NdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:33:05 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-168-oXXW1TqjM1ui_dIee1C0Zw-1; Thu, 28 May 2020 14:33:01 +0100
X-MC-Unique: oXXW1TqjM1ui_dIee1C0Zw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 28 May 2020 14:33:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 28 May 2020 14:33:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'kan.liang@linux.intel.com'" <kan.liang@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
Thread-Topic: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
Thread-Index: AQHWNPJS+Ezh9RvMC0GYZtjdLUC73Ki9fXeg
Date:   Thu, 28 May 2020 13:33:00 +0000
Message-ID: <de3b847eddd143998997d70a1ba161b8@AcuMS.aculab.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kan.liang@linux.intel.com
> Sent: 28 May 2020 14:15
...
> +static inline bool is_valid_mmio_offset(struct intel_uncore_box *box,
> +					unsigned long offset)

You need a better name, needs to start 'uncore_' and 'mmio'
probably isn't right either.

> +{
> +	if (box->pmu->type->mmio_map_size > offset)
> +		return true;

Swap over.
Conditionals always read best if 'variable op constant'.
So you want:
	if (offset < box->pmu->type->mmio_map_size)
		return true;

> +
> +	pr_warn_once("perf uncore: Access invalid address of %s.\n",
> +		     box->pmu->type->name);

Pretty hard to debug without the invalid offset.

I've no idea what the code is supposed to be doing though.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

