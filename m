Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ED2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AFE20760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgFIQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:08:42 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:35844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgFIQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:08:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BF78480DEF63;
        Tue,  9 Jun 2020 16:08:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank82_4f0fd4926dc3
X-Filterd-Recvd-Size: 2004
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 16:08:37 +0000 (UTC)
Message-ID: <77778948acc1f475e82ad36d015ba76dc96352ff.camel@perches.com>
Subject: Re: [PATCH 17/17] scripts/spelling.txt: Add descriptors correction
From:   Joe Perches <joe@perches.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Xiong <xndchn@gmail.com>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 09:08:36 -0700
In-Reply-To: <20200609124610.3445662-18-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
         <20200609124610.3445662-18-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-09 at 13:46 +0100, Kieran Bingham wrote:
> After coming across the s/decriptors/descriptors/ spelling error twice,
> a scan of the tree showed it was a pervasive mistake.
[]
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -404,6 +404,7 @@ decendants||descendants
>  decompres||decompress
>  decsribed||described
>  decription||description
> +decriptors||descriptors

spelling.txt does not check singular and plural
uses unless each is described separately so please
add the singular one too:

decriptor|descriptor

$ git grep -i -w decriptor | wc -l
18
$ git grep -i -w decriptors | wc -l
12

