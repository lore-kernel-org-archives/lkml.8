Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0DB2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhqMJTVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgIHSEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbgIHSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:04:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A21C061573;
        Tue,  8 Sep 2020 11:04:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so60044ljg.9;
        Tue, 08 Sep 2020 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jEj3Cyz6BLHbNpIEqvvmWp+Pn9SwJlYwmj/5uG+ZbOA=;
        b=QhqMJTVlEdukL/UWb9NH/q8ck0QAqkSghth47dlIa6+z38TfeH5UeH7aF/DPIY6N+Y
         RZUR5lu4uSb9PoyE1lmcxqtb9FdzR1Rh/QqGuXr/lf6oUIicrNk/yM5G1l0t3at2Cgao
         tJGoOrFPc2kJP5heYLK08GwdxikRUO/ufIBas2fADjoq6KBwqp7iVLMBIkjyaJS/YOE1
         aGtiUCdVhXDzxRQ3cxbvbcjICM3usQaxMiLHtY0KyOqBJAPYzXguIY6r/Ec7MSggqDtD
         DmtGlJsMExhc94sstGACELYqVDZPj7by4c+NgNKqC0V0hK/lfK4B4I8wS/bwEtwY7TBu
         /xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jEj3Cyz6BLHbNpIEqvvmWp+Pn9SwJlYwmj/5uG+ZbOA=;
        b=So6fK4OqfRgDnIYRFVkUY0CsQFBE/BhSzx+413EsLXQ/wXTNkVzfpxxIzkYFZk/U7z
         uOIbCIB955KLzgKvf2mCFqilfa8ftDXuZ29pifKlxlTzG0VXyEWKIehveoGvgbEXAIoP
         bONkrd9UATVCfAzCqUSkqDtF+UfnXsOG4zCql9rwwDc5S5T5mMgokNmGLXWYM1hjFR5T
         CxAxljX+zr8UlKVw4PWnUJsNp7VC7xTSvXrwICgVLjCWQ29o1V+lmrnoSBAVF+O2EHca
         oDMhCNSAHmyZGcoQgpeN1U5bbdIJELD+RmJfRFj/WzjcoBSQb5j01Nliezzj5dEj5WN6
         7/ag==
X-Gm-Message-State: AOAM5321WnX0hw86lcQdLgEcHvB29Cjbz15TxCtuJ74VRJmbgFgSZBpC
        4xUCqoN2kkx2/GGJL2klHt2OoA7+ojNjKg==
X-Google-Smtp-Source: ABdhPJxOUh/DrhDJ0sLHODDZNX/AG6pD3ZL1wq5ajq4aTkSAV8ndeDN1OI1ZCYVq9+MPf2vTkw+8bg==
X-Received: by 2002:a2e:9047:: with SMTP id n7mr14193403ljg.125.1599588259222;
        Tue, 08 Sep 2020 11:04:19 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:4400:1ee0:403c:d08c:bf15:55e0])
        by smtp.gmail.com with ESMTPSA id h17sm132955ljj.4.2020.09.08.11.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:04:18 -0700 (PDT)
Subject: Re: [PATCH 04/12] dma-mapping: fix DMA_OPS dependencies
To:     Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org
Cc:     Tomasz Figa <tfiga@chromium.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20200908164758.3177341-1-hch@lst.de>
 <20200908164758.3177341-5-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <8404208b-7276-914e-e4da-e65a907a5e9b@gmail.com>
Date:   Tue, 8 Sep 2020 21:04:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908164758.3177341-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/8/20 7:47 PM, Christoph Hellwig wrote:

> Driver that select DMA_OPS need to depend on HAS_DMA support to
> work.  The vop driver was missing that dependency, so add it, and also
> add a nother depends in DMA_OPS itself.  That won't fix the issue due

   Another? :-)

> to how the Kconfig dependencies work, but at least produce a warning
> about unmet dependencies.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
