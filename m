Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB879C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A582A2075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BYy9wj6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGKP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgGKP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:27:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC02C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:27:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so3448179pls.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJhe6zCH1WNKrcTnZAWBMSujOY8veheAqOunmYv7YNY=;
        b=BYy9wj6hr+/2xBff/O9U6Mv8X2RuoxrhGspttITfJd4H8BT42Uvff1YmrFUq1cxZjM
         /RlLAChkcLmFmI+uTo4zm5wijjEeCSEKarUvluxfkHEzzxmXiQlqMrHG2/F4iJIIcrUU
         dlISfhoybUvWlEufXBVpXrUwypgMaxD7ZGIprD/q16PiAC6VPerZ8yOEw6qfLn7b1gxp
         yBLasf14IkCYP1/Sbgl7pveb8Ap5sLlIU6Tn0JjWQLLV63+9FPOd+AGwZ5hKOXwD6lbs
         /+Tf7pb6hwTXQ6mywbOPTiiiCpJe3T/y4srOH3PaOr0xp8zFTuVKircjNbS/AODWG60I
         bEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJhe6zCH1WNKrcTnZAWBMSujOY8veheAqOunmYv7YNY=;
        b=R/sVuwuVRL28YVGs1L2UnuCI++BVUtpFJ2oSFN4KVT35teSnpkfnsLwZ/2GmqDTqli
         C7XK+6XUKHwpsmFSYiHzzatmCekjTGdxWKRH63bPz5o6uZF/eYrlXCzV9F7wDakWpqH6
         VYfjPh7OI+TOCva5AjfwTjSKVoW8MyPdibe85BVINeHDbajVmV4raOfis+fcDCXx0DYj
         XrycuuToCpwULTnDiiKg4iSoVfzm3/rhhzFVleR5GVwc2ZaxmCtJLDLRD1WEYrpDYNVo
         X8rop2M8o3nWU1fFPgBqXAbZxBtGeCXyrJ080mZR6rjU4rBirIVrncF8vcph4IzKt857
         eJRA==
X-Gm-Message-State: AOAM5308puLhMoABLf0aNh9aGgs/3Wtb91us7zIUBSdAybCq1+rxoBF1
        xXKBKIAzsxlrO0tErJevji9N1w==
X-Google-Smtp-Source: ABdhPJyBB95eQ4mlp1x88D2vqXWSfX0Jo3FgIJzOV4+vOR092AfZ2VdaRT1r4N6tEvSEQtk9/OdRQw==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr11139688pjb.106.1594481267471;
        Sat, 11 Jul 2020 08:27:47 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id cv7sm8923477pjb.9.2020.07.11.08.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 08:27:46 -0700 (PDT)
Subject: Re: [PATCH] rsxx: switch from 'pci_free_consistent()' to
 'dma_free_coherent()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200711064647.247564-1-christophe.jaillet@wanadoo.fr>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c885edac-8de8-ba4c-c8bc-98654417ce20@kernel.dk>
Date:   Sat, 11 Jul 2020 09:27:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711064647.247564-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/20 12:46 AM, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script bellow.
> It has been compile tested.
> 
> This also aligns code with what is in use in '/rsxx/dma.c'

Applied, thanks.

-- 
Jens Axboe

