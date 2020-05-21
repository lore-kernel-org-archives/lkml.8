Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF76C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3224A20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0wILMXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgEUEgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgEUEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:36:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:36:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so2706348pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eT+xRG/v2TF4nGrc1FOaU6f7rS0qB1ZWjEBefkEwxkA=;
        b=Q0wILMXN5wl22nrpcoEWsujQk97MNUyAxDuNg+JG4QAV4F2SLxacZnCTz3YgW/Ythc
         zhOnoeSPSUOmuLbibehiAbph/lIWY7ok/eZEUoUnxRQ3IpCGHToo1HLrTGFk109NgaKd
         PNUFzREtOa+2BSXhf8aiJrq7TM/RJ6xfeXAsjLQAwpgEpLwgT8x517Z2CrIXDXLG4e5G
         B+bw/8Y7YgPXsVDyJs49YdOwLwff87pz4lK+qWpW9bauQazdo0oVncEDmIeZr8Yk/ZnV
         nrQvvCS18GvRqNSUiggKUKMmHppmool/Mwl4TZZcJGoAaWbpHPZGDOEBkXSqwMdwjFl8
         2j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eT+xRG/v2TF4nGrc1FOaU6f7rS0qB1ZWjEBefkEwxkA=;
        b=SCFmHq0za5sWAlzzQ5c9KnaPmmEE4zPRf5LNPecrDeeqYdJiY58q8AV5h+fqEH8Tz5
         ItmZSq2UYZcFcBsvvuoVxWdRKZbW+x5HuHZOz/lWCgopz02W7zy+ooLnTB1OeYrXIFqO
         B33eQ0oLqdoXdmjx6He1kk7C4y4mKbb3U8z1W6yhVMepQUmYOOfxvVs0z0njpQO+7n0N
         FH3DZytfAnfewO3J9aOcMpLny96KVI18zCL/MRmiVeoSe29+2pX/NIFTxtJj1apLY0vn
         UC2K7fHzvFYh9FmgLYfG7CJI7JgerFxzso3M5a/hb5b+Pi4uBIO5xezHPQzOwiQbds6w
         hQsA==
X-Gm-Message-State: AOAM531i45z+fjqVKbs+CiWctD/3Xf7Djvqmf0sOqhJYJUDUvhO2Y8Kk
        klMXY8R/fgjUpoL8YSVMUgg=
X-Google-Smtp-Source: ABdhPJzz8gkLN0J9T2eU9zKoFYdwTB7xNCAWpkb/hANZKG/Lv6BVo6zyOP4VqZAsk+TqlK1nUeSySQ==
X-Received: by 2002:a63:f856:: with SMTP id v22mr7349071pgj.64.1590035791231;
        Wed, 20 May 2020 21:36:31 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 25sm3168282pjk.50.2020.05.20.21.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 21:36:30 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 21 May 2020 13:36:28 +0900
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521043628.GB755@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
 <20200520121000.GF520@jagdpanzerIV.localdomain>
 <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
 <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/20 18:00), Andrew Morton wrote:
[..]
> I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> puts() a string of any length.
> 
> I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> ...) which could perhaps be converted, thus saving an argument.

Can you point me at some examples?

	-ss
