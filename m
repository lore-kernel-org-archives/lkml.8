Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11485C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4052084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgDTV1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:27:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:53890 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDTV1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:27:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3DE57823;
        Mon, 20 Apr 2020 21:27:30 +0000 (UTC)
Date:   Mon, 20 Apr 2020 15:27:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/33] docs: update recommended Sphinx version to
 2.4.4
Message-ID: <20200420152729.40cb10e1@lwn.net>
In-Reply-To: <498f701c618f7d0cf5f0a37e5889ee926f7c8bf4.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
        <498f701c618f7d0cf5f0a37e5889ee926f7c8bf4.1586881715.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 18:48:30 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The Sphinx check script is already smart enough to keep
> working, with older versions, warning the users that
> an upgrade is recommended (and explaining how):
> 
> 	Sphinx version 1.7.9
> 	Warning: It is recommended at least Sphinx version 2.4.4.
> 	Detected OS: Fedora release 31 (Thirty One).
> 
> 	To upgrade Sphinx, use:
> 
> 		/usr/bin/virtualenv sphinx_2.4.4
> 		. sphinx_2.4.4/bin/activate
> 		pip install -r ./Documentation/sphinx/requirements.txt

Sigh...that version is all of a month and some old.  I hate to be pushing
people that hard on the upgrade treadmill.

I'm still looking over the set, and will probably apply this, but I think
we should consider tweaking this before 5.8:

 - Can we make the warning more explicit that 2.4.4 is needed *if you are
   generating PDF*?  Most people, I think, don't do that, and can live
   happily with an older version.

 - Perhaps the time has come to raise the lower bound to, say, 1.7?  That
   might let us get rid of a bit of cruft.

Thanks,

jon
