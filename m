Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3713C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D4B214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgCSONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:13:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:33578 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbgCSONJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:13:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7EB54384;
        Thu, 19 Mar 2020 14:13:08 +0000 (UTC)
Date:   Thu, 19 Mar 2020 08:13:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chucheng Luo <luochucheng@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v3] Translate Documentation/filesystems/debugfs.txt into
 Chinese
Message-ID: <20200319081307.14034870@lwn.net>
In-Reply-To: <20200319032057.29833-1-luochucheng@vivo.com>
References: <20200319032057.29833-1-luochucheng@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 11:20:43 +0800
Chucheng Luo <luochucheng@vivo.com> wrote:

> Translate debugfs.txt into Chinese and link it to the index.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Excuse me but ... where did this come from?  I'm far more likely to apply
this patch than ack it.  You can't just make up tags like this.

Thanks,

jon
