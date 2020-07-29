Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5E320829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595980837;
	bh=+2XKddAYfaltITXN0VY0V8q4QDdilMY0eb0ayDOLhHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z6W0FE98Grh/pqIvSNALpr/rZYqdAHJAmCmTIx4jqCcyK2vUUb+idRE6MR5KJ1wpq
	 V3hhm7S/PpWKXkU1xSPKO3c1HPZ5LwYDu2JBNnUODixus3innVCnczh1Tt4AIK5NJy
	 BTOXnR4bFJy7BPAFQ+hyg+I/EzdT7V5rOO9V107Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgG2AAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:00:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41798 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgG2AAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:00:35 -0400
Received: by mail-il1-f196.google.com with SMTP id c16so6023885ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9WqMZ97j3+53daSNfhsHBQoaaEy2kmohpeoSYJwCfQ=;
        b=Agre9W3Adold3I3m2ju3LYZYRfBxdNMeVFgMyak8ZhPtC0o0lJEgk0S/oJndR4gyab
         c7y1iEPLdfTg8z68z9vqqYFUg9ML1AywQSO1Q/c9930bhds2rA4pul1i3rcEubHjWXTm
         JuIzAA7MZqopDojeoyDQHp+4D2dBm9qe8GaBNefWX1aLsQIQVq3YJhcMOD/c/WvQpeOH
         /VulwJyOSswSrPATSz+EBEO5Rm3mp4wPBmzfW8yY1qT75SlYt4qtP+psj+m8hhh1zG7/
         ambn34YwcoKjHy5VHzNvQrWoNksy0v41QOBUXtL5RXzq6v739m5GjCwhGNcHrdPXEzjC
         Fk+w==
X-Gm-Message-State: AOAM5302xCVAa9Om4QdtC7aQgh+mnS1cVldV1tPQKURPZhIAObrWglSr
        j1xnrZ2KNx+OJlebirIBKlmUc6F/7KI=
X-Google-Smtp-Source: ABdhPJy9Fg4c1obWsmgcmNM+bCfo5THx6FqSiWZzvjhS4PAj+pEMUEVVkOhZG7CHWaK/5D6fqYrEVA==
X-Received: by 2002:a92:49c3:: with SMTP id k64mr28942967ilg.278.1595980834028;
        Tue, 28 Jul 2020 17:00:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i8sm198288ilq.67.2020.07.28.17.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:00:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0E2E040945; Wed, 29 Jul 2020 00:00:31 +0000 (UTC)
Date:   Wed, 29 Jul 2020 00:00:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gxt@pku.edu.cn,
        Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org,
        akpm@linux-foundation.org, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mark.rutland@arm.com,
        james.morse@arm.com, alex.shi@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        rdunlap@infradead.org, davem@davemloft.net, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org, krzk@kernel.org,
        zaslonko@linux.ibm.com, matti.vaittinen@fi.rohmeurope.com,
        uwe@kleine-koenig.org, clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Add and use a generic version of devmem_is_allowed()
Message-ID: <20200729000030.GI4332@42.do-not-panic.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:19:20PM -0700, Palmer Dabbelt wrote:
> As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
> implementation of devmem_is_allowed() that's exactly the same as the version in
> a handful of other ports.  Rather than duplicate code, I've put a generic
> version of this in lib/ and used it for the RISC-V port.
> 
> I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
> (though this is the first version, so they're unreviewed).  The other three
> obviously depend on the first one going on, but I'm not putting them in the
> RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
> yours along with the others then please say something, as otherwise I'll
> probably forget.
> 
> I've put the whole thing at
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
> generic-devmem .

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
