Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15DF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX9dpDaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgEOGu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgEOGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:50:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8107EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:50:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z1so536906pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=7XHHtEVCTq9EorQyCY4/UvWYJNsYHxtqr43sHEkAmWw=;
        b=HX9dpDaWHlXuHM6lY8eDCQGhpbMQf3qtPGEUQfyO+SU8a+5FrPc9GMheuX7QwikzKc
         /JfzAc/dal971cbYAgGsl3FZrm25dGi/um5phwKFPZNPohJ5YNfKIAtF3RwZCr7/cn+s
         o9Zk/zZoxxQKae3m+4F7j2PuPLbVPHRUd76xQTePvGvlybUeFySfi0V8SIDWVLGTav5a
         /lddvGb4c7N9e1ABTygLkqwvkQ1Oihv1qeKx/+EbcpG/Q5MP9g3poLEuqSazW7HSRrnC
         YVoqJReUflB6OU2c/L+ofQ/n+aUBWkZysQklwztl8eynhkstmR1PQmynQsMT9SHORTzt
         Z3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=7XHHtEVCTq9EorQyCY4/UvWYJNsYHxtqr43sHEkAmWw=;
        b=b9R7E0c0kC+SdFLP0/NbBpgtwO5j5NCPpTpdISuJD8lSXCPN9Xs4in1ppmIu62Bmr/
         oBsYim1lL26xURTGHA+sjT1bvwyTTH5hKVGNX82zRD1+xrtCxdMiIl+N7FBn3glO8sfd
         M5LPpZO57hYeedQiQuL3eNTLT4d58p+7oS+H6TbioB57LWlVFFoBy2bjlBr5sAgTcB7w
         6jjq5T6UwCc4ALhIkTwWI1IrFUDZoNv52s9Xa/v6EDskeAUCIrUWuJXWq5DwOOb/uUhB
         ra3F9U/R7nN8Cm64G8wJadGCczvMhcISN3ttSURpysCrC/zdF0surVU4n5fEkOKVRQm3
         xRyw==
X-Gm-Message-State: AOAM531uEkX/mUHrlL2OyEbIFJNQ0V169jgpvsXmHo9BWCytz6mj/idl
        SHQ569PfQ2HT6OnVrFK/+YoiEtIc
X-Google-Smtp-Source: ABdhPJwsPyoTCoo6JlALOTwHr0STJx1657ad1ODOumBxpC7KU7yIsP01keF2eGOOtO/Zn4G6jtEINw==
X-Received: by 2002:a63:5a41:: with SMTP id k1mr1858578pgm.424.1589525426898;
        Thu, 14 May 2020 23:50:26 -0700 (PDT)
Received: from localhost ([61.68.67.54])
        by smtp.gmail.com with ESMTPSA id p5sm964133pgk.28.2020.05.14.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 23:50:26 -0700 (PDT)
Date:   Fri, 15 May 2020 16:50:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Possibility of conflicting memory types in lazier TLB mode?
To:     Rik van Riel <riel@surriel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-Id: <1589523957.s4pf3vd48l.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Commit 145f573b89a62 ("Make lazy TLB mode lazier").

A couple of questions here (and I don't know the x86 architecture too=20
well let alone the ASID stuff, so bear with me). I'm assuming, and it=20
appears to be in the x86 manual that you can't map the same physical=20
page with conflicting memory types on different processors in general
(or in different ASIDs on the same processor?)

Firstly, the freed_tables check, that's to prevent CPUs in the lazy mode=20
with this mm loaded in their ASID from bringing in new translations=20
based on random "stuff" if they happen to speculatively load userspace=20
addresses (but in lazy mode they would never explicitly load such=20
addresses), right?

I'm guessing that's a problem but the changed pte case is not, is=20
because the table walker is going to barf if it sees garbage, but a=20
valid pte is okay.

Now the intel manual says conflicting attributes are bad because you'll=20
lose cache coherency on stores. But the speculative accesses from the=20
lazy thread will never push stores to cache coherency and result of the=20
loads doesn't matter, so maybe that's how this special case avoids the
problem.

But what about if there are (real, not speculative) stores in the store=20
queue still on the lazy thread from when it was switched, that have not=20
yet become coherent? The page is freed by another CPU and reallocated
for something that maps it as nocache. Do you have a coherency problem=20
there?

Ensuring the store queue is drained when switching to lazy seems like it=20
would fix it, maybe context switch code does that already or you have=20
some other trick or reason it's not a problem. Am I way off base here?

Thanks,
Nick
