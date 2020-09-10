Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033DFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18CA2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599754964;
	bh=eYB7NVQ0w8fEmrT5JGCldNlkgVi29FDwCgpinZyi2XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v1xyDdIKA89PK3XFXVrx642ofRiIBgSJ0qiNnrJgeJ5Bel1gIDB2mBBIoAx923uiR
	 tC0rnfmGbhCA2k8EEgPVS21Oci6Rgns6pLABcDcOqrqs3n5T/qi3sR0APNZd+7Xsdg
	 t1Px2NggvO4n5+abp016Nn8K2WqNbblR7oacYR1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJQWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgIJQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:20:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84D920BED;
        Thu, 10 Sep 2020 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754735;
        bh=eYB7NVQ0w8fEmrT5JGCldNlkgVi29FDwCgpinZyi2XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHIvIfNsKVPc9XIzCo8yq2jod8gfmfg1He2Wu7Vdq/HqnG4w2/SjjTAf7quC2jVdh
         6lWNtY4ubxIJkErPeecN+N0iHCMn36Du911dNUbYJSDSPHFfwuzvQWA4u633Zt3v4c
         lKUVIfb8nqPfA+0oZiQCwRXygSk5ApyiR2M5NOCI=
Date:   Thu, 10 Sep 2020 18:19:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/2] idr: Document calling context for IDA APIs
 mustn't use locks
Message-ID: <20200910161902.GB1180022@kroah.com>
References: <20200910055246.2297797-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910055246.2297797-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:52:45PM -0700, Stephen Boyd wrote:
> The documentation for these functions indicates that callers don't need
> to hold a lock while calling them, but that documentation is only in one
> place under "IDA Usage". Let's state the same information on each IDA
> function so that it's clear what the calling context requires.
> Furthermore, let's document ida_simple_get() with the same information
> so that callers know how this API works.

Thank you for this, I always have to go look it up too...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
