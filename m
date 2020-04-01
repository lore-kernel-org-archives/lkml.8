Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C908C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19AF20842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="SkwqLLE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgDAAIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:08:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38444 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgDAAIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 20:08:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so20179020qtq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2ZJH2bqoeAK0auR/UMe60BRQ+wnm6Zhq3FSNSqtWLpQ=;
        b=SkwqLLE+Fow7/6Cah0e/j95l9bMReiVaYR4axf2TUigtGS/eaMdShdCnE1kPmtW8xR
         /2az1sR0MrFLXdNwIqYBsyjiDUKNnfELPUgcNOobar7ZtpNdp71qiqvD1LrukFi0CpgA
         J5FAkULaIxv4Ug5J2eypaO5WiiHNqJrCiCqTH4dU1J+r6tnbMHtNkwd7fNCXvIIvklvt
         9KwDKFX3E7bH2UUTKBdZIx/lHXRCJ/+99lUGzjOaXf3lY5oyFAuqifMyjkfjPGhm8ukf
         n88tUjgzfiFmlrNd+in4y5NvLTdL+hVNEBxm7PoZTDrQ9zX6o87y87BT2HzzK8pOTv7n
         /nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2ZJH2bqoeAK0auR/UMe60BRQ+wnm6Zhq3FSNSqtWLpQ=;
        b=aeqyMxj9Zhq7Jv6pcoVF6TADjLQK64fL2W2v+0t/HQrmcMP9X5IteLn1Q1vG5mT2U6
         DJIr3S8AxHvBDLrUH5qi4vaoPRuBQA+Gawdc4GCnP741YtmQlQxUWZFQC+McL8rDiaGC
         WlkbhsvYvvPXPMOZz+qchrZbWG36SZLH6Q285MEuBvvuoI63h02y1P30BcL9cLYYva9U
         RGTXTjRbii+PcsqEQbL6vOt2P6Q//ZouhcEuOFNthhmmwLkY7V48DxM2xrH/uVXqwWi5
         Gf4y8cRpJOQe16ia+i5DxUKCwypAnE+4YlC/4HZwK0zPHHnpSwmZicijZ16apwqLgGaU
         9Ocg==
X-Gm-Message-State: ANhLgQ26qbmy8F80TQ4vBheYndoULcbdIg835iT7ghmDX5dD1/5TJoiz
        oydfMFgKRmHtTucEUla9DGmhFg==
X-Google-Smtp-Source: ADFU+vt+sCovG6L+oIaQ3zQdeuF6yYCHLi+70BqvCcjee5mfo7yd78UD47UhE9xaOFer2GPikk3WbQ==
X-Received: by 2002:ac8:2921:: with SMTP id y30mr7807073qty.161.1585699718754;
        Tue, 31 Mar 2020 17:08:38 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id b7sm383592qkc.61.2020.03.31.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 17:08:38 -0700 (PDT)
Message-ID: <6a307032bbd05a7405c5e6a6629071ae03f62a8c.camel@massaru.org>
Subject: Re: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to
 ReST
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Date:   Tue, 31 Mar 2020 21:08:35 -0300
In-Reply-To: <20200401000439.GE21484@bombadil.infradead.org>
References: <cover.1585693146.git.vitor@massaru.org>
         <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
         <20200401000439.GE21484@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 17:04 -0700, Matthew Wilcox wrote:
> On Tue, Mar 31, 2020 at 07:28:56PM -0300, Vitor Massaru Iha wrote:
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++-----
> > ----
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst}
> > (82%)
> > 
> > diff --git a/Documentation/filesystems/sysfs-pci.txt
> > b/Documentation/filesystems/sysfs-pci.rst
> 
> In addition to Jon's comments, for the next version, I would suggest
> cc'ing the linux-pci@vger.kernel.org mailing list.  
> 
> Also, maybe add:
> 
> F: Documentation/filesystems/sysfs-pci.rst
> 
> to the 'PCI SUBSYSTEM' section of MAINTAINERS.

Thanks Matthew.

