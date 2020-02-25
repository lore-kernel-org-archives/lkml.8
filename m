Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C534CC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A603921D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgBYKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:05:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:53034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgBYKFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:05:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A611B738;
        Tue, 25 Feb 2020 10:05:06 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:05:01 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Some cross-reference fixes due to fixes renames
Message-ID: <20200225030501.48770bc2@lwn.net>
In-Reply-To: <cover.1582361737.git.mchehab+huawei@kernel.org>
References: <cover.1582361737.git.mchehab+huawei@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 10:00:00 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are some references that got broken due to renames
> (mostly .txt to .yaml and .rst, but also some files got moved
> to other directories).
> 
> The first patch actually contains a fix for
> documentation-file-ref-check, with currently reports several
> false positives.
> 
> Mauro Carvalho Chehab (7):
>   scripts: documentation-file-ref-check: improve :doc: handling
>   docs: dt: fix several broken references due to renames
>   docs: fix broken references to text files
>   docs: adm1177: fix a broken reference
>   docs: fix broken references for ReST files that moved around
>   docs: remove nompx kernel parameter and intel_mpx from index.rst
>   docs: gpu: i915.rst: fix warnings due to file renames

OK, I've applied the first and the last of those.  Patches 2 and 4 have
already been applied elsewhere.  Parts 3 and 5 have horrific conflicts
against docs-next, so I've passed them by.  That leaves nompx, which had
a comment from Dave Hansen.

Thanks,

jon
