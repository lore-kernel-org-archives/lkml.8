Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62791C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4050C246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1SIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:08:21 -0500
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:57186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgB1SIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:08:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8F291837F24A;
        Fri, 28 Feb 2020 18:08:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch56_2b73572b6e63e
X-Filterd-Recvd-Size: 1764
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 18:08:18 +0000 (UTC)
Message-ID: <a81f6072c8adfc5343fbc249f355c9ea5ced698e.camel@perches.com>
Subject: Re: [PATCH 4.14 111/237] tty: synclinkmp: Adjust indentation in
 several functions
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 28 Feb 2020 10:06:45 -0800
In-Reply-To: <20200228071239.GC2895159@kroah.com>
References: <20200227132255.285644406@linuxfoundation.org>
         <20200227132305.054909944@linuxfoundation.org>
         <11c17de7c525997ddddab995223828bdec8e8e93.camel@perches.com>
         <20200228071239.GC2895159@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 08:12 +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 27, 2020 at 07:55:49PM -0800, Joe Perches wrote:
> > On Thu, 2020-02-27 at 14:35 +0100, Greg Kroah-Hartman wrote:
> > > From: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > I believe these sorts of whitespace only changes should
> > not be applied to a stable branch unless it's useful for
> > porting other actual defect fixes.
> 
> I want to get clang build warnings down to the same level that gcc build
> warnings are, so that they become useful in detecting new issues.  That
> is why I add these types of patches to the stable trees.

New issues should be found in the current kernel.
Backporting whitespace changes is value-free.


