Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4134CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BF4207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgEYQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:33:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:60820 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbgEYQdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:33:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D3EB4A2;
        Mon, 25 May 2020 16:33:11 +0000 (UTC)
Date:   Mon, 25 May 2020 10:33:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: security: core.rst: add missing
 argument
Message-ID: <20200525103310.455f50e0@lwn.net>
In-Reply-To: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
References: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
        <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 20:39:17 -0400
Ben Boeckel <me@benboeckel.net> wrote:

> From: Ben Boeckel <mathstuf@gmail.com>
> 
> This argument was just never documented in the first place.
> 
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  Documentation/security/keys/core.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

jon
