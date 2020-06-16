Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B13C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440CB2078D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgFPVFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:05:31 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:34358 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726804AbgFPVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:05:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 59FFD18029210;
        Tue, 16 Jun 2020 21:05:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: act63_4314fc526e02
X-Filterd-Recvd-Size: 2034
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Jun 2020 21:05:29 +0000 (UTC)
Message-ID: <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>, Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Date:   Tue, 16 Jun 2020 14:05:27 -0700
In-Reply-To: <20200616134507.GO31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-21-jim.cromie@gmail.com>
         <20200616134507.GO31238@alley>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > There are *lots* of ad-hoc debug printing solutions in kernel,
> > this is a 1st attempt at providing a common mechanism for many of them.
> 
> I agree that it might make sense to provide some common mechanism.
[]
> My problem with this approach is that it is too generic. Each class
> would have different meaning in each subsystem.
> 
> It might help to replace any existing variants. But it would be hard
> for developers debugging the code. They would need to study/remember
> the meaning of these groups for particular subsystems. They would
> need to set different values for different messages.
> 
> Could you please provide more details about the potential users?
> Would be possible to find some common patterns and common
> meaning of the groups?

I doubt the utility of common patterns.
Verbosity is common but groupings are not.

Look at the DRM patterns vs other groups.

$ git grep 'MODULE_PARM_DESC.*debug'


