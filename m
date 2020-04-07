Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3765207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHbNDz0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGVaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:30:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:30:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so5546330wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeOb7bw7ZU05WWRpiZXDbb732pxeQMi4LbeTnQvk5RI=;
        b=GHbNDz0o8lcP5xbu+Wb/yshUnWPBucml6fsGMRJi7IBP7dlySYYTU+1q09y0DGhMZ5
         l+vEnigD2NFXbI2q9UGJX0uKIiYrZHR6Z0PPksE81MY8Ij18sJ15Swrxe+rgJxmlxvHG
         wgmgqsIm4ZTFD/9Uck+I6zXU2Phju7lN0KT6wsP9QYYd5Zf/hxU0LKqjFyLjLzPDpsd0
         HCnXfUYrCTWW/GmGqoRSbUOCYwpq8WpJQPJGI5n1IhUT96jNUjfacOh4zsltx4qHHbIr
         4JCy2UJtZyDC14m7/+K42dxM9U71fsoXZNlZcS3a215KLEzfZzN+CV9GBtnoFqijrgHE
         PskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeOb7bw7ZU05WWRpiZXDbb732pxeQMi4LbeTnQvk5RI=;
        b=P2cfadZ9m5eQtIfxZXcpd8WJ/7E/1BQZl2j2XDlVjRqRPbThDP7s0ntRQ3DqamU4kn
         LWZiHyxB38qV30Jytdo/nf6GuQ8u5oX/kZNba78I7NMZCvSmcSozSGT5M0L2OkrBWQku
         SzZLRxKsEHc7CzjCxr8Po5uFwFc9ezi8E8WUUcxXlwZMmNT+mh5P7rTVYvLydDyRLR+g
         Rh+ymhiO8hkmP30tMRV7MUhInK51Ydj4Lbs6MfXabPQwMhYvc+HfbueCUnulu+gckAtz
         /a3uLEn+1u+JisE//3tS3uIy5kABsjQFuOJMC22rNK9mQVfOhtd/XDmYS+D5vZ1phGNT
         B2Dw==
X-Gm-Message-State: AGi0PuYLFPLa4hYpDyGksuIh4xe/Jh0wuEP6m6jmWWKZBFvxulWnIGFm
        85VxdbSy4AZ9YiLww6uTUhs=
X-Google-Smtp-Source: APiQypLgEgrDf34HSgRuIR4yNy76OxilPFRw0shtbt54IFPaMkrRIaOXKXmW1ahdPA+N0lBTKuGvuw==
X-Received: by 2002:adf:916f:: with SMTP id j102mr4530675wrj.335.1586295005505;
        Tue, 07 Apr 2020 14:30:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t67sm4438171wmg.40.2020.04.07.14.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 14:30:04 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:30:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/memory_hotplug: remove
 is_mem_section_removable()
Message-ID: <20200407213004.xeipetht4eq5g72r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135416.24093-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 03:54:16PM +0200, David Hildenbrand wrote:
>Fortunately, all users of is_mem_section_removable() are gone. Get rid of
>it, including some now unnecessary functions.
>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Nice.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
