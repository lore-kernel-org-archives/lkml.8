Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF278C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C4920820
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="En42fRWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFER5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFER5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:57:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F98C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cya1qLD0P42aWQWkjKaY3QBjbUjBXUzgtuTZm/iNADQ=; b=En42fRWl5UKCNeQMK05PeZcQLx
        j53xRdO5uhWPa7XSB5c1osSy0lkBPGkg2Y33eyaBgp82Gdizv+FfpUQFlFVM5Ei3FZIBKCa6JimAK
        OoJHw+wGMWtKkU/prBbAxEcIDHofa9S5E1IIEckGl9MlnYqZabpB9V3o47/fAKErnn+bZIak4ezXq
        unFjrbJ6LBU7z+7FXHNJQpGFFBEA5PYa3bzm0W2Y797F8z6iCN/E9l5WCgs/YCL/UavxGkiK1MgzM
        OagCjCR507RjgfBrSw5X8mxq6DseN26L73pTyYJi8Ov7PK19dVOZHsE9rnUihCQMC2TL7XXitfja5
        MgMdhSOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhGac-00046K-7m; Fri, 05 Jun 2020 17:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B58B3301DFC;
        Fri,  5 Jun 2020 19:57:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9139A21A7522A; Fri,  5 Jun 2020 19:57:08 +0200 (CEST)
Date:   Fri, 5 Jun 2020 19:57:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        David.Laight@ACULAB.COM
Subject: Re: [PATCH V3 1/3] perf/x86/intel/uncore: Fix oops when counting IMC
 uncore events on some TGL
Message-ID: <20200605175708.GR2750@hirez.programming.kicks-ass.net>
References: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks!
