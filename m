Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0739C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911592063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgFHSt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:49:28 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31392 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgFHSt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:49:27 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 8 Jun 2020 11:49:23 -0700
Received: from localhost (unknown [10.188.145.109])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BE76C4051D;
        Mon,  8 Jun 2020 11:49:24 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:49:24 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <mbenes@suse.cz>
Subject: Re: [PATCH v2 1/4] objtool: Move object file loading out of check
Message-ID: <20200608184924.GA1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz
References: <20200608071203.4055-1-jthierry@redhat.com>
 <20200608071203.4055-2-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200608071203.4055-2-jthierry@redhat.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:12:00AM +0100, Julien Thierry wrote:
> Structure objtool_file can be used by different subcommands. In fact
> it already is, by check and orc.
> 
> Provide a function that allows to initialize objtool_file, that builtin
> can call, without relying on check to do the correct setup for them and
> explicitly hand the objtool_file to them.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Reviewed-by: Matt Helsley <mhelsley@vmware.com>

> ---
>  tools/objtool/builtin-check.c |  7 ++++++-
>  tools/objtool/builtin-orc.c   |  8 +++++++-
>  tools/objtool/check.c         | 37 +++++++++++------------------------
>  tools/objtool/objtool.c       | 29 +++++++++++++++++++++++++++
>  tools/objtool/objtool.h       |  4 +++-
>  tools/objtool/weak.c          |  4 +---
>  6 files changed, 57 insertions(+), 32 deletions(-)
