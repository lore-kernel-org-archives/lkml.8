Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C44214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJoM4vYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395107AbgDPPMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729914AbgDPPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:28 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE1C0610D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LsVp9g60MKfk7ryW4q0HIe7K/ddM+Pems4kp0GQK70U=; b=IJoM4vYQ5wKB1Y075Ha4+wmc2i
        k6uFvNeMeGEhNXLuStb8tKAr3+l9czSLwKL1lsUBsPmw+7fYmxD8bmwEgjlYnsbcQRyA0ZZXW6sz2
        1gAQ4wJ+2bDi4McjHGBlX42yBILZdkzilBzmQS3KWoiOb/9wOfpi/cAhMwNa6hP6dzCIo3bbT2eIH
        4IrWjQB8AJQOqzC7znzE3gc/jHn3f6nL4JazYj6YIIAhiPXSt7JT44Ftjjuvv+PlyNWLWK94366GE
        4BnNk8chhxgVsTr30PAOBaaso3lXGACVb2JhPEiPqcu12LDTsibv3n7N2qX514v6Brs1s3bX7IV+f
        oum1WxiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BH-00046e-Lf; Thu, 16 Apr 2020 15:11:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CA88304D2B;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF7C52B0DE4BB; Thu, 16 Apr 2020 17:11:53 +0200 (CEST)
Message-Id: <20200416150752.569029800@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 0/7] objtool vs retpoline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Based on Alexandre's patches, here's a few patches that apply on top of my
other series:

  https://lkml.kernel.org/r/20200416114706.625340212@infradead.org

which seems to build a clean defconfig without ANNOTATE_NOSPEC_ALTERNATIVE on.

I've not tried to boot the thing, I'll leave that to the robots.

