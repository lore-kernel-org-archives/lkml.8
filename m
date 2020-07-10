Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5253C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D4B207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389791;
	bh=PIClI0sFL2uSyFyo6uiNIL8cUhLjKb6+sOqjCYDTVAg=;
	h=Date:From:To:To:To:Cc:Cc:Subject:In-Reply-To:References:List-ID:
	 From;
	b=VOs9MUnrbakuf2EsPsDs3YK6XRtqRWcNZI+U5H74naN9yssUa4oDtjwYv1DiOaoP9
	 tOreWSlgCz6l/rQbUH491lTCsLMXXGwZ2IG3laHm0yXRkTl+5JoIHD/c6bTG5pTHTg
	 ymCeGgC86QsqCX5eBgbRprP52xMZg2vbzzSJGWqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgGJODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgGJODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:03:04 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DCC2082E;
        Fri, 10 Jul 2020 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594389784;
        bh=PIClI0sFL2uSyFyo6uiNIL8cUhLjKb6+sOqjCYDTVAg=;
        h=Date:From:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
        b=eTjjUsY0sgCe9aVrzVIDtVhGdxw7Xd005E9N0tEJwwAGJ0RZLqApWE1xfE8/AUqi8
         6k5JSCawuGRflxK/t/oCaTDgoDHQSLuKmKRoYF/7J3rox5KB8tgv9e9lsDzRDwguJh
         WN9jrO4UiKzwx3HPTkKK44moqnmpG4FCVDxobS7k=
Date:   Fri, 10 Jul 2020 14:03:03 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 4/4] intel_th: Fix a NULL dereference when hub driver is not loaded
In-Reply-To: <20200706161339.55468-5-alexander.shishkin@linux.intel.com>
References: <20200706161339.55468-5-alexander.shishkin@linux.intel.com>
Message-Id: <20200710140304.72DCC2082E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 39f4034693b7 ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices").

The bot has tested the following trees: v5.7.7, v5.4.50, v4.19.131, v4.14.187, v4.9.229, v4.4.229.

v5.7.7: Build OK!
v5.4.50: Build OK!
v4.19.131: Build OK!
v4.14.187: Failed to apply! Possible dependencies:
    c2d2c7de972d7 ("intel_th: Don't touch switch routing in host mode")

v4.9.229: Failed to apply! Possible dependencies:
    c2d2c7de972d7 ("intel_th: Don't touch switch routing in host mode")

v4.4.229: Failed to apply! Possible dependencies:
    c2d2c7de972d7 ("intel_th: Don't touch switch routing in host mode")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
