Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9FAC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E03120A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgELHf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:35:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A78C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 00:35:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0E4AC2A0A56;
        Tue, 12 May 2020 08:35:52 +0100 (BST)
Date:   Tue, 12 May 2020 09:35:31 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: Re: [PATCH v7 1/7] i3c: master: secondary master initialization
 document
Message-ID: <20200512093531.6c348b8e@collabora.com>
In-Reply-To: <DM5PR07MB3196C4B887D5D4720971BF11C1BE0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202759-5677-1-git-send-email-pthombar@cadence.com>
        <20200511180500.6e1c4453@collabora.com>
        <DM5PR07MB3196C4B887D5D4720971BF11C1BE0@DM5PR07MB3196.namprd07.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 05:03:32 +0000
Parshuram Raju Thombare <pthombar@cadence.com> wrote:

> >> Document describing secondary master initialization,
> >> mastership handover and DEFSLVS handling processes.  
> >
> >Thanks for doing that, but you probably didn't try to compile the doc
> >(the formatting is all messed up).
> >
> ># make htmldocs  
> 
> Yes, it looks messed in email but I built html format of doc and formatting was ok.

I did build the html doc and it's not ok here.

> May be because some tab/space issue it is looking  messed up in email.

No, it's really the html output I'm complaining about.
