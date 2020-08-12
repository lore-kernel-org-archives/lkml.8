Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F80C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE3F207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHLNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:18:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:35640 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:18:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5578377F;
        Wed, 12 Aug 2020 13:18:02 +0000 (UTC)
Date:   Wed, 12 Aug 2020 07:18:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        jforbes@fedoraproject.org
Subject: Re: Documentation: build failure with sphinx >= 3.0.0: exception:
 cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c'
Message-ID: <20200812071801.71d44fe2@lwn.net>
In-Reply-To: <579fbb36-515d-5af4-f7dc-c092d29fddd8@darmarit.de>
References: <20200408113705.GB1924@ArchLinux>
        <20200408132505.52e595bc@lwn.net>
        <20200408233450.GA14923@debian>
        <20200809132327.GA145573@eldamar.local>
        <20200812073059.GA509953@eldamar.local>
        <579fbb36-515d-5af4-f7dc-c092d29fddd8@darmarit.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 10:21:40 +0200
Markus Heiser <markus.heiser@darmarit.de> wrote:

> @jon, do you have time to implement a patch?
> .. sorry, I'am in a hurry :o

This is on my list ... but life is busy at the moment.  I would not be
distressed if somebody beat me to it.

jon
