Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9CB208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGDVvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:51:12 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:57746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgGDVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:51:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E202D18224D8E;
        Sat,  4 Jul 2020 21:51:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side00_500090426e9d
X-Filterd-Recvd-Size: 1420
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat,  4 Jul 2020 21:51:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 04 Jul 2020 14:51:09 -0700
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
In-Reply-To: <1593897917.7058.11.camel@HansenPartnership.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1593897917.7058.11.camel@HansenPartnership.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <7eb36e09e13138d3e349e9657039644f@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [47.151.133.149]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-04 14:25, James Bottomley wrote:
> On Sat, 2020-07-04 at 13:02 -0700, Dan Williams wrote:
> [...]
>> diff --git a/Documentation/process/inclusive-terminology.rst
[]
> Could we just lose this entire document?

Yes please.
