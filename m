Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ADEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222E62073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mC6KKwyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgDMMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727797AbgDMMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:49:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC8C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:49:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so8580739lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbDD5DeAkQAv3XRBJBIaEDRRBL0cq0+mIq6gtoIwJZU=;
        b=mC6KKwygD/vileEJq7528mS8TZmlrfjyV/5QKLXnNUb7Dd4GcGSrPZlGJZ/dUa78gx
         2KNI65bh2aHROVXLIB4Q7myNNgvxPrUx874CUD9HLZGo3hAgtyoR0/t09LRpKQRzcGft
         wwnEySDhElz42d7N/1VE0PYC4dV2J+e2jXrZ7jUxgIgiPCz3fBqpLpNWWWEEM76micUP
         hlpGcZVqlH9/i+vZiiW7H8vvYoyaAkgMch67JGRj/dRp10ZR9Ssy6km5/U6AWdcbtgnO
         P99Hqbr1EzfJyK59Gw02imvuL+nnCRqJUm7DBrO3OzS5++M/bdO1MiOmFfPtXfRC/rgW
         meDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbDD5DeAkQAv3XRBJBIaEDRRBL0cq0+mIq6gtoIwJZU=;
        b=V9Z6vQT8BVl2/Hn8mwcDUyaouyHCi02vKIBT9wCg1eiueOcyfmi4+YJs3UzUa+Hl0D
         37NCMcMHdTG1JeZ5phE2bC1Wf+GQ5OKWeZBVXbtRW+gtaII1vFah9oQD0e1n5AI9bNxg
         NgcfF646UPjm8ioLq27aoEkAnNzHml1O8sLIgSkMXPpXYAFIrrza41CEv9UrcZAfDzbG
         jwkUH+azPtj/j9y/bYtsds6R3/A67puzbOpiWRhvvQrDNVvhKwyqumjhXgP5s53FkXl/
         JrT86ua4qksL5IsuiiLx55EtR18BWKtOp158uToplrZgub53Al0ApCR/h2aojnLMTKja
         Evxw==
X-Gm-Message-State: AGi0PuY/qS2sFU5OTecsDyi4inhFxnkhmbOSIOI5JTlOoj7n59nLOd9w
        xDtW/iHU7PrGQwXoH9soRcgc5Q==
X-Google-Smtp-Source: APiQypJzpKMJQTH9x4hIQGQMNXlmDVUpW0SuvwyD+TPebx84Bbver2RNEzmsaubdeBhC0pMnxUAByQ==
X-Received: by 2002:a2e:8955:: with SMTP id b21mr5912499ljk.216.1586782151726;
        Mon, 13 Apr 2020 05:49:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f7sm7095712ljj.4.2020.04.13.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:49:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0402B10230F; Mon, 13 Apr 2020 15:49:12 +0300 (+03)
Date:   Mon, 13 Apr 2020 15:49:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] thp/khugepaged improvements and CoW semantics
Message-ID: <20200413124911.yvhferw32dnqeowj@box>
References: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 01:04:41PM +0300, Kirill A. Shutemov wrote:
> The patchset adds khugepaged selftest (anon-THP only for now), expands
> cases khugepaged can handle and switches anon-THP copy-on-write handling
> to 4k.
> 
> Please review and consider applying.

Please ignore, I've missed last two patches by mistake. I'll resend.

-- 
 Kirill A. Shutemov
