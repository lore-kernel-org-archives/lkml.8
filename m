Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2620838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOrQHyef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgCCKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:32:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53605 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgCCKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:32:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id cx7so1155986pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqQPvVpfCUeuYgBc2cgqqSfJNV0Jwct5hvRDfltneII=;
        b=uOrQHyeflwKQT2FWHpxmjqSxCOzUmM45BmOkyKkyM+m949DMLrLgz7CIeoKNISLuHa
         A88/FDlDWEx3K8HYzjdaDG8d4Q7TzVg0JJLV1tuLyTMcNNTqZTeN1xMiMNsr8OSTfa9n
         wCyS1n/AZlBdk0604zASV9f+vApcy5ukQPa6LLdLky59QewxFdsqngfnw8dY3HzYzYgV
         jPSuQkfNe7ZhQaCjAs8CrhCZZRxiucfr2Y2xLqJh0vk8msQcDvxMeYp8cHph+XQfDWRa
         gdSph83HAbyQPFvgVmjvt4fcZHOltfUTiQJuQV6uq0Gj/ncV6RkJTAzledd0HIIor6ZM
         ilYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqQPvVpfCUeuYgBc2cgqqSfJNV0Jwct5hvRDfltneII=;
        b=W1pvFRkAus3redss6eIqv36YgL7ljDYwwX5kJdpqp93npFd/SLpsgpq5J7sl2eMi99
         T/UMpnJTaT0ifXHrPKGeTFbc2vuJFL3n9yN3sVnvKu46iawviS775lwSrm7zcIxf4kys
         rTjxqoyhnotckTHMQ7aBng6aCWTE5HpMYfhw/nZ+cqPweVrmJrLbCknV1x9GDKutlyPU
         FG3cU3PkH0bFvCLNzF/Ay7ZSXxZAx9V1RHTM5/iVo/tn2pnyPnw6+KjC1Vv/tyniiiH2
         hCqLXXlz8mL3j6C3yg9UFxeijS0PB3fF8GWdz5CfPrdEICMKy1Y3wKET0G0pQoDl9qnu
         HaXg==
X-Gm-Message-State: ANhLgQ1ERZtW/wCTur9CGPLF3Ero2gqT3S449N0Vq1XhU3jqxWyhdj1A
        dVUU0bpBW363x7KW3uX7ktI=
X-Google-Smtp-Source: ADFU+vuJLDKMo8iW2axGmY/AV069rKY9kUI27RvXIT424nsV8Qettivq8YPMAynSs9RftoCSBg9cOg==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr3328720pjb.90.1583231566109;
        Tue, 03 Mar 2020 02:32:46 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id k70sm2266347pje.38.2020.03.03.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 02:32:45 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 3 Mar 2020 19:32:42 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 0/3] lib/test_printf: Clean up basic pointer testing
Message-ID: <20200303103242.GC904@jagdpanzerIV.localdomain>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200303072456.GA904@jagdpanzerIV.localdomain>
 <20200303092255.c4j7q2r734t5upvz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303092255.c4j7q2r734t5upvz@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/03 10:22), Petr Mladek wrote:
> On Tue 2020-03-03 16:24:56, Sergey Senozhatsky wrote:
> > On (20/02/27 14:01), Petr Mladek wrote:
> > > 
> > > The discussion about hashing NULL pointer value[1] uncovered that
> > > the basic tests of pointer formatting do not follow the original
> > > structure and cause confusion.
> > 
> > FWIW, overall looks good to me.
> 
> Could I add Acked-by or Reviewed-by tag, please?

Sure

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
