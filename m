Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C28208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaJ5rhDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgD2Nz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:55:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgD2Nz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588168526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxaVkGmIzNCD7S/waco7p06sl1vo0f84OW1yaoPDlxM=;
        b=FaJ5rhDVqRGdO1pmvpV6Z21OwCvBSRdh1tYs78PJm1RpI8QTaa0eRexCsy7xz5KR2wnsHT
        zDVfDA2kJI5WJ4q9W+Por7SRestQp2gjgRCpWESnFmPfk6J3kkoPNJeET6apAmLE5F72kE
        FYhoTC+p5zo+tGSXBdHbsVixGVnkrpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-xIyadMCCPwynY6fRioCn8A-1; Wed, 29 Apr 2020 09:55:24 -0400
X-MC-Unique: xIyadMCCPwynY6fRioCn8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC5AA1899520;
        Wed, 29 Apr 2020 13:55:22 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-218.rdu2.redhat.com [10.10.115.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2EF2605CB;
        Wed, 29 Apr 2020 13:55:21 +0000 (UTC)
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Markus Elfring <Markus.Elfring@web.de>
References: <20200429135328.26976-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7530523e-749c-dac7-f6ab-f52dcb20ecb9@redhat.com>
Date:   Wed, 29 Apr 2020 09:55:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200429135328.26976-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 9:53 AM, Waiman Long wrote:
> In a couple of places in the slub memory allocator, the code uses
> "s->offset" as a check to see if the free pointer is put right after the
> object. That check is no longer true with commit 3202fa62fb43 ("slub:
> relocate freelist pointer to middle of object").
>
> As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> may cause a bunch of "Freepointer corrupt" error reports like the
> following to appear with the system in panic afterwards.
>
> [   38.579769] =============================================================================
> [   38.580845] BUG dentry(666:pmcd.service) (Tainted: G    B): Freepointer corrupt
> [   38.581948] -----------------------------------------------------------------------------
>
> To fix it, use the check "s->offset == s->inuse" in the new helper

Sorry, forgot to change the commit log to ">=". Anyway, this is a 
serious bug that needs to be fixed before v5.7 is released.

Cheers,
Longman

