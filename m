Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC252166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="h3NN+FFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgCCKX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:23:56 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:37410 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:23:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E5F203F80D;
        Tue,  3 Mar 2020 11:23:54 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=h3NN+FFK;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sPW0qWza6X9Z; Tue,  3 Mar 2020 11:23:54 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 16E073F524;
        Tue,  3 Mar 2020 11:23:54 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id D0D41360106;
        Tue,  3 Mar 2020 11:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583231033; bh=RVfyASf7XP1Z1TIdelkLDDDCUoluWWyyQf/Mz9CblFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h3NN+FFKgh26TwA0W2Nj/kfUBdOlOyuAjB6PzNdD12sCjH0ZvmvrGjbVqy3cDjF0D
         C169qGfKK3a/jIs8N5QghDRkGfgk0T33yUbv4UShzFYYpafZJXTW8Y47BKkMeekbxD
         W9LELOU4YwHeFBlR8mXQRvfvfJe8xVcliTRk9nhg=
Subject: Re: [PATCH v4 0/9] Huge page-table entries for TTM
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
 <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
 <20200229200432.55b5b64f46dc2f2f80fa7461@linux-foundation.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <f6ebe219-3496-6dd3-b1da-2effc707548a@shipmail.org>
Date:   Tue, 3 Mar 2020 11:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200229200432.55b5b64f46dc2f2f80fa7461@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/20 5:04 AM, Andrew Morton wrote:
> On Fri, 28 Feb 2020 14:08:04 +0100 Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:
>
>> I'm wondering what's the best way here to get the patches touching mm
>> reviewed and accepted?
>> While drm people and VMware internal people have looked at them, I think
>> the huge_fault() fallback splitting and the introduction of
>> vma_is_special_huge() needs looking at more thoroughly.
>>
>> Apart from that, if possible, I think the best way to merge this series
>> is also through a DRM tree.
> Patches 1-3 look OK to me.  I just had a few commenting/changelogging
> niggles.

Thanks for reviewing, Andrew.

I just updated the series following your comments.

Thanks,

Thomas


