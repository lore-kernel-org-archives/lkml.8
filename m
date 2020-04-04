Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CAC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48509206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 18:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEawZWJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgDDSwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 14:52:40 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:33427 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDDSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 14:52:39 -0400
Received: by mail-lj1-f171.google.com with SMTP id f20so10431289ljm.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hBMXqhkR3Bd5JwVi0rinAAJBGM9rUC/9TzS2AavdsaE=;
        b=eEawZWJ2ayk08oPbswgZWuozx6Ijh+Ywg9oScIkGbDjhxGyhf1oVbDqIqrcTpJA988
         a1q6xo0g9jvs8M6iIEvzHndqLyuf7sQN8764oNTZJK8P+OPFviBgefcAKYHY8JAmq2zV
         SpxyQ1rpaZK0RZUGG1neWz9nlbgANMmhF/ns9775kmnWxwzWpE0GA76KeatKo1UgD45o
         AXo9A2vijGJ8uCiaUrPZ/DPZoBO6y3xTWQvtTpzioRnl7ZGSZMqHQIgjSChGb2xIkAtK
         suUFx3iJG+ohi+AkhWjqQ+LmLNq7yYGaJ952fAUgiWDKq/6F6JgaxHQflI37oeFP1/I9
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hBMXqhkR3Bd5JwVi0rinAAJBGM9rUC/9TzS2AavdsaE=;
        b=KFkA6pyTD1LAqXNSdeUaAEdKVHZSIFnlNyPMB55JnzurK020qvJjM1xy8HHkwFmReK
         0RUlPthVbkNmGI0iNAyE5OHZ/wpUY5fJLmzyoIv4hiWF1wGkLqTrGr43aOfi8UvCIq55
         mU8uBL92RKOD3S1gWtgOWxlfhEkrArsSPuxia2jiaLAQMj3145MMPOnc6usttfmjITOU
         gRVv8wPBKC9ZC4tGj+FZTbiN92nZW4X/nqMmz9WuDYvfkiNMUr5sAvF1Ts92sBMYnqKJ
         K+XcqSY+cXlBg5r91FLK2eIx/2OMz370zeluYiqeNpf0AJD8X/svWKHCmKpyy0l8B+p2
         Knqw==
X-Gm-Message-State: AGi0PuaJ4r3jBDi+e4auCQJ8aejyGddLSWXOi8ELpLYAkF+WGdEouUBi
        wCho7weRp5im0uPRXZzvagA=
X-Google-Smtp-Source: APiQypJY7Z0bBl4GHlSA43yOpOdCsc++txL/kR5eOW2aOEE1Yew08Ncwu2teYb1M97/7lyo5CFz26Q==
X-Received: by 2002:a2e:998c:: with SMTP id w12mr8197378lji.57.1586026357027;
        Sat, 04 Apr 2020 11:52:37 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o2sm7293546ljm.2.2020.04.04.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 11:52:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 4 Apr 2020 20:52:29 +0200
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200404185229.GA424@pc636>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> ﻿Is there any need to similarly sanitize “size” to assure start + size doesn’t go past “end?”
> 
Why is that double check needed if all such tests are done deeper on stack?

--
Vlad Rezki
