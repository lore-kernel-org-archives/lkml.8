Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF8C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C29E206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgGMRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgGMRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:24:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14042C061755;
        Mon, 13 Jul 2020 10:24:25 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BB61460C;
        Mon, 13 Jul 2020 17:24:24 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:24:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation/filesystems/proc.rst: copy-editing
 cleanup
Message-ID: <20200713112423.41706f1a@lwn.net>
In-Reply-To: <a5f126e6-d67a-154a-1c87-d8f07542a21c@infradead.org>
References: <a5f126e6-d67a-154a-1c87-d8f07542a21c@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 23:49:57 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Clean up Documentation/filesystems/proc.rst.
> 
> This is basically fixing lots of spelling, grammar, punctuation,
> typos, spacing, consistency, section numbering, and headings.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/filesystems/proc.rst |  111 +++++++++++++--------------
>  1 file changed, 55 insertions(+), 56 deletions(-)

Applied, thanks.

jon
