Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E55C43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CED520739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCTXPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:15:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:44072 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCTXPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:15:33 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 43AF5537;
        Fri, 20 Mar 2020 23:15:33 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:15:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?572X5qWa5oiQ?= <luochucheng@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v3] Translate Documentation/filesystems/debugfs.txt into
 Chinese
Message-ID: <20200320171532.5c1867e7@lwn.net>
In-Reply-To: <AJMA1gBkCACQq0nG1FQtEapJ.3.1584675294189.Hmail.luochucheng@vivo.com>
References: <20200319081307.14034870@lwn.net>
        <AJMA1gBkCACQq0nG1FQtEapJ.3.1584675294189.Hmail.luochucheng@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 11:34:54 +0800 (GMT+08:00)
罗楚成 <luochucheng@vivo.com> wrote:

> OK， I mistook an answer from you as acked-by.
> I won't use this tag next time.

Please, never add a tag like that unless the person named explicitly tells
you to.

Meanwhile, does the v3 you sent reflect the feedback from Alex Shi, or
should I wait for a v4?

Thanks,

jon
