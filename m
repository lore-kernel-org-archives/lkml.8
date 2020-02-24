Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD79C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981362072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8411zTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBXMfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:35:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbgBXMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582547741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A76EGrw49ZVRKmkTyfyUNvOOyxmLePhddhz/3ngCACc=;
        b=P8411zTkx7ua9nNUfDHH5ePnNeMRrUvF5H15dlDWtJWO4muTsBxe5Hcn+iLJdGAyd3Nna0
        dGPCHtKs/fRK5BotpT3qd9m+ptwZtb09qoIhcmHSlnzyxsTdtFjAUkvz8dRvPUvPCiLzfW
        njY590SLV71BRFrv8LfCcUUqtU1aeiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Vn3EV3SMO1yNpkDnjwMgZw-1; Mon, 24 Feb 2020 07:35:33 -0500
X-MC-Unique: Vn3EV3SMO1yNpkDnjwMgZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5E74DB60;
        Mon, 24 Feb 2020 12:35:31 +0000 (UTC)
Received: from krava (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C28B1001B2C;
        Mon, 24 Feb 2020 12:35:28 +0000 (UTC)
Date:   Mon, 24 Feb 2020 13:35:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
Message-ID: <20200224123526.GF16664@krava>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224022225.30264-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:22:25AM +0800, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
>=20
> We should support the annotation functionality even without symbols.
>=20
> This patch fakes a symbol and the symbol name is the string of address.
> After that, we just follow current annotation working flow.
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
>  v3:
>  ---
>  Keep just the ANNOTATION_DUMMY_LEN, and remove the
>  opts->annotate_dummy_len since it's the "maybe in future
>  we will provide" feature.
>=20
>  v2:
>  ---
>  Fix a crash issue when annotating an address in "unknown" object.
>=20
>  The steps to reproduce this issue:
>=20
>  perf record -e cycles:u ls
>  perf report
>=20
>     75.29%  ls       ld-2.27.so        [.] do_lookup_x
>     23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
>      1.04%  ls       [unknown]         [k] 0xffffffff85c01210
>      0.03%  ls       ld-2.27.so        [.] _start
>=20
>  When annotating 0xffffffff85c01210, the crash happens.
>=20
>  v2 adds checking for ms->map in add_annotate_opt(). If the object is
>  "unknown", ms->map is NULL.
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
>  tools/perf/util/annotate.h     |  1 +
>  2 files changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hi=
sts.c
> index f36dee499320..2f07680559c4 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2465,13 +2465,41 @@ do_annotate(struct hist_browser *browser, struc=
t popup_action *act)
>  	return 0;
>  }
> =20
> +static struct symbol *new_annotate_sym(u64 addr, struct map *map)
> +{
> +	struct symbol *sym;
> +	struct annotated_source *src;
> +	char name[64];
> +
> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
> +
> +	sym =3D symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
> +	if (sym) {
> +		src =3D symbol__hists(sym, 1);
> +		if (!src) {
> +			symbol__delete(sym);
> +			return NULL;
> +		}

hi,
I like the patchset:

Acked-by: Jiri Olsa <jolsa@redhat.com>

could you please also check if we can do this earlier,
so the dummy symbol is actualy collecting all the hits?

like within the symbol__inc_addr_samples function,
but I mght be missing something..

thanks,
jirka

