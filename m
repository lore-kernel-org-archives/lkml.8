Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E542214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="PgRYwHdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAaOzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:55:42 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:14924 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgAaOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:55:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6C5013F719;
        Fri, 31 Jan 2020 15:55:40 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PgRYwHdL;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o99GYiZ3GynY; Fri, 31 Jan 2020 15:55:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A40A93F673;
        Fri, 31 Jan 2020 15:55:38 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0228136036B;
        Fri, 31 Jan 2020 15:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580482538; bh=YUkH1CjFdKHoKkg1wUKHwBtD41OhnQCCW4mcJCaz6rs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PgRYwHdLB4qOKQCMd7PmviXAMuf9e5dRdZ9bz+v1HJEQwWKon53XFKUIhZMExdi4A
         9SphEllwwZKwCMizMXnwV2q+6E5CWvstooBeB7+JOrS5zvl+8dJz77Pf1MFP1dl8lO
         X4GGdCILwGc8shIX/5DhhOsbO7xdF784nstBJhxk=
Subject: Re: [PATCH] mm/mapping_dirty_helpers: Update huge page-table entry
 callbacks
To:     Steven Price <steven.price@arm.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
References: <20200131100052.58761-1-thomas_os@shipmail.org>
 <20200131113307.GA34020@arm.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <5db5ee79-f4f0-0476-b6ac-5fde0d3feb20@shipmail.org>
Date:   Fri, 31 Jan 2020 15:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200131113307.GA34020@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 12:33 PM, Steven Price wrote:
> On Fri, Jan 31, 2020 at 10:00:52AM +0000, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Following the update of pagewalk code
>> commit a07984d48146 ("mm: pagewalk: add p4d_entry() and pgd_entry()")
>> we can modify the mapping_dirty_helpers' huge page-table entry callbacks
>> to avoid splitting when a huge pud or -pmd is encountered.
>>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Cc: Steven Price <steven.price@arm.com>
> LGTM
>
> Reviewed-by: Steven Price <steven.price@arm.com>

Thanks for reviewing, Steven!

/Thomas


