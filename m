Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76977C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546322063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582585;
	bh=y5D+W7NP27fjd1kgv9I14AGiEIlE4eeOVt/8IFLm2u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qSQs1KyyEjbiuQrWxt9Kme8iF7qS2gF92c19L7OAVeIAHsmyQLu1rNKWBxyNrprPc
	 /crnuHpuEnmtAmn1n79KRKCCljqrf6sJY9m1kTL7pEsH0+ek//iSz/+9yl9xF504WA
	 WxLkgWAajHEHA7waUrdFjqnJ6q37KdMvmN3cKK9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGXJXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgGXJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:23:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:23:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so6550434edz.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LNGLkZP5D8/u8cZ8++DJl4JEFHoFdXiIn1C5bXtzgAs=;
        b=TVr8EnMEYkpB0XNbRADjLeg2HaEo67xazjjWxA5VZcA++bSJRceRIQCCczT/6Rdyms
         PxD8N3rPU0zlDTLl0LiWRrFYiuJ+8lEymThg54tbeP37GA8lo/or9STAos35EffaRkAJ
         5SNnbMVtTySpaFcoLrjOjuAWUxUmrWXLb1V4n0Mt+3mppuMNH3pD2zFLmqfIcIs/4Bcn
         uzAWTs/OYCwd4otci5b8oc2UaPkSA+Wd7CdgIYYKJmt2LOEyIJbt8rH66v1Awm/Gm8Bf
         KXQdXz7kBRGTdb/n5IiRWZnltOlcihVclXxs5yiTe6tr/TehnCANlzulMrpSvZ1g6bDJ
         CChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LNGLkZP5D8/u8cZ8++DJl4JEFHoFdXiIn1C5bXtzgAs=;
        b=nGkoA5oCPHTTiAgMoBUNxdfK+GFl9GHKBRxzIjiV2DVsxPbq8K2grX2128jBnGp90z
         tUlBnx09ICSOvHwtumvE2X5PHCrn8bF5ABi5h3arlc27c47gFXHPzYUuwd4cBtwv0Kyf
         8jjuZVbrY/GpXydV35HYN8VNOd7E3xUuQ1d6koxJc/C4PCgYaWMc1MWxYHxoJuIo9ESz
         8S7pkva7d/mKX4S3O7aheRFXUDxgdU8vxahUYDX8Lp4dpLlV1V2uRfcictu6Dsuu1nrV
         gP3cRUvoV6hTTbrjk3lc5UFo9gEftt+Bk5lUVg7G83JmKDDdTw4cr97yrW+bjRGr86eW
         mNjA==
X-Gm-Message-State: AOAM533O/T11BIcpQ81wQ+WgGDM1c0hjr1MOdz2Ef+ooxp+y4RmwokvP
        yN5zZ0lt/9EkdPgEpX1pRSpi15g+
X-Google-Smtp-Source: ABdhPJyWsapp3jdS9V13rZnwZ7bt/j9qOk6Yb8QWM32MEAIMsYVZRyrJGN0IyC3c8uZfYWUPSH/StA==
X-Received: by 2002:a05:6402:32b:: with SMTP id q11mr6140414edw.67.1595582581687;
        Fri, 24 Jul 2020 02:23:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d23sm287994ejj.74.2020.07.24.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:23:01 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:22:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Brian Gerst <brgerst@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] arch/x86: Implement text_alloc() and text_free()
Message-ID: <20200724092258.GC517988@gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-4-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-4-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> +void text_free(void *region)
> +{
> +	/*
> +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> +	 * supported by vmalloc.
> +	 */
> +	lockdep_assert_irqs_enabled();
> +
> +	vfree(region);

Had to dig around a bit to find the source of this restriction. Might 
make sense to clarify this comment to:

	/*
	 * This memory may be read-only, and freeing VM_FLUSH_RESET_PERMS memory
	 * in an interrupt is not supported by vmalloc.
	 */

Thanks,

	Ingo
