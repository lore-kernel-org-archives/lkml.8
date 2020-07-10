Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17BA2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mII+P3go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGJKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:33:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A4C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:33:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so5903770ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7wcSEVgyD5Y3dugrOjCqv9VAWTaRIiDXcxelGf3UV2M=;
        b=mII+P3goT2djho8sZLapqR2ZO0BzJs7VFIU+jKjyv8cANY5LcCi7pvATB+/EZ2IDEp
         BAGAbApnVctDKvjDeXMHHf0J20Cv0BvvBVsaQPMQZ2fDEqfW2N8waquGalnNPdiH61el
         5J6CLC9m0fRyfkLIEGDf3fICqmx6muoWdrLLee7Cm3LOVtlMSfCgA9lq7qlHW1Gr4dre
         wlJQb8eFXXT8Y0CU0X8BGIO8Pu1ooM5zs5+cxzlVe1WeF21XDi3s+Xh+LFWJ7PGBCYa9
         kbMVXtbkphRNg7DNQtJ0Xw90E36pD5J3JQBLPRR5m5ZVtgPlXK+IXrDTZUzjKqtZP4Sh
         I/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7wcSEVgyD5Y3dugrOjCqv9VAWTaRIiDXcxelGf3UV2M=;
        b=b/9eTlqbI2uv1ZYaDHrPTnH/dRHsLG9BTpdTUZnikrQImLnktOwBkkaEhR1ZkUYnl2
         0AAfhV79yNpDpwu5BNl0Ck6XAVJjXaAZsMJ6qrBAvT5/jJ3n437G8LoweZuCd3K3p1IT
         LGCv+qDT/4I3ggcvJ4zrOE9o8/9khNKdVOfHmbErr7r4NKd7W9nmRH+HyugcNmw+EgvJ
         jz8v67r/Sg7J2XJ0v1yFhGFxTLbHHJjHlZq4MSwMNodPGDOGc3hoMp6tiRFii6D3aqRg
         3LliDV3ZlGwdTxebvRq+11pfaZo3Qi6UqTl8uedXw4/eZUXr/QtKQXGUu8huvIUhS091
         Gz1A==
X-Gm-Message-State: AOAM531R89wr55wpJEjrit5gTT07Gx8W4ST/LRsZF+ZJrGmL41zGjm5a
        qHDwD3rP5BUp3Ksd6/efOEtVLIzRwdI=
X-Google-Smtp-Source: ABdhPJzIvkfX42cr5qxUwq/2hylNYWi1DXtCGvHf/btnFUlSfBwrWlICTxh9aCET97yOK8KhpJuTvA==
X-Received: by 2002:a2e:b4d3:: with SMTP id r19mr24308257ljm.150.1594377196920;
        Fri, 10 Jul 2020 03:33:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w2sm1780387lji.41.2020.07.10.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:33:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7095110222B; Fri, 10 Jul 2020 13:33:18 +0300 (+03)
Date:   Fri, 10 Jul 2020 13:33:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: a question of split_huge_page
Message-ID: <20200710103318.bm2gp743lagiajao@box>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:51:58PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/7/10 上午12:07, Kirill A. Shutemov 写道:
> > Right, and it's never got removed from LRU during the split. The tail
> > pages have to be added to LRU because they now separate from the tail
> > page.
> > 
> According to the explaination, looks like we could remove the code path,
> since it's never got into. (base on my v15 patchset). Any comments?

Yes. But why? It's reasonable failsafe that gives chance to recover if
something goes wrong.

-- 
 Kirill A. Shutemov
