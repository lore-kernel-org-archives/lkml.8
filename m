Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677E3C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49461206F1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgEBUAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 16:00:53 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:47680 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728107AbgEBUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:00:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06F1B182CED5B;
        Sat,  2 May 2020 20:00:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glove61_5eb0837fb5c1c
X-Filterd-Recvd-Size: 1433
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 20:00:50 +0000 (UTC)
Message-ID: <57b725f495e422e80c062d2edd90abe99f40fd51.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Wang YanQing <udknight@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Date:   Sat, 02 May 2020 13:00:49 -0700
In-Reply-To: <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
References: <20200502185421.GB9082@udknight>
         <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-02 at 21:40 +0200, Markus Elfring wrote:
> > The check doesn't support below formats and it will emit diagnostics info for them:
[]
> Will the tolerance (and support) grow for such quotation character alternatives?

No.

> Does this information indicate a need to split possible changes into
> separate update steps?

No.

> * Which formula do you propose for the length calculation?

None.

