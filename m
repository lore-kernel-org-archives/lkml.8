Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71086206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgFDQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:27:47 -0400
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:50000 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729641AbgFDQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:27:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3284018127182;
        Thu,  4 Jun 2020 16:27:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cat20_611517626d98
X-Filterd-Recvd-Size: 967
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 16:27:45 +0000 (UTC)
Message-ID: <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
Subject: Re: [PATCH] coccinelle: api: add kzfree script
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jun 2020 09:27:43 -0700
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> Check for memset() with 0 followed by kfree().

Perhaps those uses should be memzero_explicit or kvfree_sensitive.


