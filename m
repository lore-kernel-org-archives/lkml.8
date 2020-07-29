Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626CBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4414E205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgG2MTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:19:41 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54724 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:19:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 9E8F214A6;
        Wed, 29 Jul 2020 14:19:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2yM3dG0QQnhW; Wed, 29 Jul 2020 14:19:38 +0200 (CEST)
Received: from function (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id EC929148D;
        Wed, 29 Jul 2020 14:19:37 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k0l3Y-0051na-9a; Wed, 29 Jul 2020 14:19:36 +0200
Date:   Wed, 29 Jul 2020 14:19:36 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] staging/speakup: Move out of staging
Message-ID: <20200729121936.6ajd3b6vc5oox2aw@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20200729003531.907370-1-samuel.thibault@ens-lyon.org>
 <20200729120533.GA2883831@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729120533.GA2883831@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mer. 29 juil. 2020 14:05:33 +0200, a ecrit:
> On Wed, Jul 29, 2020 at 02:35:31AM +0200, Samuel Thibault wrote:
> > The nasty TODO items are done.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Now applied, thanks for all of the work so far.
> 
> I will be glad to merge patches for this subsystem to Linus if you want
> me to collect them.  If so, feel free to forward them on to me, or send
> me a pull request.

Ok!

Thanks,
Samuel
