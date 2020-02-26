Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35644C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B10206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYC/CpQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgBZPiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:38:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727855AbgBZPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582731503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGr3SYhU/ark2B0WUE5hTGvmZDYDzVerzAZBntfGstU=;
        b=FYC/CpQxbGmxC7ZBvipJmRI1F3/rKjaWWwxQjL0Lru28mKDoowMS3tsfD/ApTLrvWJBmqk
        9/3FpZgk+xxx97ApCvy8Iy8QHDI5wf7yueFVCYwfnt5/U/xCGwUyYLw5Lwh7oBogTwQ8uP
        3lTv0Cm0sgADq4R49hyJBtQOPkU7Ih8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-OkhiOzO0OK2mA3xqxBOZ-g-1; Wed, 26 Feb 2020 10:38:17 -0500
X-MC-Unique: OkhiOzO0OK2mA3xqxBOZ-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CEF797764;
        Wed, 26 Feb 2020 15:38:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9409990F5B;
        Wed, 26 Feb 2020 15:38:12 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:38:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 2/2] perf report: Support interactive annotation of
 code without symbols
Message-ID: <20200226153810.GE217283@krava>
References: <20200225051438.16253-1-yao.jin@linux.intel.com>
 <20200225051438.16253-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200225051438.16253-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:14:38PM +0800, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
>=20
> We should support the annotation functionality even without symbols.
>=20
> This patch fakes a dummy symbol and the symbol name is the string of
> address. After that, we just follow current annotation working flow.
>=20
> For example,
>=20
> 1. perf report
>=20
> Overhead  Command  Shared Object     Symbol
>   20.67%  div      libc-2.27.so      [.] __random_r
>   17.29%  div      libc-2.27.so      [.] __random
>   10.59%  div      div               [.] 0x0000000000000628
>    9.25%  div      div               [.] 0x0000000000000612
>    6.11%  div      div               [.] 0x0000000000000645
>=20
> 2. Select the line of "10.59%  div      div               [.] 0x0000000=
000000628" and ENTER.
>=20
> Annotate 0x0000000000000628
> Zoom into div thread
> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
> Browse map details
> Run scripts for samples of symbol [0x0000000000000628]
> Run scripts for all samples
> Switch to another data file in PWD
> Exit
>=20
> 3. Select the "Annotate 0x0000000000000628" and ENTER.
>=20
> Percent=E2=94=82
>        =E2=94=82
>        =E2=94=82
>        =E2=94=82     Disassembly of section .text:
>        =E2=94=82
>        =E2=94=82     0000000000000628 <.text+0x68>:
>        =E2=94=82       divsd %xmm4,%xmm0
>        =E2=94=82       divsd %xmm3,%xmm1
>        =E2=94=82       movsd (%rsp),%xmm2
>        =E2=94=82       addsd %xmm1,%xmm0
>        =E2=94=82       addsd %xmm2,%xmm0
>        =E2=94=82       movsd %xmm0,(%rsp)
>=20
> Now we can see the dump of object starting from 0x628.
>=20
> We can also press hotkey 'a' on address in report view.
> For branch mode, we only support the annotation for
> "branch to" address.
>=20
>  v4:
>  ---
>  1. Support the hotkey 'a'. When we press 'a' on address,
>     now it supports the annotation.

please move this to separate patch, AFAICS it's separate change
and was broken before your change

thanks,
jirka

