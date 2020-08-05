Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F66C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38B22073E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596592534;
	bh=GQBFudUaU9AYZlNlsE9DdBp6AkKsppkVxP6jf7JK/DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VfkrlXOGjr8HJCNzfuRYJTVdpbxXJJNDKSxZpEGPmGg8hCeLZs7gpaYqtm8v/IIO3
	 uoRWNUsba24ubPtokHeXp0QSgIuA/ITBJ5mcLq8uPJYOCr2/ErwKz8y7ML9n6KlNsn
	 lu/jWt7ITWqmP31oUM4lKvYBglM+oZRksHKUPkqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHEBzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgHEBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:55:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2488C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 18:55:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jp10so18034971ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teUqnhvEEAahNtC2XP50lOuVEmqnMGxKLPq+FU+cEiM=;
        b=Y14qR7M1mTFlhH4hvtVfRx09MmQ4b1sevV6B6lU36YQpbuX+FciNawWcbEGxNa03x1
         Yvu88CrCbYAXh9F8u04ogOHj2ABubxrcSSz2lVZ2FnJBjzQsMOos/flpihX9ukNbUQsr
         KjP12bj6BraPuj8Csj9tnJowO++TzDyCwtcB2U4Uy6CU4STDOUzzWL/KOJxDFsdKcVxy
         XXO0Ox9visik6a8MO5EKqY6y0rLptK4Jpsi0fiaI4Bf/+H8Nv657tB7fqzglZDem075x
         onHhcGUbbXphsR7Ixv+Pm6uzRdkc9GBw/4PdrztXiAfQ3B9Df4cvLoteruw9sVitG14v
         ocTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=teUqnhvEEAahNtC2XP50lOuVEmqnMGxKLPq+FU+cEiM=;
        b=P2Rgb0q710JZhXV0Hvw5Mk9m3+tTRQSl/S0mkVPemOgXok1qcr7cjURjNTS59uLzMf
         3kJB37twSh1l73Z7UpRJrT/OFE4PDaWP0NXXZAd+lDmQ6dXL6gpYmqaleI17cWqTKv1n
         XV1ZOKZuqPntVP60+VMHzIY0AqspOBpE3w5El+MLVUZjRZDZB6TvT8hdRWMZ4oBb/qmg
         7DxUWUIOD2bxkS3pxLFZcYpkpr8eiAT5AZJwYiwprlY/WNqO4V4u4DVlmD+EnMjiBE9y
         HuhPNIsMKES9+YWzXI4WCvdCOeni0sXhIGgaAaj8h7RS/qbdMH7ElKcVLYKb6t4dyivc
         iPng==
X-Gm-Message-State: AOAM531CdMOcTE0mZmxwV/qdxIRPqQrcjYCbGg4jYAD1Ob7mfe6wPgvU
        4+5+iCvKwXRrzfqULMXF5QI=
X-Google-Smtp-Source: ABdhPJzB7MIo5hvV3vzzmVQnNfWMUhW4reKmbOGQvPr0fAMsAaYNMIy8F1s/PjpHzyZL1w1YLOyezQ==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr914542ejc.351.1596592531489;
        Tue, 04 Aug 2020 18:55:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x1sm456763ejc.119.2020.08.04.18.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:55:30 -0700 (PDT)
Date:   Wed, 5 Aug 2020 03:55:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched/fifo changes for v5.9
Message-ID: <20200805015528.GA1620836@gmail.com>
References: <20200804111025.GA1556312@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804111025.GA1556312@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> When merging to the latest upstream tree there's a conflict in drivers/spi/spi.c,
> which can be resolved via:
> 
> 	sched_set_fifo(ctlr->kworker_task);

Correction, the suggested resolution would be:

	sched_set_fifo(ctlr->kworker->task);

Thanks,

	Ingo
