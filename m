Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509AAC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ADA20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgCDU0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:26:37 -0500
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:38018 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387926AbgCDU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:26:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78662100E7B45;
        Wed,  4 Mar 2020 20:26:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hot73_565b5f8ad3729
X-Filterd-Recvd-Size: 1567
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Mar 2020 20:26:33 +0000 (UTC)
Message-ID: <9c1c1b5e3a59705a501cbb713f1d0e44cc71e788.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 12:24:59 -0800
In-Reply-To: <20200304131035.731a3947@lwn.net>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
         <20200304131035.731a3947@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 13:10 -0700, Jonathan Corbet wrote:
> On Wed,  4 Mar 2020 08:29:50 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
[]
> > ./scripts/get_maintainer.pl --self-test complains with 27
> > warnings on Documentation/filesystems/ of this kind:
> > 
> >   warning: no file matches F: Documentation/filesystems/...
[]
> Sigh, I need to work a MAINTAINERS check into my workflow...

checkpatch already bleats a warning on patches with any
file move or rename.

It would be difficult to impossible to implement a real
pattern verification mechanism in checkpatch though.


