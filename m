Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31379C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BEDC2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgFJWlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:41:22 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:38922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgFJWlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:41:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 77002182CD48C;
        Wed, 10 Jun 2020 22:41:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drink21_010d5ba26dce
X-Filterd-Recvd-Size: 1542
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 22:41:19 +0000 (UTC)
Message-ID: <cca874b227301e0bdfb49cb49c9d21f9fd2d0550.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 10 Jun 2020 15:41:18 -0700
In-Reply-To: <0f037983-6dad-859c-3ded-f7a0c86953df@broadcom.com>
References: <20200610202640.9020-1-scott.branden@broadcom.com>
         <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
         <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
         <33204a397b2d9316e09ae9829e637894b304ea00.camel@perches.com>
         <0f037983-6dad-859c-3ded-f7a0c86953df@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 15:08 -0700, Scott Branden wrote:
> Hi Joe,

Hi Scott.

> I do not know the history of the 2 block coding styles but here's a 
> radical thought:
> Change the coding-style document to pick a single coding style for ALL 
> block comment styles and
> use that going forward in checkpatch instead?

Opinions vary.
Good luck with that.
Seriously.

