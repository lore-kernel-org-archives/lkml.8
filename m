Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA92EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BA22065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RNHbSFFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgGVPC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:02:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9274C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:02:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so2844273ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PihvrkcIdS9+OJBOnU38h7yqxzd2Wqd+kwsRkrJ6J2Y=;
        b=RNHbSFFPJwnAFASGuINzCqJII/5IgjdU8e7BUEvXcf1eqAmEktuEVJKVESGGzgK7Ys
         h55rvylSRZ9KlfZdAbq+Avva/GTpLfNS+WhPzIrOCUAaAaKW5qq6UYU+gy9HXm9Quszp
         KmDuDLxKfGnkDo9egr99I5bqA97enE6crWenk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PihvrkcIdS9+OJBOnU38h7yqxzd2Wqd+kwsRkrJ6J2Y=;
        b=PpQYqXG5J3sMmvFCergNLXBTdPuLPnorgrpnqF6hJ1UepTjgILRSS2f/3vgUWuQRnQ
         QI6uPD0y0h506+5n8ZOkG9JMZcXV0qoyFU1m6LazGZQNcmhyFKP2CZte6F+GV65QUq0H
         VbYYewfnniTmxk/O56TiH3ZzwZ+R8L57BybihksthbGMnJLkqZOWUGTsJZWG9RFy6j9+
         bogwL1iRjPW46MGFYgMVm8ThIrAT4iA3gJP/kfC6QIQ9vnVMt9okF9fVt3zAb9lpvMnZ
         qHKOlbcY2F2G9/8tu8yxb8OrhYFcIxWamHiT1Swi7fxqYaWZZzFTSd+rraIzs6ow/dIG
         aDyQ==
X-Gm-Message-State: AOAM5331hCPzyWaGkJLb0qkal7ry77eD4mRNCP2f6mhek+Fv04HMF+cF
        cI/2TWBP07wNyqCTkqC4B1SCmg==
X-Google-Smtp-Source: ABdhPJyDawdPxmJ6OAHeMXj2O5Vbp5F3TvglkcvQxvPpg0TysBMH3BD+mhxwlvotlSwEljW6jSKHGQ==
X-Received: by 2002:a2e:9b8d:: with SMTP id z13mr15240620lji.463.1595430144039;
        Wed, 22 Jul 2020 08:02:24 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e20sm123227lja.137.2020.07.22.08.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:02:23 -0700 (PDT)
References: <87wo2vwxq6.fsf@cloudflare.com> <20200722144212.27106-1-kuniyu@amazon.co.jp>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, netdev@vger.kernel.org,
        sfr@canb.auug.org.au, willemb@google.com
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
In-reply-to: <20200722144212.27106-1-kuniyu@amazon.co.jp>
Date:   Wed, 22 Jul 2020 17:02:22 +0200
Message-ID: <87v9ifwq2p.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 04:42 PM CEST, Kuniyuki Iwashima wrote:
> Can I submit a patch to net tree that rewrites udp[46]_lib_lookup2() to
> use only 'result' ?

Feel free. That should make the conflict resolution even easier later
on.

Thanks,
-jkbs
