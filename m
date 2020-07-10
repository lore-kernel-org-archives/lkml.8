Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B5020725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594401936;
	bh=mYF3i+Aso6vKO6oMEhaGo5MTSDPuOCcJZr8/ZrUf5aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NuaPNILQTW/2ndE/WaQdjxIPLfT2CgkCM4NiZMdm2nTGjka0uA/Qvo4hfxJ1xfJ/t
	 URK0u9NA7AyfI0vHWTkPlwNJ4ENA/TbtX390dH/PpT5rcGscBq+P1n3dQbCsibnts6
	 i7BK+R0425XHbmuRNz6FyhWTXwKu6RpImAEPpSbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGJRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:25:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9318020720;
        Fri, 10 Jul 2020 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594401933;
        bh=mYF3i+Aso6vKO6oMEhaGo5MTSDPuOCcJZr8/ZrUf5aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xIK2kRfA/hQZEQbB52IvWCiiEF4uMgIqnPsW9BpXzRe8IB8+JQ5F6CbH38wNSLKl6
         9sN3ks+YuhSoWx1ygRdZ/BdDfUI2QbVcSD+GMvKIdYOZiuPA0JLHAQE9hqozfQgnBG
         Vv0iWgjdmCL7EtIu3MMtIHyK39ozpAoH32ZLLi8o=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01445405FF; Fri, 10 Jul 2020 14:25:29 -0300 (-03)
Date:   Fri, 10 Jul 2020 14:25:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-ID: <20200710172529.GE7487@kernel.org>
References: <159438665389.62703.13848613271334658629.stgit@devnote2>
 <159438669349.62703.5978345670436126948.stgit@devnote2>
 <20200710135712.GO874@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710135712.GO874@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 10, 2020 at 07:27:12PM +0530, Srikar Dronamraju escreveu:
> * Masami Hiramatsu <mhiramat@kernel.org> [2020-07-10 22:11:33]:
> 
> > Warn if the probe target function is GNU indirect function (GNU_IFUNC)
> > because it may not what the user want to probe.
> > 
> > The GNU indirect function ( https://sourceware.org/glibc/wiki/GNU_IFUNC )
> > is the dynamic solved symbol at runtime. IFUNC function is a selector
> > which is invoked from the elf loader, but the symbol address of the
> > function which will be modified by the IFUNC is same as the IFUNC in
> > the symbol table. This can confuse users who is trying to probe on
> > such functions.
> > 
> > For example, the memcpy is one of IFUNC.
> > 
> > # perf probe -x /lib64/libc-2.30.so -a memcpy
> > # perf probe -l
> >   probe_libc:memcpy    (on __new_memcpy_ifunc@x86_64/multiarch/memcpy.c in /usr/lib64/libc-2.30.so)
> > 
> > the probe is put on a IFUNC.
> > 
> > # perf record -e probe_libc:memcpy --call-graph dwarf -aR ./perf
> > 
> > Thus, I decided to warn user when the perf probe detects the probe point
> > is on the GNU IFUNC symbol. Someone who wants to probe an IFUNC symbol to
> > debug the IFUNC function, they can ignore this warning.
> > 
> > Reported-by: Andi Kleen <andi@firstfloor.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
