Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E0120656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGORke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGORke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:40:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:40:34 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1C4012E2;
        Wed, 15 Jul 2020 17:40:33 +0000 (UTC)
Date:   Wed, 15 Jul 2020 11:40:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Schulz <paul@mawsonlakes.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sound/pci/hda: Changes 'blacklist/whitelist' to
 'blocklist/allowlist'
Message-ID: <20200715114032.057fd63d@lwn.net>
In-Reply-To: <20200715162204.104646-1-paul@mawsonlakes.org>
References: <20200715162204.104646-1-paul@mawsonlakes.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 01:52:04 +0930
Paul Schulz <paul@mawsonlakes.org> wrote:

> -static bool pm_blacklist = true;
> -module_param(pm_blacklist, bool, 0644);
> -MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
> +static bool pm_blocklist = true;
> +module_param(pm_blocklist, bool, 0644);
> +MODULE_PARM_DESC(pm_blocklist, "Enable power-management blocklist");

This will break any user specifying this parameter now, which isn't
something you want to do, methinks...

jon
