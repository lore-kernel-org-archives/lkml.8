Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53186C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3224D20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgG0XPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:15:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:58168 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgG0XPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:15:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C4A72E7;
        Mon, 27 Jul 2020 23:15:08 +0000 (UTC)
Date:   Mon, 27 Jul 2020 17:15:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] scripts/kernel-doc: optionally treat warnings as errors
Message-ID: <20200727171506.1e05a50a@lwn.net>
In-Reply-To: <8048e2c6-8c2d-f41e-972b-9f4730aa6726@linux.intel.com>
References: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
        <20200727162805.3ef9bacf@lwn.net>
        <8048e2c6-8c2d-f41e-972b-9f4730aa6726@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 18:09:21 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> Both points were covered by the sentence "A command-line option is
> provided to the kernel-doc script, as well as a check on environment
> variables to turn this optional behavior on".


Making that more prominent would be good, but a changelog like this should
say *which* command-line option was provided, and *which* environment
variables are checked.  Don't make people go digging through the patch to
figure it out.  See what I'm getting at?

Thanks,

jon
