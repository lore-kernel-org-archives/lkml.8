Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72902082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM57cu5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgGFX6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGFX6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:58:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84744C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:58:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so15215777wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4nSbcQc6o8w9v6ZNEJFjfitPw+WKCLAR8ckhCop8iZ8=;
        b=NM57cu5hPt5WpTyLiOYNBE+EktavfXY9/G2/Ex3+2yVkNy+hJ8Jdnwp/YX/f58v7Jd
         s/aTm97pbiBSSSWm9d8BEYy4OiC1T+GZyAZig5GPGpO9DLnb08yCiv1JAlEz3jCHrLFy
         GqNDDk429tmwQDaEAqugXo1tcZGnnFoMvADCJ9HXn7H+DU/3cNkSkcY/H7mlAZpQD1is
         CkwxTsKZo4tJ5WBsSnfoZMATroXRXxPngNT/moD5pzoo62NzDQc73OuYV+uaRDLK1T03
         izEtl6+2R183jRvTFAOQzhRPZ5bflHG/aPf08X6CgsLKCvo2kOZd7Nwr10OsbsfjEO+Z
         QIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4nSbcQc6o8w9v6ZNEJFjfitPw+WKCLAR8ckhCop8iZ8=;
        b=NyGR277yQrEZ0GPnC1snluMZTbIeK1WamAAS98WDnceSR/HM/8fF2AI24j4ZmCPqP/
         6SdOAOw0970YrqhSaIQENVcP1Ij/aaif1u0dwXW8RBSKTYUXIHy/OHQXM5iU7WZs3l8A
         eMGEIAzIHOa3V8c1I6l1/uWyue42nVGdtocIKnUNzhC0nypWGRoL/3+MXeMe8A5+TIHl
         LCzeYLT6iAKdxGundNe30EQfQ0xf39ctQCPaz6CmghxT6NoWvYXecpN+msJpzR0l8H66
         bQXg8dhS1H3kXafx23R51gBpox7gA4UJSvJ1gws+0tnprohwxCQhApbtNbEpNOy8nJjk
         FhMw==
X-Gm-Message-State: AOAM532Nn3Q610iIp2jqyQOLIC53BCWqjk4KhWGgRMiis8Skuv7Z9P3/
        5ktDfHBN5WEnpolpyqlVTDhH3l3E
X-Google-Smtp-Source: ABdhPJz/bnvnR1MbXLHSB/I+s79KjMOEJuqMp6UPW3B20faugZU31FoxDxW6frq4uLxEEavfTp2tXw==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr52188056wru.399.1594079903117;
        Mon, 06 Jul 2020 16:58:23 -0700 (PDT)
Received: from [192.168.50.2] (178-164-237-246.pool.digikabel.hu. [178.164.237.246])
        by smtp.gmail.com with ESMTPSA id l8sm25651546wrq.15.2020.07.06.16.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 16:58:22 -0700 (PDT)
From:   Tibor Raschko <tibrasch@gmail.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, skhan@linuxfoundation.org
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
Message-ID: <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
Date:   Tue, 7 Jul 2020 01:58:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The suggestions you made will help us adapt inclusive terminology
> for the current times, and also help us move toward terms that are
> intuitive and easier to understand keeping our global developer
> community in mind.

> Allowlist/denylist terms are intuitive and action based which have a
> globally uniform meaning.

Nobody has a problem understanding "blacklist" and "whitelist". These
are universally understood words even outside of computing. Claiming
that we need clearer alternatives is smoke and mirrors.

> Terms such as "whitelist" etc are contextual, hence assume contextual
> knowledge on the part of the reader.

We are talking about the source code of and interacting with an
operating system kernel. Naturally, most things here are contextual and
require domain knowledge to be understood correctly. Not requiring
contextual knowledge when reading the kernel sources doesn't sound like
a realistic argument.

Raschko T.
