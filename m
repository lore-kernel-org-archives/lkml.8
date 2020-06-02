Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBE520734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RA2jFaTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBSHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBSHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:07:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F6C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:07:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 185so5444703pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTxalqs/pHPsm3sLO7uWOd7CCP2I2KVCnswTNK8P1k8=;
        b=RA2jFaTtyiyOffX+8t+4eoki862K5Ju2HjEVedRIQuk1JD0Ec86Haa06krSLrl6LpL
         VkG/BNoeku+uha0fc4pA2ZuczeoC+O+OEKk4wh2MakrjpCLCY0WnxHxNKn1XZyKJS6h/
         wi9nvGVrLMzreLbS+RNIMp7kAsbY/XJYcn7L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTxalqs/pHPsm3sLO7uWOd7CCP2I2KVCnswTNK8P1k8=;
        b=BaqFSZYaVRwoNLSjaJO4MTzWisTVAbvneRjrKxf6H868UtKQ4GDMzVOO/WPfmfI5qO
         kwiHcGKX1CgqpIGIP7ThCaiJjuJEuWvF+tfLbMIOKTxLS07QalG38gzQFxk9hwL+nchD
         0UPDNReWoutP2p4Ep8AmjJyiTTSoa0mxyQZnie7fqzOMLQBinsUl/NUL14aSaG+Ii5oi
         VE9/wPE63ChEOVef8OlRrLRsAFDtBuGSp5I8kF8cXz61mnX7k2Yv4ayo7suSJGyhqDTy
         3uR36fiCeWuRkoJHFvlBla/lQOMnhw09PaX73AyqkCn/yW9cd31LmxRwLDsTYEesSMyz
         4IZg==
X-Gm-Message-State: AOAM531xYnUgQFlEtuGlj78ieEnyG4ikbZ2Ob7amrLnFj2poXIKcvMFj
        PMh2VsulzGmcRXWlJ01cn9cpEEv5dEwyJQ==
X-Google-Smtp-Source: ABdhPJzHVVx9VNVUgr3dHCYpuAqidPMbaFtV5I/trgX7Y4qqdH9iIOAQQBQw/OAJgP7tQnT+4N+oUQ==
X-Received: by 2002:a05:6a00:150c:: with SMTP id q12mr26468066pfu.270.1591121230644;
        Tue, 02 Jun 2020 11:07:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm2868552pfq.43.2020.06.02.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:07:09 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:07:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] kernel/panic.c: Make oops_may_print() return bool
Message-ID: <202006021106.6360CB6FD@keescook>
References: <1591103358-32087-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591103358-32087-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:09:17PM +0800, Tiezhu Yang wrote:
> The return value of oops_may_print() is true or false, so change its type
> to reflect that.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Sure, that looks fine. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
