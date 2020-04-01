Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6525FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4448620757
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgDACCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:02:50 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:56514 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731523AbgDACCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:02:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A66B180295A7;
        Wed,  1 Apr 2020 02:02:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swim09_52a8a4aeb7003
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2020 02:02:47 +0000 (UTC)
Message-ID: <b630a85e4f75e179cfa4a3cef4a4bc9fcca8109a.camel@perches.com>
Subject: Re: [PATCH 0/2] Documentation: Convert sysfs-pci to ReST
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 31 Mar 2020 19:00:53 -0700
In-Reply-To: <20200331164956.0e10b87e@lwn.net>
References: <cover.1585693146.git.vitor@massaru.org>
         <20200331164956.0e10b87e@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 16:49 -0600, Jonathan Corbet wrote:
> On Tue, 31 Mar 2020 19:28:55 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > Vitor Massaru Iha (2):
> >   Documentation: filesystems: Convert sysfs-pci to ReST
> >   Documentation: filesystems: remove whitespaces
> > 
> >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 44 ++++++++++---------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (81%)
[]
> When you convert a file to RST, you need to add it to the index.rst file
> as well so that it can be a part of the documentation build.

And if it's in the MAINTAINERS file, update the file type too.


