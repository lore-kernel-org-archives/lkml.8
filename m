Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44AC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0020873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRZ7aFoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBLCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:08:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44301 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:08:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so308527plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 18:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=O2ZsuKPEP5oLCWMhrZcn4KHLKYwr5L+g0EDvWX5oHfY=;
        b=GRZ7aFoo3yb1JhjX4RKiJaWrQjkfYB8yJfXsYRBpLTGeQa50GZzVKxSJl5a3+7aT5X
         F+Jh3OEWE/gDMAf8Z4nG6nW5NAT0vtl516eU9STByC1A9cltp71M+/F6lcK8qX09MfQl
         F7Oaa9xk7waAp+4c2XlqwRaSPuUin0D4JGe3gTriXZVpFpXHWAgpSzAn/MX9EEgcPrMB
         DLxjfc/xk8wn7YeEDh0uA4KeCz8wSJPU595IOAJ0AGVceyqypBz/4Tzhky7PJybMbHOk
         ESgwAxqKoELPKcc+Xfihw8Q4h/A8MiK0YeRrP/ewOtMflUlq6Ni6DM/daI26CVOE/HJd
         c+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=O2ZsuKPEP5oLCWMhrZcn4KHLKYwr5L+g0EDvWX5oHfY=;
        b=Gh24g3YY90OzmBIYGY2E5hrqBcxWCHPYQpHZZFyz+94cJIT0g4uqrdizs8boCj4QpJ
         hBnUjten97zSf8Vmn82xyHQD9vllLBFbVPszszm+XdUHVnRl4IaXip3QH/lxW6jXRmPX
         BeuMu90S0aWT1EW4NPLyMIml/vuPius2SGGJSBtih9bmsCmQu52bwYU3ZljPIPiJv1B8
         5Gj42fgljJnaZWOREDZlPQZLokKRxbh5J9SYueqhnsT3BtTVIeMm7yuCBTLRpnvAq5X8
         GD0uFMP4TiJobhMIugwcjTX1hju0aUtM7AVwFDKzW3xFk+kTs+C+rBQovoCTY0gNjOVP
         w0Rw==
X-Gm-Message-State: APjAAAXtj3M2TLQI3dldbbBNC0KQ6ESupQTlF03p7Fcl5ksWGHpR+Tjm
        S9f8f5AEnOnZ11UyC0BxpX5xLA==
X-Google-Smtp-Source: APXvYqxD3Z3q4kqE5IkZZfnwQHS/3ERW12ITlfqiDi9YHEM/AmDj9MMNkW9RCHPA5x2C9OUOL8O5ww==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr19872097plf.50.1581473320284;
        Tue, 11 Feb 2020 18:08:40 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d26sm5062927pgv.66.2020.02.11.18.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 18:08:39 -0800 (PST)
Date:   Tue, 11 Feb 2020 18:08:39 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: vmpressure: use mem_cgroup_is_root API
In-Reply-To: <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2002111808280.170855@chino.kir.corp.google.com>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com> <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Yang Shi wrote:

> Use mem_cgroup_is_root() API to check if memcg is root memcg instead of
> open coding.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: David Rientjes <rientjes@google.com>
