Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D682C207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFKSWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:22:45 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:40186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgFKSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:22:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4AEF718111E54;
        Thu, 11 Jun 2020 18:22:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bell15_120039f26dd5
X-Filterd-Recvd-Size: 1313
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 18:22:42 +0000 (UTC)
Message-ID: <fcd6d2c34c082ee3dd21a1c3bfd558306e566261.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: perform commit ID check from external to
 git folder
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Matteo Croce <mcroce@redhat.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 11:22:41 -0700
In-Reply-To: <20200611125957.1993741-1-leon@kernel.org>
References: <20200611125957.1993741-1-leon@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 15:59 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The execution of scripts/checkpatch.pl in folder outside of git produces
> complains about invalid commit ID, despite having valid one.

There is already a slightly different test for this in -next
It also uses a environment test for GIT_DIR.

Try that one.  


