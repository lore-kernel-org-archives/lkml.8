Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC00C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8230420675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naJ+eFJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDERXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:23:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDERXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:23:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id k21so12192576ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yPEjuWyQ9aW5UfsWY/0pffS6lX/UZzplajlsr7ydC3s=;
        b=naJ+eFJhwX0b3neaEjeSBsB2hvbtuO2W56Cvko0OKp8VaOUx3T/gqXLSofntRMaMuJ
         X0k0OsxuPeUGM0DoqLwLLvTgs+7mSNF5fYJKWWWZEZtgjjpJxDXijV0Rvew8rawq7BDx
         kMDbQOMquRDvD535LSe6/pxWICoQbZPWQOa2z/d98zvon8i0JWDbGakkwP61bY/MRBQh
         zpgM/W7Tx/4+lfFuTxVeExRKAbjJs75is68ec4R5m41Nssh3SnSCimCRb4VEqlpTHTBx
         GDQrc97Axh/lNy34j/YOdsi1yU9h+7jbqqSt5ci7JzgBfTM0Zr+siA3ZYr1m58XuEqiZ
         UKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yPEjuWyQ9aW5UfsWY/0pffS6lX/UZzplajlsr7ydC3s=;
        b=CzjxMvuyoM4mQKycXyS7QmMtCmLa2MeFsikZJZhtCfDOumGtnC2yZbKXStQQ7b4TgM
         +BRH1l+Bwcnqa8rNXj7M8OySuseSmCCRg/xzpSE8iFoDjPSJN1cjWYhAVpNr3GvxKYw/
         thiBaViei7onszs+7aVV7SV9kwN8R+MAiXh94/bvC5HZxkaxyTeB/Ck1l6Dj4gpwKYR/
         aeWY17qXncJ1FtunKHmTGEHqWBS79qzvQp430k/B/aB7ABRatYVS38tCGQG0fDvtuuyj
         Lhs86x4TZNlH3u8jhVNNIjxsnGbpb7SwDCdiHvajQ4QjVJyflrtLKDRIcfuOBftnt9Wg
         gQig==
X-Gm-Message-State: AGi0PubbY6Jm4XaTPLrNAJlPTgvUDd1PLK8WgAlmkCs7Hyo1Whk0DH+o
        RngNqYi+O2/sJCIjlrqcMzk=
X-Google-Smtp-Source: APiQypJ3BTuzzIA14hwtV3hrEpnUo9BzlhPnRKeMd3Ofkz9hKlOrpb8TiiAzbiwNMty3Px+5pqK9jA==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr10222447lji.76.1586107410011;
        Sun, 05 Apr 2020 10:23:30 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id k4sm9954742lfo.47.2020.04.05.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:23:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 5 Apr 2020 19:23:15 +0200
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200405172315.GA8404@pc636>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
 <20200404185229.GA424@pc636>
 <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 11:25:45PM -0600, William Kucharski wrote:
> 
> 
> > On Apr 4, 2020, at 12:52 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> >> 
> >> ﻿Is there any need to similarly sanitize “size” to assure start + size doesn’t go past “end?”
> >> 
> > Why is that double check needed if all such tests are done deeper on stack?
> 
> If such tests ARE performed, then it doesn't matter to me whether it is checked before or after,
> it just seems that nothing checks whether start + size makes some sort of sense with respect
> to end.
> 
> I admit I didn't walk through all the routines to see if such a check would be superfluous.
> 
Yes, we check it:

<snip>
static __always_inline bool
is_within_this_va(struct vmap_area *va, unsigned long size,
 unsigned long align, unsigned long vstart)
{
 ...
 return (nva_start_addr + size <= va->va_end);
}
<snip>

--
Vlad Rezki
