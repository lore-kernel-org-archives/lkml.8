Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC65C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18190206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WwRUF9vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgAQNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:30:31 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43257 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:30:31 -0500
Received: by mail-qk1-f176.google.com with SMTP id t129so22622098qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=U4/RhVLZS3DfSJ3cg9+WjUoTzOlLIbTI9zPCVAjn1nY=;
        b=WwRUF9vKt/5s/PIHYqrzuoQMr2a8YirD708F+kCBoHzuyHxGQbvciWODf9JXNvicud
         fqkP5IagKLSw36fHs65g0Fuc+OBpucXWd0khkY0AI6jOJOaB2wCwCz+Fem2Dxod2uAOF
         7DqLsEJ0gJGCKrTJ1dZ5pI5Z+1GLrrAKe1wYPDFdTrrQDKYdNeRC8Udk9m0cvmXuhZoH
         gitDSWd2DQbEKfWmn+/wi5caB9h9sCIjcwUX5lfPy+BRMxU+eA9KRNN0i8RazrzcxYAj
         SgGSUMOXtda41CAn75tZhLeh2/If/6LK07j7rx65Jk9ahagGfAX1JfzmuLeHrI2//Zs+
         UyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=U4/RhVLZS3DfSJ3cg9+WjUoTzOlLIbTI9zPCVAjn1nY=;
        b=uMI68xPs0A6//SezN68pFH08C/JjSzneeSNF0TTKPUvm265V7FbHpVS9qVWev6++7S
         Pjet3hzkCOtdMdx7pg4Yvk9+55RxXBpYtKLuXUygb/Q7R9uLKuyZ4L+i5BrTyH232DuZ
         YNL+ltU68w2+hxx7dBtUT1Sde5zcyWe2rp4gYBuJneb7eSqhpmB7jPXMuKeWKSXtngy9
         EBkOYb8S0bGNxZjIa0vCbbKTNOYhfuJfqRDHhPjBbaS+pRgcHqrZNWNSE6NHtQHQ7C/B
         vEDysZKAmbk+7rZ2Xxta67UIPJn4hFMWcDuircAFUsAgrTXg+grj0M5kkE6uFUORPFJM
         QZDg==
X-Gm-Message-State: APjAAAWvOBfcaCqASaOBP5Fnm0Ialt1cpg0BtwnhrYvOHOCALkeKXq1h
        FZDMceKYfLh/d1k+xEhFIKHPGxevzHSNjw==
X-Google-Smtp-Source: APXvYqylfHOqkWU3ftpd4sx7sBeSiuzylqb2aIYlnoIXhgDLdJTrg4fN/JqIAWiMZCi38UjMkMiwVQ==
X-Received: by 2002:a37:7005:: with SMTP id l5mr36899936qkc.334.1579267828641;
        Fri, 17 Jan 2020 05:30:28 -0800 (PST)
Received: from ?IPv6:2600:1000:b029:6649:b819:fcc3:734e:5994? ([2600:1000:b029:6649:b819:fcc3:734e:5994])
        by smtp.gmail.com with ESMTPSA id v4sm12909646qtd.24.2020.01.17.05.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 05:30:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 08:30:24 -0500
Message-Id: <D58FE32E-C5D9-4812-BCD8-BB3E6C4A7C55@lca.pw>
References: <6f924bf7-835b-0176-1b12-aff4f1f4be0e@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
In-Reply-To: <6f924bf7-835b-0176-1b12-aff4f1f4be0e@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 7:53 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> Can't we just use the zone_idx() stored in the memmap instead?

I am having a hard time to guess what that means. Care to elaborate?
