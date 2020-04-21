Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2976CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1920747
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587498986;
	bh=Q38SnWOvz4AnBx07LWYwNxGnnvvT7pWqjzliwW5rQB8=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=UwYpEgujkSf/gKxBswRvIE8xbGY2R6zg4vJPgh/7WLEAMS2ziXzTQtbZMd5rpvYjE
	 yyWzbPciUyFb32vlL/i25MPcqzewLWKQPqrEg0QAOJxagBjFJp/5IkelA6x6t2QADR
	 0tvIaWVHvuk1nTLGkiISakH0pLdiMH73NkHGmUYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgDUT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgDUT4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:56:22 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E3820774;
        Tue, 21 Apr 2020 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587498982;
        bh=Q38SnWOvz4AnBx07LWYwNxGnnvvT7pWqjzliwW5rQB8=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=ruVji9SgCdr/8ZmxfPRHsSVZjVD3JIF+5KINhiTaybm4z3AfwHG9N5JNss7Z+O9+8
         YzdWM2rSo8HxSW8DEUzfozH+luyTZBCPq1DwbYxaFxclAO51U+FHPIhL7tttT5RYIc
         chKRyXDRWJnBzBHQuUpEDG+cUVtqKC2JV7oh+29A=
Date:   Tue, 21 Apr 2020 19:56:21 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: SVM: avoid infinite loop on NPF from bad address
In-Reply-To: <20200417163843.71624-2-pbonzini@redhat.com>
References: <20200417163843.71624-2-pbonzini@redhat.com>
Message-Id: <20200421195621.E9E3820774@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 05d5a4863525 ("KVM: SVM: Workaround errata#1096 (insn_len maybe zero on SMAP violation)").

The bot has tested the following trees: v5.6.5, v5.5.18, v5.4.33.

v5.6.5: Build OK!
v5.5.18: Failed to apply! Possible dependencies:
    Unable to calculate

v5.4.33: Failed to apply! Possible dependencies:
    Unable to calculate


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
