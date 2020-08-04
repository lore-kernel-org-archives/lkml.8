Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA14C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AC9206D8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKz23poc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgHDUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:33:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726987AbgHDUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596573178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7Z7vDg3Q1pr+nhfflKaYjiVNAZMF87UK16s+2aaWsU=;
        b=YKz23pocm3ZTRZa4VQldDSuBp3n284TKCi7iDN0+iENpbicqsSyf6xC0qTAAOq1m31vvDo
        /RwkZyWkZZOGgKihEOkR5Tc+8v/GRivNBjgvGV0u+rks8fA9+6lgTFT842bVJnAjViwGJR
        uy3cbAtdrvqPM+WDehyyNOac7OWtruk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Yap-K20-OX-axNigE7kk9g-1; Tue, 04 Aug 2020 16:32:54 -0400
X-MC-Unique: Yap-K20-OX-axNigE7kk9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE7418C63C0;
        Tue,  4 Aug 2020 20:32:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56B7C6FEF4;
        Tue,  4 Aug 2020 20:32:50 +0000 (UTC)
Date:   Tue, 4 Aug 2020 22:32:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH v2 2/3] perf symbols: Try reading the symbol table with
 libbfd
Message-ID: <20200804203249.GJ139381@krava>
References: <20200804085736.385232-1-rbernon@codeweavers.com>
 <20200804085736.385232-2-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804085736.385232-2-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:57:35AM +0200, Remi Bernon wrote:

SNIP

> +
> +int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
> +{
> +	int err = -1;
> +	long symbols_size, symbols_count;
> +	asection *section;
> +	asymbol **symbols, *sym;
> +	struct symbol *symbol;
> +	bfd *abfd;
> +	u_int i;
> +	u64 start, len;
> +
> +	abfd = bfd_openr(dso->long_name, NULL);
> +	if (!abfd)
> +		return -1;
> +
> +	if (!bfd_check_format(abfd, bfd_object)) {
> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
> +			  dso->long_name);
> +		goto out_close;
> +	}
> +
> +	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
> +		goto out_close;

aah, so the code is actualy only for non elf objects,
somehow I thought it's replacing the symbol load globaly

jirka

