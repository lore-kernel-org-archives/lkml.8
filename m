Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B40BC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5156E2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIKIBcXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgBRVJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:09:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727916AbgBRVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582060182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9mRKEIAjKB1Xq/wMpY1paNLH79mcLaPS2RPUKkvMDQ=;
        b=PIKIBcXXV5icRXnBUto48WVeEz7JlejGzH9QixoY2on11Zwy4OnlJMUM3PdphJm69+L+qM
        kmgGnu7omAxZY8QDPP+v2oZFiD4hdwC48TfAucvhtlnBvntR7AAkapQ70lB4Z7IR59UYD1
        gZzs7OMMTv5YmAfzUPF1vSmCahJGUoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-D5lFg6opNpGvWSZgTdsX6A-1; Tue, 18 Feb 2020 16:09:34 -0500
X-MC-Unique: D5lFg6opNpGvWSZgTdsX6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA32DBA3;
        Tue, 18 Feb 2020 21:09:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A890060BE1;
        Tue, 18 Feb 2020 21:09:31 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>,
        "Shutemov\, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
        <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 18 Feb 2020 16:09:30 -0500
In-Reply-To: <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
        (Dan Williams's message of "Tue, 14 Jan 2020 22:02:34 -0800")
Message-ID: <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> [ drop Ross, add Kirill, linux-mm, and lkml ]
>
> On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>>
>> By running xfstests with fsdax enabled, generic/437 always hits this
>> warning[1] since this commit:
>>
>> commit 83d116c53058d505ddef051e90ab27f57015b025
>> Author: Jia He <justin.he@arm.com>
>> Date:   Fri Oct 11 22:09:39 2019 +0800
>>
>>     mm: fix double page fault on arm64 if PTE_AF is cleared
>>
>> Looking at the test program[2] generic/437 uses, it's pretty easy
>> to hit this warning. Remove this WARN as it seems not necessary.
>
> This is not sufficient justification. Does this same test fail without
> DAX? If not, why not? At a minimum you need to explain why this is not
> indicating a problem.

I ran into this, too, and Kirill has posted a patch[1] to fix the issue.
Note that it's a potential data corrupter, so just removing the warning
is NOT the right approach.  :)

-Jeff

[1] https://lore.kernel.org/linux-mm/20200218154151.13349-1-kirill.shutemov@linux.intel.com/T/#u

