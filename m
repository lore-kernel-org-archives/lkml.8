Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF641C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA14C2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20150623.gappssmtp.com header.i=@batbytes-com.20150623.gappssmtp.com header.b="yyvOCWed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgEMQwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgEMQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:52:30 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23459C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:52:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 79so9565313iou.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5McRs2h2rvQaY1hOmppn2DhIQWDdbeyxX3/ow9TFsWY=;
        b=yyvOCWedrXow2BTnlBPoSzxefeBUlqPTLOYTrwybYY7TltWzD6ssezGq4U/ocvTT7t
         JQ5aI/+N6IRhOMVqRRNFSZ18mZkEkicMu8e9q9P2Qc9uQqU8yFXf+2mT7Knit95PqzbV
         RhqhwRuIxteRZL2AFtnzRrHJkW7bz+74bCeECYfnDSQuVUygmqfv6c6PdbUp7emgVdrX
         02fwwSPuPNEUcMXdoOsORImgUY+KHzayFTQMBTCAv/SbTVPaUD5Q4nnWRJFz2f5jv9w3
         06YqehD8TvzjBdXXkiJu9yHDahxLBgeKSPurdpx9iVrEDiEBkKApA1gQuAZClwZk3b9Q
         znzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5McRs2h2rvQaY1hOmppn2DhIQWDdbeyxX3/ow9TFsWY=;
        b=S6l41aoxkEqF91H9w2aS1LzG/Q+Acl6+y+Ebm8LyCo3bjm5IRnKQNe8BGlG+mOO76w
         IwsNhcrCWt/x/cHaIpiWpkiW+cFlIZEIjjVejx51U+r0RUIN+NUAiTRhcRipeCHRQ7Sz
         CXx/9FZHC869/ydrdSu32YpaP8w2mmGxQnPEPsgz9xWvZpjt055KY/HLheQQmxWOdVZI
         7/kbMAd3o5M2MPOcxgejXhMMucpAcJmdYDeGMDx4eyzCGdeIs1SesHKbWdTA/e7c9Ulc
         hSIrf7W0Aaa7Of0TgsB4FxesZjpp6/XPdCFuslFKgh+Itx2lvHyUxyx9QbtclVf1XGPm
         i8sg==
X-Gm-Message-State: AOAM5301swZPbYrrdw8cwE6Kf0UMAFdH8Wd2VYZEdbOSb/Ubm4yInoEB
        XjfqdISlx+QolmYNcVgvU/RKi6rAx4/IcXhNF26Olw==
X-Google-Smtp-Source: ABdhPJyPfW6H9wwwQe6DBa63NJUPn6IGaBXOWRPRbhDR9tbygys78o4ddqWvafGyeagcefdCry4FG7O4qoH+Tai9RFw=
X-Received: by 2002:a5e:8705:: with SMTP id y5mr150522ioj.142.1589388749263;
 Wed, 13 May 2020 09:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACh33FpkBrHpTNfZN6EiyaVPVb6bvJqHO8dJkiHzWPOF0+pKAQ@mail.gmail.com>
 <20200513161113.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200513161113.GU23230@ZenIV.linux.org.uk>
From:   Patrick Donnelly <batrick@batbytes.com>
Date:   Wed, 13 May 2020 09:52:17 -0700
Message-ID: <CACh33FqzSc26qyvdueZ3ee28j28cyz42n++xnE=BUXe507NLKA@mail.gmail.com>
Subject: Re: file system permissions regression affecting root
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>, xiubli@redhat.com,
        kchai@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 9:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 13, 2020 at 08:00:28AM -0700, Patrick Donnelly wrote:
> > In newer kernels (at least 5.6), it appears root is not able to write
> > to files owned by other users in a sticky directory:
>
> Yes.  Controlled by /proc/sys/fs/protected_regular, which systemd crowd
> has decided to enable in commit 2732587540035227fe59e4b64b60127352611b35
>  [...]

Thanks for the information Al!

However, it seems odd that this depends on the owner of the directory.
i.e. this protection only seems to be enforced if the sticky directory
is owned by root. That's expected?


-- 
Patrick Donnelly
