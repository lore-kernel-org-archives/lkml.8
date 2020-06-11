Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38DC207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFKKng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:43:36 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:34874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgFKKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:43:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id ED0BC1800BE84;
        Thu, 11 Jun 2020 10:43:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean51_2014fa926dd3
X-Filterd-Recvd-Size: 1502
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 10:43:33 +0000 (UTC)
Message-ID: <3144e9630c814ca08cd940d7aff12aab822676d9.camel@perches.com>
Subject: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org,
        kristen.c.accardi@intel.com, mishi@linux.com,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org
Date:   Thu, 11 Jun 2020 03:43:32 -0700
In-Reply-To: <7688658f-1388-1c8a-11cf-54352c64e630@suse.cz>
References: <20200611083035.23008-1-sjpark@amazon.com>
         <7688658f-1388-1c8a-11cf-54352c64e630@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 10:32 +0200, Jiri Slaby wrote:
> On 11. 06. 20, 10:30, SeongJae Park wrote:
> > For example, as it seems at least you and I agree on the f-word to hug
> > replacement, we could add ``fuck||hug`` in the `deprecated_terms.txt` file to
> > avoid future spread of the f-words.
> 
> You will likely get my ACK on that, if that helps.

But likely not mine.

$ git grep -i '\bfuck' | wc -l
15


