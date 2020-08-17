Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FA82072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3/d+es/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgHQWJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgHQWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EDEC061389;
        Mon, 17 Aug 2020 15:09:13 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u126so19121443iod.12;
        Mon, 17 Aug 2020 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=kmrZR8ILE+zMSpiGsSvpHpAliJOJWWuFzBlFgpRJThM=;
        b=Z3/d+es/kdHvkLa0W7gppN/H/5OCefRnXFXYL5XOxmZdrEwTmYriZJlrnwhnBSncWi
         ZHwtmh9jr60Y7Uc4Aamj0QIYC9gLSaiGYeyi6YNCXmMl2qbmkXr/XEx5nczunm5GBHOD
         WBkLsw0zMDSECa1fHTIrAu5SMZ1VCrIpE4ugwI8gOOxSIh0XhvJpzK7Kt8tRzVTF33V2
         j5r/4W4ZMebBV9PCBn3ctQrXfdD6qNHGWkRS2jBxa1HlFo4KhYvavHipC5j0rHzfDj5R
         ine/7gKGqkzY028YoTmtsN286QS0m5mZzAvHYbsLppweXTOZhlWqgX1IJcJn7PxOr+po
         8HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=kmrZR8ILE+zMSpiGsSvpHpAliJOJWWuFzBlFgpRJThM=;
        b=o/LmgytehrZfhw31fAFHcx8WYxV7+TkbFxsQYU0zENhA3x3HrLykxlwB54/aif+Lzb
         QTycNeClBEo6sxQXQVQsacFkDSCgkkp4Y4xHUAQ7KOOQ9GYy/sY4fZ9eVAaRm3wY9mAY
         ptpmsu6oz2LIARDwcWLUDtZ34Ef2/lYejf2hCmAEDKqQmyvbE1xef/j5N1mXl2njY+Su
         w8hzY7KapDl885Rlqz0nsvAlIYDC+9sHa/MEyp1phBfns6f2Dl+7h3hgCbSZdStbb6Am
         YvPJjoYU0NDOryAP131xcV6yavfThjmM/7L5f3CA2u3DRH2M/qkUBSmBqhQEGXcWyC6m
         N3HQ==
X-Gm-Message-State: AOAM532+CqeryxUp/ECAQsufMqDps/N6xFCis2FtWX76Kk89U/YoldfI
        3z8Epp/Ii3PpTj44VSZB97xMrDTU9IZGP3iNwmY=
X-Google-Smtp-Source: ABdhPJzxHAUdEQ/PzDpP6mC6eDteoLkBCEtX33rbqiPackUZdVk8CHeMrK2hL0BcCcXjMSPnGlmprmniIbZ0RFgsLjU=
X-Received: by 2002:a02:1988:: with SMTP id b130mr15917005jab.15.1597702151428;
 Mon, 17 Aug 2020 15:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818075918.15ac1099@canb.auug.org.au>
In-Reply-To: <20200818075918.15ac1099@canb.auug.org.au>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 17 Aug 2020 17:09:00 -0500
Message-ID: <CABhMZUUzSQQZbySX6-E6JL8nBd8fc=cfSjih9LWJk0C-H8C=eQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pci-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   35150fc886a0 ("PCI/P2PDMA: Fix build without DMA ops")
>
> Fixes tag
>
>   Fixes: 2f9237d4f6d ("dma-mapping: make support for dma ops optional")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Fixed, thanks.
