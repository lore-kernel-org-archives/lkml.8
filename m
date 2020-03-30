Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9FC20A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgC3CpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:45:17 -0400
Received: from mx.sdf.org ([205.166.94.20]:65080 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgC3CpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:45:17 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02U2jC2R004428
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 02:45:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02U2jCVs023274;
        Mon, 30 Mar 2020 02:45:12 GMT
Date:   Mon, 30 Mar 2020 02:45:11 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, lkml@sdf.org
Subject: Another batched entropy idea
Message-ID: <20200330024511.GB4206@SDF.ORG>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
 <20200329174122.GD4675@SDF.ORG>
 <20200329214214.GB768293@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329214214.GB768293@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posting all those patches has depressurized my brain and let me think of 
additional ways to speed up batched random number generation, taking 
advantage of the fact that we don't have to anti-backtrack the key.

Rather than using the primary_crng and its lock, use a global 256-bit key, 
and give each CPU a disjoint 64-bit sequence number space.
(for (seq = raw_smp_processor_id(); ; seq += NR_CPUS).)

Then, when a CPU needs to refill its batched pool, copy over the constant, 
the global key, the per-cpu sequence number, do something TBD with the 
nonce, and run ChaCha on the result.

And voila, no global locking ever, unless a reseed interval has elapsed.

(We could also consider using 12 <= r < 20 ChaCha rounds for the batch.
After all, the best attack is <8 rounds and eSTREAM recommends 12.
16 might be reasonable.)
