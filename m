Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE20CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D129320722
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lR2KuM1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHBT6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:58:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8AEC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:58:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f7so32346616wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EY2GM8DAMcjIe2PibsUkkd0lvUS8v18wFqJKkQw10vU=;
        b=lR2KuM1CkmbL3QM8ZBeu1Bu6902zGmKtJkkMlSUl1xP1YGYjFmDiD8hvQYC9SZl4Sk
         bnsLzKmekMU+p8J/SpmSyuX4mIyiBh09rpiNzbFPGgfeFJTFdiHQo6HqCYyn5S2yu0Jv
         pWDCB8K+U7R1cGYngpB064q8EnCkwdNtVUCsSQKsPUelTJdv8gdC04za4TAZ9TO+WsZV
         x/NtF4/hRtglRH81xegr5f1mQCCy5daEP93etsaNBBSxMdVjUD7zf3cHgBGtDurMjleF
         AcZcf7S84y1gdEVVX/cShP7kwOhjAcLofXAwKC3O3eHuW0zEIl+qvcYLGaTbVd70DeEB
         1fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EY2GM8DAMcjIe2PibsUkkd0lvUS8v18wFqJKkQw10vU=;
        b=rn5143q5F48OVKfxmABaPbmP1aFDnCNGPsWGccGAsbFiyGDfiw7Cd9E823zs2W/jgO
         OGkex36aFvKXz0K0OC/gO7MLqgFYpTytGwqEFE2lJ8MkwvMefZvLyRAg0CCYxIDWG0zr
         E5giZD6ltnUqQFYfsrEmmclHntrKeSxgFxufMWEM8jujM0gbf2sEmYnNyrKvOzVhCW+M
         zByHyuclmrT3MDHLPx53FZ5v5LSbJAVfG4fTrXj786OeilruXrb1h/DIFmdBZqC1wmXD
         9DIANAzcgLfHk5pLaZqdeKRQzkXElRMe/206jMLE42ahRtgsB1QaUbRN/FUHiq0CIS2p
         rpmA==
X-Gm-Message-State: AOAM532oNXmvh74z56HUg5e4/W5ExRQud4e5S6+xTveE2b8g5nwQHpj5
        08Q1TP2Jm6obYHsB+z0gF6c=
X-Google-Smtp-Source: ABdhPJxXJm2pq/i0tJ+Ro+2DF6E2cgdBiHcgro15aChsIlOOknuFI8SGbys6muWJVrx25+LVkqCZCQ==
X-Received: by 2002:a5d:4005:: with SMTP id n5mr11873938wrp.26.1596398315335;
        Sun, 02 Aug 2020 12:58:35 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id 65sm22205018wre.6.2020.08.02.12.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 12:58:34 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
From:   Chris Clayton <chris2553@googlemail.com>
To:     LKML <linux-kernel@vger.kernel.org>, ricky_wu@realtek.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        philquadra@gmail.com, Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
Message-ID: <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
Date:   Sun, 2 Aug 2020 20:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I should have said that the patch is against 5.7.12. It applies to upstream, but with offsets.

On 02/08/2020 20:48, Chris Clayton wrote:
> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on my Intel NUC6CAYH box.
> 
> The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp() was added to rtsx_pci_init_hw().
> At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in rtsx_pci_init_ocp() the cardreader
> gets disabled.
> 
> I've avoided this by making excution code that results in the reader being disabled conditional on the device
> not being an RTS5229. Of course, other rtsxxx card readers may also be disabled by this bug. I don't have the
> knowledge to address that, so I'll leave to the driver maintainers.
> 
> The patch to avoid the bug is attached.
> 
> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
> Link: https://marc.info/?l=linux-kernel&m=159105912832257
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on my Intel NUC6CAYH box.
> 
> The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp() was added to rtsx_pci_init_hw().
> At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in rtsx_pci_init_ocp() the cardreader
> gets disabled.
> 
> I've avoided this by making excution code that results in the reader being disabled conditional on the device
> not being an RTS5229. Of course, other rtsxxx card readers may also be disabled by this bug. I don't have the
> knowledge to address that, so I'll leave to the driver maintainers.
> 
> The patch to avoid the bug is attached.
> 
> Chris
> 
