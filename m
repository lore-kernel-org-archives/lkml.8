Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC9C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77E42078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgD0Vqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:46:34 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:52642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgD0Vqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:46:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DEC1752AD;
        Mon, 27 Apr 2020 21:46:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger90_903895eead545
X-Filterd-Recvd-Size: 2218
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 21:46:30 +0000 (UTC)
Message-ID: <e9f534ef6c90d98d9cae0cbf133c8d83ecdce790.camel@perches.com>
Subject: Re: [PATCH v3.1] docs: filesystems: convert configfs.txt to ReST
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-usb@vger.kernel.org
Date:   Mon, 27 Apr 2020 14:46:29 -0700
In-Reply-To: <5f005c5a846b3fd4382a24166a1ba736ff697b86.1588022310.git.mchehab+huawei@kernel.org>
References: <c2424ec2ad4d735751434ff7f52144c44aa02d5a.1588021877.git.mchehab+huawei@kernel.org>
         <5f005c5a846b3fd4382a24166a1ba736ff697b86.1588022310.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 23:43 +0200, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document and section titles;
> - Use copyright symbol;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
> 
> Also, as this file is alone on its own dir, and it doesn't
> seem too likely that other documents will follow it, let's
> move it to the filesystems/ root documentation dir.
[]
> diff --git a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs.rst
[]
> +++ b/Documentation/filesystems/configfs.rst
> @@ -1,5 +1,6 @@
> -
> -configfs - Userspace-driven kernel object configuration.
> +=======================================================
> +Configfs - Userspace-driven Kernel Object Configuration

trivia: likely this "Configfs" shouldn't be capitalized.



