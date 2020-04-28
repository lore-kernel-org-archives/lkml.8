Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1EBC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A39206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgD1SxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:53:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:41470 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgD1SxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:53:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6E7352D6;
        Tue, 28 Apr 2020 18:53:13 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:53:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] More changes for sphinx-pre-install script
Message-ID: <20200428125312.1bfb20f4@lwn.net>
In-Reply-To: <cover.1587478901.git.mchehab+huawei@kernel.org>
References: <cover.1587478901.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 16:31:04 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> As asked, I changed the sphinx-pre-install script to print a different message
> for the PDF minimal recommended version. This change itself was easy,
> but, while testing the patch, I noticed some new weird behaviors when python
> venv is used.
> 
> Basically, when using python venv, the venv environment will contain python
> itself. So, an attempt to create a new virtual environment to upgrade a version
> fails (at least here with Fedora 31). As I didn't notice this behavior before,
> maybe the problem was due to some Fedora upgrade.
> 
> In any case, the approach I took should be generic enough to work past eventual
> distro packaging differences.
> 
> -
> 
> At the end,  instead of a single patch, I ended needing to fix some other stuff, 
> for this to work better. Oh well...
> 
> The good news is that, at the cost of a slicely more complex logic, the script
> should now detect if a virtual environment works and to recommend activating
> a newer environment if it exists (instead of recommending to reinstall a
> venv using the name of an already-existing directory).
> 
> Mauro Carvalho Chehab (5):
>   scripts: sphinx-pre-install: only ask to activate valid venvs
>   scripts: sphinx-pre-install: change the warning for version < 2.4.4
>   scripts: sphinx-pre-install: change recommendation text if venv exists
>   scripts: sphinx-pre-install: fix a bug when using with venv
>   scripts: sphinx-pre-install: change the output order

Series applied, thanks.

jon
