Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7632072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gv8cHf4Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dbAK9Q2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCMP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:26:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59234 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbgCMP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:26:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0BFD98EE111;
        Fri, 13 Mar 2020 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584113202;
        bh=o2W1sIitaU9EdMMf7U/2e2clLPQy2HbQwjU0rL7X0iQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gv8cHf4ZwR9mcg343YvWSC7ZCFfIMi6lw6evmB3SL3WUHeoAhM9RLYI06LvuAo0bQ
         Q2IDvKUZ0gq8oTRfsxLz7RHyxjYrMLZlMxNFouhHc/lwbbVJtyvqFqC3Q6J2MaS3h6
         UwuZrAovNRVNDWwlA5nOPm+WV44/zmgRF5lG4OlI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GdPuLdhlpgJi; Fri, 13 Mar 2020 08:26:41 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 72C5B8EE10C;
        Fri, 13 Mar 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584113201;
        bh=o2W1sIitaU9EdMMf7U/2e2clLPQy2HbQwjU0rL7X0iQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dbAK9Q2TaWRlaousAmgnhiiqT47e1H1BdW24PAEymd/Ql5bZrkYG4e/TY+Zg8789O
         3b8WUUcONzKrgpvbJJzPG0F8SDUYNNFk4zDmv2WDJK2Z9svFOdsWjm/F7PpxmDEfRs
         sHYcTix6JgmNblfMxNXFJrSJuNNqYgpaQpm9s6xQ=
Message-ID: <1584113200.3391.16.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Date:   Fri, 13 Mar 2020 08:26:40 -0700
In-Reply-To: <87wo7ojnrl.fsf@intel.com>
References: <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com>
         <20200313093548.GA2089143@kroah.com>
         <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
         <20200313100755.GA2161605@kroah.com>
         <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
         <20200313103720.GA2215823@kroah.com>
         <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com>
         <20200313081216.627c5bdf@gandalf.local.home> <874kusl50q.fsf@intel.com>
         <20200313145206.GE225435@mit.edu> <87wo7ojnrl.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 17:08 +0200, Jani Nikula wrote:
> On Fri, 13 Mar 2020, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> > On Fri, Mar 13, 2020 at 04:10:29PM +0200, Jani Nikula wrote:
> > > 
> > > Have you considered whether the eligibility for running and
> > > voting should be made the same? As it is, absolutely anyone can
> > > self-nominate and run.
> > 
> > That's always been the case.  However, at least historically,
> > people who weren't physically present has never been successful.
> 
> Oh? May I ask for that to be clarified in the TAB charter, please.

It's a historical observation, not a rule.  In fact, it does have an
exception: GregKH was elected in Edinburgh in 2012 without being
physically present at the voting (although he was in Edinburgh at the
time).

James

