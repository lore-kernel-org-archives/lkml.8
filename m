Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EBCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A322063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgF2SrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:47:12 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:42629 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728632AbgF2SqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:24 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 72326FB182
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:08:09 +0100 (IST)
Received: (qmail 27903 invoked from network); 29 Jun 2020 15:08:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jun 2020 15:08:09 -0000
Date:   Mon, 29 Jun 2020 16:08:07 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [REGRESSION] 5.8-rc3: seccomp crash with Chromium, QtWebEngine
 and related browsers: seccomp-bpf failure in syscall 0072
Message-ID: <20200629150807.GB3183@techsingularity.net>
References: <2293324.KF7j4Pszzj@merkaba>
 <202006290739.8AB49B15@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202006290739.8AB49B15@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:41:56AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 11:08:10AM +0200, Martin Steigerwald wrote:
> > Dear Andy, Kees, Will, dear kernel community,
> > 
> > With 5.8-rc3 there is a seccomp related crash which prevents Chromium and
> > QtWebEngine from starting:
> > 
> > Bug 208369 - seccomp crash with Chromium, QtWebEngine and related browsers: seccomp-bpf failure in syscall 0072
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=208369
> > 
> > Reverting to 5.8-rc2 fixes the issue.
> 
> Hi,
> 
> It looks like this is from e9c15badbb7b ("fs: Do not check if there is a
> fsnotify watcher on pseudo inodes")
> 
> Currently being discussed here:
> https://lore.kernel.org/lkml/7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com/#r
> 

It's a definite problem. I've sent a revert but it hasn't hit lkml yet
for whatever reason.

-- 
Mel Gorman
SUSE Labs
