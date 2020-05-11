Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DDC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3975A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="KIf/Q0XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEKVSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:18:46 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:56962 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgEKVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:18:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4C7D927E05BE;
        Mon, 11 May 2020 23:18:44 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G8nyLIkWJSJN; Mon, 11 May 2020 23:18:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id F29C427E05D1;
        Mon, 11 May 2020 23:18:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu F29C427E05D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1589231924;
        bh=5x0ABVhNlbMdXxTh8MHf7m0UxlvKT+zK8VMupqi0OrQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KIf/Q0XYPkwtMMwUl0i5C7J9SW9h7qBmtdctchQe8r0GJU93fsNBloc/GsIuCxpZ2
         V+GQpTSRZfKLfWvAnV6Hl6d5UARPDp2o9li9QwGCLI8YBV1JQIYh2p/aFAB3VQtv9n
         AyJ5qbKPoZJxbvPD7YBdp1Beb7l90cPf2HSxGH9I=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Iv3WE6goo6xJ; Mon, 11 May 2020 23:18:43 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DE47927E05BE;
        Mon, 11 May 2020 23:18:43 +0200 (CEST)
Date:   Mon, 11 May 2020 23:18:43 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1306795191.2034071.1589231923729.JavaMail.zimbra@kalray.eu>
Subject: reserved_mem and early builtin device tree usage
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Index: 2Sdjv+NE14cZ7kqfvsgX2/nahmnvvQ==
Thread-Topic: reserved_mem and early builtin device tree usage
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently experiencing a bug during the port of the kernel on
a new architecture and after looking at other architectures, I
suspect the problem might be there too. my question is about
reserved memories and usage of early device tree.

From what I understand, when reserved memory is initialized using
early_init_fdt_scan_reserved_mem, the reserved memories are
created using some pointers inside the early dt (mainly the names).
If this early device tree is located into the init section (when
using a builtin dtb for instance), this section will be discarded
(when calling free_initmem_default) and memset with a zero/poison
value. So all pointers which are referencing the early dt will be
invalid. This will clobber all the "names" of the reserved memory
entries. As a side effect, all drivers using of_reserved_mem_lookup
after the init section has been freed will always failed because
the search is based on the name of the reserved mem.

I also said that it might be present on other architectures because
the usual function call I found is the following:
- early_init_dt_scan
- early_init_fdt_reserve_self (only reserve memory in memblock)
- early_init_fdt_scan_reserved_mem
- unflatten_and_copy_device_tree
- free_initmem_default
- potential calls to of_reserved_mem_lookup

Which (if the device tree is builtin in init section) will lead
to the result I described before.=20

So my question is about the legit usage of pointers referencing
the early dtb. If is it ok to use such pointers, this means that
the early dtb must always be available and that when using a
builtin dtb, then it should probably be copied early before
using it for scan operations with unflatten_and_copy_device_tree.

However, since the scan of the reserved mem nodes is required to
avoid allocating in reserved memory, unflatten_and_copy_device_tree
should probably not be called before early_init_fdt_scan_reserved_mem
since it allocates data. So this is a bit of the snake biting its
tail and thus, early dt pointers should probably not be used.

Is my understanding correct ? Or have I missed something since it
seems to haven't been noticed on other architectures ?

Thanks & regards,

Cl=C3=A9ment
