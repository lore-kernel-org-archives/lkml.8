Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0DE206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwDJgsjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgICPfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:35:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58548 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgICPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599147350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rU2y9GlEoqQBcx+HtwgNNaTpu74bHBMWUNiw/ZwTiPA=;
        b=gwDJgsjF0w6/z7EY1TvEil2OJ/XYi3M9WV/xLOZODgeJmiCm+DQBdjteDgqbV4RcAVHIiH
        L0jtl1pI6/RM7jaEFWDQI0deQzJiL/Tc9nBI3yXwoCQu6/RxhAUu02KK8J6rny/KMRlrrT
        DH5D6om5evZoPEqQjCkgFmCLvYU3pM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-tQIbLeSwP_eYZZDkq8FQ_A-1; Thu, 03 Sep 2020 11:35:49 -0400
X-MC-Unique: tQIbLeSwP_eYZZDkq8FQ_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0659E1005504;
        Thu,  3 Sep 2020 15:35:48 +0000 (UTC)
Received: from treble (ovpn-117-249.rdu2.redhat.com [10.10.117.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8EC39A47;
        Thu,  3 Sep 2020 15:35:47 +0000 (UTC)
Date:   Thu, 3 Sep 2020 10:35:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] objtool: support symtab_shndx during dump
Message-ID: <20200903153545.zy24o7pqfohgoxge@treble>
References: <20200812175712.9462-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812175712.9462-1-kristen@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:57:11AM -0700, Kristen Carlson Accardi wrote:
> When getting the symbol index number, make sure to use the
> extended symbol table information in order to support symbol
> index's greater than 64K.

"indexes"

>  			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
> -				scn = elf_getscn(elf, sym.st_shndx);
> +				if ((sym.st_shndx > SHN_UNDEF &&
> +				     sym.st_shndx < SHN_LORESERVE) ||
> +				    (xsymtab && sym.st_shndx == SHN_XINDEX)) {
> +					if (sym.st_shndx != SHN_XINDEX)
> +						shndx = sym.st_shndx;

The sym.st_shndx checks are redundant, if 'sym.st_shndx == SHN_XINDEX'
then 'sym.st_shndx != SHN_XINDEX' can't be true.

Actually I think this can be even further simplified to something like

				if (!shndx)
					shndx = sym.st_shndx;

-- 
Josh

