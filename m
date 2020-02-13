Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B108521734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBMRnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:43:42 -0500
Received: from ms.lwn.net ([45.79.88.28]:46672 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMRnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:43:41 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B51A2D8;
        Thu, 13 Feb 2020 17:43:41 +0000 (UTC)
Date:   Thu, 13 Feb 2020 10:43:40 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: bootconfig: fix Sphinx block warning
Message-ID: <20200213104340.787b6460@lwn.net>
In-Reply-To: <20200210115410.292565d4@gandalf.local.home>
References: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
        <20200210161647.416ce0dcd0710f4349a665b1@kernel.org>
        <20200210115410.292565d4@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 11:54:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Jon,
> 
> Would you like to take this through your tree?
> 
>   https://lore.kernel.org/r/07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org

Will do.

jon
