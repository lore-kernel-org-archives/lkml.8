Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A55C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97522073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y3qVTjWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgATCpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 21:45:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52065 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgATCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 21:45:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id d15so6039885pjw.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 18:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSA7tjQ0gZwwIxLsC3H38R1G6GxZRXNeLGZnOEN9y2s=;
        b=Y3qVTjWTPNV5H8+jp1UxyYrh+5RE5/V7FLkYQMxTtVs4Yu1GWSItts1OpZHr4f7SMX
         rds4rGjGDE3RfW/gTysiwdGDwbhGd10uO7eY84wGNujZYt8nztdyp0SWZisov53+/m+Y
         zUyLLltJhior5qAlHoXpoiLJkwSCVYCT/4T8mUt92rXZfdS9QrxjfcIVYlq45pCQXYeA
         BavuhWh3a0ZAhYH3k38x+w7JhSMws0ALDZQDjLTJ62J15MVE282tUNAONxTXy7NerrJ2
         THKdi6+SrO8JO5ynoShOQR3hxhlFIoa+lkmEQiZjBhzK5f9U1iy3bI3CKwja2hRVuF+2
         P6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSA7tjQ0gZwwIxLsC3H38R1G6GxZRXNeLGZnOEN9y2s=;
        b=oe9RMepJBeBY/WzyL0hmrLbo/vuvRgthaoQaLboaOU5sWPpXpXwZCXw1lmYQ47m/fD
         NtDTIcEnQvEbypQcgR4Fqsd5UsHFWahY1wP7PMdo1BrbS9kklwVvNclWLrblS+f8rwRq
         IUYzBAS1RfLVOOXU7zecIhEVm4L45nBW3jUORPQ4IbZWT6iXVMkCEkCrceMOWsdpa2Jc
         /4V9kUTlshyNJTUY5xZh1pFZZbIfPPgxUEEjvqyvom556e3RQE0zfTEq+Y2UQ2UjAdjd
         NEZoKsQib7PBRnHEbr8WPL5RO36+zIjsvwqyEHuLeG8LMC+xp82fbZWbEuOC+maM61N1
         /lFw==
X-Gm-Message-State: APjAAAX0TfDqZEZig74QYv0zZyatckNrHrfeW6HwRnF9D1hABO859Gzg
        rZJT4kndl0NC1DR+0Uyutrl2Ug==
X-Google-Smtp-Source: APXvYqwizD7zKOp7aV1NwnruAEOpn02MxxgF/dP6zCxiIUPM8XwhimnueiHcQcvOLDqJhgNc8Yq9RQ==
X-Received: by 2002:a17:902:74c5:: with SMTP id f5mr12199970plt.229.1579488333971;
        Sun, 19 Jan 2020 18:45:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z22sm37421853pfr.83.2020.01.19.18.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 18:45:33 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20191220123614.5f11d2e3@canb.auug.org.au>
 <f6ff3aa5-e08b-8b25-454a-9aa51b8b5c37@kernel.dk>
 <20200120124051.2fdcfc61@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0af609c-aa1b-5a8b-89d4-ea6aff779c67@kernel.dk>
Date:   Sun, 19 Jan 2020 19:45:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120124051.2fdcfc61@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 6:40 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Thu, 19 Dec 2019 22:34:59 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/19/19 6:36 PM, Stephen Rothwell wrote:
>>>
>>> Today's linux-next merge of the block tree got a conflict in:
>>>
>>>   fs/open.c
>>>
>>> between commit:
>>>
>>>   0a51692d49ec ("open: introduce openat2(2) syscall")
>>>
>>> from the vfs tree and commit:
>>>
>>>   252270311374 ("fs: make build_open_flags() available internally")
>>>
>>> from the block tree.
>>>
>>> I fixed it up (see at end, plus the merge fix patch below) and can
>>> carry the fix as necessary. This is now fixed as far as linux-next is
>>> concerned, but any non trivial conflicts should be mentioned to your
>>> upstream maintainer when your tree is submitted for merging.  You may
>>> also want to consider cooperating with the maintainer of the
>>> conflicting tree to minimise any particularly complex conflicts.  
>>
>> Thanks Stephen, I may just pull in the vfs tree to avoid this conflict.
> 
> I looks like Al has rewritten the branch you merged from his tree and
> caused various conflicts in my merge of the block tree today.  I used
> Al's new versions of the conflicting files.

That's a bummer. I guess I'll have to rebase on top of the new one. Al,
is the new one going to be persistent?

-- 
Jens Axboe

