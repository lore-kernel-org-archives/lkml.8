Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C80C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8494320578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhCnznIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBXNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:52:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727160AbgBXNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582552320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwVACNE8Nn4mN92QnK8i1NIMbHEw2dqW37LdY/t44G0=;
        b=dhCnznIHt+ihtQsl9m3vcy0wbrNVKofAYTvCRk9d+Y22PpKxir9JyMLSpaHfVa8x8VVfSB
        tx+kbayrno9JmVyE0g/u7xj5OT0a8IflVB0wkNdLT3shDULicvcRy4UAzYH2nj+80bU14O
        PLSBgv9c1a1f3xCwvZtzYCEqGr+ojTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-pV-k5gWnONiC8SRb30P0fw-1; Mon, 24 Feb 2020 08:51:49 -0500
X-MC-Unique: pV-k5gWnONiC8SRb30P0fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF10800D5A;
        Mon, 24 Feb 2020 13:51:47 +0000 (UTC)
Received: from krava (ovpn-204-48.brq.redhat.com [10.40.204.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B13315C28C;
        Mon, 24 Feb 2020 13:51:44 +0000 (UTC)
Date:   Mon, 24 Feb 2020 14:51:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
Message-ID: <20200224135141.GH16664@krava>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:55:12PM +0530, Ravi Bangoria wrote:
> Hi Jin,
>=20
> On 2/24/20 7:52 AM, Jin Yao wrote:
> > For perf report on stripped binaries it is currently impossible to do
> > annotation. The annotation state is all tied to symbols, but there ar=
e
> > either no symbols, or symbols are not covering all the code.
> >=20
> > We should support the annotation functionality even without symbols.
> >=20
> > This patch fakes a symbol and the symbol name is the string of addres=
s.
> > After that, we just follow current annotation working flow.
> >=20
> > For example,
> >=20
> > 1. perf report
> >=20
> > Overhead  Command  Shared Object     Symbol
> >    20.67%  div      libc-2.27.so      [.] __random_r
> >    17.29%  div      libc-2.27.so      [.] __random
> >    10.59%  div      div               [.] 0x0000000000000628
> >     9.25%  div      div               [.] 0x0000000000000612
> >     6.11%  div      div               [.] 0x0000000000000645
> >=20
> > 2. Select the line of "10.59%  div      div               [.] 0x00000=
00000000628" and ENTER.
> >=20
> > Annotate 0x0000000000000628
> > Zoom into div thread
> > Zoom into div DSO (use the 'k' hotkey to zoom directly into the kerne=
l)
> > Browse map details
> > Run scripts for samples of symbol [0x0000000000000628]
> > Run scripts for all samples
> > Switch to another data file in PWD
> > Exit
> >=20
> > 3. Select the "Annotate 0x0000000000000628" and ENTER.
> >=20
> > Percent=E2=94=82
> >         =E2=94=82
> >         =E2=94=82
> >         =E2=94=82     Disassembly of section .text:
> >         =E2=94=82
> >         =E2=94=82     0000000000000628 <.text+0x68>:
> >         =E2=94=82       divsd %xmm4,%xmm0
> >         =E2=94=82       divsd %xmm3,%xmm1
> >         =E2=94=82       movsd (%rsp),%xmm2
> >         =E2=94=82       addsd %xmm1,%xmm0
> >         =E2=94=82       addsd %xmm2,%xmm0
> >         =E2=94=82       movsd %xmm0,(%rsp)
> >=20
> > Now we can see the dump of object starting from 0x628.
>=20
> If I press 'a' on address, it's not annotating. But if I annotate
> by pressing enter, like you explained, it works. Is it intentional?

I saw that too, but I thought it's unrelated issue,
because we played with that just recently

if you go through the 'enter' way and back, then the=20
next time 'a' works ;-)

jirka

