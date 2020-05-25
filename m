Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBBDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A386F20776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S3wCwl5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbgEYTDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgEYTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:03:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:03:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e11so8166999pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+zZvfQ9uHEcIup7MCl+X+CsUnoR1rGvk/AB5eqrO2gc=;
        b=S3wCwl5Zq/JaG4MuDdB4aCHBce7iBLI4XtmboFqCQK4GIuePZwfBYQJJdtXr1k7hUh
         5V7zvNPvjam68fJZZ0kNFKU+122AjlSTJgmLYrC8BAOwmIwSOUSOZpZkcylUlBthYDAy
         Fa7AsXyZm662yGHDrguZvBPg/HvU4AULESaJ+U1KsywvLDTBN+yuIbnC25LT54M34Fhm
         ZvOjkZk3XYyiC34o6cllfK/WSSPkXML5JbvyTxLmQNiA+K0ATMPAugPyp7mTwajppvad
         HwOU06CdBST0cIt00v9uVoOCMUiUMndEMjEXtAudlZcWg1DWH8Vo94MSedJDnxlviJZK
         gB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zZvfQ9uHEcIup7MCl+X+CsUnoR1rGvk/AB5eqrO2gc=;
        b=Pvx5NQZBHpYk/T62XeA6mk/i80OlLNsmmgjsS2aK8sZ4ps1+cQCxrxPN7kOHbKwvbN
         TIuonmTdAlkdEVLOlzpIp8UZibHlgUHci/sOaiO0LXunvuNh/TgI78EHu3MkrVVwwKw1
         Jk+o+qx6acSCFlHv/4ljwtJ2Hx2mryaYj6SHj/pzMFXT7eug1ei3V7jctt7Z0BWxqaO7
         vdF8QaohK05UmseBf/lSbFhNjY836AGecs1L9nKccfD8NbhSLBfomYKybXdmP9WKi+Oq
         yCYKaS+UAtq7nlCc3fB2dK4zyTVaEAWxobDx7GYlsLBj3ehgqECxhzhJ2VrgC25Gevtg
         1Oyg==
X-Gm-Message-State: AOAM532DHinVFKCB0IkdDH0ncHLDgEzJer1UoHdCsWt3+Fekiteq1A4G
        vmAfKevlNmjw3tgAbfF4toYgrY29rXmxmg==
X-Google-Smtp-Source: ABdhPJxsO2BATErq1hdRMq+47FTRMwcZqrwtKyAss+sFid9AQbw59BL9UQzeUW9fi2iigF0qEz0ZNg==
X-Received: by 2002:a63:34cd:: with SMTP id b196mr10800118pga.2.1590433427045;
        Mon, 25 May 2020 12:03:47 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:3c00:cb1c:41a3:c8d? ([2605:e000:100e:8c61:3c00:cb1c:41a3:c8d])
        by smtp.gmail.com with ESMTPSA id u20sm13638359pfn.144.2020.05.25.12.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:03:46 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
References: <20200525150837.54fe6977@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c0e6af76-46d8-ccf0-3874-0751f7622caf@kernel.dk>
Date:   Mon, 25 May 2020 13:03:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525150837.54fe6977@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/20 11:08 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> mm/filemap.c: In function 'generic_file_buffered_read':
> mm/filemap.c:2075:9: error: 'written' undeclared (first use in this function); did you mean 'writeb'?
>  2075 |     if (written) {
>       |         ^~~~~~~
>       |         writeb
> 
> Caused by commit
> 
>   23d513106fd8 ("mm: support async buffered reads in generic_file_buffered_read()")
> 
> from the block tree interacting with commit
> 
>   6e66f10f2cac ("fs: export generic_file_buffered_read()")
> 
> from the btrfs tree.
> 
> [Aside: that btrfs tree commit talks about "correct the comments and variable
>     names", but changes "written" to "copied" in the function definition
>     but to "already_read" in the header file declaration ...]
> 
> I ave applied the following merge fix patch:

Looks like a frivolous change... Thanks for fixing this up Stephen.

-- 
Jens Axboe

