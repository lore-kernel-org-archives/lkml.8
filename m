Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EACC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E3520650
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgCKOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:32:33 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:52068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729473AbgCKOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:32:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id ED76818033F6E;
        Wed, 11 Mar 2020 14:32:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mark59_160635481ae36
X-Filterd-Recvd-Size: 1361
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 14:32:31 +0000 (UTC)
Message-ID: <8689ac477bce81aec15a9b8d89192b91fb3d3adb.camel@perches.com>
Subject: Re: [PATCH -next 011/491] ARM/QUALCOMM SUPPORT: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 11 Mar 2020 07:30:48 -0700
In-Reply-To: <c9ae6eed-6320-56c2-6248-b9c52e7d34d0@free.fr>
References: <cover.1583896344.git.joe@perches.com>
         <2e6818291503f032e7662f1fa45fb64c7751a7ae.1583896348.git.joe@perches.com>
         <c9ae6eed-6320-56c2-6248-b9c52e7d34d0@free.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 09:46 +0100, Marc Gonzalez wrote:
> On 11/03/2020 05:51, Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> 
> What is the rationale for such a change?
> Portability to different tool-chains? Something else?

Converting /* fallthrough */ style comments to the pseudo-keyword fallthrough
allows clang 10 and higher to work at finding missing fallthroughs too.


